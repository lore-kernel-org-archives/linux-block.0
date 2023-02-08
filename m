Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02847C636D6
	for <linux-block@archiver.kernel.org>; Wed,  8 Feb 2023 12:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjBHMDF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Feb 2023 07:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBHMDB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Feb 2023 07:03:01 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F154149000
        for <linux-block@vger.kernel.org>; Wed,  8 Feb 2023 04:02:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A23F220E07;
        Wed,  8 Feb 2023 12:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675857778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8dQchTfjre+vyXOBj8BI3VL/oLOIpc8D3WQvUEID+7g=;
        b=px2uXjVtzKD1hn9ystdvcr/jPlNGuTd54tJ35kMXx1lQ2u69fZr8Me1vN/mw2qTDkBA0Sz
        Hb3E9CNChhRT1IKcSTvKmtEY7/6o+7f7D3X87X0uJjIt+PFqsU6kof4p9nW56PrHMCu5eu
        jX6h0h61dvMXmzLZEn8tDphwKSycb5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675857778;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8dQchTfjre+vyXOBj8BI3VL/oLOIpc8D3WQvUEID+7g=;
        b=ugQxLREE2ZC5dpyV23elh7RaY+eEn/WeguEBIFab7Dd4X6JW3xVWRzTYSXprCX27RLdrQf
        o8Iw8XJcVWYOPxBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94A4C1358A;
        Wed,  8 Feb 2023 12:02:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8RFDJHKP42M6XwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 08 Feb 2023 12:02:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1A277A06D5; Wed,  8 Feb 2023 13:02:58 +0100 (CET)
Date:   Wed, 8 Feb 2023 13:02:58 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] block: Do not reread partition table on exclusively open
 device
Message-ID: <20230208120258.64yhqho252gaydmu@quack3>
References: <20221130175653.24299-1-jack@suse.cz>
 <ada13b1b-dd2a-8be0-3b12-3470a086bbf6@huaweicloud.com>
 <Y9kiltmuPSbRRLsO@infradead.org>
 <92d53d6b-f83d-0767-4f6a-1b897b33b227@huaweicloud.com>
 <Y9oFHssFz2obv83W@infradead.org>
 <1901c3f0-da34-1df1-2443-3426282a6ecb@huaweicloud.com>
 <1b5d3502-353d-8674-cd5d-79283fa8905d@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b5d3502-353d-8674-cd5d-79283fa8905d@huaweicloud.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi!

On Mon 06-02-23 11:24:10, Yu Kuai wrote:
> 在 2023/02/01 15:20, Yu Kuai 写道:
> > Hi,
> > 
> > 在 2023/02/01 14:22, Christoph Hellwig 写道:
> > > On Wed, Feb 01, 2023 at 09:04:12AM +0800, Yu Kuai wrote:
> > > > > +    if (test_bit(GD_NEED_PART_SCAN, &disk->state) && !bdev->bd_holder)
> > > > >            bdev_disk_changed(disk, false);
> > > > 
> > > > I think this is wrong here... We should at least allow the exclusively
> > > > opener to scan partition, right?
> > > 
> > > bd_holder is only set in bd_finish_claiming, which is called after
> > > the partition rescan.
> > > .
> > > 
> > 
> > I mean that someone open bdev exclusively first, and then call ioctl to
> > rescan partition.
> 
> Any suggestions?

After some thought I don't like opencoding blkdev_get_by_dev() in disk_scan
partitions. But I agree Christoph's approach with blkdev_get_whole() does
not quite work either. We could propagate holder/owner into
blkdev_get_whole() to fix Christoph's check but still we are left with a
question what to do with GD_NEED_PART_SCAN set bit when we get into
blkdev_get_whole() and find out we are not elligible to rescan partitions.
Because then some exclusive opener later might be caught by surprise when
the partition rescan happens due to this bit being set from the past failed
attempt to rescan.

So what we could do is play a similar trick as we do in the loop device and
do in disk_scan_partitions():

	/*
	 * If we don't hold exclusive handle for the device, upgrade to it
	 * here to avoid changing partitions under exclusive owner.
	 */
	if (!(mode & FMODE_EXCL)) {
		error = bd_prepare_to_claim(disk->part0, disk_scan_partitions);
		if (error)
			return error;
	}
	set_bit(GD_NEED_PART_SCAN, &disk->state);
	bdev = blkdev_get_by_dev(disk_devt(disk), mode & ~FMODE_EXCL, NULL);
	if (IS_ERR(bdev)) {
		error = PTR_ERR(bdev);
		goto abort;
	}
	blkdev_put(bdev, mode & ~FMODE_EXCL);
	error = 0;
abort:
	if (!(mode & FMODE_EXCL))
		bd_abort_claiming(disk->part0, disk_scan_partitions);
	return error;

So esentially we'll temporarily block any exlusive openers by claiming the
bdev while we set the GD_NEED_PART_SCAN and force partition rescan. What do
you think?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
