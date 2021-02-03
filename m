Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36383C433DB
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 10:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D18DB64F6A
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 10:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbhBCKHS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Feb 2021 05:07:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:50248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233592AbhBCKHE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Feb 2021 05:07:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77B216024A;
        Wed,  3 Feb 2021 10:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612346783;
        bh=/EURuZNeGu0ap6ghqbj8w47olfrSXpAmMx9BST4FI40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hvK19omVP7DG+xpldCjNoTm4UJiEaQcvEggP1+ILqvkdTwsKLnCZwuzEab9Pjl1GA
         R1rRBS2VyuR8gWeOpIx3Xj+atNrn269Omb4hhYMp60dONuJYVPzgHGfiraDScO6tdk
         bmq0Sx2pY5rn4+0PqAuLqj1M1o5aPLpcdmO/epS4=
Date:   Wed, 3 Feb 2021 11:06:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Changheun Lee <nanich.lee@samsung.com>
Cc:     Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, damien.lemoal@wdc.com, hch@infradead.org,
        jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, mj0123.lee@samsung.com, osandov@fb.com,
        patchwork-bot@kernel.org, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, tj@kernel.org, tom.leiming@gmail.com,
        woosung2.lee@samsung.com, yt0928.kim@samsung.com
Subject: Re: [PATCH v4 2/2] bio: add limit_bio_size sysfs
Message-ID: <YBp1nC+/P9Qcwzzm@kroah.com>
References: <YBpmQhqx4pvUh//a@kroah.com>
 <CGME20210203093835epcas1p2e86a35ba3012882950abc7013cae59b9@epcas1p2.samsung.com>
 <20210203092247.29258-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203092247.29258-1-nanich.lee@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 03, 2021 at 06:22:47PM +0900, Changheun Lee wrote:
> Add limit_bio_size block sysfs node to limit bio size.
> Queue flag QUEUE_FLAG_LIMIT_BIO_SIZE will be set if limit_bio_size is set.
> And bio max size will be limited by queue max sectors via
> QUEUE_FLAG_LIMIT_BIO_SIZE set.
> 
> Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
> ---
>  block/blk-sysfs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index b513f1683af0..840d97f427e6 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -288,6 +288,7 @@ QUEUE_SYSFS_BIT_FNS(nonrot, NONROT, 1);
>  QUEUE_SYSFS_BIT_FNS(random, ADD_RANDOM, 0);
>  QUEUE_SYSFS_BIT_FNS(iostats, IO_STAT, 0);
>  QUEUE_SYSFS_BIT_FNS(stable_writes, STABLE_WRITES, 0);
> +QUEUE_SYSFS_BIT_FNS(limit_bio_size, LIMIT_BIO_SIZE, 0);
>  #undef QUEUE_SYSFS_BIT_FNS
>  
>  static ssize_t queue_zoned_show(struct request_queue *q, char *page)
> @@ -615,6 +616,7 @@ QUEUE_RW_ENTRY(queue_nonrot, "rotational");
>  QUEUE_RW_ENTRY(queue_iostats, "iostats");
>  QUEUE_RW_ENTRY(queue_random, "add_random");
>  QUEUE_RW_ENTRY(queue_stable_writes, "stable_writes");
> +QUEUE_RW_ENTRY(queue_limit_bio_size, "limit_bio_size");
>  
>  static struct attribute *queue_attrs[] = {
>  	&queue_requests_entry.attr,
> @@ -648,6 +650,7 @@ static struct attribute *queue_attrs[] = {
>  	&queue_rq_affinity_entry.attr,
>  	&queue_iostats_entry.attr,
>  	&queue_stable_writes_entry.attr,
> +	&queue_limit_bio_size_entry.attr,

Still no documentation for this new file?

That's not allowed :(

greg k-h
