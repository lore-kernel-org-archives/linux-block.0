Return-Path: <SRS0=mumx=BQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4159FC433E1
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 19:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C17A22CA1
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 19:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgHFTPa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:15:30 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36120 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgHFTP2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Aug 2020 15:15:28 -0400
Received: by mail-pl1-f193.google.com with SMTP id y6so1097438plt.3
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2020 12:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ej+QUm3coPFgr2Dcj9yEtLaivghbIlLTGBhcu85qsl0=;
        b=pfJVEI0ozIS0VP8g7r3FnvWkZmrrL7alJ9IM++b8570GIgJ8YoArj5vJ1Ohj4KRq7y
         elv/CPLC6X/VwPO5DHM4ydqoBOM5DYfsX4NQ2oWaO1Qrk3WYBvVfsWENFsVnsWJMJ802
         DPKSQxU+CkX/6aGXnQwPbbMb4n9lTzJekIkp5ZkkGQJIYeiLPjEPS8KnuTbdMJ72DiA4
         Cx0AfcNFDqGX6AM7Kg++QhBf2Pe+KGmhlRsy/ggLK3h1bzW6oOyBQgWEgtlBX8WmA208
         fQPQ5vGm8V6gypqq1J8dy0kZTteDEDJBZSbPoE86SRrHlzaqaWqw7zHQccF8D2sh84GP
         twjw==
X-Gm-Message-State: AOAM530Swc+wupYu6M5BkLY1UgOC2ytUlDw7JjxKVXxfFg2fBnUvNFIN
        AYnOuI9NfFlLZRqRK1juChw=
X-Google-Smtp-Source: ABdhPJwdKoS5ikFKMLUhiwd3I9A14+UiYINPr50Jbgs0eZPKpyu/jRZ4pZiZS+y/mDNBwXAGLGs+YQ==
X-Received: by 2002:a17:90a:3307:: with SMTP id m7mr9351246pjb.203.1596741327396;
        Thu, 06 Aug 2020 12:15:27 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:d88d:857c:b14c:519a])
        by smtp.gmail.com with ESMTPSA id q16sm9784014pfg.153.2020.08.06.12.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 12:15:26 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v2 4/7] tests/nvme: restrict tests to specific transports
Date:   Thu,  6 Aug 2020 12:15:15 -0700
Message-Id: <20200806191518.593880-5-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200806191518.593880-1-sagi@grimberg.me>
References: <20200806191518.593880-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Protect against running tests with the wrong transport type. Most tests
cannot have nvme_trtype=nvme and discovery tests expect the $trtype to
be written and verified in the .out file. Adding a couple of helpers
to restrict the transport types in tests.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/002 |  1 +
 tests/nvme/003 |  1 +
 tests/nvme/004 |  1 +
 tests/nvme/005 |  1 +
 tests/nvme/006 |  1 +
 tests/nvme/007 |  1 +
 tests/nvme/008 |  1 +
 tests/nvme/009 |  1 +
 tests/nvme/010 |  1 +
 tests/nvme/011 |  1 +
 tests/nvme/012 |  1 +
 tests/nvme/013 |  1 +
 tests/nvme/014 |  1 +
 tests/nvme/015 |  1 +
 tests/nvme/016 |  1 +
 tests/nvme/017 |  1 +
 tests/nvme/018 |  1 +
 tests/nvme/019 |  1 +
 tests/nvme/020 |  1 +
 tests/nvme/021 |  1 +
 tests/nvme/022 |  1 +
 tests/nvme/023 |  1 +
 tests/nvme/024 |  1 +
 tests/nvme/025 |  1 +
 tests/nvme/026 |  1 +
 tests/nvme/027 |  1 +
 tests/nvme/028 |  1 +
 tests/nvme/029 |  1 +
 tests/nvme/030 |  1 +
 tests/nvme/031 |  1 +
 tests/nvme/rc  | 16 ++++++++++++++++
 31 files changed, 46 insertions(+)

diff --git a/tests/nvme/002 b/tests/nvme/002
index 8540623497c7..8cfcb75e5142 100755
--- a/tests/nvme/002
+++ b/tests/nvme/002
@@ -12,6 +12,7 @@ DESCRIPTION="create many subsystems and test discovery"
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_loop
 }
 
 test() {
diff --git a/tests/nvme/003 b/tests/nvme/003
index 68f823011d7d..09d4c50bef2f 100755
--- a/tests/nvme/003
+++ b/tests/nvme/003
@@ -13,6 +13,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_not_pci
 }
 
 test() {
diff --git a/tests/nvme/004 b/tests/nvme/004
index af434674beaa..9e40b08ca595 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -14,6 +14,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_not_pci
 }
 
 test() {
diff --git a/tests/nvme/005 b/tests/nvme/005
index ff0975ce7c28..68dc9311e9de 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -14,6 +14,7 @@ requires() {
 	_nvme_requires
 	_have_modules loop && \
 		_have_module_param_value nvme_core multipath Y
+	_require_nvme_trtype_not_pci
 }
 
 test() {
diff --git a/tests/nvme/006 b/tests/nvme/006
index 3f161d08bc22..82809379b5d4 100755
--- a/tests/nvme/006
+++ b/tests/nvme/006
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_not_pci
 }
 
 test() {
diff --git a/tests/nvme/007 b/tests/nvme/007
index b0e61186e886..747e7402ee7d 100755
--- a/tests/nvme/007
+++ b/tests/nvme/007
@@ -11,6 +11,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
+	_require_nvme_trtype_not_pci
 }
 
 test() {
diff --git a/tests/nvme/008 b/tests/nvme/008
index 7ffac945a58a..9f17fcfe801a 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_not_pci
 }
 
 test() {
diff --git a/tests/nvme/009 b/tests/nvme/009
index 9ac5cb479983..017b06e13637 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -11,6 +11,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
+	_require_nvme_trtype_not_pci
 }
 
 test() {
diff --git a/tests/nvme/010 b/tests/nvme/010
index d90ca9d88053..426276c87ed1 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -12,6 +12,7 @@ TIMED=1
 requires() {
 	_nvme_requires
 	_have_fio _have_modules loop
+	_require_nvme_trtype_not_pci
 }
 
 test() {
diff --git a/tests/nvme/011 b/tests/nvme/011
index d8badbc00846..d799af0ba6f4 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -12,6 +12,7 @@ TIMED=1
 requires() {
 	_nvme_requires
 	_have_fio
+	_require_nvme_trtype_not_pci
 }
 
 test() {
diff --git a/tests/nvme/012 b/tests/nvme/012
index 93b6cfaf4c77..b9848eb0b0ee 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -13,6 +13,7 @@ requires() {
 	_nvme_requires
 	_have_program mkfs.xfs && _have_program fio && \
 		_have_modules loop
+	_require_nvme_trtype_not_pci
 }
 
 test() {
diff --git a/tests/nvme/013 b/tests/nvme/013
index 3bae2f5edb3d..df462f165a8d 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -12,6 +12,7 @@ TIMED=1
 requires() {
 	_nvme_requires
 	_have_program mkfs.xfs && _have_fio
+	_require_nvme_trtype_not_pci
 }
 
 test() {
diff --git a/tests/nvme/014 b/tests/nvme/014
index b61e7182af66..9a9292a9d309 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_not_pci
 }
 
 test() {
diff --git a/tests/nvme/015 b/tests/nvme/015
index 05195e3bc598..600e625d341d 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_not_pci
 }
 
 test() {
diff --git a/tests/nvme/016 b/tests/nvme/016
index a5ad973dc246..8ba0a895fbff 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -10,6 +10,7 @@ DESCRIPTION="create/delete many NVMeOF block device-backed ns and test discovery
 
 requires() {
 	_nvme_requires
+	_require_nvme_trtype_is_loop
 }
 
 test() {
diff --git a/tests/nvme/017 b/tests/nvme/017
index 67d7ffc72e93..36b14f677449 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -10,6 +10,7 @@ DESCRIPTION="create/delete many file-ns and test discovery"
 
 requires() {
 	_nvme_requires
+	_require_nvme_trtype_is_loop
 }
 
 test() {
diff --git a/tests/nvme/018 b/tests/nvme/018
index 43340d3c4d25..9059b2557efa 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -13,6 +13,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_not_pci
 }
 
 test() {
diff --git a/tests/nvme/019 b/tests/nvme/019
index 98d82ae21b42..ca7954953fd8 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_not_pci
 }
 
 test() {
diff --git a/tests/nvme/020 b/tests/nvme/020
index 2d4c0152bc55..39d08439f113 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -11,6 +11,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
+	_require_nvme_trtype_not_pci
 }
 
 test() {
diff --git a/tests/nvme/021 b/tests/nvme/021
index 03b2ab749052..918be51d2087 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_not_pci
 }
 
 test() {
diff --git a/tests/nvme/022 b/tests/nvme/022
index 977b844ee117..a03e83500b47 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_not_pci
 }
 
 test() {
diff --git a/tests/nvme/023 b/tests/nvme/023
index 6c3b44174884..c1ef8e08a31d 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_not_pci
 }
 
 test() {
diff --git a/tests/nvme/024 b/tests/nvme/024
index 9b5f6a44a916..bf7416f908e9 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_not_pci
 }
 
 test() {
diff --git a/tests/nvme/025 b/tests/nvme/025
index 9f0e9f722a02..8f8e472ab3ce 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_not_pci
 }
 
 test() {
diff --git a/tests/nvme/026 b/tests/nvme/026
index e60e73b2c26a..f1f8878793ce 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_not_pci
 }
 
 test() {
diff --git a/tests/nvme/027 b/tests/nvme/027
index 805a3c63eba2..53766775e096 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_not_pci
 }
 
 test() {
diff --git a/tests/nvme/028 b/tests/nvme/028
index c9bd3dde7f20..6fbf0d6d7938 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_not_pci
 }
 
 test() {
diff --git a/tests/nvme/029 b/tests/nvme/029
index 7bf904b16edc..7a4fd8d6d4c5 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -13,6 +13,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_not_pci
 }
 
 test_user_io()
diff --git a/tests/nvme/030 b/tests/nvme/030
index 220b29f42962..44f3b56dec4e 100755
--- a/tests/nvme/030
+++ b/tests/nvme/030
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_not_pci
 }
 
 
diff --git a/tests/nvme/031 b/tests/nvme/031
index 001f9d2b0b3a..a5714982b5d9 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -20,6 +20,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_not_pci
 }
 
 test() {
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 191f0497416a..a2cb0c0add93 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -46,6 +46,22 @@ _require_test_dev_is_nvme() {
 	return 0
 }
 
+_require_nvme_trtype_is_loop() {
+	if [[ "${nvme_trtype}" != "loop" ]]; then
+		SKIP_REASON="nvme_trtype=${nvme_trtype} is not supported in this test"
+		return 1
+	fi
+	return 0
+}
+
+_require_nvme_trtype_not_pci() {
+	if [[ "${nvme_trtype}" == "pci" ]]; then
+		SKIP_REASON="nvme_trtype=${nvme_trtype} is not supported in this test"
+		return 1
+	fi
+	return 0
+}
+
 _cleanup_nvmet() {
 	local dev
 	local port
-- 
2.25.1

