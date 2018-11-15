Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6655CC43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 19:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D333208E7
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 19:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="2RATox6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D333208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbeKPGBO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:01:14 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36192 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeKPGBO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 01:01:14 -0500
Received: by mail-pg1-f196.google.com with SMTP id n2so2298137pgm.3
        for <linux-block@vger.kernel.org>; Thu, 15 Nov 2018 11:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fz9g1ov0KEBk0jca5hC7QbGAUKLsaBIiDlim4iRDh3o=;
        b=2RATox6BMIW4EUoQcZ4YDFq8hclWiTuXeB0mphIjgCKp5th1/sVoIJ8ylG8PQoF2DZ
         NreEVIM6RSDoPPZBYglwNOHYxM6eH2ECaACQ+vstVVz64rVelgNDJbGTfTkX+90SuEdg
         Z0l50QcL7XI6neZX1tPhLZhdhaC4NcB/kMWonvxGLi4foG9GmsQyjSF68Hdal2lKxFZo
         VJozM1hrlqQL8XZVvCWGOcZLBY6h48g5dqXW1TwxQKmZoT87gFr24KncOm4Vg1F/0y+E
         BxYqKHt+kzOp/rjD0zkGtTUDs1+Jq4Uv4T+Uf0vr3ovf/z2p8un//jf5frh8aOju+3xr
         zd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fz9g1ov0KEBk0jca5hC7QbGAUKLsaBIiDlim4iRDh3o=;
        b=q9UB3fo9n83DqakGbuz26In2EL1VdbV+j6zN3inPODbuVgRdseSuNchk7BUgZz4+EF
         jjav8Ap5AuMadnJb4WtKagYaYD7ejnH7wPMH2VQ3/c7VRo4cCawu3Rwa3ltsyDzBRA+O
         n6lavGGe7KsbkwXRoeo7foWsjWetQ08KKntIpK34D/QRAMdVss5xN1xS03EAiYB12d+a
         cItHI59HsqgGT+AHA3uEtMvXj6IzzeFJ2wa5K7k+eZuVZvR0le6xaXmhtT8RX526d/M9
         gj0w+gug1wc82p8ord+BrBgHRMA6WR7y4razYq5DYp0e4s+mrfjKutVcuX/djIFkUDLv
         56Vg==
X-Gm-Message-State: AGRZ1gIpTVE8gWBgMdu7Ed5V3w6IawJnNleDSh95mxlP6TYNgMYFjpN7
        N7iz2CLSu9aNXVHtzaDZq5GErpU6Reo=
X-Google-Smtp-Source: AJdET5c7FMGsxqg4HwcXgEXNRIEpm3boNBIOUyyK+dfkELu4a+gcwhVkpHgjOTnVApGReG9hSNw6Ow==
X-Received: by 2002:a63:d747:: with SMTP id w7mr6918420pgi.360.1542311521459;
        Thu, 15 Nov 2018 11:52:01 -0800 (PST)
Received: from x1.localdomain ([2620:10d:c090:180::1:7813])
        by smtp.gmail.com with ESMTPSA id d68-v6sm30670766pfa.80.2018.11.15.11.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 11:52:00 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/11] block: don't plug for aio/O_DIRECT HIPRI IO
Date:   Thu, 15 Nov 2018 12:51:35 -0700
Message-Id: <20181115195135.22812-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181115195135.22812-1-axboe@kernel.dk>
References: <20181115195135.22812-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Those will go straight to issue inside blk-mq, so don't bother
setting up a block plug for them.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index c124982b810d..9dc695a3af4e 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -356,7 +356,13 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 	dio->multi_bio = false;
 	dio->should_dirty = is_read && iter_is_iovec(iter);
 
-	blk_start_plug(&plug);
+	/*
+	 * Don't plug for HIPRI/polled IO, as those should go straight
+	 * to issue
+	 */
+	if (!(iocb->ki_flags & IOCB_HIPRI))
+		blk_start_plug(&plug);
+
 	for (;;) {
 		bio_set_dev(bio, bdev);
 		bio->bi_iter.bi_sector = pos >> 9;
@@ -403,7 +409,9 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		submit_bio(bio);
 		bio = bio_alloc(GFP_KERNEL, nr_pages);
 	}
-	blk_finish_plug(&plug);
+
+	if (!(iocb->ki_flags & IOCB_HIPRI))
+		blk_finish_plug(&plug);
 
 	if (!is_sync)
 		return -EIOCBQUEUED;
-- 
2.17.1

