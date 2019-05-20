Return-Path: <SRS0=zuir=TU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6272EC04AAC
	for <linux-block@archiver.kernel.org>; Mon, 20 May 2019 14:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386B3214AE
	for <linux-block@archiver.kernel.org>; Mon, 20 May 2019 14:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="klc8jCf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732627AbfETOOx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 May 2019 10:14:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56830 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732112AbfETOOx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 May 2019 10:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NPQTfzA3xSQCanDPEw/jzPQJQu9EGXFMmFTekbPJr30=; b=klc8jCf+jbKddpqPX+epNq5ej
        J/3NFANXfHmkSK8zuJ5gyHQW+FZ4J+Tdsvv8NfCz/tAfJLcMVq1zJK+HurzTSTAMhJaJnNdBjs7Bh
        qbdTudVHZFsq0HAFTCHVCQIQAc7rhuK05hDUb42lP0mcrthhz3alZ9clOCQErB7g8xNev58K+8jHj
        8vr9i3DSSv5SZyYx8f+K+7/Ed0eFBfUorxDhvxuAca0GrFxmnsm1vbGdKvxssTc82luSMkB7Jv1wZ
        I3Xuhs6CkC8VutZ+ZdgdjztslwCn9JaAUd9qwdCh1CYRKSRxrs0hssdLHv2kEyYzwj5ecbmIxYgJY
        nbVsnsenA==;
Received: from 089144206147.atnat0015.highway.bob.at ([89.144.206.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSj40-0000Ev-Fu; Mon, 20 May 2019 14:14:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: improve print_req_error
Date:   Mon, 20 May 2019 16:13:59 +0200
Message-Id: <20190520141359.30027-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Print the calling function instead of print_req_error as a prefix, and
print the operation and op_flags separately instrad of the whole field.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 419d600e6637..b1f7e244340e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -167,18 +167,20 @@ int blk_status_to_errno(blk_status_t status)
 }
 EXPORT_SYMBOL_GPL(blk_status_to_errno);
 
-static void print_req_error(struct request *req, blk_status_t status)
+static void print_req_error(struct request *req, blk_status_t status,
+		const char *caller)
 {
 	int idx = (__force int)status;
 
 	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(blk_errors)))
 		return;
 
-	printk_ratelimited(KERN_ERR "%s: %s error, dev %s, sector %llu flags %x\n",
-				__func__, blk_errors[idx].name,
-				req->rq_disk ?  req->rq_disk->disk_name : "?",
-				(unsigned long long)blk_rq_pos(req),
-				req->cmd_flags);
+	printk_ratelimited(KERN_ERR
+		"%s: %s error, dev %s, sector %llu op 0x%x flags 0x%x\n",
+		caller, blk_errors[idx].name,
+		req->rq_disk ?  req->rq_disk->disk_name : "?",
+		blk_rq_pos(req), req_op(req),
+		req->cmd_flags & ~REQ_OP_MASK);
 }
 
 static void req_bio_endio(struct request *rq, struct bio *bio,
@@ -1418,7 +1420,7 @@ bool blk_update_request(struct request *req, blk_status_t error,
 
 	if (unlikely(error && !blk_rq_is_passthrough(req) &&
 		     !(req->rq_flags & RQF_QUIET)))
-		print_req_error(req, error);
+		print_req_error(req, error, __func__);
 
 	blk_account_io_completion(req, nr_bytes);
 
-- 
2.20.1

