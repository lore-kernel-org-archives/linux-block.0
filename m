Return-Path: <SRS0=i0oD=EB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E815C4363A
	for <linux-block@archiver.kernel.org>; Mon, 26 Oct 2020 21:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5B682076D
	for <linux-block@archiver.kernel.org>; Mon, 26 Oct 2020 21:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbgJZVDX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Oct 2020 17:03:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:58994 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729495AbgJZVDW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Oct 2020 17:03:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E8DB3ADE8;
        Mon, 26 Oct 2020 21:03:21 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, David Disseldorp <ddiss@suse.de>,
        Douglas Gilbert <dgilbert@interlog.com>
Subject: [PATCH] lib/scatterlist: use consistent sg_copy_buffer() return type
Date:   Mon, 26 Oct 2020 22:03:10 +0100
Message-Id: <20201026210310.30169-1-ddiss@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

sg_copy_buffer() returns a size_t with the number of bytes copied.
Return 0 instead of false if the copy is skipped.

Signed-off-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Douglas Gilbert <dgilbert@interlog.com>
---
 lib/scatterlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 0a482ef988e5..a59778946404 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -933,7 +933,7 @@ size_t sg_copy_buffer(struct scatterlist *sgl, unsigned int nents, void *buf,
 	sg_miter_start(&miter, sgl, nents, sg_flags);
 
 	if (!sg_miter_skip(&miter, skip))
-		return false;
+		return 0;
 
 	while ((offset < buflen) && sg_miter_next(&miter)) {
 		unsigned int len;
-- 
2.26.2

