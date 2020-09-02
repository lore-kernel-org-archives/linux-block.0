Return-Path: <SRS0=rVNK=CL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0308C433E7
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 22:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63DE9207EA
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 22:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgIBW3J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Sep 2020 18:29:09 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:51412 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIBW3I (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Sep 2020 18:29:08 -0400
Received: by mail-pj1-f67.google.com with SMTP id ds1so491993pjb.1
        for <linux-block@vger.kernel.org>; Wed, 02 Sep 2020 15:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ub0Y3FnpAu3+m+90OvoGZcXT6a2cMjL2UkvmPpWQ8U=;
        b=qHjnZvNlxcJWApg82fSZfmdApXyd+4qC8dTpBOS596Sogf8lG7EIwBevG69MHfylYt
         gf0sw7uVL6vEOm1ByA2K8vc904J5hjhWz0RtXAIQuL16DyOzlRiFQoML4dhC2Oc3necS
         X+/EAZhyItuuVH4+lOBm6xYOlRLMiqXDgmsoCgkInMhaUSeweQc/siUGasEw2JS8y+Py
         QMjEaiZZWA3a/1Ie7KGsUkOYtPHNQuEmKb8g9BWzdjkc6gxFMgaWMGSyIzJwAEwqFsku
         fLQTG3UJPkfNI4BQUfwmw0RVA20IWXDsl0wYuPotaeiB2KJwV/RpLIYHfOdKRnKw2DJ6
         iEZA==
X-Gm-Message-State: AOAM532Slpw6blUCizB9eaexDQqon2z00w/gd1woOZ9y0Es+WazlYGeF
        Fyu5vmMloTvU+XATOzjGUDzQqvjQFtW00Q==
X-Google-Smtp-Source: ABdhPJz27x5f3DWc14XKd7Yv10IP/VjJPBn43io1aREik3yZ0h/Oa0uyFCns9gkvCTK2jXqM2/jA6w==
X-Received: by 2002:a17:90a:f309:: with SMTP id ca9mr4176784pjb.0.1599085746002;
        Wed, 02 Sep 2020 15:29:06 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net ([2601:647:4802:9070:4025:ed24:701e:8cf3])
        by smtp.gmail.com with ESMTPSA id p184sm569293pfb.47.2020.09.02.15.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 15:29:05 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v5 1/7] nvme: consolidate nvme requirements based on transport type
Date:   Wed,  2 Sep 2020 15:28:55 -0700
Message-Id: <20200902222901.408217-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200902222901.408217-1-sagi@grimberg.me>
References: <20200902222901.408217-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Right now, only pci and loop have tests, hence these are
the only ones that are allowed. The user can pass an env
variable nvme_trtype and check for the necessary modules.

This allows prepares us to support other transport types.

Note that test 031 is designed to run only with nvme, hence
it overrides the environment variable to nvme_trtype=pci.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/002 |  3 ++-
 tests/nvme/003 |  3 ++-
 tests/nvme/004 |  3 ++-
 tests/nvme/005 |  6 +++---
 tests/nvme/006 |  4 ++--
 tests/nvme/007 |  2 +-
 tests/nvme/008 |  4 ++--
 tests/nvme/009 |  2 +-
 tests/nvme/010 |  4 ++--
 tests/nvme/011 |  4 ++--
 tests/nvme/012 |  5 +++--
 tests/nvme/013 |  4 ++--
 tests/nvme/014 |  4 ++--
 tests/nvme/015 |  3 ++-
 tests/nvme/016 |  2 +-
 tests/nvme/017 |  2 +-
 tests/nvme/018 |  4 ++--
 tests/nvme/019 |  4 ++--
 tests/nvme/020 |  2 +-
 tests/nvme/021 |  4 ++--
 tests/nvme/022 |  4 ++--
 tests/nvme/023 |  4 ++--
 tests/nvme/024 |  4 ++--
 tests/nvme/025 |  4 ++--
 tests/nvme/026 |  4 ++--
 tests/nvme/027 |  4 ++--
 tests/nvme/028 |  4 ++--
 tests/nvme/029 |  4 ++--
 tests/nvme/030 |  5 ++---
 tests/nvme/031 |  5 ++---
 tests/nvme/032 |  4 ++++
 tests/nvme/rc  | 19 +++++++++++++++++++
 32 files changed, 80 insertions(+), 54 deletions(-)

diff --git a/tests/nvme/002 b/tests/nvme/002
index 07b7fdae2d39..aaa5ec4d729a 100755
--- a/tests/nvme/002
+++ b/tests/nvme/002
@@ -10,7 +10,8 @@
 DESCRIPTION="create many subsystems and test discovery"
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && _have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/003 b/tests/nvme/003
index ed0feca3cac7..fd696d9efe2c 100755
--- a/tests/nvme/003
+++ b/tests/nvme/003
@@ -11,7 +11,8 @@ DESCRIPTION="test if we're sending keep-alives to a discovery controller"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && _have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/004 b/tests/nvme/004
index 0debcd9c7049..b841a8d4cd87 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -12,7 +12,8 @@ DESCRIPTION="test nvme and nvmet UUID NS descriptors"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && _have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/005 b/tests/nvme/005
index 325f2b656613..df0900b372be 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -11,9 +11,9 @@ DESCRIPTION="reset local loopback target"
 QUICK=1
 
 requires() {
-	_have_modules loop nvme-core nvme-loop nvmet && \
-		_have_module_param_value nvme_core multipath Y && \
-		_have_configfs && _have_program nvme
+	_nvme_requires
+	_have_modules loop && \
+		_have_module_param_value nvme_core multipath Y
 }
 
 test() {
diff --git a/tests/nvme/006 b/tests/nvme/006
index 6c8e18560264..3f47613d52d2 100755
--- a/tests/nvme/006
+++ b/tests/nvme/006
@@ -10,8 +10,8 @@ DESCRIPTION="create an NVMeOF target with a block device-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/007 b/tests/nvme/007
index 58f4bf8808a1..0902745a4ab2 100755
--- a/tests/nvme/007
+++ b/tests/nvme/007
@@ -10,7 +10,7 @@ DESCRIPTION="create an NVMeOF target with a file-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules nvme-loop nvmet && _have_configfs
+	_nvme_requires
 }
 
 test() {
diff --git a/tests/nvme/008 b/tests/nvme/008
index 71ff4d962b00..f19de17fefac 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -10,8 +10,8 @@ DESCRIPTION="create an NVMeOF host with a block device-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/009 b/tests/nvme/009
index 25c7da2ab854..4afbe62864f6 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -10,7 +10,7 @@ DESCRIPTION="create an NVMeOF host with a file-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules nvme-loop nvmet && _have_configfs
+	_nvme_requires
 }
 
 test() {
diff --git a/tests/nvme/010 b/tests/nvme/010
index 2ed0f4871a30..53b97484615f 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -10,8 +10,8 @@ DESCRIPTION="run data verification fio job on NVMeOF block device-backed ns"
 TIMED=1
 
 requires() {
-	_have_program nvme && _have_fio && \
-		_have_modules loop nvme-loop nvmet && _have_configfs
+	_nvme_requires
+	_have_fio _have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/011 b/tests/nvme/011
index 974b33745b99..a54583d5c582 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -10,8 +10,8 @@ DESCRIPTION="run data verification fio job on NVMeOF file-backed ns"
 TIMED=1
 
 requires() {
-	_have_program nvme && _have_fio && _have_configfs && \
-		_have_modules nvme-loop nvmet
+	_nvme_requires
+	_have_fio
 }
 
 test() {
diff --git a/tests/nvme/012 b/tests/nvme/012
index 27981e903c58..0049c3d8ceb6 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -10,8 +10,9 @@ DESCRIPTION="run mkfs and data verification fio job on NVMeOF block device-backe
 TIMED=1
 
 requires() {
-	_have_program nvme && _have_program mkfs.xfs && _have_program fio && \
-		_have_modules loop nvme-loop nvmet && _have_configfs
+	_nvme_requires
+	_have_program mkfs.xfs && _have_program fio && \
+		_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/013 b/tests/nvme/013
index af5f3730a2fc..622706ec4088 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -10,8 +10,8 @@ DESCRIPTION="run mkfs and data verification fio job on NVMeOF file-backed ns"
 TIMED=1
 
 requires() {
-	_have_program nvme && _have_program mkfs.xfs && _have_fio && \
-		_have_modules nvme-loop nvmet && _have_configfs
+	_nvme_requires
+	_have_program mkfs.xfs && _have_fio
 }
 
 test() {
diff --git a/tests/nvme/014 b/tests/nvme/014
index c255d5f12205..9517230253ab 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -10,8 +10,8 @@ DESCRIPTION="flush a NVMeOF block device-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/015 b/tests/nvme/015
index a8497a2ba400..40b850974b43 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -10,7 +10,8 @@ DESCRIPTION="unit test for NVMe flush for file backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && _have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/016 b/tests/nvme/016
index f1e383cb441a..e1bad2f81461 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -9,7 +9,7 @@
 DESCRIPTION="create/delete many NVMeOF block device-backed ns and test discovery"
 
 requires() {
-	_have_program nvme && _have_modules nvme-loop nvmet && _have_configfs
+	_nvme_requires
 }
 
 test() {
diff --git a/tests/nvme/017 b/tests/nvme/017
index 6787b5c754ba..2e6d649f9b65 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -9,7 +9,7 @@
 DESCRIPTION="create/delete many file-ns and test discovery"
 
 requires() {
-	_have_program nvme && _have_modules nvme-loop nvmet && _have_configfs
+	_nvme_requires
 }
 
 test() {
diff --git a/tests/nvme/018 b/tests/nvme/018
index 67d89a6f0b24..e39613709c90 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -11,8 +11,8 @@ DESCRIPTION="unit test NVMe-oF out of range access on a file backend"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/019 b/tests/nvme/019
index a8b0204ec0eb..86a2a2945b35 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -10,8 +10,8 @@ DESCRIPTION="test NVMe DSM Discard command on NVMeOF block-device ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/020 b/tests/nvme/020
index b480ee1b92d0..ccadec6a5822 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -10,7 +10,7 @@ DESCRIPTION="test NVMe DSM Discard command on NVMeOF file-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules nvme-loop nvmet && _have_configfs
+	_nvme_requires
 }
 
 test() {
diff --git a/tests/nvme/021 b/tests/nvme/021
index bbee54d16ff1..bbcb9d56a350 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -10,8 +10,8 @@ DESCRIPTION="test NVMe list command on NVMeOF file-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/022 b/tests/nvme/022
index 9ba07c1cc50f..452e7b3d196c 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -10,8 +10,8 @@ DESCRIPTION="test NVMe reset command on NVMeOF file-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/023 b/tests/nvme/023
index ed2a5ad7653f..2714571d16d9 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -10,8 +10,8 @@ DESCRIPTION="test NVMe smart-log command on NVMeOF block-device ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/024 b/tests/nvme/024
index 538580947c5c..1f87bd19ec69 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -10,8 +10,8 @@ DESCRIPTION="test NVMe smart-log command on NVMeOF file-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/025 b/tests/nvme/025
index 0039fefa5007..1b9e33351f61 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -10,8 +10,8 @@ DESCRIPTION="test NVMe effects-log command on NVMeOF file-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/026 b/tests/nvme/026
index 7e89d840529c..21a265a630ba 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -10,8 +10,8 @@ DESCRIPTION="test NVMe ns-descs command on NVMeOF file-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/027 b/tests/nvme/027
index 4d293beb8b47..d7d33796e122 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -10,8 +10,8 @@ DESCRIPTION="test NVMe ns-rescan command on NVMeOF file-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/028 b/tests/nvme/028
index 1280107ed5df..1643857437e8 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -10,8 +10,8 @@ DESCRIPTION="test NVMe list-subsys command on NVMeOF file-backed ns"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/029 b/tests/nvme/029
index 65eb40031888..9f437285d085 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -11,8 +11,8 @@ DESCRIPTION="test userspace IO via nvme-cli read/write interface"
 QUICK=1
 
 requires() {
-	_have_program nvme && _have_modules loop nvme-loop nvmet && \
-		_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test_user_io()
diff --git a/tests/nvme/030 b/tests/nvme/030
index 94020f47411e..7156cad7b657 100755
--- a/tests/nvme/030
+++ b/tests/nvme/030
@@ -10,9 +10,8 @@ DESCRIPTION="ensure the discovery generation counter is updated appropriately"
 QUICK=1
 
 requires() {
-	_have_program nvme &&
-	_have_modules loop nvme-loop nvmet &&
-	_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 
diff --git a/tests/nvme/031 b/tests/nvme/031
index 892f20bad9a7..7e7ee7327e62 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -18,9 +18,8 @@ DESCRIPTION="test deletion of NVMeOF controllers immediately after setup"
 QUICK=1
 
 requires() {
-	_have_program nvme &&
-	_have_modules loop nvme-loop nvmet &&
-	_have_configfs
+	_nvme_requires
+	_have_modules loop
 }
 
 test() {
diff --git a/tests/nvme/032 b/tests/nvme/032
index 0d0d53b325e6..017d4a339971 100755
--- a/tests/nvme/032
+++ b/tests/nvme/032
@@ -11,11 +11,15 @@
 
 . tests/nvme/rc
 
+#restrict test to nvme-pci only
+nvme_trtype=pci
+
 DESCRIPTION="test nvme pci adapter rescan/reset/remove during I/O"
 QUICK=1
 CAN_BE_ZONED=1
 
 requires() {
+	_nvme_requires
 	_have_fio
 }
 
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 6ffa971b4308..320aa4b2b475 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -6,6 +6,25 @@
 
 . common/rc
 
+nvme_trtype=${nvme_trtype:-"loop"}
+
+_nvme_requires() {
+	_have_program nvme
+	case ${nvme_trtype} in
+	loop)
+		_have_modules nvmet nvme-core nvme-loop
+		_have_configfs
+		;;
+	pci)
+		_have_modules nvme nvme-core
+		;;
+	*)
+		SKIP_REASON="unsupported nvme_trtype=${nvme_trtype}"
+		return 1
+	esac
+	return 0
+}
+
 group_requires() {
 	_have_root
 }
-- 
2.25.1

