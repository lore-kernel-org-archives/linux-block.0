Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB74AC433C1
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 13:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98746619F8
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 13:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhCZNDS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Mar 2021 09:03:18 -0400
Received: from verein.lst.de ([213.95.11.211]:45633 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230094AbhCZNCv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Mar 2021 09:02:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 00E4267373; Fri, 26 Mar 2021 14:02:48 +0100 (CET)
Date:   Fri, 26 Mar 2021 14:02:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: not create too many partitions
Message-ID: <20210326130248.GA18275@lst.de>
References: <20210326085954.474119-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326085954.474119-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 26, 2021 at 04:59:54PM +0800, Ming Lei wrote:
> Commit a33df75c6328 ("block: use an xarray for disk->part_tbl") drops
> check on max supported partitions number, and allows partition with
> bigger partition number to be added. However, ->bd_partno is defined
> as u8, so partition index of xarray table may not match with ->bd_partno.
> Then delete_partition() may delete one unmatched partition, and caused
> use-after-free.
> 
> Cc: Bart Van Assche <bvanassche@acm.org>
> Reported-by: syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com
> Fixes: a33df75c6328 ("block: use an xarray for disk->part_tbl")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> Another fix is to define ->bd_partno as u32, not sure if we need to
> support so many partitions.
> 
>  block/partitions/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index 1a7558917c47..933d47105b64 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -322,6 +322,10 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
>  	const char *dname;
>  	int err;
>  
> +	/* disk_max_parts() is zero during initialization, ignore if so */
> +	if (disk_max_parts(disk) && (partno + 1) > disk_max_parts(disk))
> +		return ERR_PTR(-EINVAL);

disk->minors is set in __alloc_disk_node, so AFAICS it can't ever be 0
when add_partition is called.  So I think this should be just:

	if (partno >= disk_max_parts(disk))
		return ERR_PTR(-EINVAL);

otherwise this looks good.
