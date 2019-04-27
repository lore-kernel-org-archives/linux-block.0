Return-Path: <SRS0=GE/Q=S5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB272C43218
	for <linux-block@archiver.kernel.org>; Sat, 27 Apr 2019 11:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E37208C2
	for <linux-block@archiver.kernel.org>; Sat, 27 Apr 2019 11:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="uxg1b4bH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfD0Li3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Apr 2019 07:38:29 -0400
Received: from smtpbgsg2.qq.com ([54.254.200.128]:60955 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfD0Li3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Apr 2019 07:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1556365101;
        bh=QoEPkHGf2GjvrA+JuHxH7RdWJXrNTx0c6VmRvcWcY7o=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=uxg1b4bHSkNllpH5cppRYr3HXQj5fAsCABJggV2TKq5MjpzrwtCKPgjRdZwf7jg0m
         gfTW0iBJTqlAiXe1DKDq7bBByudRcXhD/hOe5KM0w1z6q4IRKuClmf6Q6bNhIuh6rX
         +AfMK6dC7RWWy4gJHhhdFZTPqDPrE/ENInjn+2dc=
X-QQ-mid: esmtp2t1556365099tcvlbqsdz
Received: from localhost.localdomain (unknown [61.48.57.6])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sat, 27 Apr 2019 19:38:19 +0800 (CST)
X-QQ-SSF: 01000000000000F0FH3000000000000
X-QQ-FEAT: IWL+UNg1+673L6sz+QPiAKL5jKE7NrynKe2ng7dm8KYpy94uxGvWYB1texm3z
        KbpQTbrPNQ2T2id6fSYcYvWSev+Iu7wWyOOXRzEOSttHEZaTH6tHoRV/zSpclx9VxZE1iLL
        Ih7j43jGMAkAnjVCl9i1y0y+9SHB+U/+h8JIAYgsp/BzMNYCCMyZfl7Jt6Zvlk9aRuuHp9l
        PWRSpsC+lHVZvEEFWrFlhMxTkPjNgZ7mpdeuGN5dAnyIMXIf/HvE1MYPELHVeX2cAO6XMlt
        GaYMjBGX+pefc4a6a//FeY+DDFfeEW4pwS4w==
X-QQ-GoodBg: 0
From:   Shenghui Wang <shhuiw@foxmail.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] io_uring: free ctx->sq_ring if array size overflow detected in io_allocate_scq_urings
Date:   Sat, 27 Apr 2019 19:38:07 +0800
Message-Id: <20190427113807.4933-2-shhuiw@foxmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190427113807.4933-1-shhuiw@foxmail.com>
References: <20190427113807.4933-1-shhuiw@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgforeign:bgforeign4
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Free ctx->sq_ring before return -EOVERFLOW.

Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
---
 fs/io_uring.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 9d382ac27e63..6e1d22cbb029 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2743,8 +2743,10 @@ static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 	ctx->sq_mask = sq_ring->ring_mask;
 
 	size = array_size(sizeof(struct io_uring_sqe), p->sq_entries);
-	if (size == SIZE_MAX)
+	if (size == SIZE_MAX) {
+		io_mem_free(ctx->sq_ring);
 		return -EOVERFLOW;
+	}
 
 	ctx->sq_sqes = io_mem_alloc(size);
 	if (!ctx->sq_sqes) {
-- 
2.20.1



