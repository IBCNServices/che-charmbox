#!/usr/bin/python3
import yaml
import os


JUJU_HOME = os.path.join(os.environ['HOME'], '.local', 'share', 'juju')
JUJU_MODELS_YAML = os.path.join(JUJU_HOME, 'models.yaml')
JUJU_CONTROLLERS_YAML = os.path.join(JUJU_HOME, 'controllers.yaml')


def parse_yaml_file(yaml_file):
    try:
        with open(yaml_file, 'r') as f:
            return yaml.load(f)
    except (FileNotFoundError, yaml.YAMLError) as exc:
        return {}


def get_current_controller():
    """Return current juju controller
    """
    controllers = parse_yaml_file(JUJU_CONTROLLERS_YAML)
    return controllers.get("current-controller", "")


def get_current_model(controller):
    """Return current model for current controller
    """
    try:
        models = parse_yaml_file(JUJU_MODELS_YAML)
        model = models["controllers"][controller]["current-model"]
    except KeyError:
        model = ""
    return model


if __name__ == "__main__":
    controller = get_current_controller()
    print("%s:%s" % (controller, get_current_model(controller)))
