Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660FFC433FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 20:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiKBUKq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 16:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiKBUK0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 16:10:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F6463F7
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 13:10:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 063D0B82414
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 20:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1E7C433C1;
        Wed,  2 Nov 2022 20:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667419797;
        bh=d1aAEMRH2LDynQy+67/JpvxY+WetfEO+/8rGX/Fb/h8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dc7aEfMOsHcNjAMVKdNO3adbYsQ6ASltODpaEa2up9juj1nGsm2XDkBEMzZH7mFeZ
         2ihwVwf5IAFhZBL0LBbn8SwCailGYsWk9UZ+boZUDeDLWKuCd+fhZ+Ve1s3AMSsJLU
         zEdSHAqn4BwyZVPwGcZmHalOYbmwWfHL0yDfVGJ8NhAKEYrCl1TqJfMCm+mGfNON1u
         aQuBHiXOAI6Yr95k2G5J7E9knHMQkMWoUe7Y7FynIKHs3/h9mkhxMJtzGjy72ye0e9
         rFYkCRXguNnD2/abCqt1nGlnz6pnbe4bZ9lX4oh6Exg9bWZeajo3CrFRyq8NE8ev2L
         jc2onMQbAkvjw==
Date:   Wed, 2 Nov 2022 14:09:54 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Dmitrii Tcvetkov <me@demsh.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Regression: wrong DIO alignment check with dm-crypt
Message-ID: <Y2LOkmU0IJUTyYza@kbusch-mbp.dhcp.thefacebook.com>
References: <Y2Hf08vIKBkl5tu0@sol.localdomain>
 <Y2KEH6OZ0MDf5cSh@kbusch-mbp.dhcp.thefacebook.com>
 <Y2KXfNZzwPZBJRTW@kbusch-mbp.dhcp.thefacebook.com>
 <20221102200345.0800a8bf@xps.demsh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102200345.0800a8bf@xps.demsh.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 02, 2022 at 08:03:45PM +0300, Dmitrii Tcvetkov wrote:
> 
> Applied on top 6.1-rc3, the issue still reproduces.

Yeah, I see that now. I needed to run a dm-crypt setup to figure out how
they're actually doing this, so now I have that up and running.

I think this type of usage will require the dma_alignment to move from
the request_queue to the queue_limits. Here's that, and I've
successfully tested this with cryptsetup. I still need more work to get
mdraid atop that working on my dev machine, but I'll post this now since
it's looking better:

---
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 8bb9eef5310e..e84304959318 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -81,6 +81,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
 	lim->max_dev_sectors = UINT_MAX;
 	lim->max_write_zeroes_sectors = UINT_MAX;
 	lim->max_zone_append_sectors = UINT_MAX;
+	lim->dma_alignment = 511;
 }
 EXPORT_SYMBOL(blk_set_stacking_limits);
 
@@ -600,6 +601,7 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 
 	t->io_min = max(t->io_min, b->io_min);
 	t->io_opt = lcm_not_zero(t->io_opt, b->io_opt);
+	t->dma_alignment = max(t->dma_alignment, b->dma_alignment);
 
 	/* Set non-power-of-2 compatible chunk_sectors boundary */
 	if (b->chunk_sectors)
@@ -773,7 +775,7 @@ EXPORT_SYMBOL(blk_queue_virt_boundary);
  **/
 void blk_queue_dma_alignment(struct request_queue *q, int mask)
 {
-	q->dma_alignment = mask;
+	q->limits.dma_alignment = mask;
 }
 EXPORT_SYMBOL(blk_queue_dma_alignment);
 
@@ -795,8 +797,8 @@ void blk_queue_update_dma_alignment(struct request_queue *q, int mask)
 {
 	BUG_ON(mask > PAGE_SIZE);
 
-	if (mask > q->dma_alignment)
-		q->dma_alignment = mask;
+	if (mask > q->limits.dma_alignment)
+		q->limits.dma_alignment = mask;
 }
 EXPORT_SYMBOL(blk_queue_update_dma_alignment);
 
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 159c6806c19b..2653516bcdef 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -3630,6 +3630,7 @@ static void crypt_io_hints(struct dm_target *ti, struct queue_limits *limits)
 	limits->physical_block_size =
 		max_t(unsigned, limits->physical_block_size, cc->sector_size);
 	limits->io_min = max_t(unsigned, limits->io_min, cc->sector_size);
+	limits->dma_alignment = limits->logical_block_size - 1;
 }
 
 static struct target_type crypt_target = {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 854b4745cdd1..69ee5ea29e2f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -310,6 +310,13 @@ struct queue_limits {
 	unsigned char		discard_misaligned;
 	unsigned char		raid_partial_stripes_expensive;
 	enum blk_zoned_model	zoned;
+
+	/*
+	 * Drivers that set dma_alignment to less than 511 must be prepared to
+	 * handle individual bvec's that are not a multiple of a SECTOR_SIZE
+	 * due to possible offsets.
+	 */
+	unsigned int		dma_alignment;
 };
 
 typedef int (*report_zones_cb)(struct blk_zone *zone, unsigned int idx,
@@ -455,12 +462,6 @@ struct request_queue {
 	unsigned long		nr_requests;	/* Max # of requests */
 
 	unsigned int		dma_pad_mask;
-	/*
-	 * Drivers that set dma_alignment to less than 511 must be prepared to
-	 * handle individual bvec's that are not a multiple of a SECTOR_SIZE
-	 * due to possible offsets.
-	 */
-	unsigned int		dma_alignment;
 
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 	struct blk_crypto_profile *crypto_profile;
@@ -1318,7 +1319,7 @@ static inline sector_t bdev_zone_sectors(struct block_device *bdev)
 
 static inline int queue_dma_alignment(const struct request_queue *q)
 {
-	return q ? q->dma_alignment : 511;
+	return q ? q->limits.dma_alignment : 511;
 }
 
 static inline unsigned int bdev_dma_alignment(struct block_device *bdev)
--
