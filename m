Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F96C12002
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 05:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DFC86100C
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 05:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhGUEvw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jul 2021 00:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhGUEvr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jul 2021 00:51:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9EBC061574;
        Tue, 20 Jul 2021 22:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UIe3t7U9ttMqTuOm5HTkTK76a1TyJwwc0+hE6h3VkC4=; b=awd14+cLFPTgHWZF5axFBezG9F
        +D5ie/GWOlOI0peJ8ORqGb/YcqfuXmD6lHdkS1yIFubBw+Xs4PgUqAQnb4CW6qBqvWe0NcC3zQRTR
        Ruh6mTXE/7reHGLTMhoVERl6SBk8R1bo5nAATE8wMb8nkEh5kmTZ1KgGkqZU7UHfJIJSKhAkCCdih
        xy6NDh9Gs2K9aiE8lqnOU7cxXdGOUnqtycxm+yyZiXjlcmJqJ1C+b//G8Y3BToU8XZ7LI7hmi6izK
        DJq+i5c7KvCb7xzN0mIHIT70bINQw/5sAEX196faFlLokH/sCfLzNWdx9nonM0SiH5aTGGu4veuWi
        WqRSe+Sw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m64pe-008pi3-Bh; Wed, 21 Jul 2021 05:31:49 +0000
Date:   Wed, 21 Jul 2021 06:31:46 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, hare@suse.de, bvanassche@acm.org,
        ming.lei@redhat.com, hch@infradead.org, jack@suse.cz,
        osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, kbusch@kernel.org
Subject: Re: [PATCH 4/5] nvme: replace GENHD_FL_UP with GENHD_FL_DISK_ADDED
Message-ID: <YPexQv88hGXxBoLE@infradead.org>
References: <20210720182048.1906526-1-mcgrof@kernel.org>
 <20210720182048.1906526-5-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720182048.1906526-5-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 20, 2021 at 11:20:47AM -0700, Luis Chamberlain wrote:
> The GENHD_FL_DISK_ADDED flag is what we really want, as the
> flag GENHD_FL_UP could be set on a semi-initialized device.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/nvme/host/core.c      | 4 ++--
>  drivers/nvme/host/multipath.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 11779be42186..7be78491c838 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1819,7 +1819,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
>  static inline bool nvme_first_scan(struct gendisk *disk)
>  {
>  	/* nvme_alloc_ns() scans the disk prior to adding it */
> -	return !(disk->flags & GENHD_FL_UP);
> +	return !(blk_disk_added(disk));
>  }

So this on is obviously right as it wants to check for the probe
time scan.  Although we don't need the braces.

>
>  
>  static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id)
> @@ -3823,7 +3823,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>  	nvme_mpath_clear_current_path(ns);
>  	synchronize_srcu(&ns->head->srcu); /* wait for concurrent submissions */
>  
> -	if (ns->disk->flags & GENHD_FL_UP) {
> +	if (blk_disk_added(ns->disk)) {

This is something that goes back to before the damn of time, but I do
not think we actually need it.  All the errors paths before alloc_disk
and add_disk just directly free the ns and never end up here.

>  		if (!nvme_ns_head_multipath(ns->head))
>  			nvme_cdev_del(&ns->cdev, &ns->cdev_device);
>  		del_gendisk(ns->disk);
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 0ea5298469c3..f77bd2d5c1a9 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -764,7 +764,7 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
>  {
>  	if (!head->disk)
>  		return;
> -	if (head->disk->flags & GENHD_FL_UP) {
> +	if (blk_disk_added(head->disk)) {
>  		nvme_cdev_del(&head->cdev, &head->cdev_device);
>  		del_gendisk(head->disk);
>  	}

This one is sort of correct due to the lazy disk addition.  But we
could and probably should check for NVME_NSHEAD_DISK_LIVE instead.
