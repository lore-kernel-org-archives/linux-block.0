Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAB4C433EF
	for <linux-block@archiver.kernel.org>; Sat, 16 Apr 2022 05:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiDPGAJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Apr 2022 02:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiDPGAI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Apr 2022 02:00:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93093EF0E
        for <linux-block@vger.kernel.org>; Fri, 15 Apr 2022 22:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bR66EBE3nvCiMrI28fR9pGb0v8PbBJaFXXBv3CUcvU8=; b=CzRXPb9Vz+8mI5+ha+oJUC2qPz
        rvKojrGdHqol+X2tx+AzM29hg1msFang98XOZF9inkk5cCH6n0pbL86kDlyF/K6Hw0580+yKQgvLw
        VPv2eHoyxUoa1101v6FMkY9oKayufhs5HhS111Gg5+ruHULPN5bNQYON1cuR0EiBlHwZlzjdK8Yr8
        lUMrZUUp9xuvenUSuUlkoVJeGKU/5UwkYqm86jCbj12MW+lwNMrxkRzpfSOmz8ap7CafGYRKcUMQv
        A80shUA4aK/mK8ug6zJsvEX01prB3gBNY8mdeG7rpdt9/YRGhbWsDnF9jKV368rV7sgAYjm+jV/5t
        JQVf8F3w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfbR9-00CJbD-Vt; Sat, 16 Apr 2022 05:57:36 +0000
Date:   Fri, 15 Apr 2022 22:57:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 1/8] block: replace disk based account with bdev's
Message-ID: <Ylpaz2LpRcbPI5Lp@infradead.org>
References: <20220412085616.1409626-1-ming.lei@redhat.com>
 <20220412085616.1409626-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412085616.1409626-2-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 12, 2022 at 04:56:09PM +0800, Ming Lei wrote:
> 'block device' is generic type for interface, and gendisk becomes more
> one block layer internal type, so replace disk based account interface
> with bdec's.

I can't parse this sentence.

> +unsigned long bdev_start_io_acct(struct block_device *bdev,
> +				 unsigned int sectors, unsigned int op,
> +				 unsigned long start_time)
>  {
> -	return __part_start_io_acct(disk->part0, sectors, op, jiffies);
> +	return __part_start_io_acct(bdev, sectors, op, start_time);
>  }
> -EXPORT_SYMBOL(disk_start_io_acct);
> +EXPORT_SYMBOL(bdev_start_io_acct);

Just rename __part_start_io_acct to bdev_start_io_acct instead.

> -void disk_end_io_acct(struct gendisk *disk, unsigned int op,
> +void bdev_end_io_acct(struct block_device *bdev, unsigned int op,
>  		      unsigned long start_time)
>  {
> -	__part_end_io_acct(disk->part0, op, start_time);
> +	__part_end_io_acct(bdev, op, start_time);
>  }
> -EXPORT_SYMBOL(disk_end_io_acct);
> +EXPORT_SYMBOL(bdev_end_io_acct);

Same here.

