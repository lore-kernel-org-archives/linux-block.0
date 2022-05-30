Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD66C433F5
	for <linux-block@archiver.kernel.org>; Mon, 30 May 2022 13:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbiE3NIn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 May 2022 09:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbiE3NIl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 May 2022 09:08:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3317091E
        for <linux-block@vger.kernel.org>; Mon, 30 May 2022 06:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=hF0N8d1hVFIfQRMHICovfH2QmOFI1XtKqCkbbhP/EgM=; b=yLL4t3YzDiE7Bt9kJT73Pc1W/u
        zwHrOvXh2XSUsyaAmabmx4TPGgyRgYA6+j+8RB2KAVwusPLzZdFUX6FMBxPZHDLOa7lxz9BcWjhm7
        tsX6PauPiS3TB9ZVlLzs8KSN1exWQCWNR2OohTom7tAiT1N1PT/96q+KKxRBASmJnV9T8cx2l+Iri
        M8A4APyJqhU/JpmyCvOUgO3FHzrXs2vQCLPJHFHXpVGP3FtzHsoOmkpU7B0CEZ68cy3c4KES8KCUq
        MjOQelqyabvcn8dkcGE9GIk5RgwZbcg6/k7x6/y/m4L5IQBfbbueIW8hI/ywjglisTpdJB3Y8ZD+G
        Qhsbt/kg==;
Received: from [2001:4bb8:185:a81e:fda9:da32:3b0c:8358] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvf8R-006bt8-2u; Mon, 30 May 2022 13:08:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 9/9] common: do not require scsi_debug support to be modular
Date:   Mon, 30 May 2022 15:08:11 +0200
Message-Id: <20220530130811.3006554-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220530130811.3006554-1-hch@lst.de>
References: <20220530130811.3006554-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use _have_driver instead of _have_modules in _have_scsi_debug for the
basic scsi_debug check, and instead only require an actual module in
_init_null_blk when specific module parameters are passed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 common/scsi_debug | 14 ++++++++++----
 tests/block/001   |  4 +++-
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/common/scsi_debug b/common/scsi_debug
index 95da14e..e9161d3 100644
--- a/common/scsi_debug
+++ b/common/scsi_debug
@@ -5,7 +5,7 @@
 # scsi_debug helper functions.
 
 _have_scsi_debug() {
-	_have_modules scsi_debug
+	_have_driver scsi_debug
 }
 
 _init_scsi_debug() {
@@ -18,8 +18,14 @@ _init_scsi_debug() {
 		args+=(zbc=host-managed zone_nr_conv=0)
 	fi
 
-	if ! modprobe -r scsi_debug || ! modprobe scsi_debug "${args[@]}"; then
-		return 1
+	if ((${#args[@]})); then
+		if ! modprobe -qr scsi_debug; then
+			exit 1
+		fi
+		if ! modprobe scsi_debug "${args[@]}"; then
+			SKIP_REASON="scsi_debug not modular"
+			return 1
+		fi
 	fi
 
 	udevadm settle
@@ -60,5 +66,5 @@ _exit_scsi_debug() {
 	unset SCSI_DEBUG_TARGETS
 	unset SCSI_DEBUG_DEVICES
 	udevadm settle
-	modprobe -r scsi_debug
+	modprobe -rq scsi_debug
 }
diff --git a/tests/block/001 b/tests/block/001
index 5f05fa8..fb93932 100755
--- a/tests/block/001
+++ b/tests/block/001
@@ -13,7 +13,9 @@ DESCRIPTION="stress device hotplugging"
 TIMED=1
 
 requires() {
-	_have_scsi_debug && _have_modules sd_mod sr_mod
+	_have_scsi_debug
+	_have_driver sd_mod
+	_have_driver sr_mod
 }
 
 stress_scsi_debug() {
-- 
2.30.2

