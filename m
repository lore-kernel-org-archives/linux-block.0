Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C12C433E6
	for <linux-block@archiver.kernel.org>; Mon,  4 Jan 2021 17:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7CCB22518
	for <linux-block@archiver.kernel.org>; Mon,  4 Jan 2021 17:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbhADRMY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Jan 2021 12:12:24 -0500
Received: from verein.lst.de ([213.95.11.211]:58552 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbhADRMY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Jan 2021 12:12:24 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id EDAD168AFE; Mon,  4 Jan 2021 18:11:41 +0100 (CET)
Date:   Mon, 4 Jan 2021 18:11:41 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Minwoo Im <minwoo.im.dev@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [RFC PATCH V3 1/1] block: reject I/O for same fd if block size
 changed
Message-ID: <20210104171141.GB27235@lst.de>
References: <20210104130659.22511-1-minwoo.im.dev@gmail.com> <20210104130659.22511-2-minwoo.im.dev@gmail.com> <20210104171108.GA27235@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104171108.GA27235@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 04, 2021 at 06:11:08PM +0100, Christoph Hellwig wrote:
> On Mon, Jan 04, 2021 at 10:06:59PM +0900, Minwoo Im wrote:
> > +	if (q->backing_dev_info && q->backing_dev_info->owner &&
> > +			limits->logical_block_size != size) {
> > +		bdev = blkdev_get_no_open(q->backing_dev_info->owner->devt);
> > +		bdev->bd_disk->flags |= GENHD_FL_BLOCK_SIZE_CHANGED;
> > +		blkdev_put_no_open(bdev);
> > +	}
> 
> We really need the backpointer from the queue to the gendisk I've wanted
> to add for a while.  Can we at least restrict this to a live gendisk?

Alternatively we could make this request_queue QUEUE* flag for now.
