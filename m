Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B4AC433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 10:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1F2260EE9
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 10:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhJRKQN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 06:16:13 -0400
Received: from verein.lst.de ([213.95.11.211]:33175 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231907AbhJRKPD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 06:15:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 39B2068AFE; Mon, 18 Oct 2021 12:12:50 +0200 (CEST)
Date:   Mon, 18 Oct 2021 12:12:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     axboe@kernel.dk, hch@lst.de, willy@infradead.org,
        sunhao.th@gmail.com, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: fix incorrect references to disk objects
Message-ID: <20211018101250.GA6754@lst.de>
References: <20211018091116.16874-1-qiang.zhang1211@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018091116.16874-1-qiang.zhang1211@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 18, 2021 at 05:11:16PM +0800, Zqiang wrote:
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -424,6 +424,7 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
>  	device_del(pdev);
>  out_put:
>  	put_device(pdev);
> +	disk = NULL;
>  out_put_disk:
>  	put_disk(disk);
>  	return ERR_PTR(err);

Stylistic nitpick:  I think directly returning where this currently
clears disk would be a little easier to follow.
