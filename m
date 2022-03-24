Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1B6C433F5
	for <linux-block@archiver.kernel.org>; Thu, 24 Mar 2022 13:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbiCXNY7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Mar 2022 09:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236979AbiCXNY6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 09:24:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC30A774C
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 06:23:25 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 15B9E210DB;
        Thu, 24 Mar 2022 13:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648128204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MzQ+aUPdE/0iGhDktTPztuu2knGtt31lC78epnE6SgA=;
        b=RZzU8YVwHd7uXdz0fE9dn8PqzegHwd48JOZrB7Wvpos83O4fsXN9ak+cWPnWMeNLVo40AM
        kehBgSZOttNspDVX3nGG8/rJXsZ+Z8od58ktWgV1xtPOx4qaqo4z+JpGSwIYcSehTBZKJc
        QXqvcxGFFUM7d9m9PGbn2eYBVy2+XVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648128204;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MzQ+aUPdE/0iGhDktTPztuu2knGtt31lC78epnE6SgA=;
        b=3MtuobPCA00jBfcjaLFELc9t0kU+FS2lYWsviTXWYojFJbWMNbXTFLcABmZvDJC4B38A1Z
        ggCRY6kU84ZgE3BA==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EC526A3B89;
        Thu, 24 Mar 2022 13:23:22 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9A6B4A0610; Thu, 24 Mar 2022 14:23:22 +0100 (CET)
Date:   Thu, 24 Mar 2022 14:23:22 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: Re: [PATCH 01/13] nbd: use the correct block_device in nbd_ioctl
Message-ID: <20220324132322.2t3y4evcxunlpvzm@quack3.lan>
References: <20220324075119.1556334-1-hch@lst.de>
 <20220324075119.1556334-2-hch@lst.de>
 <20220324122041.itc55zladc5sax5p@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324122041.itc55zladc5sax5p@quack3.lan>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 24-03-22 13:20:41, Jan Kara wrote:
> On Thu 24-03-22 08:51:07, Christoph Hellwig wrote:
> > The bdev parameter to ->ioctl contains the block device that the ioctl
> > is called on, which can be the partition.  But the code in nbd_ioctl
> > that uses it really wants the whole device for things like the bd_openers
> > check.  Switch to not pass the bdev along and always use nbd->disk->part0
> > instead.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Looks good. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Hum, thinking about this some more...

> > -static void nbd_clear_sock_ioctl(struct nbd_device *nbd,
> > -				 struct block_device *bdev)
> > +static void nbd_clear_sock_ioctl(struct nbd_device *nbd)
> >  {
> >  	sock_shutdown(nbd);
> > -	__invalidate_device(bdev, true);
> > -	nbd_bdev_reset(bdev);
> > +	__invalidate_device(nbd->disk->part0, true);
> > +	nbd_bdev_reset(nbd);

Should't we call __invalidate_device() for the partition bdev here? Because
if the NBD device has partitions, filesystem will be mounted on this
partition and we want to invalidate it. Similarly the partition buffer
cache is different from the buffer cache of the whole device and we should
invalidate the partition one. In fact in cases like this I think we need
to invalidate all the partitions and filesystems that are there on this
disk so neither the old, nor the new code looks quite correct to me. Am I
missing something?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
