Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081BFC433E0
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 18:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB3B522287
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 18:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbgLWSc2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Dec 2020 13:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgLWSc0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Dec 2020 13:32:26 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC0AC061794
        for <linux-block@vger.kernel.org>; Wed, 23 Dec 2020 10:31:46 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id e2so122396pgi.5
        for <linux-block@vger.kernel.org>; Wed, 23 Dec 2020 10:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JnpI6LhmMGk+FuAkC4hEiEZ/iwoRhterIinJkyNBzjM=;
        b=tHz+bIdufgAO/iPkCzEAlhb9iW9D9hsevXt5aV7agMNPAk8571dJqBgeUb0IHNrtvr
         e5XKPu2e+hOTRJngdF8FdnqsLhmmY3FAfNTZlLAmq1ugcnISqqOF8GTUGiMYCTlaRcpP
         pCbfvw7n5t25cnJLSbE2BCbRgk6g7PrusG8e7NUAlzwwJom2TAS+7p7nbzGW4Va1wION
         9HPvSOZalbmhR2XeNAvVfP1mAuowl7JWcEr11/oq8RFK5njhVxMV/QptsjuukUz22RS5
         e/AMTpDyrIlsRLr0niyvEyPiWeJ6fhU3uFPS6+ojYQlPg/KKm7BUSmu0WhqeppJ7uh13
         7miA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JnpI6LhmMGk+FuAkC4hEiEZ/iwoRhterIinJkyNBzjM=;
        b=AEhyKL3mn0Sat7UdHtOKiw+CbxoJJy3kQV5+6VzrEBBxuqBAbKJ9oa2G3G+TDXzq81
         nYQAKKviKqlFdmKB/u1SrZf+B+la6aOVkDmGZ8imGeTSlz3+awPEKNQvoDTuR6my7RoT
         ImifcNw9UOEDHsHaX92OjV1CaLbcjpFtEypcEnX4lpB92sE1Fa9UrIku2VrsTGeSM/Eq
         haJ7F2A0jXxDaG4AM9NTpnwU3m8JgriZw2acqha+FjgP6DFPidOx6s5rqZ8x8RVvcQar
         pW29Dv9H4hOuKBZkoXzxHFoypbao8yPPdwtkt8ncrdiuogHrnMi+2W8davlzg87hBrxF
         pzBA==
X-Gm-Message-State: AOAM532s5sMXAKC3cEdR+4ABCcVZMy0H0igOkSLNOQS3OUSJwoSSeie+
        nMTve4WYi2Roto+rJbaHzG8=
X-Google-Smtp-Source: ABdhPJzTHLgLHvUOB5xQOKUa2UPBletPb0mM3/gpCiwCZI8Tb+Z1pvLFNquqb1Vo/hF3tAXkcjVOKQ==
X-Received: by 2002:a63:fc42:: with SMTP id r2mr7457043pgk.234.1608748305810;
        Wed, 23 Dec 2020 10:31:45 -0800 (PST)
Received: from localhost ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id a18sm23945720pfg.107.2020.12.23.10.31.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Dec 2020 10:31:45 -0800 (PST)
Date:   Thu, 24 Dec 2020 03:31:43 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [RFC] nvme: set block size during namespace validation
Message-ID: <20201223183143.GB13354@localhost.localdomain>
References: <20201223150136.4221-1-minwoo.im.dev@gmail.com>
 <20201223154904.GA5967@lst.de>
 <20201223161650.GA13354@localhost.localdomain>
 <20201223162737.GA8688@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201223162737.GA8688@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 20-12-23 17:27:37, Christoph Hellwig wrote:
> On Thu, Dec 24, 2020 at 01:16:50AM +0900, Minwoo Im wrote:
> > Hello,
> > 
> > On 20-12-23 16:49:04, Christoph Hellwig wrote:
> > > set_blocksize just sets the block sise used for buffer heads and should
> > > not be called by the driver.  blkdev_get updates the block size, so
> > > you must already have the fd re-reading the partition table open?
> > > I'm not entirely sure how we can work around this except by avoiding
> > > buffer head I/O in the partition reread code.  Note that this affects
> > > all block drivers where the block size could change at runtime.
> > 
> > Thank you Christoph for your comment on this.
> > 
> > Agreed.  BLKRRPART leads us to block_read_full_page which takes buffer
> > heads for I/O.
> > 
> > Yes, __blkdev_get() sets i_blkbits of block device inode via
> > set_init_blocksize.  And Yes again as nvme-cli already opened the block
> > device fd and requests the BLKRRPART with that fd.  Also, __bdev_get()
> > only updates the i_blkbits(blocksize) in case bdev->bd_openers == 0 which
> > is the first time to open this block device.
> > 
> > Then, how about having NVMe driver prevent underflow case for the
> > request->__data_len is smaller than the logical block size like:
> 
> Not sure this helps.  I think we need to fix this proper and in the
> block layer.  The long term fix is to stop messing with i_blksize
> at all, but that is going to take very long.

Agreed.

> 
> I think for now the only thing we can do is to set a flag in the
> gendisk when the block size changes and then reject all I/O until
> the next first open that sets the blocksize.

Let me prepare work around patch for this issue soon.

Thanks!
