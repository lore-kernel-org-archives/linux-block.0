Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0D3C433FE
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 21:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353781AbiBKVl0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 16:41:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353779AbiBKVlZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 16:41:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25FC7C73
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 13:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644615682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=0iX5cBRgHe/bSS7YT5ZJ9ztGvi8JUB0cZ1xYv+ukKb0=;
        b=KV9OnyIcTjdPfhDUwOejd4VhvmV/gmyAif4byJoGvO8PsouQsxt2wddH+vg3IBEegZvVOq
        ERBGp+nvXaEUc9mY5jefc/lQf4NccGls3cd+AHE6jaevOU+qJjmrjJqTbgCXdYEKRlyBd8
        bbQysFdwj55o8AP3IbpqxJke60JGk6Q=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-ZsbPjZ2KO3mpS-czXpJSJQ-1; Fri, 11 Feb 2022 16:41:21 -0500
X-MC-Unique: ZsbPjZ2KO3mpS-czXpJSJQ-1
Received: by mail-ot1-f69.google.com with SMTP id j2-20020a9d7d82000000b005a12a0fb4b0so6043879otn.5
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 13:41:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0iX5cBRgHe/bSS7YT5ZJ9ztGvi8JUB0cZ1xYv+ukKb0=;
        b=WhwlbfXrefu9QkYns7Abdk16tIX0c7brTnupT9wBHZSmh+ltn8imyOd6Eim06DK2E7
         dGK0VrCP0ubclkar0nbwDBnZ6cb0WvSKIBSrsSV1Wb0TYjd/PoJtIMWbcQwyQr1Jaywf
         3mFNR19Dv06774oLeO0g0ImDC8sw/deQMZjwooAWM2C2uiaDw8tdQMrV9PirrQlZSK7n
         dJCyPpmCNheIYcbnHiFYuroMffYl0zcsYsRFQJe8Gt/8fc4pMTxgWtTgsmIW16lNNbr3
         TIS0V2g24Ss81TMho8LKFTE1OW+AAQUl54wcOHc95nX0M1BjuBJtMGiaBGvGqO9aikoO
         00Zg==
X-Gm-Message-State: AOAM530S1IArB7CU2OyXR1cMafvqOWndrq4DFNak1AVMQwjuU/3JQyDJ
        AYVRQBrVgFdzZsTkWv5GHAt9n04Kq+w4tZF6xgLpAW53gqtr+/kCh5VPMowwX6X4yg36+Ty2cTr
        Z0jCWXKCJiughLqmnFW5RRA==
X-Received: by 2002:a05:6870:3815:: with SMTP id y21mr801773oal.330.1644615680062;
        Fri, 11 Feb 2022 13:41:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhaY79cQa6rRIF6xGYCLQRnDZ3YcQEltVBHgKRWycktiay6UBHrlSniHAxFVmlgiQyEikfMQ==
X-Received: by 2002:a05:6870:3815:: with SMTP id y21mr801770oal.330.1644615679858;
        Fri, 11 Feb 2022 13:41:19 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id u32sm6180621oiw.28.2022.02.11.13.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 13:41:19 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH v2 09/14] dm: move kicking of suspend queue to dm_io_dec_pending
Date:   Fri, 11 Feb 2022 16:40:52 -0500
Message-Id: <20220211214057.40612-10-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220211214057.40612-1-snitzer@redhat.com>
References: <20220211214057.40612-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move kicking of the suspend queue to dm_io_dec_pending (the only
caller) since end_io_acct will soon only be called if IO accounting
was started.

Also, some comment tweaks and removal of local variables.
No functional change.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 2f2002348b26..72686329f91e 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -487,12 +487,12 @@ EXPORT_SYMBOL_GPL(dm_start_time_ns_from_clone);
 
 static void start_io_acct(struct dm_io *io)
 {
-	struct mapped_device *md = io->md;
 	struct bio *bio = io->orig_bio;
 
 	bio_start_io_acct_time(bio, io->start_time);
-	if (unlikely(dm_stats_used(&md->stats)))
-		dm_stats_account_io(&md->stats, bio_data_dir(bio),
+
+	if (unlikely(dm_stats_used(&io->md->stats)))
+		dm_stats_account_io(&io->md->stats, bio_data_dir(bio),
 				    bio->bi_iter.bi_sector, bio_sectors(bio),
 				    false, 0, &io->stats_aux);
 }
@@ -500,18 +500,12 @@ static void start_io_acct(struct dm_io *io)
 static void end_io_acct(struct mapped_device *md, struct bio *bio,
 			unsigned long start_time, struct dm_stats_aux *stats_aux)
 {
-	unsigned long duration = jiffies - start_time;
-
 	bio_end_io_acct(bio, start_time);
 
 	if (unlikely(dm_stats_used(&md->stats)))
 		dm_stats_account_io(&md->stats, bio_data_dir(bio),
 				    bio->bi_iter.bi_sector, bio_sectors(bio),
-				    true, duration, stats_aux);
-
-	/* nudge anyone waiting on suspend queue */
-	if (unlikely(wq_has_sleeper(&md->wait)))
-		wake_up(&md->wait);
+				    true, jiffies - start_time, stats_aux);
 }
 
 static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio)
@@ -829,6 +823,10 @@ void dm_io_dec_pending(struct dm_io *io, blk_status_t error)
 		free_io(io);
 		end_io_acct(md, bio, start_time, &stats_aux);
 
+		/* nudge anyone waiting on suspend queue */
+		if (unlikely(wq_has_sleeper(&md->wait)))
+			wake_up(&md->wait);
+
 		if (io_error == BLK_STS_DM_REQUEUE)
 			return;
 
@@ -1127,9 +1125,7 @@ static void __map_bio(struct bio *clone)
 	clone->bi_end_io = clone_endio;
 
 	/*
-	 * Map the clone.  If r == 0 we don't need to do
-	 * anything, the target has assumed ownership of
-	 * this io.
+	 * Map the clone.
 	 */
 	dm_io_inc_pending(io);
 	tio->old_sector = clone->bi_iter.bi_sector;
@@ -1154,6 +1150,7 @@ static void __map_bio(struct bio *clone)
 
 	switch (r) {
 	case DM_MAPIO_SUBMITTED:
+		/* target has assumed ownership of this io */
 		break;
 	case DM_MAPIO_REMAPPED:
 		/* the bio has been remapped so dispatch it */
@@ -1301,10 +1298,9 @@ static bool is_abnormal_io(struct bio *bio)
 static bool __process_abnormal_io(struct clone_info *ci, struct dm_target *ti,
 				  int *result)
 {
-	struct bio *bio = ci->bio;
 	unsigned num_bios = 0;
 
-	switch (bio_op(bio)) {
+	switch (bio_op(ci->bio)) {
 	case REQ_OP_DISCARD:
 		num_bios = ti->num_discard_bios;
 		break;
-- 
2.15.0

