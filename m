Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EC9C5519F
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 19:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE31520B80
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 19:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgKLTNZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Nov 2020 14:13:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:49348 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbgKLTNZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Nov 2020 14:13:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2940BAB95;
        Thu, 12 Nov 2020 19:13:24 +0000 (UTC)
Date:   Thu, 12 Nov 2020 20:13:22 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Martijn Coenen <maco@android.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: add a return value to
 set_capacity_revalidate_and_notify
Message-ID: <20201112191322.GA14767@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20201112165005.4022502-1-hch@lst.de>
 <20201112165005.4022502-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112165005.4022502-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

> Return if the function ended up sending an uevent or not.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
> ---
>  block/genhd.c         | 5 ++++-
>  include/linux/genhd.h | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)

> diff --git a/block/genhd.c b/block/genhd.c
> index 0a273211fec283..9387f050c248a7 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -49,7 +49,7 @@ static void disk_release_events(struct gendisk *disk);
>   * Set disk capacity and notify if the size is not currently
>   * zero and will not be set to zero
>   */
> -void set_capacity_revalidate_and_notify(struct gendisk *disk, sector_t size,
> +bool set_capacity_revalidate_and_notify(struct gendisk *disk, sector_t size,
>  					bool update_bdev)
>  {
>  	sector_t capacity = get_capacity(disk);
> @@ -62,7 +62,10 @@ void set_capacity_revalidate_and_notify(struct gendisk *disk, sector_t size,
>  		char *envp[] = { "RESIZE=1", NULL };

>  		kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
> +		return true;
>  	}
> +
> +	return false;
>  }

>  EXPORT_SYMBOL_GPL(set_capacity_revalidate_and_notify);
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 38f23d75701379..03da3f603d309c 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -315,7 +315,7 @@ static inline int get_disk_ro(struct gendisk *disk)
>  extern void disk_block_events(struct gendisk *disk);
>  extern void disk_unblock_events(struct gendisk *disk);
>  extern void disk_flush_events(struct gendisk *disk, unsigned int mask);
> -void set_capacity_revalidate_and_notify(struct gendisk *disk, sector_t size,
> +bool set_capacity_revalidate_and_notify(struct gendisk *disk, sector_t size,
>  		bool update_bdev);

>  /* drivers/char/random.c */
