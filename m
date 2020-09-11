Return-Path: <SRS0=ap3D=CU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF35C43461
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 21:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C211722208
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 21:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPXM/BJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgIKVxx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Sep 2020 17:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbgIKVxq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Sep 2020 17:53:46 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BEEC061757
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2020 14:53:45 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id j10so5963633qvk.11
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2020 14:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GRLBuD8wBJFxDc/w03BbrMXmSaW8vxwnTTNt5AMacZQ=;
        b=IPXM/BJtVSbF56WFe+dQGDaehyeUbURYvNrpuzgrIzX3UTUu7Oaco/K4wT2FeKyyOK
         U7geWRKYjYdCkT7LgB6R4zaN8X3tyNK+uCz6aKnVIU3d3ToeefD/Dy5CuVEkoBefitIi
         y54wKDWyNTB2xvQgGVs0E9ZbTGG5gQZni4Y7LLnbzkkngWEi2PNm9ncCmzImmt9MWpSk
         9q4bzDU/neKadPtArd/684GHDAYe3QAdstNW41KG7ZZgfutChA4wzds9kFl/CY+qd4sH
         PyYaHxodpympljX4CK21q3ParOF11Gh2pTiDu6avpdoKKyAMjTVsGuWgtm2GeJJDd5V6
         TU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=GRLBuD8wBJFxDc/w03BbrMXmSaW8vxwnTTNt5AMacZQ=;
        b=pLh36Nqj0F9LTJMq0n9zhkHj2DaWJXcCMdnezYYlYPpukgIUvtLa8ksJhIvLwgIOZi
         alT+mrd9XlLvWyAM3WScsm+rnsUJRfvjL7ZB+k2fB0vgtKBeYCvyjBJ2aaCuE8MUpEt1
         BfmzaVUuio6iaWq03aF6JQdNa0sPPqrgCB/uRhyq5jjjBMfMb1RRHrLbo+1wBeiPOBw6
         WUO/7ufIjhPeI57l67Ki15FOe7GvGRSp+bCCcyr/MoFBTnVknaMiCjhCriOXJGsgo0XJ
         XLJFh860jMTJl4D2uF+vrVdmphzWk4BmYtYyfEWFTt1d9kzv1WrluJAdij+L9rGYFXPr
         ubHg==
X-Gm-Message-State: AOAM533EXJcpls32mXSLwy9HrBUxBkXjGi/IAGsk1x01l6dAn/fhVvlQ
        lAaFs81IcJsCI0WUxtCe4EGaRwefOV4=
X-Google-Smtp-Source: ABdhPJx27ClViUb7nTbJhj32Atvn5BloXIPBVOd8RavvWX13r9fIuwblDEfzORG3/z0J6FmmbPsPsA==
X-Received: by 2002:ad4:408f:: with SMTP id l15mr3987842qvp.4.1599861224845;
        Fri, 11 Sep 2020 14:53:44 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id g4sm3909063qth.30.2020.09.11.14.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 14:53:44 -0700 (PDT)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Vijayendra Suman <vijayendra.suman@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 3/3] block: allow 'chunk_sectors' to be non-power-of-2
Date:   Fri, 11 Sep 2020 17:53:38 -0400
Message-Id: <20200911215338.44805-4-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200911215338.44805-1-snitzer@redhat.com>
References: <20200911215338.44805-1-snitzer@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is possible for a block device to use a non power-of-2 for chunk
size which results in a full-stripe size that is also a non
power-of-2.

Update blk_queue_chunk_sectors() and blk_max_size_offset() to
accommodate drivers that need a non power-of-2 chunk_sectors.

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 block/blk-settings.c   | 10 ++++------
 include/linux/blkdev.h | 12 +++++++++---
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index b09642d5f15e..e40a162cc946 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -172,15 +172,13 @@ EXPORT_SYMBOL(blk_queue_max_hw_sectors);
  *
  * Description:
  *    If a driver doesn't want IOs to cross a given chunk size, it can set
- *    this limit and prevent merging across chunks. Note that the chunk size
- *    must currently be a power-of-2 in sectors. Also note that the block
- *    layer must accept a page worth of data at any offset. So if the
- *    crossing of chunks is a hard limitation in the driver, it must still be
- *    prepared to split single page bios.
+ *    this limit and prevent merging across chunks. Note that the block layer
+ *    must accept a page worth of data at any offset. So if the crossing of
+ *    chunks is a hard limitation in the driver, it must still be prepared
+ *    to split single page bios.
  **/
 void blk_queue_chunk_sectors(struct request_queue *q, unsigned int chunk_sectors)
 {
-	BUG_ON(!is_power_of_2(chunk_sectors));
 	q->limits.chunk_sectors = chunk_sectors;
 }
 EXPORT_SYMBOL(blk_queue_chunk_sectors);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 453a3d735d66..e72bcce22143 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1059,11 +1059,17 @@ static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
 static inline unsigned int blk_max_size_offset(struct request_queue *q,
 					       sector_t offset)
 {
-	if (!q->limits.chunk_sectors)
+	unsigned int chunk_sectors = q->limits.chunk_sectors;
+
+	if (!chunk_sectors)
 		return q->limits.max_sectors;
 
-	return min(q->limits.max_sectors, (unsigned int)(q->limits.chunk_sectors -
-			(offset & (q->limits.chunk_sectors - 1))));
+	if (is_power_of_2(chunk_sectors))
+		chunk_sectors -= (offset & (chunk_sectors - 1));
+	else
+		chunk_sectors -= sector_div(offset, chunk_sectors);
+
+	return min(q->limits.max_sectors, chunk_sectors);
 }
 
 static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
-- 
2.15.0

