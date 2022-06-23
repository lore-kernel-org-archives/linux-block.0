Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEF1C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiFWTBX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiFWTBK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:01:10 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D1F10E664
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:27 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id r1so18807623plo.10
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rKTCk58kKj6hHEYQUU+L0ZT122Mosw2WofE5kNcBd7s=;
        b=ZNf3+h4r1DYJsQ5+j01saz0K7CSFCzEkEk9ghxng3JqXTKdVHkenv1uZIdxBgsLzAX
         Xp6ZbeNWAx92/N7td7wfeBkKeAxTkHsuuC21bEmBYamkJ2Lony/Mq6IakxT5PYc856YS
         n4709HEUmepWlcpZtNS4q6biPNfHgXBf58k1WwHHw6WlZruMw+Lhh4DFPV4Y8lM+xaGX
         g1m/4kS9pV8fxGlR02eW7AKjj7Ss09qsl179UX6iaGCyrc6KvXTFO+vSGVz5F6j0n+w/
         xV8vq2NJbgya+NE7WvxdWarMpTAwVX+kgj9KTuFA4R875yd03eZsC/DK5BUWlxwKFLdn
         DTBA==
X-Gm-Message-State: AJIora/DGDMKDk17QX8KRQlQEyhuBICPbOc65pit2ltwmABygW7LJbHq
        Tc1WtTW0Pl9iiyOsTZXoVKm8D5xkmlY=
X-Google-Smtp-Source: AGRyM1tbpecTSmX2EedCxj4ZJMTK2rh/myShvZYksjOZtvo8Wj2rhzsxxdHn0ZeWVbdNHsjRlkuGRw==
X-Received: by 2002:a17:902:e807:b0:16a:471b:a4cc with SMTP id u7-20020a170902e80700b0016a471ba4ccmr9837713plg.102.1656007586465;
        Thu, 23 Jun 2022 11:06:26 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:25 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 33/51] scsi/ufs: Rename a 'dir' argument into 'op'
Date:   Thu, 23 Jun 2022 11:05:10 -0700
Message-Id: <20220623180528.3595304-34-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve consistency of the kernel code by renaming a request operation
argument from 'dir' into 'op'.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufshpb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufshpb.c b/drivers/ufs/core/ufshpb.c
index 24f1ee82c215..a1a7a1175a5a 100644
--- a/drivers/ufs/core/ufshpb.c
+++ b/drivers/ufs/core/ufshpb.c
@@ -434,7 +434,7 @@ int ufshpb_prep(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 }
 
 static struct ufshpb_req *ufshpb_get_req(struct ufshpb_lu *hpb, int rgn_idx,
-					 enum req_op dir, bool atomic)
+					 enum req_op op, bool atomic)
 {
 	struct ufshpb_req *rq;
 	struct request *req;
@@ -445,7 +445,7 @@ static struct ufshpb_req *ufshpb_get_req(struct ufshpb_lu *hpb, int rgn_idx,
 		return NULL;
 
 retry:
-	req = blk_mq_alloc_request(hpb->sdev_ufs_lu->request_queue, dir,
+	req = blk_mq_alloc_request(hpb->sdev_ufs_lu->request_queue, op,
 			      BLK_MQ_REQ_NOWAIT);
 
 	if (!atomic && (PTR_ERR(req) == -EWOULDBLOCK) && (--retries > 0)) {
