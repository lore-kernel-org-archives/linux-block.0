Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3DCC433FE
	for <linux-block@archiver.kernel.org>; Mon, 30 May 2022 13:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbiE3NIU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 May 2022 09:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236311AbiE3NIT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 May 2022 09:08:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E09870904
        for <linux-block@vger.kernel.org>; Mon, 30 May 2022 06:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1iTf7Qet2TO/OJElGF0bDUHAoibVwZrzdRnAkEJ0pks=; b=XqU8DL3XtX2LaIq2+A0Mxu3t25
        3WWWJW144/N3K7LfFYdVx+5zlOr9LU4LKYoyIQNVWd9MegYOc6atDrJsg+T0nrq9IcNaWQ2cIcK+b
        5jqGCTFdobfSuQKy6BCj0b/8PKyimQIFj4dRFSNazHcEVXPSdPt26Q43MU6mFnlCWXsgJpeZPOX67
        MhzTruHsfGsgvDeDnwJvuGOM9lgrZ7d4dgBHIBkUaYE9xTTR5cKSZ7LcIMS5L01fXVZ41R2ptTtGB
        0UUVqQndZNm9wX7q922MtTfgJ+TAjz6uUyefAwRCmFd/AOc4MK336IdaQDJixszwQHBixQW0QFa6n
        in+vHmjA==;
Received: from [2001:4bb8:185:a81e:fda9:da32:3b0c:8358] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvf85-006bl1-Ds; Mon, 30 May 2022 13:08:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 1/9] nvme: use _have_loop instead of _have_modules loop
Date:   Mon, 30 May 2022 15:08:03 +0200
Message-Id: <20220530130811.3006554-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220530130811.3006554-1-hch@lst.de>
References: <20220530130811.3006554-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Also check for the losetup existance.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/nvme/002 | 2 +-
 tests/nvme/003 | 2 +-
 tests/nvme/004 | 2 +-
 tests/nvme/005 | 3 +--
 tests/nvme/006 | 2 +-
 tests/nvme/008 | 2 +-
 tests/nvme/010 | 2 +-
 tests/nvme/012 | 2 +-
 tests/nvme/014 | 2 +-
 tests/nvme/015 | 2 +-
 tests/nvme/018 | 2 +-
 tests/nvme/019 | 2 +-
 tests/nvme/021 | 2 +-
 tests/nvme/022 | 2 +-
 tests/nvme/023 | 2 +-
 tests/nvme/024 | 2 +-
 tests/nvme/025 | 2 +-
 tests/nvme/026 | 2 +-
 tests/nvme/027 | 2 +-
 tests/nvme/028 | 2 +-
 tests/nvme/029 | 2 +-
 tests/nvme/030 | 2 +-
 tests/nvme/031 | 2 +-
 23 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/tests/nvme/002 b/tests/nvme/002
index ca11c11..6c6ae5f 100755
--- a/tests/nvme/002
+++ b/tests/nvme/002
@@ -11,7 +11,7 @@ DESCRIPTION="create many subsystems and test discovery"
 
 requires() {
 	_nvme_requires
-	_have_modules loop
+	_have_loop
 	_require_nvme_trtype_is_loop
 }
 
diff --git a/tests/nvme/003 b/tests/nvme/003
index 101c184..2ba6954 100755
--- a/tests/nvme/003
+++ b/tests/nvme/003
@@ -12,7 +12,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
-	_have_modules loop
+	_have_loop
 	_require_nvme_trtype_is_fabrics
 }
 
diff --git a/tests/nvme/004 b/tests/nvme/004
index 4b0b7ae..9dda538 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -13,7 +13,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
-	_have_modules loop
+	_have_loop
 	_require_nvme_trtype_is_fabrics
 }
 
diff --git a/tests/nvme/005 b/tests/nvme/005
index 9f3e388..de567a7 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -12,8 +12,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
-	_have_modules loop && \
-		_have_module_param_value nvme_core multipath Y
+	_have_loop && _have_module_param_value nvme_core multipath Y
 	_require_nvme_trtype_is_fabrics
 }
 
diff --git a/tests/nvme/006 b/tests/nvme/006
index 9230dc6..d993861 100755
--- a/tests/nvme/006
+++ b/tests/nvme/006
@@ -11,7 +11,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
-	_have_modules loop
+	_have_loop
 	_require_nvme_trtype_is_fabrics
 }
 
diff --git a/tests/nvme/008 b/tests/nvme/008
index 219fe9b..5568fe4 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -11,7 +11,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
-	_have_modules loop
+	_have_loop
 	_require_nvme_trtype_is_fabrics
 }
 
diff --git a/tests/nvme/010 b/tests/nvme/010
index 08e39d5..b7b1d51 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -11,7 +11,7 @@ TIMED=1
 
 requires() {
 	_nvme_requires
-	_have_fio && _have_modules loop
+	_have_fio && _have_loop
 	_require_nvme_trtype_is_fabrics
 }
 
diff --git a/tests/nvme/012 b/tests/nvme/012
index 6bb4972..c9d2438 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -14,7 +14,7 @@ requires() {
 	_nvme_requires
 	_have_xfs
 	_have_fio
-	_have_modules loop
+	_have_loop
 	_require_nvme_trtype_is_fabrics
 }
 
diff --git a/tests/nvme/014 b/tests/nvme/014
index 48f8caa..d13cff7 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -11,7 +11,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
-	_have_modules loop
+	_have_loop
 	_require_nvme_trtype_is_fabrics
 }
 
diff --git a/tests/nvme/015 b/tests/nvme/015
index e33cfde..bb52ba2 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -11,7 +11,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
-	_have_modules loop
+	_have_loop
 	_require_nvme_trtype_is_fabrics
 }
 
diff --git a/tests/nvme/018 b/tests/nvme/018
index 7f407da..315e795 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -12,7 +12,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
-	_have_modules loop
+	_have_loop
 	_require_nvme_trtype_is_fabrics
 }
 
diff --git a/tests/nvme/019 b/tests/nvme/019
index 8259e2e..4cb3509 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -11,7 +11,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
-	_have_modules loop
+	_have_loop
 	_require_nvme_trtype_is_fabrics
 }
 
diff --git a/tests/nvme/021 b/tests/nvme/021
index fb77f9c..6ee0af1 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -11,7 +11,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
-	_have_modules loop
+	_have_loop
 	_require_nvme_trtype_is_fabrics
 }
 
diff --git a/tests/nvme/022 b/tests/nvme/022
index 62c4690..1d76ffa 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -11,7 +11,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
-	_have_modules loop
+	_have_loop
 	_require_nvme_trtype_is_fabrics
 }
 
diff --git a/tests/nvme/023 b/tests/nvme/023
index bce21b5..b65be07 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -11,7 +11,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
-	_have_modules loop
+	_have_loop
 	_require_nvme_trtype_is_fabrics
 }
 
diff --git a/tests/nvme/024 b/tests/nvme/024
index ffec36c..f756797 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -11,7 +11,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
-	_have_modules loop
+	_have_loop
 	_require_nvme_trtype_is_fabrics
 }
 
diff --git a/tests/nvme/025 b/tests/nvme/025
index 3d3f01b..941bf36 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -11,7 +11,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
-	_have_modules loop
+	_have_loop
 	_require_nvme_trtype_is_fabrics
 }
 
diff --git a/tests/nvme/026 b/tests/nvme/026
index 2f56077..c3f06c2 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -11,7 +11,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
-	_have_modules loop
+	_have_loop
 	_require_nvme_trtype_is_fabrics
 }
 
diff --git a/tests/nvme/027 b/tests/nvme/027
index 53f0664..0ad663a 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -11,7 +11,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
-	_have_modules loop
+	_have_loop
 	_require_nvme_trtype_is_fabrics
 }
 
diff --git a/tests/nvme/028 b/tests/nvme/028
index 3d9084f..7de977a 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -11,7 +11,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
-	_have_modules loop
+	_have_loop
 	_require_nvme_trtype_is_fabrics
 }
 
diff --git a/tests/nvme/029 b/tests/nvme/029
index 960e5f5..f8b4cbb 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -12,7 +12,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
-	_have_modules loop
+	_have_loop
 	_require_nvme_trtype_is_fabrics
 }
 
diff --git a/tests/nvme/030 b/tests/nvme/030
index c6d485e..20fef69 100755
--- a/tests/nvme/030
+++ b/tests/nvme/030
@@ -11,7 +11,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
-	_have_modules loop
+	_have_loop
 	_require_nvme_trtype_is_fabrics
 }
 
diff --git a/tests/nvme/031 b/tests/nvme/031
index 7c18a64..4e17982 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -19,7 +19,7 @@ QUICK=1
 
 requires() {
 	_nvme_requires
-	_have_modules loop
+	_have_loop
 	_require_nvme_trtype_is_fabrics
 }
 
-- 
2.30.2

