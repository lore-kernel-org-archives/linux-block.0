Return-Path: <SRS0=ap3D=CU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B4BC2BC11
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 21:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBF0C22208
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 21:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmMBvAQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgIKVxq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Sep 2020 17:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgIKVxm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Sep 2020 17:53:42 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3F0C061757
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2020 14:53:42 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id v54so9094619qtj.7
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2020 14:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p0AgwegfJk6uZfD0nMSn2ocvdLTNtvY1TgQDTCc+R4g=;
        b=BmMBvAQPizWki1G9HXUVUOlvXIGF0lmWAr2CbUYPi/d58Ea2Gcl/WtD13S79GTXBx2
         2EYxZTrkk3pXR3NxxPMr5KuGlLCtFYpaKoxjdliXWXdcTG4xFQPzbDsQ2tFi7Sq3WoDn
         CVawx9RFhwrde5+fnspvZ675TwYbfzibmqOaoH/3vMd6Xj3zzCTxyr7oUxy7CaIn/3jY
         iHkfw3dS2dUnfCfl6GZhWeV3EVA6UMzNimKXflCBJzy9acfCgzx80GBqqj8t2zMObgZo
         pljPIgwGIS+o5aelun3NVWRcmUjTpLn/Em8FLQbKo9J5DEuIKy5KXPwLo9CwovEqD21x
         gQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=p0AgwegfJk6uZfD0nMSn2ocvdLTNtvY1TgQDTCc+R4g=;
        b=Os/0zJkveTL39dQeMcgJG8SteCOWG7Zdn3vpKPH/1HGtHMRj33jjXgPHUzeGsqvl33
         E2GEU6pajSOndLq3DZAMS2S4NbAPvFdb8inamKMo8uO0fuc7BaDXVdwvGZPgwmUNvThB
         puPgkXD2XlRZfmz+3JKqbouSNSbBKXsZMYq2fM+UwIjzTFWmteAZ+8Mr0DcmAfEsD5+z
         daQqXafx2QhLEoacvD7x7guJo9Kad6WTdK50zzf1wfI3yz2rhcQ8i8h7df+gzSmFbU67
         35rXpogq6ez1UddYP4i3Quikls0EzcQf4FAtBW8WlB7UjJt7TTIAOyZfhnz+/XYhYY87
         t72w==
X-Gm-Message-State: AOAM531XFwpMVZ/gvC51ZWR5Iii25lP990kt2lmLsLRz4R5nzLjtQ3Jb
        sk7GhUmxNXHGL0YYtj56niU=
X-Google-Smtp-Source: ABdhPJxS62mFnmJmeEU6DtwZij4rhz+l6eaC1J9f8aEST+av5WDf61y6CcNxX10pGo483sQiSfl21w==
X-Received: by 2002:aed:2555:: with SMTP id w21mr4007348qtc.132.1599861221854;
        Fri, 11 Sep 2020 14:53:41 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id g203sm4551960qkb.51.2020.09.11.14.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 14:53:41 -0700 (PDT)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Vijayendra Suman <vijayendra.suman@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 1/3] block: fix blk_rq_get_max_sectors() to flow more carefully
Date:   Fri, 11 Sep 2020 17:53:36 -0400
Message-Id: <20200911215338.44805-2-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200911215338.44805-1-snitzer@redhat.com>
References: <20200911215338.44805-1-snitzer@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_queue_get_max_sectors() has been trained for REQ_OP_WRITE_SAME and
REQ_OP_WRITE_ZEROES yet blk_rq_get_max_sectors() didn't call it for
those operations.

Also, there is no need to avoid blk_max_size_offset() if
'chunk_sectors' isn't set because it falls back to 'max_sectors'.

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 include/linux/blkdev.h | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bb5636cc17b9..453a3d735d66 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1070,17 +1070,24 @@ static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
 						  sector_t offset)
 {
 	struct request_queue *q = rq->q;
+	int op;
+	unsigned int max_sectors;
 
 	if (blk_rq_is_passthrough(rq))
 		return q->limits.max_hw_sectors;
 
-	if (!q->limits.chunk_sectors ||
-	    req_op(rq) == REQ_OP_DISCARD ||
-	    req_op(rq) == REQ_OP_SECURE_ERASE)
-		return blk_queue_get_max_sectors(q, req_op(rq));
+	op = req_op(rq);
+	max_sectors = blk_queue_get_max_sectors(q, op);
 
-	return min(blk_max_size_offset(q, offset),
-			blk_queue_get_max_sectors(q, req_op(rq)));
+	switch (op) {
+	case REQ_OP_DISCARD:
+	case REQ_OP_SECURE_ERASE:
+	case REQ_OP_WRITE_SAME:
+	case REQ_OP_WRITE_ZEROES:
+		return max_sectors;
+	}
+
+	return min(blk_max_size_offset(q, offset), max_sectors);
 }
 
 static inline unsigned int blk_rq_count_bios(struct request *rq)
-- 
2.15.0

