Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD81C48BE5
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 08:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40CDD613EC
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 08:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhFOIIY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jun 2021 04:08:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36572 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhFOIIX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jun 2021 04:08:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EA0841FD55;
        Tue, 15 Jun 2021 08:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623744378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2YCHEN9bBhq+CquAvvfdLSogJ8m0Yow/o6oRjKR+l2A=;
        b=FdRKXE/6sSoc1vinN0OAWEFLd7bW1XClny4/kJUViqPdHjf9myb0Vepf9zPKwIDRNz+BfI
        o+Xhaubjlj2bGVBK0ARkNah8rHz0cauY7GAASFnfKgU06h8FadrIh7RDCbCSppxoSsqpdF
        fnUg6jeGaoVjIc3F02rLlZ8i8oN0Tzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623744378;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2YCHEN9bBhq+CquAvvfdLSogJ8m0Yow/o6oRjKR+l2A=;
        b=HDEEJBC2El1DryF8Aa44smSVzfEQpfUdj+z42/HxAYZfxtbFNo40ijcNJZP2i/11rBByRq
        5bgrGSszlkihhlBQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id D9E6DA3BAC;
        Tue, 15 Jun 2021 08:06:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B164B1F2C88; Tue, 15 Jun 2021 10:06:18 +0200 (CEST)
Date:   Tue, 15 Jun 2021 10:06:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Ingo Franzki <ifranzki@linux.ibm.com>, Karel Zak <kzak@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Juergen Christ <jchrist@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: loop_set_block_size: loop0 () has still dirty pages (nrpages=2)
Message-ID: <20210615080618.GF29751@quack2.suse.cz>
References: <8bed44f2-273c-856e-0018-69f127ea4258@linux.ibm.com>
 <YMIliuPi2tTLUJxv@T590>
 <cf3c803f-350e-c365-afac-0a07a9b6cee2@linux.ibm.com>
 <YMfaJZEIOsvFeIJ4@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMfaJZEIOsvFeIJ4@T590>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 15-06-21 06:37:25, Ming Lei wrote:
> On Mon, Jun 14, 2021 at 09:35:30AM +0200, Ingo Franzki wrote:
> > On 10.06.2021 16:45, Ming Lei wrote:
> > > On Tue, Jun 08, 2021 at 02:01:29PM +0200, Ingo Franzki wrote:
> > >> Hi all,
> > >>
> > >> we occasionally encounter a problem when setting up a loop device in one of our automated testcases.
> > >>
> > >> We set up a loop device as follows:
> > >>
> > >>     # dd if=/dev/zero of=/var/tmp/loopbackfile1.img bs=1M count=2500 status=none
> > >>     # losetup --sector-size 4096 -fP --show /var/tmp/loopbackfile1.img
> > >>
> > >> This works fine most of the times, but in the seldom case of the error, we get 'losetup: /var/tmp/loopbackfile1.img: failed to set up loop device: Resource temporarily unavailable'.
> > >>
> > >> I am sure that no other loop device is currently defined, so we don't run out of loop devices.
> > >>
> > >> We also see the following message in the syslog when the error occurs:
> > >>
> > >>      loop_set_block_size: loop0 () has still dirty pages (nrpages=2)
> > >>
> > >> The nrpages number varies from time to time. 
> > >>
> > >> "Resource temporarily unavailable" is EAGAIN, and function loop_set_block_size() in drivers/block/loop.c returns this after printing the syslog message via pr_warn:
> > >>
> > >> static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
> > >> {
> > >> 	int err = 0;
> > >>
> > >> 	if (lo->lo_state != Lo_bound)
> > >> 		return -ENXIO;
> > >>
> > >> 	err = loop_validate_block_size(arg);
> > >> 	if (err)
> > >> 		return err;
> > >>
> > >> 	if (lo->lo_queue->limits.logical_block_size == arg)
> > >> 		return 0;
> > >>
> > >> 	sync_blockdev(lo->lo_device);
> > >> 	invalidate_bdev(lo->lo_device);
> > >>
> > >> 	blk_mq_freeze_queue(lo->lo_queue);
> > >>
> > >> 	/* invalidate_bdev should have truncated all the pages */
> > >> 	if (lo->lo_device->bd_inode->i_mapping->nrpages) {
> > >> 		err = -EAGAIN;
> > >> 		pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
> > >> 			__func__, lo->lo_number, lo->lo_file_name,
> > >> 			lo->lo_device->bd_inode->i_mapping->nrpages);
> > >> 		goto out_unfreeze;
> > >> 	}
> > >>
> > >> 	blk_queue_logical_block_size(lo->lo_queue, arg);
> > >> 	blk_queue_physical_block_size(lo->lo_queue, arg);
> > >> 	blk_queue_io_min(lo->lo_queue, arg);
> > >> 	loop_update_dio(lo);
> > >> out_unfreeze:
> > >> 	blk_mq_unfreeze_queue(lo->lo_queue);
> > >>
> > >> 	return err;
> > >> }
> > >>
> > >> So looks like invalidate_bdev() did actually not truncate all the pages under some circumstances....
> > >>
> > >> The problem only happens when '--sector-size 4096' is specified, with the default sector size is always works. It does not call loop_set_block_size() in the default case I guess.
> > >>
> > >> The loop0 device has certainly be used by other testcases before, most likely with the default block size. But at the time of this run, no loop device is currently active (losetup shows nothing). 
> > >>
> > >> Anyone have an idea what goes wrong here? 
> > > 
> > > It returns '-EAGAIN' to ask userspace to try again.
> > > 
> > > I understand loop_set_block_size() doesn't prevent page cache of this
> > > loop disk from being dirtied, so it isn't strange to
> > > see lo_device->bd_inode->i_mapping->nrpages isn't zero after sync_blockdev()
> > > & invalidate_bdev() on loop.
> > > 
> > 
> > OK, that makes sense from the kernel perspective. 
> 
> We might improve this code by holding ->i_rwsem / mapping->invalidate_lock in
> loop_set_block_size() to prevent new dirtying pages, but this still
> can't guarantee that i_mapping->nrpages can become 0 after sync &
> revalidate bdev. Or maybe replace invalidate_bdev() with truncate_bdev_range().

i_rwsem won't be enough because even racing with reads into bdev page cache
(which is what I suspect is happening here) will cause EAGAIN error and
reads are not protected by i_rwsem. But after the invalidate_lock work
lands, we should have enough to implement atomic (wrt any page cache
operation) flush & invalidate sequence for a bdevs.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
