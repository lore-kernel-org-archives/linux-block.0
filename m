Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FB8C433F5
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 19:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239096AbiA0THx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 14:07:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55655 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229628AbiA0THx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 14:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643310472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=2JN+LOniMXFro+iNkmrv3NdOziHLaBtesI3NZwO1yaE=;
        b=EEEN03l57jZDVfr2SVTKzabGHyEv4CU8MeMbXFJwWrxUDq8YGhPRv3BWDjZDkz6UF2AVUE
        mnNqN6HIs3nAfUOo5xV76DKEo1NmUhwk988v0SSiAx0K4z1RbWpTmCzprneQQPCIxkh96y
        SjYM4l94Z3HFHsemBHa3bT349BJ7cwM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-NprfTgN7MRipL08zb6yZZw-1; Thu, 27 Jan 2022 14:07:50 -0500
X-MC-Unique: NprfTgN7MRipL08zb6yZZw-1
Received: by mail-qt1-f197.google.com with SMTP id 22-20020ac85656000000b002d2426b6fc1so2913577qtt.15
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 11:07:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2JN+LOniMXFro+iNkmrv3NdOziHLaBtesI3NZwO1yaE=;
        b=y4gUH8zGHUc02jSXJR1lRtx1QXcvuEwYOSro3X6RoLzXTLJTOo7aXUBH5n0IJnVzwl
         lSGHKBgWp0cdS9aRPLwz9jlOP2KsfS3EqqBVX7INNgHJgSB+OSQO0hB4d7giICxprg9z
         KMyCzYgM7ar1khQRhdilNihrDk3z85ROSVX3cSdsGpjaS/0KbtQNd/T5MsB1J3oyd3VO
         At0MnsFudcxzSS1msi41xJW8wIKz64uBo18AjlYmiSV9xhwPvWva5Sz/8nt5Us2OWkPS
         k+6W1yRM3l/YOnC489SWZK2kM5SntJVVKWDLDLuiLcPI6fMGdYIQ8JdemQ39e9ENj6nG
         nyKw==
X-Gm-Message-State: AOAM531/D12NJaENF3dOc6dYv/za1TBoYAmsIX37GsZDmLfVO1TPXuJg
        w1kXBEj06+6yRVfN+uP5f9arTOAuX5ZlOEX4Yl24rhFdh7YigBvYU4GaxMs6OhC/0RImzG0aja0
        zvgsRgNo5DwqLTA7E2BJDrw==
X-Received: by 2002:a05:620a:138c:: with SMTP id k12mr3748668qki.727.1643310469474;
        Thu, 27 Jan 2022 11:07:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy8y8ISQKT74HIcxOb8RAwKBCEXzsuDElroT3TNZEEsMsmQR/6TnFw9eNzPzOVsNXWHOn5Kdw==
X-Received: by 2002:a05:620a:138c:: with SMTP id k12mr3748651qki.727.1643310469289;
        Thu, 27 Jan 2022 11:07:49 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id k15sm2076787qko.82.2022.01.27.11.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 11:07:48 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     axboe@kernel.dk
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 3/3] dm: properly fix redundant bio-based IO accounting
Date:   Thu, 27 Jan 2022 14:07:42 -0500
Message-Id: <20220127190742.12776-4-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220127190742.12776-1-snitzer@redhat.com>
References: <20220127190742.12776-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Record the start_time for a bio but defer the starting block core's IO
accounting until after IO is submitted using __bio_start_io_acct().

This approach avoids the need to mess around with any of the
individual IO stats in response to a bio_split() that follows bio
submission.

Reported-by: Bud Brown <bubrown@redhat.com>
Cc: stable@vger.kernel.org
Depends-on: e8d7405fccc6 ("block: add __bio_start_io_acct() to control start_time")
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 9849114b3c08..144436301a57 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -489,7 +489,7 @@ static void start_io_acct(struct dm_io *io)
 	struct mapped_device *md = io->md;
 	struct bio *bio = io->orig_bio;
 
-	io->start_time = bio_start_io_acct(bio);
+	__bio_start_io_acct(bio, io->start_time);
 	if (unlikely(dm_stats_used(&md->stats)))
 		dm_stats_account_io(&md->stats, bio_data_dir(bio),
 				    bio->bi_iter.bi_sector, bio_sectors(bio),
@@ -535,7 +535,7 @@ static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio)
 	io->md = md;
 	spin_lock_init(&io->endio_lock);
 
-	start_io_acct(io);
+	io->start_time = READ_ONCE(jiffies);
 
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

