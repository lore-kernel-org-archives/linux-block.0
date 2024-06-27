Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF53913C806
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719479436; cv=none; b=ImnbNDAy9O+Jf38AoyDj5Z2plR6twqkEE/KIyj+tW2xT3roqsyKsZJuUkQsmlEsej1w/CchpxsLpoTPb+WlXiNi+U/5+NIpM5P0Mz2azp0kxQCrX0YLLo03EMldN5EbVySpvPBe4uXqOjpwdaQ9O7lhdIjk9kLEadifvVnwSZ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719479436; c=relaxed/simple;
	bh=GAjQ5Gp1E+qG3N/w5nf9yJQaGonahU5gRXtb6/YYmN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkgC/17CzbVv+tfPs25qDNq7s13MOBPvkJ5FWgSkCLK7EmDKDpGBCFetiKUYoffeWJ79MCFrThr05rx0rczVNltid3DBjOid5rWue377NoeumZ6aFK1ToKcYy2757UcRNdUOqiR/lCZoV8dcx3cTtuKP4weP+SmnJzXG7U8R2Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CEC7A1FBB3;
	Thu, 27 Jun 2024 09:10:32 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C02851384C;
	Thu, 27 Jun 2024 09:10:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DZjxLYgsfWbCFgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 27 Jun 2024 09:10:32 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 3/3] contrib: add remote target setup/cleanup script
Date: Thu, 27 Jun 2024 11:10:16 +0200
Message-ID: <20240627091016.12752-4-dwagner@suse.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627091016.12752-1-dwagner@suse.de>
References: <20240627091016.12752-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: CEC7A1FBB3
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

Use nvmetcli to setup/cleanup a remote soft target.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 contrib/nvme_target_control.py | 181 +++++++++++++++++++++++++++++++++
 contrib/nvmet-subsys.jinja2    |  71 +++++++++++++
 2 files changed, 252 insertions(+)
 create mode 100755 contrib/nvme_target_control.py
 create mode 100644 contrib/nvmet-subsys.jinja2

diff --git a/contrib/nvme_target_control.py b/contrib/nvme_target_control.py
new file mode 100755
index 000000000000..0a34a5a85a66
--- /dev/null
+++ b/contrib/nvme_target_control.py
@@ -0,0 +1,181 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-3.0+
+
+# blktests calls this script to setup/teardown remote targets. blktests passes
+# all relevant information via the command line, e.g. --hostnqn.
+#
+# This script uses nvmetcli to setup the remote target (it depends on the REST
+# API feature [1]). There is not technical need for nvmetcli to use but it makes
+# it simple to setup a remote Linux box. If you want to setup someting else
+# you should to replace this part.
+#
+# There are couple of global configuration options which need to be set.
+# Add ~/.config/blktests/nvme_target_control.toml file with something like:
+#
+# [main]
+# skip_setup_cleanup=false
+# nvmetcli='/usr/bin/nvmetcli'
+# remote='http://nvmet.local:5000'
+#
+# [host]
+# blkdev_type='device'
+# trtype='tcp'
+# hostnqn='nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349'
+# hostid='0f01fb42-9f7f-4856-b0b3-51e60b8de349'
+# host_traddr='192.168.154.187'
+#
+# [subsys_0]
+# traddr='192.168.19.189'
+# trsvid='4420'
+# subsysnqn='blktests-subsystem-1'
+# subsys_uuid='91fdba0d-f87b-4c25-b80f-db7be1418b9e'
+#
+# This expects nvmetcli with the restapi service running on target.
+#
+# Alternatively, you can skip the the target setup/cleanup completely
+# (skip_setup_cleanup) and run against a previously configured target.
+#
+# [main]
+# skip_setup_cleanup=true
+# nvmetcli='/usr/bin/nvmetcli'
+# remote='http://nvmet.local:5000'
+#
+# [host]
+# blkdev_type='device'
+# trtype='tcp'
+# hostnqn='nqn.2014-08.org.nvmexpress:uuid:1a9e23dd-466e-45ca-9f43-a29aaf47cb21'
+# hostid='1a9e23dd-466e-45ca-9f43-a29aaf47cb21'
+# host_traddr='10.161.16.48'
+#
+# [subsys_0]
+# traddr='10.162.198.45'
+# trsvid='4420'
+# subsysnqn='nqn.1988-11.com.dell:powerstore:00:f03028e73ef7D032D81E'
+# subsys_uuid='3a5c104c-ee41-38a1-8ccf-0968003d54e7'
+#
+# nvmetcli uses JSON configuration, thus this script creates a JSON configuration
+# using a jinja2 template. After this step we simple have to set the blktests
+# variable correctly and start blktests.
+#
+#   NVME_TARGET_CONTROL=~/blktests/contrib/nvme_target_control.py ./check nvme
+#
+# [1] https://github.com/hreinecke/nvmetcli/tree/restapi
+
+import os
+import tomllib
+import argparse
+import subprocess
+from jinja2 import Environment, FileSystemLoader
+
+
+XDG_CONFIG_HOME = os.environ.get("XDG_CONFIG_HOME")
+if not XDG_CONFIG_HOME:
+    XDG_CONFIG_HOME = os.environ.get('HOME') + '/.config'
+
+
+with open(f'{XDG_CONFIG_HOME}/blktests/nvme_target_control.toml', 'rb') as f:
+    config = tomllib.load(f)
+    nvmetcli = config['main']['nvmetcli']
+    remote = config['main']['remote']
+
+
+def gen_conf(conf):
+    basepath = os.path.dirname(__file__)
+    environment = Environment(loader=FileSystemLoader(basepath))
+    template = environment.get_template('nvmet-subsys.jinja2')
+    filename = f'{conf["subsysnqn"]}.json'
+    content = template.render(conf)
+    with open(filename, mode='w', encoding='utf-8') as outfile:
+        outfile.write(content)
+
+
+def target_setup(args):
+    if config['main']['skip_setup_cleanup']:
+        return
+
+    conf = {
+        'subsysnqn': args.subsysnqn,
+        'subsys_uuid': args.subsys_uuid,
+        'hostnqn': args.hostnqn,
+        'allowed_hosts': args.hostnqn,
+        'ctrlkey': args.ctrlkey,
+        'hostkey': args.hostkey,
+        'blkdev': '/dev/vdc'
+    }
+
+    gen_conf(conf)
+
+    subprocess.call(['python3', nvmetcli, '--remote=' + remote,
+                     'restore', args.subsysnqn + '.json'])
+
+
+def target_cleanup(args):
+    if config['main']['skip_setup_cleanup']:
+        return
+
+    subprocess.call(['python3', nvmetcli, '--remote=' + remote,
+                     'clear', args.subsysnqn + '.json'])
+
+
+def target_config(args):
+	if args.show_blkdev_type:
+		print(config['host']['blkdev_type'])
+	elif args.show_trtype:
+		print(config['host']['trtype'])
+	elif args.show_hostnqn:
+		print(config['host']['hostnqn'])
+	elif args.show_hostid:
+		print(config['host']['hostid'])
+	elif args.show_host_traddr:
+		print(config['host']['host_traddr'])
+	elif args.show_traddr:
+		print(config['subsys_0']['traddr'])
+	elif args.show_trsvid:
+		print(config['subsys_0']['trsvid'])
+	elif args.show_subsysnqn:
+		print(config['subsys_0']['subsysnqn'])
+	elif args.show_subsys_uuid:
+		print(config['subsys_0']['subsys_uuid'])
+
+
+def build_parser():
+    parser = argparse.ArgumentParser()
+    sub = parser.add_subparsers(required=True)
+
+    setup = sub.add_parser('setup')
+    setup.add_argument('--subsysnqn', required=True)
+    setup.add_argument('--subsys-uuid', required=True)
+    setup.add_argument('--hostnqn', required=True)
+    setup.add_argument('--ctrlkey', default='')
+    setup.add_argument('--hostkey', default='')
+    setup.set_defaults(func=target_setup)
+
+    cleanup = sub.add_parser('cleanup')
+    cleanup.add_argument('--subsysnqn', required=True)
+    cleanup.set_defaults(func=target_cleanup)
+
+    config = sub.add_parser('config')
+    config.add_argument('--show-blkdev-type', action='store_true')
+    config.add_argument('--show-trtype', action='store_true')
+    config.add_argument('--show-hostnqn', action='store_true')
+    config.add_argument('--show-hostid', action='store_true')
+    config.add_argument('--show-host-traddr', action='store_true')
+    config.add_argument('--show-traddr', action='store_true')
+    config.add_argument('--show-trsvid', action='store_true')
+    config.add_argument('--show-subsys-uuid', action='store_true')
+    config.add_argument('--show-subsysnqn', action='store_true')
+    config.set_defaults(func=target_config)
+
+    return parser
+
+
+def main():
+    import sys
+
+    parser = build_parser()
+    args = parser.parse_args()
+    args.func(args)
+
+
+if __name__ == '__main__':
+    main()
diff --git a/contrib/nvmet-subsys.jinja2 b/contrib/nvmet-subsys.jinja2
new file mode 100644
index 000000000000..a446fbd9b784
--- /dev/null
+++ b/contrib/nvmet-subsys.jinja2
@@ -0,0 +1,71 @@
+{
+  "hosts": [
+    {
+      "nqn": "{{ hostnqn }}"
+    }
+  ],
+  "ports": [
+    {
+      "addr": {
+        "adrfam": "ipv4",
+        "traddr": "0.0.0.0",
+        "treq": "not specified",
+        "trsvcid": "4420",
+        "trtype": "tcp",
+        "tsas": "none"
+      },
+      "ana_groups": [
+        {
+          "ana": {
+            "state": "optimized"
+          },
+          "grpid": 1
+        }
+      ],
+      "param": {
+        "inline_data_size": "16384",
+        "pi_enable": "0"
+      },
+      "portid": 0,
+      "referrals": [],
+      "subsystems": [
+        "{{ subsysnqn }}"
+      ]
+    }
+  ],
+  "subsystems": [
+    {
+      "allowed_hosts": [
+        "{{ allowed_hosts }}"
+      ],
+      "attr": {
+        "allow_any_host": "0",
+        "cntlid_max": "65519",
+        "cntlid_min": "1",
+        "firmware": "yada",
+        "ieee_oui": "0x000000",
+        "model": "Linux",
+        "pi_enable": "0",
+        "qid_max": "128",
+        "serial": "0c74361069d9db6c65ef",
+        "version": "1.3"
+      },
+      "namespaces": [
+        {
+          "ana": {
+            "grpid": "1"
+          },
+          "ana_grpid": 1,
+          "device": {
+            "nguid": "00000000-0000-0000-0000-000000000000",
+            "path": "{{ blkdev }}",
+            "uuid": "{{ subsys_uuid }}"
+          },
+          "enable": 1,
+          "nsid": 1
+        }
+      ],
+      "nqn": "{{ subsysnqn }}"
+    }
+  ]
+}
-- 
2.45.2

