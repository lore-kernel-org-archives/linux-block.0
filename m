Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EAFC4167D
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 15:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349828AbiA1P7B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jan 2022 10:59:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35178 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349795AbiA1P6u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jan 2022 10:58:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643385529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=c3s11MYpaHLkMPB6MRaVylhz5gNk+Yl6C2qy7I40rZo=;
        b=WZSwZ1AMD8jyZfhdrCSDDw58m/jIAfBSzrde0okAxb26NdYtNsaynVyIwNS3+cdep+ffQ3
        ejXyyE7x8iTROujlpaMazZNmwOW+I2UOsOTj+yMSUNVP8lp11WiuiTTnZLGt+Sj43C7FpX
        LEWhyETbhaYC55UsH7ju6vsPlmYVOWA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-muXGK68SMAShArU2ulTiww-1; Fri, 28 Jan 2022 10:58:48 -0500
X-MC-Unique: muXGK68SMAShArU2ulTiww-1
Received: by mail-qt1-f197.google.com with SMTP id y22-20020ac87c96000000b002d1bfdbd86dso4792920qtv.20
        for <linux-block@vger.kernel.org>; Fri, 28 Jan 2022 07:58:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c3s11MYpaHLkMPB6MRaVylhz5gNk+Yl6C2qy7I40rZo=;
        b=acbDsb68BVvq0/zX13NQyAXIo37xmBFvK02bFDPlYN04pdroSkKD35aoI61jMUGgvd
         yUpbSK6CWmy+CujT6pSir3zb3o0XOQorms40t4/itGmjv5PfKZje7Aijf5WutFAw9rVP
         pL8nrMrOW3ZvbVFHL3jDUVfQk5tOb2hfP6yMHh2kfwQ7bMxWqf/l51s5JYb7HX0qqkmZ
         FnAckJmEmeRk5Xrq2UmTcJudtTI+/LYYn2gnR+qB/4vmjTxkd+/5xnTidCZC9LM8/7ls
         jFc8l3g4KrlxvnQ/TDF6FmlC3SaaWnUHTquX3Dqf18VpAd7biieUCizbWIKwRxxHn9vU
         ZnoQ==
X-Gm-Message-State: AOAM531PXIcqlLYr1/pponggpYZnqPcZBOvSqpBTlhUVsK6vp/dFu8x+
        0ipmTY+15EFSHJjJQuDIvAvzppKAhvd2h+r7qCky+gmTngfboe16Fsc1ZZarS0W7J66XJXf4WMX
        uZf9hUzSvPBB9Hkxa1iiCmA==
X-Received: by 2002:ad4:5c4f:: with SMTP id a15mr7612218qva.37.1643385527769;
        Fri, 28 Jan 2022 07:58:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyicgWAEB6ayWqMlLhzSn7kxy+IJwfePHjuqVVRWhOwQ3qf8gee6U9e8wmQ3bOt09J6PLJR5w==
X-Received: by 2002:ad4:5c4f:: with SMTP id a15mr7612210qva.37.1643385527577;
        Fri, 28 Jan 2022 07:58:47 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id l11sm3665173qkp.86.2022.01.28.07.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 07:58:47 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH v4 3/3] dm: properly fix redundant bio-based IO accounting
Date:   Fri, 28 Jan 2022 10:58:41 -0500
Message-Id: <20220128155841.39644-4-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220128155841.39644-1-snitzer@redhat.com>
References: <20220128155841.39644-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Record the start_time for a bio but defer the starting block core's IO
accounting until after IO is submitted using bio_start_io_acct_time().

This approach avoids the need to mess around with any of the
individual IO stats in response to a bio_split() that follows bio
submission.

Reported-by: Bud Brown <bubrown@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org
Depends-on: 1073e8492f88 ("block: add bio_start_io_acct_time() to control start_time")
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 9849114b3c08..dcbd6d201619 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -489,7 +489,7 @@ static void start_io_acct(struct dm_io *io)
 	struct mapped_device *md = io->md;
 	struct bio *bio = io->orig_bio;
 
-	io->start_time = bio_start_io_acct(bio);
+	bio_start_io_acct_time(bio, io->start_time);
 	if (unlikely(dm_stats_used(&md->stats)))
 		dm_stats_account_io(&md->stats, bio_data_dir(bio),
 				    bio->bi_iter.bi_sector, bio_sectors(bio),
@@ -535,7 +535,7 @@ static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio)
 	io->md = md;
 	spin_lock_init(&io->endio_lock);
 
-	start_io_acct(io);
+	io->start_time = jiffies;
 
 	return io;
 }
@@ -1482,6 +1482,7 @@ static void __split_and_process_bio(struct mapped_device *md,
 			submit_bio_noacct(bio);
 		}
 	}
+	start_io_acct(ci.io);
 
 	/* drop the extra reference count */
 	dm_io_dec_pending(ci.io, errno_to_blk_status(error));
-- 
2.15.0

