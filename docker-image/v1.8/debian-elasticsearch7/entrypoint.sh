#!/bin/sh

# AUTOMATICALLY GENERATED
# DO NOT EDIT THIS FILE DIRECTLY, USE /templates/entrypoint.sh.erb


set -e

if [ -z ${FLUENT_ELASTICSEARCH_SED_DISABLE} ] ; then
  if [ -z ${FLUENT_ELASTICSEARCH_USER} ] ; then
    sed -i  '/FLUENT_ELASTICSEARCH_USER/d' /fluentd/etc/${FLUENTD_CONF}
  fi

  if [ -z ${FLUENT_ELASTICSEARCH_PASSWORD} ] ; then
    sed -i  '/FLUENT_ELASTICSEARCH_PASSWORD/d' /fluentd/etc/${FLUENTD_CONF}
  fi
fi

SIMPLE_SNIFFER=$( gem contents fluent-plugin-elasticsearch | grep elasticsearch_simple_sniffer.rb )

if [ -n "$SIMPLE_SNIFFER" -a -f "$SIMPLE_SNIFFER" ] ; then
    FLUENTD_OPT="$FLUENTD_OPT -r $SIMPLE_SNIFFER"
fi


exec fluentd -c /fluentd/etc/${FLUENTD_CONF} -p /fluentd/plugins --gemfile /fluentd/Gemfile ${FLUENTD_OPT}