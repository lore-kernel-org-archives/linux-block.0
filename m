Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0CFC433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 14:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1A00613A8
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 14:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhJTOnw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJTOns (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 10:43:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253A9C06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 07:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2L92/9QiIWcdw+bg0wFwZR/PGctR7z/K/xZ8EpEVFeM=; b=OvTtpECULhDowgzcczTu2qMDNq
        M2BP34iaml6UvBaDDSgUNAHNeLNEI/UksfspDw4Iq3NAgPkKVak3ZxWoxfO9a1dNVdHRPHf2kIMnP
        knyzuMNdoofzqSmd4behjbExTmnfiFO9mElCsQ/cAAx/0ij8eGRoZKBJPPBZ374aNMyheCROryEAU
        GRwtOst1/m+59kLB5WvWCi+teRisYhzNxQ8AQdNdwKVTTOCKfE29kCl5L9faYGFVhbH69XlCUI+73
        Ly3W5WGlXtk6VGzmrmN8TUOK/5Z6XH/FTe3baZHGX6QYViHjAl4MjH75ZeqBpazXI4W03PySbbQsM
        1FyVBWmw==;
Received: from [2001:4bb8:180:8777:a130:d02a:a9b5:7d80] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdCma-004oGj-5Q; Wed, 20 Oct 2021 14:41:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 3/4] block: optimise blk_flush_plug_list
Date:   Wed, 20 Oct 2021 16:41:18 +0200
Message-Id: <20211020144119.142582-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211020144119.142582-1-hch@lst.de>
References: <20211020144119.142582-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

Don't call flush_plug_callbacks if there are no plug callbacks.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
[hch: split from a larger patch]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index e6ad5b51d0c3d..63fee1f82bd7d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1639,8 +1639,8 @@ EXPORT_SYMBOL(blk_check_plugged);
 
 void blk_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
-	flush_plug_callbacks(plug, from_schedule);
-
+	if (!list_empty(&plug->cb_list))
+		flush_plug_callbacks(plug, from_schedule);
 	if (!rq_list_empty(plug->mq_list))
 		blk_mq_flush_plug_list(plug, from_schedule);
 	if (unlikely(!from_schedule && plug->cached_rq))
-- 
2.30.2

