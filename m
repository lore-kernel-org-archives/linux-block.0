Return-Path: <SRS0=rVNK=CL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5C4C433E7
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 22:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC12D207EA
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 22:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgIBW3P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Sep 2020 18:29:15 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50782 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIBW3L (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Sep 2020 18:29:11 -0400
Received: by mail-pj1-f66.google.com with SMTP id b16so493625pjp.0
        for <linux-block@vger.kernel.org>; Wed, 02 Sep 2020 15:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nM3Jh+2A7SND6C2uA+VVGAm4b4TPZp+ycA7WS17xgcA=;
        b=Yzw7/WBqWw2xdRcw8/PG1wy50mnrdItjS3RrMFVqPWloBEUaqicyhWtQfQHgI+zVWE
         Wa8EqPrqBtirsvWFSuHEeyhnKCFvc9A87wWBiHT34Ld5KhFrvdfuNv0EBcIh3ZDSg93Q
         fCZLeK6o+/JOlaoqJwO5X/pZrfU2pa0ozaYZZnDFsJ6NkwZ31ojHtWOb6SGMHPCcC9Nv
         QmSnAK/mhByUrAP8/mRZ9td0yTobInBePc3XTPbNw4GDpEKu6M1mA1gO4LmupL8uhkwE
         JyW92tg4m5ff9I4NC5Oey9BzUPGBQyQ/81NQisp4MLl5rJSTVpWiZDlEiBBNcZnNt8LK
         BHCg==
X-Gm-Message-State: AOAM533qHBGA+utFAPJjUpTqFn0aERVHCufZDmfpS9MlKHsvFTmcYLzo
        ulgC5rxKOeYhx/33xnRe/lbMFpXSlj7jOw==
X-Google-Smtp-Source: ABdhPJwjHYsSlGXviSiSRUdz3Kg0QQUWzqT5vZQiv96e2rHgtLBFnWzLlviUrjfBgPAvTtgjtJZ+Ag==
X-Received: by 2002:a17:90a:cb0f:: with SMTP id z15mr3915710pjt.76.1599085750346;
        Wed, 02 Sep 2020 15:29:10 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net ([2601:647:4802:9070:4025:ed24:701e:8cf3])
        by smtp.gmail.com with ESMTPSA id p184sm569293pfb.47.2020.09.02.15.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 15:29:09 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v5 4/7] tests/nvme: restrict tests to specific transports
Date:   Wed,  2 Sep 2020 15:28:58 -0700
Message-Id: <20200902222901.408217-5-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200902222901.408217-1-sagi@grimberg.me>
References: <20200902222901.408217-1-sagi@grimberg.me>
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
index 7ff6f339017c..b711c9677b9f 100755
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
index a4c66b1ba7ad..d5f2b84d913a 100755
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
index e6142ded7f06..cf4c41bfd673 100755
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
index b8f3cab176b0..5e9f2aecc6cc 100755
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
index a236d16d41d2..1993a34c39d5 100755
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
index 10b5d81ff101..995a0820e3fd 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -11,6 +11,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/010 b/tests/nvme/010
index 7b0648957e3c..6f8755ac36b9 100755
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
index 11dda72351b3..d94602ccce22 100755
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
index c4bd34bec812..3ff6692b4bf9 100755
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
index 17fc8a2d00cc..66171b1d5d5e 100755
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
index b79069850da8..7da62a96112b 100755
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
index ec15dbce498d..b0e8e315e13d 100755
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
index 229aa9ab02e7..5dfac7bfdd67 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -10,6 +10,7 @@ DESCRIPTION="create/delete many NVMeOF block device-backed ns and test discovery
 
 requires() {
 	_nvme_requires
+	_require_nvme_trtype_is_loop
 }
 
 test() {
diff --git a/tests/nvme/017 b/tests/nvme/017
index a630b8217a70..86a528fb7b48 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -10,6 +10,7 @@ DESCRIPTION="create/delete many file-ns and test discovery"
 
 requires() {
 	_nvme_requires
+	_require_nvme_trtype_is_loop
 }
 
 test() {
diff --git a/tests/nvme/018 b/tests/nvme/018
index 698fa7b2095f..049c4bb3cf41 100755
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
index 58f1dbeea400..90ff405f0d7b 100755
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
index ce4fbe648f14..328843294f87 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -11,6 +11,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/021 b/tests/nvme/021
index d34ec9dca49e..5056e83d70d8 100755
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
index 2461abed7df5..97efe963dab3 100755
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
index f98b77d832f7..46523bd281b1 100755
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
index a311ff5b0f00..11fae2500a81 100755
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
index cdf7f4499f33..21971070f870 100755
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
index 7cc3794099b9..d72d683e509f 100755
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
index 48f761922e73..b865821df13a 100755
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
index d841906982da..ef0a842e0e85 100755
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
index 79e30a1c337b..37144c5953bc 100755
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
index a9abec1b20af..f18731caef61 100644
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

