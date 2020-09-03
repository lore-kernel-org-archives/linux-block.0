Return-Path: <SRS0=kdGS=CM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC13C2BB84
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 21:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F21C206CA
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 21:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgICV07 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:26:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52770 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbgICV06 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Sep 2020 17:26:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id q9so4235652wmj.2
        for <linux-block@vger.kernel.org>; Thu, 03 Sep 2020 14:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b/uTQxij/TKn4MX+WnD0zPtzN/MEHz4PhHGNPUyvyWs=;
        b=KlFKt/dBQo6Nyq1VQJRNViUaUZhaPLUyOlvs6vNUjeMegGB1BItszHPMiN+YyxQxya
         05grByeW+mmZTt23LZqu8XTLtWRHPMD9MP/KcqxsTg7m23qXvPcyWCjlXh+Vpbr9DPbz
         VOujouoaPFEKXBnJbeoz9x0vpsIU6Y6kTIy/1unmkViOoWQJi/WxLeyoXtMsIUNT6XWe
         V/HTT57RfqAvXYToe7C93kmlW91YtMMsUS/NqV1tDcLw45inSQfkpw00FkW3Di3/xoU1
         gDu1C4GsNBrG7KHF4/MdUmeou3906uOe5eM2mTEFdPACdkfBGg3WN3G1m4cZtkziDA2j
         kSbw==
X-Gm-Message-State: AOAM53382unOeL1Jyx/Zr2oP2gf0Ry7fq+6LhZBwK4OBau/nj7eAErhE
        uc0ICvqR205QZ//ctD8u/WACv9cm1Z7icA==
X-Google-Smtp-Source: ABdhPJy1zGwMVoR0i0CrBNfWFKiHdinSmndHsalamEqg2oXCN3eQH5nSHJdIYvoNo7LBK8S6RLz4Eg==
X-Received: by 2002:a1c:5581:: with SMTP id j123mr4468392wmb.11.1599168413511;
        Thu, 03 Sep 2020 14:26:53 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:79a5:e112:bd7c:4b29])
        by smtp.gmail.com with ESMTPSA id v204sm6659896wmg.20.2020.09.03.14.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 14:26:53 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     linux-nvme@lists.infradead.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 4/7] tests/nvme: restrict tests to specific transports
Date:   Thu,  3 Sep 2020 14:26:31 -0700
Message-Id: <20200903212634.503227-5-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903212634.503227-1-sagi@grimberg.me>
References: <20200903212634.503227-1-sagi@grimberg.me>
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
index 955f68da026a..ca11c11c9a09 100755
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
index 654ff776f6f9..101c1841c6df 100755
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
index 0a62e3448e7b..dfca79aab20c 100755
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
index e97287a96a4e..0d5801868bc0 100755
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
index 8fe95461e6cc..9230dc6ed902 100755
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
index e712026ba373..d53100f3ff7b 100755
--- a/tests/nvme/007
+++ b/tests/nvme/007
@@ -11,6 +11,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/008 b/tests/nvme/008
index cb36442bda18..8616617ad398 100755
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
index 6abca757b4e6..e91d79065cb1 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -11,6 +11,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/010 b/tests/nvme/010
index 903da818b5ac..9d96d7803be3 100755
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
index 4060e6278d44..06dc568fb6ea 100755
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
index dd8bceca5373..8110430e49d4 100755
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
index 059d608a892f..176b11b9ccb5 100755
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
index 192322862072..e3c70364e332 100755
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
index 353445ad31b9..46fa4f605749 100755
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
index f829dedf7baa..4eba30223a08 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -10,6 +10,7 @@ DESCRIPTION="create/delete many NVMeOF block device-backed ns and test discovery
 
 requires() {
 	_nvme_requires
+	_require_nvme_trtype_is_loop
 }
 
 test() {
diff --git a/tests/nvme/017 b/tests/nvme/017
index e552af17ccb9..f2a95cf276cb 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -10,6 +10,7 @@ DESCRIPTION="create/delete many file-ns and test discovery"
 
 requires() {
 	_nvme_requires
+	_require_nvme_trtype_is_loop
 }
 
 test() {
diff --git a/tests/nvme/018 b/tests/nvme/018
index 73703a286ff8..6d7934d09d99 100755
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
index 8ccfface176e..486b5acff713 100755
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
index 7861d47513e5..c8053f440e2e 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -11,6 +11,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
+	_require_nvme_trtype_is_fabrics
 }
 
 test() {
diff --git a/tests/nvme/021 b/tests/nvme/021
index 52d14f0490b1..f543a1d8fd92 100755
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
index 111dec92f791..e824ed31f6f0 100755
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
index 31f77ff07055..bdef3dc8abca 100755
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
index 5a30b08b9d8e..78f779e8a08a 100755
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
index b7903d6ad8f2..223430965d7e 100755
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
index 721d486bc7de..7f82284d9c57 100755
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
index 6be7d0492d37..da96e6c5008d 100755
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
index 2d89c8fa35de..f826b67623f1 100755
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
index 0bface97ccd5..5bed9b8e70ae 100755
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
index 91c042ab6b0b..37df902da895 100755
--- a/tests/nvme/030
+++ b/tests/nvme/030
@@ -12,6 +12,7 @@ QUICK=1
 requires() {
 	_nvme_requires
 	_have_modules loop
+	_require_nvme_trtype_is_fabrics
 }
 
 
diff --git a/tests/nvme/031 b/tests/nvme/031
index 3faa4c171cc8..36263ca2379c 100755
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
index 875127d85876..fbd5b66c25d5 100644
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

