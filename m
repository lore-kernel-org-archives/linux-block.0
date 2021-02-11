Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCB3C433E0
	for <linux-block@archiver.kernel.org>; Thu, 11 Feb 2021 18:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A3CB60C3E
	for <linux-block@archiver.kernel.org>; Thu, 11 Feb 2021 18:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhBKRze (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Feb 2021 12:55:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54107 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229945AbhBKRxd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Feb 2021 12:53:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613065926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fenxytKArqtTHKIX0KFNGto9Rr37iOO0PVNFNChrRes=;
        b=Cr6hHU8O1yIJfiONArBRgAxAe60T1xInKIl+aJkrA7D/kJfuyVtGiS2af24dUCgW8ienNe
        /xGEnEMu1WZ9TJ3A8KUVE+YwI6u1MPGkrNqtVvKph29a0y7cZr9YYTOzx3G5ce1PAfn4fA
        kBV1ONq6YYASzVhzybdBuwWLsY7BWHE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-0ivb-37aPGug7-ZVGVREEA-1; Thu, 11 Feb 2021 12:52:04 -0500
X-MC-Unique: 0ivb-37aPGug7-ZVGVREEA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36A5A1020C25;
        Thu, 11 Feb 2021 17:52:02 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 90E105D6B1;
        Thu, 11 Feb 2021 17:51:52 +0000 (UTC)
Date:   Thu, 11 Feb 2021 12:51:51 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     Damien.LeMoal@wdc.com, hare@suse.de, ming.lei@redhat.com,
        agk@redhat.com, corbet@lwn.net, axboe@kernel.dk, jack@suse.cz,
        johannes.thumshirn@wdc.com, gregkh@linuxfoundation.org,
        koct9i@gmail.com, steve@sk2.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel.tide@veeam.com
Subject: Re: [PATCH v5 5/6] dm: add 'noexcl' option for dm-linear
Message-ID: <20210211175151.GA13839@redhat.com>
References: <1612881028-7878-1-git-send-email-sergei.shtepa@veeam.com>
 <1612881028-7878-6-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612881028-7878-6-git-send-email-sergei.shtepa@veeam.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 09 2021 at  9:30am -0500,
Sergei Shtepa <sergei.shtepa@veeam.com> wrote:

> The 'noexcl' option allow to open underlying block-device
> without FMODE_EXCL.
> 
> Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
> ---
>  drivers/md/dm-linear.c        | 14 +++++++++++++-
>  drivers/md/dm-table.c         | 14 ++++++++------
>  drivers/md/dm.c               | 26 +++++++++++++++++++-------
>  drivers/md/dm.h               |  2 +-
>  include/linux/device-mapper.h |  7 +++++++
>  5 files changed, 48 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
> index 00774b5d7668..b16d89802b9d 100644
> --- a/drivers/md/dm-linear.c
> +++ b/drivers/md/dm-linear.c
> @@ -33,7 +33,7 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>  	char dummy;
>  	int ret;
>  
> -	if (argc != 2) {
> +	if ((argc < 2) || (argc > 3)) {
>  		ti->error = "Invalid argument count";
>  		return -EINVAL;
>  	}
> @@ -51,6 +51,18 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>  	}
>  	lc->start = tmp;
>  
> +	ti->non_exclusive = false;
> +	if (argc > 2) {
> +		if (strcmp("noexcl", argv[2]) == 0)
> +			ti->non_exclusive = true;
> +		else if (strcmp("excl", argv[2]) == 0)
> +			ti->non_exclusive = false;
> +		else {
> +			ti->error = "Invalid exclusive option";
> +			return -EINVAL;
> +		}
> +	}
> +
>  	ret = dm_get_device(ti, argv[0], dm_table_get_mode(ti->table), &lc->dev);
>  	if (ret) {
>  		ti->error = "Device lookup failed";
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 4acf2342f7ad..f020459465bd 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -322,7 +322,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>   * device and not to touch the existing bdev field in case
>   * it is accessed concurrently.
>   */
> -static int upgrade_mode(struct dm_dev_internal *dd, fmode_t new_mode,
> +static int upgrade_mode(struct dm_dev_internal *dd, fmode_t new_mode, bool non_exclusive,
>  			struct mapped_device *md)
>  {
>  	int r;
> @@ -330,8 +330,8 @@ static int upgrade_mode(struct dm_dev_internal *dd, fmode_t new_mode,
>  
>  	old_dev = dd->dm_dev;
>  
> -	r = dm_get_table_device(md, dd->dm_dev->bdev->bd_dev,
> -				dd->dm_dev->mode | new_mode, &new_dev);
> +	r = dm_get_table_device(md, dd->dm_dev->bdev->bd_dev, dd->dm_dev->mode | new_mode,
> +				non_exclusive, &new_dev);
>  	if (r)
>  		return r;
>  
> @@ -387,7 +387,8 @@ int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
>  		if (!dd)
>  			return -ENOMEM;
>  
> -		if ((r = dm_get_table_device(t->md, dev, mode, &dd->dm_dev))) {
> +		r = dm_get_table_device(t->md, dev, mode, ti->non_exclusive, &dd->dm_dev);
> +		if (r) {
>  			kfree(dd);
>  			return r;
>  		}
> @@ -396,8 +397,9 @@ int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
>  		list_add(&dd->list, &t->devices);
>  		goto out;
>  
> -	} else if (dd->dm_dev->mode != (mode | dd->dm_dev->mode)) {
> -		r = upgrade_mode(dd, mode, t->md);
> +	} else if ((dd->dm_dev->mode != (mode | dd->dm_dev->mode)) &&
> +		   (dd->dm_dev->non_exclusive != ti->non_exclusive)) {
> +		r = upgrade_mode(dd, mode, ti->non_exclusive, t->md);
>  		if (r)
>  			return r;
>  	}
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 00c41aa6d092..c25dcc2fdb89 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1117,33 +1117,44 @@ static void close_table_device(struct table_device *td, struct mapped_device *md
>  	if (!td->dm_dev.bdev)
>  		return;
>  
> -	bd_unlink_disk_holder(td->dm_dev.bdev, dm_disk(md));
> -	blkdev_put(td->dm_dev.bdev, td->dm_dev.mode | FMODE_EXCL);
> +	if (td->dm_dev.non_exclusive)
> +		blkdev_put(td->dm_dev.bdev, td->dm_dev.mode);
> +	else {
> +		bd_unlink_disk_holder(td->dm_dev.bdev, dm_disk(md));
> +		blkdev_put(td->dm_dev.bdev, td->dm_dev.mode | FMODE_EXCL);
> +	}
> +
> +
> +	blkdev_put(td->dm_dev.bdev, td->dm_dev.mode);
> +
>  	put_dax(td->dm_dev.dax_dev);
>  	td->dm_dev.bdev = NULL;
>  	td->dm_dev.dax_dev = NULL;
> +	td->dm_dev.non_exclusive = false;
>  }
>  
>  static struct table_device *find_table_device(struct list_head *l, dev_t dev,
> -					      fmode_t mode)
> +					      fmode_t mode, bool non_exclusive)
>  {
>  	struct table_device *td;
>  
>  	list_for_each_entry(td, l, list)
> -		if (td->dm_dev.bdev->bd_dev == dev && td->dm_dev.mode == mode)
> +		if (td->dm_dev.bdev->bd_dev == dev &&
> +		    td->dm_dev.mode == mode &&
> +		    td->dm_dev.non_exclusive == non_exclusive)
>  			return td;
>  
>  	return NULL;
>  }
>  
> -int dm_get_table_device(struct mapped_device *md, dev_t dev, fmode_t mode,
> +int dm_get_table_device(struct mapped_device *md, dev_t dev, fmode_t mode, bool non_exclusive,
>  			struct dm_dev **result)
>  {
>  	int r;
>  	struct table_device *td;
>  
>  	mutex_lock(&md->table_devices_lock);
> -	td = find_table_device(&md->table_devices, dev, mode);
> +	td = find_table_device(&md->table_devices, dev, mode, non_exclusive);
>  	if (!td) {
>  		td = kmalloc_node(sizeof(*td), GFP_KERNEL, md->numa_node_id);
>  		if (!td) {
> @@ -1154,7 +1165,8 @@ int dm_get_table_device(struct mapped_device *md, dev_t dev, fmode_t mode,
>  		td->dm_dev.mode = mode;
>  		td->dm_dev.bdev = NULL;
>  
> -		if ((r = open_table_device(td, dev, md))) {
> +		r = open_table_device(td, dev, md, non_exclusive);
> +		if (r) {
>  			mutex_unlock(&md->table_devices_lock);
>  			kfree(td);
>  			return r;
> diff --git a/drivers/md/dm.h b/drivers/md/dm.h
> index fffe1e289c53..7bf20fb2de74 100644
> --- a/drivers/md/dm.h
> +++ b/drivers/md/dm.h
> @@ -179,7 +179,7 @@ int dm_open_count(struct mapped_device *md);
>  int dm_lock_for_deletion(struct mapped_device *md, bool mark_deferred, bool only_deferred);
>  int dm_cancel_deferred_remove(struct mapped_device *md);
>  int dm_request_based(struct mapped_device *md);
> -int dm_get_table_device(struct mapped_device *md, dev_t dev, fmode_t mode,
> +int dm_get_table_device(struct mapped_device *md, dev_t dev, fmode_t mode, bool non_exclusive,
>  			struct dm_dev **result);
>  void dm_put_table_device(struct mapped_device *md, struct dm_dev *d);
>  
> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> index 61a66fb8ebb3..70002363bfc0 100644
> --- a/include/linux/device-mapper.h
> +++ b/include/linux/device-mapper.h
> @@ -150,6 +150,7 @@ struct dm_dev {
>  	struct block_device *bdev;
>  	struct dax_device *dax_dev;
>  	fmode_t mode;
> +	bool non_exclusive;
>  	char name[16];
>  };
>  
> @@ -325,6 +326,12 @@ struct dm_target {
>  	 * whether or not its underlying devices have support.
>  	 */
>  	bool discards_supported:1;
> +
> +	/*
> +	 * Set if this target needs to open device without FMODE_EXCL
> +	 * mode.
> +	 */
> +	bool non_exclusive:1;
>  };
>  
>  void *dm_per_bio_data(struct bio *bio, size_t data_size);
> -- 
> 2.20.1
> 

I'm really not liking this tug-of-war about FMODE_EXCL vs not.
Especially dislike the prospect of needing to change _every_ DM target
that would be made to support blk_interposer.

I've said this before, private or otherwise, but: Hannes' approach that
fell back to opening without FMODE_EXCL if FMODE_EXCL open failed.  Have
you explored that kind of approach?

You _should_ be able to infer that interposer is being used given the
requirement to use an explicit remap ioctl to establish the use of
interposer.

Mike

