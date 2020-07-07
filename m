Return-Path: <SRS0=CAbX=AS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1812C433DF
	for <linux-block@archiver.kernel.org>; Tue,  7 Jul 2020 17:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFB1E20708
	for <linux-block@archiver.kernel.org>; Tue,  7 Jul 2020 17:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgGGRtJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:49:09 -0400
Received: from verein.lst.de ([213.95.11.211]:60101 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728591AbgGGRtI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Jul 2020 13:49:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1028C68AFE; Tue,  7 Jul 2020 19:49:05 +0200 (CEST)
Date:   Tue, 7 Jul 2020 19:49:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: loop: share code of reread partitions
Message-ID: <20200707174903.GA3730@lst.de>
References: <20200707084552.3294693-1-ming.lei@redhat.com> <20200707084552.3294693-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707084552.3294693-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 07, 2020 at 04:45:51PM +0800, Ming Lei wrote:
> loop_reread_partitions() has been there for rereading partitions, so
> replace the open code in __loop_clr_fd() with loop_reread_partitions()
> by passing 'locked' parameter.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/loop.c | 29 ++++++++++++-----------------
>  1 file changed, 12 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index a943207705dd..0e08468b9ce0 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -650,13 +650,17 @@ static inline void loop_update_dio(struct loop_device *lo)
>  }
>  
>  static void loop_reread_partitions(struct loop_device *lo,
> -				   struct block_device *bdev)
> +				   struct block_device *bdev, bool locked)
>  {
>  	int rc;
>  
> -	mutex_lock(&bdev->bd_mutex);
> -	rc = bdev_disk_changed(bdev, false);
> -	mutex_unlock(&bdev->bd_mutex);
> +	if (locked) {
> +		rc = bdev_disk_changed(bdev, false);
> +	} else {
> +		mutex_lock(&bdev->bd_mutex);
> +		rc = bdev_disk_changed(bdev, false);
> +		mutex_unlock(&bdev->bd_mutex);
> +	}

functions with an argument based locking context are a really bad
idea.  And there is absolutely no reason to add them just for
a shared printk.
