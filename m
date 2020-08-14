Return-Path: <SRS0=DF0J=BY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A371C433E1
	for <linux-block@archiver.kernel.org>; Fri, 14 Aug 2020 06:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC9E20791
	for <linux-block@archiver.kernel.org>; Fri, 14 Aug 2020 06:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgHNGSq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Aug 2020 02:18:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39101 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgHNGSp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Aug 2020 02:18:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id g75so6960857wme.4
        for <linux-block@vger.kernel.org>; Thu, 13 Aug 2020 23:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wu2ghV8/u7ubjX0NqevskKUcN8L5GxZ12zYaXNIR/rs=;
        b=aJQpl8BQ8JdiMLJZ3kwHW6I5k0QG0EsLXv++MpR62DSiVylae6tQ9NvN8ZVvbCwKLH
         mrnsBVyunQp1bGVtf00T7EScL6GU21HDSOP2iJ4mA9Nvs191duUv2dq6cT202Cz47yRf
         k3ClXxczk8hQPyTbZbLcmNqJRa+OfJQ9NZUw0/TPSEu49fo9kJN7rW1OpHMA0m/1LER/
         CSmv2ABjL1I95Rtc3w8LPrJ8IBwRGo6sx85ImTXAyIpnbPR4fWHtLx/Gq1hNMqxPTMPV
         M+Mo2JfD1BDaPfj8HI5nLJJaQ3UyO9WGwf8B1gFAiECmPg7XEv1vHeVcDSB69gbMJ02G
         J9LA==
X-Gm-Message-State: AOAM532uvAe/sV0bjbiLbw13mR6zYFPsJHg63k4gmJarFSJzD2qpbsZN
        SF+fUFT214W4cYXDFdQflv8=
X-Google-Smtp-Source: ABdhPJw8f2bU/juTjPkUyVbj7XJn6FMIlTdkHQ7BGIB1pbwK7cHQ4B1Qts0FSxLWE8LTkuqNE4MNaw==
X-Received: by 2002:a1c:40b:: with SMTP id 11mr1068415wme.116.1597385922855;
        Thu, 13 Aug 2020 23:18:42 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:51f:3472:bc7:2f4f])
        by smtp.gmail.com with ESMTPSA id l21sm12278131wmj.25.2020.08.13.23.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 23:18:42 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v4 4/7] tests/nvme: restrict tests to specific transports
Date:   Thu, 13 Aug 2020 23:18:12 -0700
Message-Id: <20200814061815.536540-5-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814061815.536540-1-sagi@grimberg.me>
References: <20200814061815.536540-1-sagi@grimberg.me>
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
index 68f823011d7d..5f695c27fe78 100755
--- a/tests/nvme/003
+++ b/tests/nvme/003
@@ -13,6 +13,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/004 b/tests/nvme/004
index af434674beaa..03ccd1e4e6b4 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -14,6 +14,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/005 b/tests/nvme/005
index ff0975ce7c28..7081faebb801 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -14,6 +14,7 @@ requires() {
 	_nvme_requires
 	_have_modules loop && \
 		_have_module_param_value nvme_core multipath Y
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/006 b/tests/nvme/006
index 3f161d08bc22..1137ab9c43fa 100755
--- a/tests/nvme/006
+++ b/tests/nvme/006
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/007 b/tests/nvme/007
index b0e61186e886..106775e65d84 100755
--- a/tests/nvme/007
+++ b/tests/nvme/007
@@ -11,6 +11,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/008 b/tests/nvme/008
index 7ffac945a58a..fbba7ff59aec 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/009 b/tests/nvme/009
index 9ac5cb479983..39a216dc7822 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -11,6 +11,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/010 b/tests/nvme/010
index d90ca9d88053..02b653bc993b 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -12,6 +12,7 @@ TIMED=1
 requires() {
 	_nvme_requires
 	_have_fio _have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/011 b/tests/nvme/011
index d8badbc00846..349ac080f58c 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -12,6 +12,7 @@ TIMED=1
 requires() {
 	_nvme_requires
 	_have_fio
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/012 b/tests/nvme/012
index 93b6cfaf4c77..c64ad491266f 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -13,6 +13,7 @@ requires() {
 	_nvme_requires
 	_have_program mkfs.xfs && _have_program fio && \
 		_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/013 b/tests/nvme/013
index 3bae2f5edb3d..b9452d8061ec 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -12,6 +12,7 @@ TIMED=1
 requires() {
 	_nvme_requires
 	_have_program mkfs.xfs && _have_fio
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/014 b/tests/nvme/014
index b61e7182af66..40cb1615bef0 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/015 b/tests/nvme/015
index 05195e3bc598..b57680e7286e 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
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
index 43340d3c4d25..e4cd79350971 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -13,6 +13,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/019 b/tests/nvme/019
index 98d82ae21b42..a697c3ac3d02 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/020 b/tests/nvme/020
index 2d4c0152bc55..6d7d5c99410d 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -11,6 +11,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/021 b/tests/nvme/021
index 03b2ab749052..5a60ad4c8744 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/022 b/tests/nvme/022
index 977b844ee117..2cd224fcfa22 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/023 b/tests/nvme/023
index 6c3b44174884..07b48a3c1bb5 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/024 b/tests/nvme/024
index 9b5f6a44a916..14c331cd377a 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/025 b/tests/nvme/025
index 9f0e9f722a02..21b033c9c2a8 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/026 b/tests/nvme/026
index e60e73b2c26a..77f7043c8e4a 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/027 b/tests/nvme/027
index 805a3c63eba2..f950422824bb 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/028 b/tests/nvme/028
index c9bd3dde7f20..10e13b4de922 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/029 b/tests/nvme/029
index 7bf904b16edc..c871fb48fc0f 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -13,6 +13,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test_user_io()
diff --git a/tests/nvme/030 b/tests/nvme/030
index 220b29f42962..314f39e93de2 100755
--- a/tests/nvme/030
+++ b/tests/nvme/030
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 
diff --git a/tests/nvme/031 b/tests/nvme/031
index 001f9d2b0b3a..1df4dfd6cb9a 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -20,6 +20,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 191f0497416a..306a12440c20 100644
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
+_require_nvme_trtype_is_fabrics() {
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

