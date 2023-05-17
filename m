Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18D8C77B75
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 17:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjEQRpk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 13:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjEQRpf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 13:45:35 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7156E8D
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 10:45:06 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6434e263962so822574b3a.2
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 10:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684345486; x=1686937486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMWr+MCtsGHi9OfvspnRheUM1pYYUBU4HUhQP6OfIrk=;
        b=KgySUTQ2k0QgNGyA5EKMXILEjGTgsJLa93Y+vSKbTp7350AP/2zbZbeyD7M28AOmZ2
         ZE23NZgeVw3QAKOoIIwWaTHxohtWmd/H09QsdKKSRxiDnFOL1z0jk1cLPeNEm8a+jIzD
         9c0n5W8aOUMD6IKKtIfc5TDPv/9we0CrrrIyPdrOBWDraEIcHVVuofiNtUkGgrBqry41
         Sy7dUmcW997/U4CD0VQneZaqTXH6p410OzODX75FJ/2rZyQ2P7CFxICdbsMLB+MRT8ny
         aUrFUzi1Tj+pPK4iED1Cy1jbTHRkybVpkPqGZFh8Wo1jhi85FsJzY2WiPNXU+F7UVNHf
         tziw==
X-Gm-Message-State: AC+VfDy/i5TyupogaPs9IR37GQ1pw/bAdS2Q6+Gv7TOKGun6fhYDg3TK
        vWdGcpLBCwYOfc1EW//3tL8=
X-Google-Smtp-Source: ACHHUZ6P1rJLTdB0rFmkiZVXeteMzqjTcPJn4nDwb4/IziyOcrgkBwFBD+2UPQ8pmiuCgVgq9naoDg==
X-Received: by 2002:a05:6a00:80e:b0:62a:4503:53ba with SMTP id m14-20020a056a00080e00b0062a450353bamr524190pfk.26.1684345486119;
        Wed, 17 May 2023 10:44:46 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id d22-20020aa78e56000000b00646e7d2b5a7sm15334410pfr.112.2023.05.17.10.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:44:45 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v6 11/11] block: mq-deadline: Fix handling of at-head zoned writes
Date:   Wed, 17 May 2023 10:42:29 -0700
Message-ID: <20230517174230.897144-12-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230517174230.897144-1-bvanassche@acm.org>
References: <20230517174230.897144-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Before dispatching a zoned write from the FIFO list, check whether there
are any zoned writes in the RB-tree with a lower LBA for the same zone.
This patch ensures that zoned writes happen in order even if at_head is
set for some writes for a zone and not for others.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index e90879869c90..6aa5daf7ae32 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -346,7 +346,7 @@ static struct request *
 deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 		      enum dd_data_dir data_dir)
 {
-	struct request *rq;
+	struct request *rq, *rb_rq, *next;
 	unsigned long flags;
 
 	if (list_empty(&per_prio->fifo_list[data_dir]))
@@ -364,7 +364,12 @@ deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 	 * zones and these zones are unlocked.
 	 */
 	spin_lock_irqsave(&dd->zone_lock, flags);
-	list_for_each_entry(rq, &per_prio->fifo_list[DD_WRITE], queuelist) {
+	list_for_each_entry_safe(rq, next, &per_prio->fifo_list[DD_WRITE],
+				 queuelist) {
+		/* Check whether a prior request exists for the same zone. */
+		rb_rq = deadline_from_pos(per_prio, data_dir, blk_rq_pos(rq));
+		if (rb_rq && blk_rq_pos(rb_rq) < blk_rq_pos(rq))
+			rq = rb_rq;
 		if (blk_req_can_dispatch_to_zone(rq) &&
 		    (blk_queue_nonrot(rq->q) ||
 		     !deadline_is_seq_write(dd, rq)))
