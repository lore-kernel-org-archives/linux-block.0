Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB412C43334
	for <linux-block@archiver.kernel.org>; Tue,  7 Jun 2022 12:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244207AbiFGMs3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jun 2022 08:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244212AbiFGMsY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jun 2022 08:48:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D30712EC
        for <linux-block@vger.kernel.org>; Tue,  7 Jun 2022 05:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=65paewg8yS0KNWz5DhHsYMpKIlKFDfT9YdBgnnfnxcU=; b=rLNa4Q87lZvYgqI7ErbjxKb88E
        coz6mt8MIYxsjAd1VnljGe5cqqiH57f2T1cNmzjvG398YrxmU7ds4oOq+o+zgnJjEHtIzVye5Swch
        ddL6pZ/gyUofPaALPHHdICPGTTlgvVBvNLD5qRdnvUJaC719mKi/u/npXuZ6mxi+zFQUSdEslEwnh
        mqcWXjSi/BvTJzTt3CCMEyy6xEYIN61dESbgEwJozMfkkMzgEPF5JTApkP7ht8PJMsJBZ9vJM/fzK
        pVNorfRoVRO8i1AJO+jh0oifue3YOJqSY9IM/yco1uerF/YAjtaCAMJt7sIdjqKrzxecB2uFwExcH
        XgYQ4qyg==;
Received: from [2001:4bb8:190:726c:b34a:228:52ee:6d34] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyYd3-007Ski-6G; Tue, 07 Jun 2022 12:48:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 11/13] block/023: convert to use _configure_null_blk
Date:   Tue,  7 Jun 2022 14:47:37 +0200
Message-Id: <20220607124739.1259977-12-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607124739.1259977-1-hch@lst.de>
References: <20220607124739.1259977-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Switch to use _configure_null_blk so that built-in null_blk can be
supported, which implies not using the default nullb0 device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/block/023 | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/block/023 b/tests/block/023
index 0f20f4a..db1cbe0 100755
--- a/tests/block/023
+++ b/tests/block/023
@@ -21,10 +21,11 @@ test() {
 
 	local queue_mode
 	for queue_mode in 0 2; do
-		if _init_null_blk gb=1 queue_mode="$queue_mode"; then
+		if _configure_null_blk nullb1 size=1024 \
+				queue_mode="$queue_mode" power=1; then
 			echo "Queue mode $queue_mode"
-			dd if=/dev/nullb0 of=/dev/null iflag=direct bs=64k status=none
-			dd if=/dev/null of=/dev/nullb0 oflag=direct bs=64k status=none
+			dd if=/dev/nullb1 of=/dev/null iflag=direct bs=64k status=none
+			dd if=/dev/null of=/dev/nullb1 oflag=direct bs=64k status=none
 			_exit_null_blk
 		fi
 	done
-- 
2.30.2

