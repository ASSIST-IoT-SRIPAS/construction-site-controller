{{/*
Expand the name of the chart.
*/}}
{{- define "enabler.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "enabler.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "enabler.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Cilium Multi-cluster global service annotations.
*/}}
{{- define "globalServiceAnnotations" -}}
io.cilium/global-service: "true"
io.cilium/service-affinity: remote
{{- end }}

{{/*
Name of the component fuseki.
*/}}
{{- define "fuseki.name" -}}
{{- printf "%s-fuseki" (include "enabler.name" .) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified component fuseki name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "fuseki.fullname" -}}
{{- printf "%s-fuseki" (include "enabler.fullname" .) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create the default FQDN for fuseki headless service.
*/}}
{{- define "fuseki.svc.headless" -}}
{{- printf "%s-headless" (include "fuseki.fullname" .) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Component fuseki labels.
*/}}
{{- define "fuseki.labels" -}}
helm.sh/chart: {{ include "enabler.chart" . }}
{{ include "fuseki.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Component fuseki selector labels.
*/}}
{{- define "fuseki.selectorLabels" -}}
app.kubernetes.io/name: {{ include "enabler.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
enabler: {{ .Chart.Name }}
app.kubernetes.io/component: fuseki
isMainInterface: "yes"
tier: {{ .Values.fuseki.tier }}
{{- end }}

{{/*
Fuseki config graph endpoint.
*/}}
{{- define "fuseki.configGraphUrl" -}}
{{- print "http://" (include "fuseki.fullname" .) ":" .Values.fuseki.service.ports.fusekihttp.port "/config/" }}
{{- end }}

{{/*
Fuseki workers graph endpoint.
*/}}
{{- define "fuseki.workersGraphUrl" -}}
{{- print "http://" (include "fuseki.fullname" .) ":" .Values.fuseki.service.ports.fusekihttp.port "/workers/" }}
{{- end }}

{{/*
Name of the component glue.
*/}}
{{- define "glue.name" -}}
{{- printf "%s-glue" (include "enabler.name" .) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified component glue name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "glue.fullname" -}}
{{- printf "%s-glue" (include "enabler.fullname" .) | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Component glue labels.
*/}}
{{- define "glue.labels" -}}
helm.sh/chart: {{ include "enabler.chart" . }}
{{ include "glue.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Component glue selector labels.
*/}}
{{- define "glue.selectorLabels" -}}
app.kubernetes.io/name: {{ include "enabler.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
enabler: {{ .Chart.Name }}
app.kubernetes.io/component: glue
isMainInterface: "no"
tier: {{ .Values.glue.tier }}
{{- end }}

