Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794182917;
	b=NSP9z/VwK3fdSSnsRWfci1Wz93xUvymlyvyNQKnA8+1Pqpr2caWZNfpY5MJPsBOnNb6p
	 czLivHVepek0GpC4oImWq2bO0fpjW9AbeBinqJa50sjEGsi251u4w3R+bgcUWePAJLGN4
	 gOfT4gpS2Ija3bVn1PFCQ0gxR8rPh6WQgDGNljsvnJnbLtDFmvgqZsJ4XYdAgVQFk8g0x
	 FASAePLgt8gfS4y5UcdN7JzYdRdBmmZfRqoRoh6B6MaIJXSwTOEM8Pyp4lWYKF3eSqYPi
	 A1pJc2o74K7mitn3gWMp0FGJe3/bZRqbimW3Pznt9J26OderRjj/hEwkJetYbbs5rog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794182917;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 X-Patchwork-Bot:Content-Transfer-Encoding;
	bh=FH7Ei2gpGYo/m3TodoKUi5ug60pqHLusd8JZhBhloIA=;
	b=aqBkYha1RKU5ZZKIn51PAnUukAYwzdwrucuwZj8BcfBk8VhFmMwkZe+MzHnFnQge9OWT
	 cUJKk0Qd73PuoGJoNRXaU5ikGNXLOMNmskBQhzOKpUW8QjIXj1LGBIWRcgQOEQBG4srYh
	 9IdA5ym2JPW3WtUj+BPU0liujNKCwTEpJ1S9sJYJwl9fjdiPbrmrzgrTBnzTix3F6ivQy
	 n/4MqtbMKr683wQKUjBujr7B5oQx+g+9yZ05qEY7hOc8tm81NJ7z3w6seeYwj1udGSkxC
	 ZFk2QHbdu8m5KLw/Ip9imsG2RtTxkFZnYh9ZnOzxR0Yo+s1tL22cU36nuH6x+RB6hfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kbMn+RgE;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF4B606A322
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 00:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AF4B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kbMn+RgE
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4af520023fdso685875e9.1
        for <linux-block@vger.kernel.org>; Sun, 08 Nov 2026 16:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794182916; x=1794787716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FH7Ei2gpGYo/m3TodoKUi5ug60pqHLusd8JZhBhloIA=;
        b=kbMn+RgErprAqYnr1G1P+cdJ0h57aUAXRfwqvhmLlJlcDTR5m+xPrRUEDY8CUtatnI
         9nK1xUbMGanhD4xik3DI6An5otcLWFMeSdQ4etR5m1a4dL2dwBxlrdOp1GHMkkFuIkmL
         ESZUbeFPlK62/4x9UO5G0SWHX3ihD6V9/W1wTUrY3tJ8KGv5hKxkVDoEBPWkEy6t+Wcu
         330Sg1jGtjgynM/FmNfecG87qAMl6/DPler/XEmBgK0HmdfMHovE+gTHeQE4xl87H8TS
         XjkSNC3jbH1eRy+wGpnc0Umrtu5zUWQP5sY627TR21U7bfjJYDUgeQ7CbsYIM+b/0DvA
         dMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794182916; x=1794787716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FH7Ei2gpGYo/m3TodoKUi5ug60pqHLusd8JZhBhloIA=;
        b=08slfveGjZ9UytHilFEBDPR7Nu+33zu4CkMy7g5agh6EjVjw2tqqwB3zF+c4/O9Bmd
         bE4L3sAh+BFLQYfj9bAaGTx39ldpeYCpBWOHdIkoxD+e3D9ExRcci6PLD31RN0uc6PKc
         FWWdJv3n0MxOMEr6T2o1ZtX/1xDgvM066J9CUBKBDlbwCCXOJpX4YAQSotZ7hjmNnEyV
         ZccBW5uEDgbLAU8WljeUB0wyPA1xw/Edjyoi7g80tnuK/sHsGsMTwv7qaCueLSQE1A4j
         8Pxv1HNdCylRIWFbAcK9OlUEOQbB6KwtAxYG3EI/40nb1lb3GsN5j//Mj9y//HqLsacz
         5Jig==
X-Forwarded-Encrypted: i=1; AL+hErH/9EmHRG+bsgCPMCuhY2/NUAdjQlgxYS6DQbAygw0i3cGti3cBqq6xaOMAsCLZV2yEas8WZfY4ZVFLPw==@vger.kernel.org
X-Gm-Message-State: APuU4Z++YCOlhdg2ol4AajifRvSSBt/9dgJWdIvjwh8viVJ4vONGbKGI
	6antPlEDcXZ1GCkNvfo3eoa+CaiPvbAxGk07Vc5UROYST5bPymz7GoQ=
X-Gm-Gg: AYBFou2Hd5HdqbtB4l3GboibzP1EgYctc9a6muuWvwv6yoccPpqJm+B/j/1JbRv6RFx
	+9mloI7Xnd8/Z7nmQC4+nEN4HZ9FhEh2cbrQgnLLZqbJa3C+8fFde6jSziihnVVVciRbu/TnwyN
	hmH+EhjWcjJgp9tqKMzaIxU/2GZxexFo6QJKNE/bzaUXfYbOdWkoMd46J+TODsJbi/cd2j3VDgV
	BKyjrEdtrhVTpHSsl2yoRapHNawrh/bt/Rbc33w2kW/5mQf58TG4Dd83zeNVrmuOsl8Cuk1L39P
	U4oB5ZqEp5BYDz6DmOzpbo0pPnZIXlBUiy61IUYIWJkwCltQSlPJ2YX3D9Wrx9lVM5SwlDZLcPS
	JcztaWKlYyBsecCoZepg6M1Z0QQDPcRZZOKLt9MvVQ1C+67WAA7+Ah1rMnMzHY2VUYX+mwrqpLe
	esCxVotzEwNIjWnchwBIf1Ym6GoQcGRHjJnkaNp8bsJgjRZw57QXRPI2/I6QEIRmxzA5IHBOoMi
	yiwqMnLnKxVkXToWkegV97kQsBBsHdGImK10hdf0zwr8uwdOMoRebd3ssd3op6Zsf/WPffJaPFM
	ZAsBsLOkZKcPwotwjN6QoG1WiXND2NvA7HpwS+nbzZQBhGa2Xx4xNAuX4wfGYvjP7Q==
X-Received: by 2002:a05:6000:2888:b0:48a:f5c5:d077 with SMTP id ffacd0b85a97d-49580eea5b6mr6921767f8f.2.1794182915678;
        Sun, 08 Nov 2026 16:08:35 -0800 (PST)
Received: from localhost (69.red-80-39-28.staticip.rima-tde.net. [80.39.28.69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-495974660cfsm6755903f8f.38.2026.11.08.16.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:08:35 -0800 (PST)
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
To: 
Cc: Xose Vazquez Perez <xose.vazquez@gmail.com>,
	John Garry <john.garry@linux.dev>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Guixin Liu <kanie@linux.alibaba.com>,
	Wayne Berthiaume <Wayne.Berthiaume@dell.com>,
	Vasuki Manikarnike <vasuki.manikarnike@hpe.com>,
	Matthias Rudolph <Matthias.Rudolph@hitachivantara.com>,
	Martin George <marting@netapp.com>,
	NetApp RDAC team <ng-eseries-upstream-maintainers@netapp.com>,
	Zou Ming <zouming.zouming@huawei.com>,
	Li Xiaokeng <lixiaokeng@huawei.com>,
	Randy Jennings <randyj@purestorage.com>,
	Jyoti Rani <jrani@purestorage.com>,
	Brian Bunker <brian@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marco Patalano <mpatalan@redhat.com>,
	"Ewan D. Milne" <emilne@redhat.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Daniel Wagner <wagi@monom.org>,
	Hannes Reinecke <hare@suse.de>,
	Martin Wilck <mwilck@suse.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Christophe Varoqui <christophe.varoqui@opensvc.com>,
	BLOCK-ML <linux-block@vger.kernel.org>,
	NVME-ML <linux-nvme@lists.infradead.org>,
	SCSI-ML <linux-scsi@vger.kernel.org>,
	DM_DEVEL-ML <dm-devel@lists.linux.dev>
Subject: [PATCH] nvme-cli: nvmf-autoconnect: Consolidate vendor-specific NVMe-oF udev rules into a single file
Date: Mon,  9 Nov 2026 01:08:33 +0100
Message-ID: <20261109000834.513230-1-xose.vazquez@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Replace individual vendor udev rules (HPE, NetApp, and VAST Data) with
a unified 80-nvmf-storage_arrays.rules file, leaving the rules untouched.

This shifts execution to the 80 range for a logical sequence after base
discovery and autoconnect, while simplifying maintenance and packaging.

Cc: John Garry <john.garry@linux.dev>
Cc: Nilay Shroff <nilay@linux.ibm.com>
Cc: Guixin Liu <kanie@linux.alibaba.com>
Cc: Wayne Berthiaume <Wayne.Berthiaume@dell.com>
Cc: Vasuki Manikarnike <vasuki.manikarnike@hpe.com>
Cc: Matthias Rudolph <Matthias.Rudolph@hitachivantara.com>
Cc: Martin George <marting@netapp.com>
Cc: NetApp RDAC team <ng-eseries-upstream-maintainers@netapp.com>
Cc: Zou Ming <zouming.zouming@huawei.com>
Cc: Li Xiaokeng <lixiaokeng@huawei.com>
Cc: Randy Jennings <randyj@purestorage.com>
Cc: Jyoti Rani <jrani@purestorage.com>
Cc: Brian Bunker <brian@purestorage.com>
Cc: Uday Shankar <ushankar@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marco Patalano <mpatalan@redhat.com>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: John Meneghini <jmeneghi@redhat.com>
Cc: Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@monom.org>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Martin Wilck <mwilck@suse.com>
Cc: Benjamin Marzinski <bmarzins@redhat.com>
Cc: Christophe Varoqui <christophe.varoqui@opensvc.com>
Cc: BLOCK-ML <linux-block@vger.kernel.org>
Cc: NVME-ML <linux-nvme@lists.infradead.org>
Cc: SCSI-ML <linux-scsi@vger.kernel.org>
Cc: DM_DEVEL-ML <dm-devel@lists.linux.dev>
Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
---
BTW, there are two new I/O policies in development:
https://lore.kernel.org/linux-nvme/20260815173502.1185929-1-nilay@linux.ibm.com/
https://lore.kernel.org/linux-nvme/20261026111019.3724465-1-kanie@linux.alibaba.com/
---
 meson.build                                   |  4 +---
 nvme.spec.in                                  |  4 +---
 .../udev-rules/71-nvmf-hpe.rules.in           |  5 ----
 .../udev-rules/71-nvmf-netapp.rules.in        |  6 -----
 .../udev-rules/71-nvmf-vastdata.rules.in      |  5 ----
 .../80-nvmf-storage_arrays.rules.in           | 23 +++++++++++++++++++
 6 files changed, 25 insertions(+), 22 deletions(-)
 delete mode 100644 nvmf-autoconnect/udev-rules/71-nvmf-hpe.rules.in
 delete mode 100644 nvmf-autoconnect/udev-rules/71-nvmf-netapp.rules.in
 delete mode 100644 nvmf-autoconnect/udev-rules/71-nvmf-vastdata.rules.in
 create mode 100644 nvmf-autoconnect/udev-rules/80-nvmf-storage_arrays.rules.in

diff --git a/meson.build b/meson.build
index 90356ad94..00e9ad1be 100644
--- a/meson.build
+++ b/meson.build
@@ -894,9 +894,7 @@ if want_nvme
     udev_files = {
         '65-persistent-net-nbft.rules': 'nvmf',
         '70-nvmf-keys.rules':           'nvmf-autoconnect',
-        '71-nvmf-hpe.rules':            'nvmf',
-        '71-nvmf-netapp.rules':         'nvmf',
-        '71-nvmf-vastdata.rules':       'nvmf',
+        '80-nvmf-storage_arrays.rules': 'nvmf',
     }
     if want_nvmf_autoconnect
         udev_files += {'70-nvmf-autoconnect.rules': 'nvmf-autoconnect'}
diff --git a/nvme.spec.in b/nvme.spec.in
index 23d3d3268..a37c1a08d 100644
--- a/nvme.spec.in
+++ b/nvme.spec.in
@@ -36,9 +36,7 @@ touch %{buildroot}@SYSCONFDIR@/nvme/hostid
 @UDEVRULESDIR@/65-persistent-net-nbft.rules
 @UDEVRULESDIR@/70-nvmf-autoconnect.rules
 @UDEVRULESDIR@/70-nvmf-keys.rules
-@UDEVRULESDIR@/71-nvmf-hpe.rules
-@UDEVRULESDIR@/71-nvmf-netapp.rules
-@UDEVRULESDIR@/71-nvmf-vastdata.rules
+@UDEVRULESDIR@/80-nvmf-storage_arrays.rules
 @DRACUTRULESDIR@/70-nvmf-autoconnect.conf
 @SYSTEMDDIR@/nvmf-connect@.service
 @SYSTEMDDIR@/nvmefc-boot-connections.service
diff --git a/nvmf-autoconnect/udev-rules/71-nvmf-hpe.rules.in b/nvmf-autoconnect/udev-rules/71-nvmf-hpe.rules.in
deleted file mode 100644
index b050dd502..000000000
--- a/nvmf-autoconnect/udev-rules/71-nvmf-hpe.rules.in
+++ /dev/null
@@ -1,5 +0,0 @@
-# Set appropriate iopolicy for HPE Alletra Storage MP
-ACTION=="add", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{model}=="HPE Alletra", ATTR{iopolicy}="round-robin"
-
-# Set ctrl_loss_tmo to -1 for HPE Alletra Storage MP NVMe/TCP
-ACTION!="remove", SUBSYSTEM=="nvme", KERNEL=="nvme*", ATTR{transport}=="tcp", ATTR{model}=="HPE Alletra", ATTR{ctrl_loss_tmo}="-1"
diff --git a/nvmf-autoconnect/udev-rules/71-nvmf-netapp.rules.in b/nvmf-autoconnect/udev-rules/71-nvmf-netapp.rules.in
deleted file mode 100644
index c76a3c434..000000000
--- a/nvmf-autoconnect/udev-rules/71-nvmf-netapp.rules.in
+++ /dev/null
@@ -1,6 +0,0 @@
-# Set appropriate iopolicy for NetApp ONTAP and NetApp E-Series
-ACTION=="add", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{model}=="NetApp ONTAP Controller", ATTR{iopolicy}="queue-depth"
-ACTION=="add", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{model}=="NetApp E-Series", ATTR{iopolicy}="round-robin"
-
-# Set ctrl_loss_tmo to -1 for NetApp ONTAP NVMe/TCP
-ACTION!="remove", SUBSYSTEM=="nvme", KERNEL=="nvme*", ATTR{transport}=="tcp", ATTR{model}=="NetApp ONTAP Controller", ATTR{ctrl_loss_tmo}="-1"
diff --git a/nvmf-autoconnect/udev-rules/71-nvmf-vastdata.rules.in b/nvmf-autoconnect/udev-rules/71-nvmf-vastdata.rules.in
deleted file mode 100644
index dcd6146d8..000000000
--- a/nvmf-autoconnect/udev-rules/71-nvmf-vastdata.rules.in
+++ /dev/null
@@ -1,5 +0,0 @@
-# Enable round-robin for Vast Data Block Subsystem
-ACTION=="add", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{model}=="VASTData", ATTR{iopolicy}="round-robin"
-
-# Set ctrl_loss_tmo to -1 for Vast Data Block Controller
-ACTION!="remove", SUBSYSTEM=="nvme", KERNEL=="nvme*", ATTR{model}=="VASTData", ATTR{ctrl_loss_tmo}="-1"
diff --git a/nvmf-autoconnect/udev-rules/80-nvmf-storage_arrays.rules.in b/nvmf-autoconnect/udev-rules/80-nvmf-storage_arrays.rules.in
new file mode 100644
index 000000000..1cd6c0c0b
--- /dev/null
+++ b/nvmf-autoconnect/udev-rules/80-nvmf-storage_arrays.rules.in
@@ -0,0 +1,23 @@
+##### Storage arrays
+
+#### Set iopolicy for NVMe-oF
+### iopolicy: numa (default), round-robin (>=5.1), or queue-depth (>=6.11)
+
+## HPE
+# Alletra 9000 / Alletra Storage MP / GreenLake Block Storage MP
+ACTION=="add", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{model}=="HPE Alletra", ATTR{iopolicy}="round-robin"
+ACTION!="remove", SUBSYSTEM=="nvme", KERNEL=="nvme*", ATTR{transport}=="tcp", ATTR{model}=="HPE Alletra", ATTR{ctrl_loss_tmo}="-1"
+
+## NetApp
+# ONTAP AFF/ASA Series
+ACTION=="add", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{model}=="NetApp ONTAP Controller", ATTR{iopolicy}="queue-depth"
+ACTION!="remove", SUBSYSTEM=="nvme", KERNEL=="nvme*", ATTR{transport}=="tcp", ATTR{model}=="NetApp ONTAP Controller", ATTR{ctrl_loss_tmo}="-1"
+# E/EF-Series
+ACTION=="add", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{model}=="NetApp E-Series", ATTR{iopolicy}="round-robin"
+
+## VAST Data
+# Block Subsystem
+ACTION=="add", SUBSYSTEM=="nvme-subsystem", ATTR{subsystype}=="nvm", ATTR{model}=="VASTData", ATTR{iopolicy}="round-robin"
+ACTION!="remove", SUBSYSTEM=="nvme", KERNEL=="nvme*", ATTR{model}=="VASTData", ATTR{ctrl_loss_tmo}="-1"
+
+##### EOF
-- 
2.56.0

