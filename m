Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5DFC433EF
	for <linux-block@archiver.kernel.org>; Tue,  7 Jun 2022 12:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244163AbiFGMru (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jun 2022 08:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242948AbiFGMru (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jun 2022 08:47:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EA4A189
        for <linux-block@vger.kernel.org>; Tue,  7 Jun 2022 05:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mMuOHIc+QnUZPAlEF+ZR+W7p5ZRovy3Tyoelagso/Z8=; b=1wwIuzFwhPRg1C3MCR3CCCw/Hw
        aL8Q5Xizpqr3DnbF8YF0z86d0ScD4yt6AasUfArK1NJwCmAz330APIe+AEC5nFxtqt533/LaNn8Ok
        dlU+2Onb47WOFaPmvGdjNE/JTU69xXB4GH5nAerX4vmDfUkiDVgmKJK4wgw37Qo3CB74Rmr5aQilo
        33GUomlEO3P/q5CWLha+2V3Pa2tOAScV0JHLH4VhDW+t86IG8yZz8Z47jYmho+yb0WhKdhkxuhP93
        QPbcYtDEz4L5Hu7/kTk0zQBjTDiDYChqBsbc+ctxuwq1Dyzz/qXSctg9NXHqOxHVCCqImfSrj1okB
        /JRhfpTw==;
Received: from [2001:4bb8:190:726c:b34a:228:52ee:6d34] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyYce-007SWR-6e; Tue, 07 Jun 2022 12:47:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 02/13] common/null_blk: allow _configure_null_blk with built-in null_blk
Date:   Tue,  7 Jun 2022 14:47:28 +0200
Message-Id: <20220607124739.1259977-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607124739.1259977-1-hch@lst.de>
References: <20220607124739.1259977-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Test that do use _configure_null_blk already configure do not actually
require a built-in null_blk driver.  Relax the check in _have_null_blk
to just require a driver instead of a module, and instead set a skip
reason instead of failing in _init_null_blk when null_blk is built-in
or otherwise not available.

Also try to load the null_blk module in _configure_null_blk as
_init_null_blk is optional now and we thus can't rely on the module
to be loaded.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 common/null_blk | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/common/null_blk b/common/null_blk
index 6611db0..30d54c2 100644
--- a/common/null_blk
+++ b/common/null_blk
@@ -4,8 +4,10 @@
 #
 # null_blk helper functions.
 
+. common/shellcheck
+
 _have_null_blk() {
-	_have_modules null_blk
+	_have_driver null_blk
 }
 
 _remove_null_blk_devices() {
@@ -22,6 +24,7 @@ _init_null_blk() {
 	if (( RUN_FOR_ZONED )); then zoned="zoned=1"; fi
 
 	if ! modprobe -r null_blk || ! modprobe null_blk "$@" "${zoned}" ; then
+		SKIP_REASON="requires modular null_blk"
 		return 1
 	fi
 
@@ -32,8 +35,12 @@ _init_null_blk() {
 # Configure one null_blk instance with name $1 and parameters $2..${$#}.
 _configure_null_blk() {
 	local nullb=/sys/kernel/config/nullb/$1 param val
-
 	shift
+
+	if [[ ! -d /sys/module/null_blk ]]; then
+		modprobe -q null_blk
+	fi
+
 	mkdir "$nullb" || return $?
 	while [[ $# -gt 0 ]]; do
 		param="${1%%=*}"
@@ -46,5 +53,5 @@ _configure_null_blk() {
 _exit_null_blk() {
 	_remove_null_blk_devices
 	udevadm settle
-	modprobe -r null_blk
+	modprobe -r -q null_blk
 }
-- 
2.30.2

