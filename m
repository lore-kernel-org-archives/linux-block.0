Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F8FC433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Apr 2022 23:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiDLXVg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Apr 2022 19:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiDLXU7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Apr 2022 19:20:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6ADE1ECC7E
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 16:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649804464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gtZTurHW3+UJgerzL/YePT7n1vG3KGrW52nG09u/8dc=;
        b=YdXGNZ9qi0kKRJA4CJjmYh7z+cYqkmzb/bjT3V+bYdt+3DqyzU2e35kqPQDOZr8ngyUnQI
        xCOzph0Ncc3lZmBivDsLxVpgKq5P/hGSZd2i4S7hPjetz4C2ESuUKv9oSCLKjLuA9BDqpM
        i/N2JjJ1UnTKnAA6K9jyMpvzseN1y48=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-164-hB5Pt2EyMdOW9YB_LXZigw-1; Tue, 12 Apr 2022 19:01:03 -0400
X-MC-Unique: hB5Pt2EyMdOW9YB_LXZigw-1
Received: by mail-qv1-f69.google.com with SMTP id 33-20020a0c8024000000b0043d17ffb0bdso294020qva.18
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 16:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gtZTurHW3+UJgerzL/YePT7n1vG3KGrW52nG09u/8dc=;
        b=Xg+WlShBl4GLGKlYPHSdiJg1n6OK7DljiHtChnFVV16WPKG7CcrROSYSI7cv+9KuAe
         hvZXwnpwesGoPraHqaAAJhdITuGaWC4QxeV0LXzV0rB/6hDSTanfXoPWGlZXrSG0PueU
         EzV3iT3cnPcvva+VNQdSPiBseSwC28tt8oRoThxDI92a2j6/t8PSbkBx8+hBfnxIR37P
         950KsI/9jN2WzRuxFW2+ltumF9nuO6k99qipC8+NrN914MFGOWk7rsaBOMd0y25Ttxct
         hG9lpqO4DjAGjEu4otk26l/pL0er9nJJReeGbiFD9Hr3UafOV5BnGFagg1hEo/VF23g4
         lkqA==
X-Gm-Message-State: AOAM530q6RZxmFjdAhwwpHeR1WPg8Hf+Ih3oe8DpUAy/KptVPcaN1hWK
        jUoYMhNsunP+VqSsXs35/JqXH9XY8ACgOaBOcuWaw6BSxMuogGGv7dlMKnHuR4k7WM4GnyeMkCE
        kbdz44tenqg3BNp1FsvImQw==
X-Received: by 2002:a05:622a:34c:b0:2e1:df18:b837 with SMTP id r12-20020a05622a034c00b002e1df18b837mr5169616qtw.96.1649804461893;
        Tue, 12 Apr 2022 16:01:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygoHceLuBkgh44dxh633bwkp1AbYrrDsYNfb2O0i6d+W4oWXAOgVCddazPoY35EFraqMFD/g==
X-Received: by 2002:a05:622a:34c:b0:2e1:df18:b837 with SMTP id r12-20020a05622a034c00b002e1df18b837mr5169557qtw.96.1649804461218;
        Tue, 12 Apr 2022 16:01:01 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id br35-20020a05620a462300b0067e890073cbsm24308599qkb.6.2022.04.12.16.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 16:01:00 -0700 (PDT)
Date:   Tue, 12 Apr 2022 19:00:59 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH 5/8] dm: always setup ->orig_bio in alloc_io
Message-ID: <YlYEq0XC2XL6bv2b@redhat.com>
References: <20220412085616.1409626-1-ming.lei@redhat.com>
 <20220412085616.1409626-6-ming.lei@redhat.com>
 <YlXmmB6IO7usz2c1@redhat.com>
 <c4c83c0f-a4fc-2b37-180f-ccb272085fca@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4c83c0f-a4fc-2b37-180f-ccb272085fca@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 12 2022 at  6:38P -0400,
Damien Le Moal <damien.lemoal@opensource.wdc.com> wrote:

> On 4/13/22 05:52, Mike Snitzer wrote:
> > On Tue, Apr 12 2022 at  4:56P -0400,
> > Ming Lei <ming.lei@redhat.com> wrote:
> > 
> >> The current DM codes setup ->orig_bio after __map_bio() returns,
> >> and not only cause kernel panic for dm zone, but also a bit ugly
> >> and tricky, especially the waiting until ->orig_bio is set in
> >> dm_submit_bio_remap().
> >>
> >> The reason is that one new bio is cloned from original FS bio to
> >> represent the mapped part, which just serves io accounting.
> >>
> >> Now we have switched to bdev based io accounting interface, and we
> >> can retrieve sectors/bio_op from both the real original bio and the
> >> added fields of .sector_offset & .sectors easily, so the new cloned
> >> bio isn't necessary any more.
> >>
> >> Not only fixes dm-zone's kernel panic, but also cleans up dm io
> >> accounting & split a bit.
> > 
> > You're conflating quite a few things here.  DM zone really has no
> > business accessing io->orig_bio (dm-zone.c can just as easily inspect
> > the tio->clone, because it hasn't been remapped yet it reflects the
> > io->origin_bio, so there is no need to look at io->orig_bio) -- but
> > yes I clearly broke things during the 5.18 merge and it needs fixing
> > ASAP.
> 
> Problem is that we need to look at the BIO op in submission AND completion
> path to handle zone append requests. So looking at the clone on submission
> is OK since its op is still the original one. But on the completion path,
> the clone may now be a regular write emulating a zone append op. And
> looking at the clone only does not allow detecting that zone append.
> 
> We could have the orig_bio op saved in dm_io to avoid completely looking
> at the orig_bio for detecting zone append.

Can you please try the following patch?

Really sorry for breaking dm-zone.c; please teach this man how to test
the basics of all things dm-zoned (is there a testsuite in the tools
or something?).

Thanks,
Mike

diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index c1ca9be4b79e..896127366000 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -360,16 +360,20 @@ static int dm_update_zone_wp_offset(struct mapped_device *md, unsigned int zno,
 	return 0;
 }
 
+struct orig_bio_details {
+	unsigned int op;
+	unsigned int nr_sectors;
+};
+
 /*
  * First phase of BIO mapping for targets with zone append emulation:
  * check all BIO that change a zone writer pointer and change zone
  * append operations into regular write operations.
  */
-static bool dm_zone_map_bio_begin(struct mapped_device *md,
-				  struct bio *orig_bio, struct bio *clone)
+static bool dm_zone_map_bio_begin(struct mapped_device *md, unsigned int zno,
+				  struct bio *clone)
 {
 	sector_t zsectors = blk_queue_zone_sectors(md->queue);
-	unsigned int zno = bio_zone_no(orig_bio);
 	unsigned int zwp_offset = READ_ONCE(md->zwp_offset[zno]);
 
 	/*
@@ -384,7 +388,7 @@ static bool dm_zone_map_bio_begin(struct mapped_device *md,
 		WRITE_ONCE(md->zwp_offset[zno], zwp_offset);
 	}
 
-	switch (bio_op(orig_bio)) {
+	switch (bio_op(clone)) {
 	case REQ_OP_ZONE_RESET:
 	case REQ_OP_ZONE_FINISH:
 		return true;
@@ -401,9 +405,8 @@ static bool dm_zone_map_bio_begin(struct mapped_device *md,
 		 * target zone.
 		 */
 		clone->bi_opf = REQ_OP_WRITE | REQ_NOMERGE |
-			(orig_bio->bi_opf & (~REQ_OP_MASK));
-		clone->bi_iter.bi_sector =
-			orig_bio->bi_iter.bi_sector + zwp_offset;
+			(clone->bi_opf & (~REQ_OP_MASK));
+		clone->bi_iter.bi_sector += zwp_offset;
 		break;
 	default:
 		DMWARN_LIMIT("Invalid BIO operation");
@@ -423,11 +426,10 @@ static bool dm_zone_map_bio_begin(struct mapped_device *md,
  * data written to a zone. Note that at this point, the remapped clone BIO
  * may already have completed, so we do not touch it.
  */
-static blk_status_t dm_zone_map_bio_end(struct mapped_device *md,
-					struct bio *orig_bio,
+static blk_status_t dm_zone_map_bio_end(struct mapped_device *md, unsigned int zno,
+					struct orig_bio_details *orig_bio_details,
 					unsigned int nr_sectors)
 {
-	unsigned int zno = bio_zone_no(orig_bio);
 	unsigned int zwp_offset = READ_ONCE(md->zwp_offset[zno]);
 
 	/* The clone BIO may already have been completed and failed */
@@ -435,7 +437,7 @@ static blk_status_t dm_zone_map_bio_end(struct mapped_device *md,
 		return BLK_STS_IOERR;
 
 	/* Update the zone wp offset */
-	switch (bio_op(orig_bio)) {
+	switch (orig_bio_details->op) {
 	case REQ_OP_ZONE_RESET:
 		WRITE_ONCE(md->zwp_offset[zno], 0);
 		return BLK_STS_OK;
@@ -452,7 +454,7 @@ static blk_status_t dm_zone_map_bio_end(struct mapped_device *md,
 		 * Check that the target did not truncate the write operation
 		 * emulating a zone append.
 		 */
-		if (nr_sectors != bio_sectors(orig_bio)) {
+		if (nr_sectors != orig_bio_details->nr_sectors) {
 			DMWARN_LIMIT("Truncated write for zone append");
 			return BLK_STS_IOERR;
 		}
@@ -488,7 +490,7 @@ static inline void dm_zone_unlock(struct request_queue *q,
 	bio_clear_flag(clone, BIO_ZONE_WRITE_LOCKED);
 }
 
-static bool dm_need_zone_wp_tracking(struct bio *orig_bio)
+static bool dm_need_zone_wp_tracking(struct bio *clone)
 {
 	/*
 	 * Special processing is not needed for operations that do not need the
@@ -496,15 +498,15 @@ static bool dm_need_zone_wp_tracking(struct bio *orig_bio)
 	 * zones and all operations that do not modify directly a sequential
 	 * zone write pointer.
 	 */
-	if (op_is_flush(orig_bio->bi_opf) && !bio_sectors(orig_bio))
+	if (op_is_flush(clone->bi_opf) && !bio_sectors(clone))
 		return false;
-	switch (bio_op(orig_bio)) {
+	switch (bio_op(clone)) {
 	case REQ_OP_WRITE_ZEROES:
 	case REQ_OP_WRITE:
 	case REQ_OP_ZONE_RESET:
 	case REQ_OP_ZONE_FINISH:
 	case REQ_OP_ZONE_APPEND:
-		return bio_zone_is_seq(orig_bio);
+		return bio_zone_is_seq(clone);
 	default:
 		return false;
 	}
@@ -519,8 +521,8 @@ int dm_zone_map_bio(struct dm_target_io *tio)
 	struct dm_target *ti = tio->ti;
 	struct mapped_device *md = io->md;
 	struct request_queue *q = md->queue;
-	struct bio *orig_bio = io->orig_bio;
 	struct bio *clone = &tio->clone;
+	struct orig_bio_details orig_bio_details;
 	unsigned int zno;
 	blk_status_t sts;
 	int r;
@@ -529,18 +531,21 @@ int dm_zone_map_bio(struct dm_target_io *tio)
 	 * IOs that do not change a zone write pointer do not need
 	 * any additional special processing.
 	 */
-	if (!dm_need_zone_wp_tracking(orig_bio))
+	if (!dm_need_zone_wp_tracking(clone))
 		return ti->type->map(ti, clone);
 
 	/* Lock the target zone */
-	zno = bio_zone_no(orig_bio);
+	zno = bio_zone_no(clone);
 	dm_zone_lock(q, zno, clone);
 
+	orig_bio_details.nr_sectors = bio_sectors(clone);
+	orig_bio_details.op = bio_op(clone);
+
 	/*
 	 * Check that the bio and the target zone write pointer offset are
 	 * both valid, and if the bio is a zone append, remap it to a write.
 	 */
-	if (!dm_zone_map_bio_begin(md, orig_bio, clone)) {
+	if (!dm_zone_map_bio_begin(md, zno, clone)) {
 		dm_zone_unlock(q, zno, clone);
 		return DM_MAPIO_KILL;
 	}
@@ -560,7 +565,8 @@ int dm_zone_map_bio(struct dm_target_io *tio)
 		 * The target submitted the clone BIO. The target zone will
 		 * be unlocked on completion of the clone.
 		 */
-		sts = dm_zone_map_bio_end(md, orig_bio, *tio->len_ptr);
+		sts = dm_zone_map_bio_end(md, zno, &orig_bio_details,
+					  *tio->len_ptr);
 		break;
 	case DM_MAPIO_REMAPPED:
 		/*
@@ -568,7 +574,8 @@ int dm_zone_map_bio(struct dm_target_io *tio)
 		 * unlock the target zone here as the clone will not be
 		 * submitted.
 		 */
-		sts = dm_zone_map_bio_end(md, orig_bio, *tio->len_ptr);
+		sts = dm_zone_map_bio_end(md, zno, &orig_bio_details,
+					  *tio->len_ptr);
 		if (sts != BLK_STS_OK)
 			dm_zone_unlock(q, zno, clone);
 		break;

