Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554CFC05027
	for <linux-block@archiver.kernel.org>; Thu,  9 Feb 2023 09:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjBIJEn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Feb 2023 04:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBIJEm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Feb 2023 04:04:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472401717F
        for <linux-block@vger.kernel.org>; Thu,  9 Feb 2023 01:04:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ED7D3350F4;
        Thu,  9 Feb 2023 09:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675933479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7xiUrjiXGVRMwQYotXmHqdKQibgsTFcZek+b4y3OfyU=;
        b=AjHQJ83/5VeYYIlljkn+NHaQcwvzCGrxVGEiEgxm6APUwUzfcuUKvT0XKHuF5VMhH/M3kC
        +DWzkCODzBxicwGLH/Um2M9rkeMnPKWRRCzmy4VeI06Zjnx23hMgi8l7e3pHyMOz23IK/F
        zJZb3t6K97Qv5R2yA21Jz9vhKTkAVtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675933479;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7xiUrjiXGVRMwQYotXmHqdKQibgsTFcZek+b4y3OfyU=;
        b=A4DzsCrNE8JZXIh0Dr72NUnjFmg5RRmBBx/o6XFeqoQvwJRVOGZhKbVx8v250S6Vt3J7Rt
        1Gdep/28DNuO5zDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E0D171339E;
        Thu,  9 Feb 2023 09:04:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EB7QNie35GPIIQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 09 Feb 2023 09:04:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7A955A06D8; Thu,  9 Feb 2023 10:04:39 +0100 (CET)
Date:   Thu, 9 Feb 2023 10:04:39 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] block: Do not reread partition table on exclusively open
 device
Message-ID: <20230209090439.w2k37tufbbhk6qq3@quack3>
References: <20221130175653.24299-1-jack@suse.cz>
 <ada13b1b-dd2a-8be0-3b12-3470a086bbf6@huaweicloud.com>
 <Y9kiltmuPSbRRLsO@infradead.org>
 <92d53d6b-f83d-0767-4f6a-1b897b33b227@huaweicloud.com>
 <Y9oFHssFz2obv83W@infradead.org>
 <1901c3f0-da34-1df1-2443-3426282a6ecb@huaweicloud.com>
 <1b5d3502-353d-8674-cd5d-79283fa8905d@huaweicloud.com>
 <20230208120258.64yhqho252gaydmu@quack3>
 <02e769f7-9a41-80bc-4e47-fa87c18a36b2@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02e769f7-9a41-80bc-4e47-fa87c18a36b2@huaweicloud.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 08-02-23 22:13:02, Yu Kuai wrote:
> Hi,
> 
> 在 2023/02/08 20:02, Jan Kara 写道:
> > 
> > After some thought I don't like opencoding blkdev_get_by_dev() in disk_scan
> > partitions. But I agree Christoph's approach with blkdev_get_whole() does
> > not quite work either. We could propagate holder/owner into
> > blkdev_get_whole() to fix Christoph's check but still we are left with a
> > question what to do with GD_NEED_PART_SCAN set bit when we get into
> > blkdev_get_whole() and find out we are not elligible to rescan partitions.
> > Because then some exclusive opener later might be caught by surprise when
> > the partition rescan happens due to this bit being set from the past failed
> > attempt to rescan.
> > 
> > So what we could do is play a similar trick as we do in the loop device and
> > do in disk_scan_partitions():
> > 
> > 	/*
> > 	 * If we don't hold exclusive handle for the device, upgrade to it
> > 	 * here to avoid changing partitions under exclusive owner.
> > 	 */
> > 	if (!(mode & FMODE_EXCL)) {
> This is not necessary, all the caller make sure FMODE_EXCL is not set.

Yes, but we need to propagate it correctly from blkdev_common_ioctl() now,
exactly so that ioctl does not fail if you exclusively opened the device as
you realized below :)

> > 		error = bd_prepare_to_claim(disk->part0, disk_scan_partitions);
> > 		if (error)
> > 			return error;
> > 	}
> From what I see, if thread open device excl first, and then call ioctl()
> to reread partition, this will cause this ioctl() to fail?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
