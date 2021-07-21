Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F78C07E9B
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 05:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93CB06101E
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 05:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbhGUEnt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jul 2021 00:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhGUEnq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jul 2021 00:43:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2272C061574;
        Tue, 20 Jul 2021 22:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4w4Rr+K4p1voERuiNUi/I4B9P8DpL0Nk0BxmYqhBMeQ=; b=VaB3KcdIdumCUAwL1TVaTjvXcr
        VJecuz66bDlqj1EFyZ4N9x9QWajVfFwLbpwRABcr2d2EdqOS2XvW/x+env9olwWdBh8ZsltJC/dxq
        IdG39jldxjtT7WkQP4LLzM+p8XFPfnwyVFZ8O8ai5kmvrF4FbcKrvDwh8kkFpKjNJyCQ5JPjkFce1
        meAot8ytW//A1sb7LEkOlFh6da+4Jey72v8bEgMD/Go0vbHNWlpJ3MY2prWvisFdRDoZ4PdLM3ZWX
        NDUhAQ8V85wzbV89zFaLpAzk5Um+1lWgodFILXA8EvWKITFr4GkGVDHcZtnk1hxRh4z46fCQi+qNy
        x+w/EtfQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m64i7-008pFT-7V; Wed, 21 Jul 2021 05:24:00 +0000
Date:   Wed, 21 Jul 2021 06:23:59 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, hare@suse.de, bvanassche@acm.org,
        ming.lei@redhat.com, hch@infradead.org, jack@suse.cz,
        osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH 3/5] mmc/core/block: replace GENHD_FL_UP with
 GENHD_FL_DISK_ADDED
Message-ID: <YPevb5SpgBX6eWEZ@infradead.org>
References: <20210720182048.1906526-1-mcgrof@kernel.org>
 <20210720182048.1906526-4-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720182048.1906526-4-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 20, 2021 at 11:20:46AM -0700, Luis Chamberlain wrote:
> The GENHD_FL_DISK_ADDED flag is what we really want, as the
> flag GENHD_FL_UP could be set on a semi-initialized device.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/mmc/core/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index ce8aed562929..e9818c79fa59 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2644,7 +2644,7 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
>  		 * from being accepted.
>  		 */
>  		card = md->queue.card;
> -		if (md->disk->flags & GENHD_FL_UP) {
> +		if (blk_disk_added(md->disk)) {
>  			device_remove_file(disk_to_dev(md->disk), &md->force_ro);
>  			if ((md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
>  					card->ext_csd.boot_ro_lockable)
> -- 

I think the proper fix here is to just unwind the mmc initialization,
something like this untested patch:


diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 9890a1532cb0..982f0198d8ff 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2283,7 +2283,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 					      sector_t size,
 					      bool default_ro,
 					      const char *subname,
-					      int area_type)
+					      int area_type,
+					      unsigned int part_type)
 {
 	struct mmc_blk_data *md;
 	int devidx, ret;
@@ -2329,6 +2330,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	INIT_LIST_HEAD(&md->rpmbs);
 	md->usage = 1;
 	md->queue.blkdata = md;
+	md->part_type = part_type;
 
 	md->disk->major	= MMC_BLOCK_MAJOR;
 	md->disk->minors = perdev_minors;
@@ -2381,8 +2383,43 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 		md->disk->disk_name, mmc_card_id(card), mmc_card_name(card),
 		cap_str, md->read_only ? "(ro)" : "");
 
+	device_add_disk(md->parent, md->disk, NULL);
+	md->force_ro.show = force_ro_show;
+	md->force_ro.store = force_ro_store;
+	sysfs_attr_init(&md->force_ro.attr);
+	md->force_ro.attr.name = "force_ro";
+	md->force_ro.attr.mode = S_IRUGO | S_IWUSR;
+	ret = device_create_file(disk_to_dev(md->disk), &md->force_ro);
+	if (ret)
+		goto force_ro_fail;
+
+	if ((md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
+	     card->ext_csd.boot_ro_lockable) {
+		umode_t mode;
+
+		if (card->ext_csd.boot_ro_lock & EXT_CSD_BOOT_WP_B_PWR_WP_DIS)
+			mode = S_IRUGO;
+		else
+			mode = S_IRUGO | S_IWUSR;
+
+		md->power_ro_lock.show = power_ro_lock_show;
+		md->power_ro_lock.store = power_ro_lock_store;
+		sysfs_attr_init(&md->power_ro_lock.attr);
+		md->power_ro_lock.attr.mode = mode;
+		md->power_ro_lock.attr.name =
+					"ro_lock_until_next_power_on";
+		ret = device_create_file(disk_to_dev(md->disk),
+				&md->power_ro_lock);
+		if (ret)
+			goto power_ro_lock_fail;
+	}
 	return md;
 
+ power_ro_lock_fail:
+	device_remove_file(disk_to_dev(md->disk), &md->force_ro);
+ force_ro_fail:
+	del_gendisk(md->disk);
+ 	// XXX: undo mmc_init_queue
  err_kfree:
 	kfree(md);
  out:
@@ -2410,7 +2447,7 @@ static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
 	}
 
 	return mmc_blk_alloc_req(card, &card->dev, size, false, NULL,
-					MMC_BLK_DATA_AREA_MAIN);
+					MMC_BLK_DATA_AREA_MAIN, 0);
 }
 
 static int mmc_blk_alloc_part(struct mmc_card *card,
@@ -2424,10 +2461,9 @@ static int mmc_blk_alloc_part(struct mmc_card *card,
 	struct mmc_blk_data *part_md;
 
 	part_md = mmc_blk_alloc_req(card, disk_to_dev(md->disk), size, default_ro,
-				    subname, area_type);
+				    subname, area_type, part_type);
 	if (IS_ERR(part_md))
 		return PTR_ERR(part_md);
-	part_md->part_type = part_type;
 	list_add(&part_md->part, &md->part);
 
 	return 0;
@@ -2628,27 +2664,23 @@ static int mmc_blk_alloc_parts(struct mmc_card *card, struct mmc_blk_data *md)
 
 static void mmc_blk_remove_req(struct mmc_blk_data *md)
 {
-	struct mmc_card *card;
+	struct mmc_card *card = md->queue.card;
 
-	if (md) {
-		/*
-		 * Flush remaining requests and free queues. It
-		 * is freeing the queue that stops new requests
-		 * from being accepted.
-		 */
-		card = md->queue.card;
-		if (md->disk->flags & GENHD_FL_UP) {
-			device_remove_file(disk_to_dev(md->disk), &md->force_ro);
-			if ((md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
-					card->ext_csd.boot_ro_lockable)
-				device_remove_file(disk_to_dev(md->disk),
-					&md->power_ro_lock);
-
-			del_gendisk(md->disk);
-		}
-		mmc_cleanup_queue(&md->queue);
-		mmc_blk_put(md);
+	/*
+	 * Flush remaining requests and free queues. It is freeing the queue
+	 * that stops new requests from being accepted.
+	 */
+	if (md->disk->flags & GENHD_FL_UP) {
+		device_remove_file(disk_to_dev(md->disk), &md->force_ro);
+		if ((md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
+				card->ext_csd.boot_ro_lockable)
+			device_remove_file(disk_to_dev(md->disk),
+				&md->power_ro_lock);
+
+		del_gendisk(md->disk);
 	}
+	mmc_cleanup_queue(&md->queue);
+	mmc_blk_put(md);
 }
 
 static void mmc_blk_remove_parts(struct mmc_card *card,
@@ -2672,51 +2704,6 @@ static void mmc_blk_remove_parts(struct mmc_card *card,
 	}
 }
 
-static int mmc_add_disk(struct mmc_blk_data *md)
-{
-	int ret;
-	struct mmc_card *card = md->queue.card;
-
-	device_add_disk(md->parent, md->disk, NULL);
-	md->force_ro.show = force_ro_show;
-	md->force_ro.store = force_ro_store;
-	sysfs_attr_init(&md->force_ro.attr);
-	md->force_ro.attr.name = "force_ro";
-	md->force_ro.attr.mode = S_IRUGO | S_IWUSR;
-	ret = device_create_file(disk_to_dev(md->disk), &md->force_ro);
-	if (ret)
-		goto force_ro_fail;
-
-	if ((md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
-	     card->ext_csd.boot_ro_lockable) {
-		umode_t mode;
-
-		if (card->ext_csd.boot_ro_lock & EXT_CSD_BOOT_WP_B_PWR_WP_DIS)
-			mode = S_IRUGO;
-		else
-			mode = S_IRUGO | S_IWUSR;
-
-		md->power_ro_lock.show = power_ro_lock_show;
-		md->power_ro_lock.store = power_ro_lock_store;
-		sysfs_attr_init(&md->power_ro_lock.attr);
-		md->power_ro_lock.attr.mode = mode;
-		md->power_ro_lock.attr.name =
-					"ro_lock_until_next_power_on";
-		ret = device_create_file(disk_to_dev(md->disk),
-				&md->power_ro_lock);
-		if (ret)
-			goto power_ro_lock_fail;
-	}
-	return ret;
-
-power_ro_lock_fail:
-	device_remove_file(disk_to_dev(md->disk), &md->force_ro);
-force_ro_fail:
-	del_gendisk(md->disk);
-
-	return ret;
-}
-
 #ifdef CONFIG_DEBUG_FS
 
 static int mmc_dbg_card_status_get(void *data, u64 *val)
@@ -2882,7 +2869,7 @@ static void mmc_blk_remove_debugfs(struct mmc_card *card,
 
 static int mmc_blk_probe(struct mmc_card *card)
 {
-	struct mmc_blk_data *md, *part_md;
+	struct mmc_blk_data *md;
 	int ret = 0;
 
 	/*
@@ -2900,6 +2887,8 @@ static int mmc_blk_probe(struct mmc_card *card)
 		return -ENOMEM;
 	}
 
+	dev_set_drvdata(&card->dev, md);
+
 	md = mmc_blk_alloc(card);
 	if (IS_ERR(md)) {
 		ret = PTR_ERR(md);
@@ -2910,18 +2899,6 @@ static int mmc_blk_probe(struct mmc_card *card)
 	if (ret)
 		goto out;
 
-	dev_set_drvdata(&card->dev, md);
-
-	ret = mmc_add_disk(md);
-	if (ret)
-		goto out;
-
-	list_for_each_entry(part_md, &md->part, part) {
-		ret = mmc_add_disk(part_md);
-		if (ret)
-			goto out;
-	}
-
 	/* Add two debugfs entries */
 	mmc_blk_add_debugfs(card, md);
 
