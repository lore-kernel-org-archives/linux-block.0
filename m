Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE31C05027
	for <linux-block@archiver.kernel.org>; Thu,  9 Feb 2023 13:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjBIN6f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Feb 2023 08:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjBIN6d (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Feb 2023 08:58:33 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228875D3C2
        for <linux-block@vger.kernel.org>; Thu,  9 Feb 2023 05:58:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D3B985D04E;
        Thu,  9 Feb 2023 13:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675951110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MS43P+m9grllEWukHHKlPK7jn5tLUA3snOn2bfAL5J4=;
        b=UxwSKSxpikMNP1noWVfVmGcLSr9B7Gn8evV4hXu0neoI7YzID3g6PIXFzyl5Z4+te3gEFn
        +DO3mXQGrHAuLBrxLQIPbte9CmhBLgtKG9i5HxH+r5duuOGByhqPHcgq/UTBj5vw+7ovnT
        iFpQzsr/0uGcvaBg/9pIZTB8EDv4beY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675951110;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MS43P+m9grllEWukHHKlPK7jn5tLUA3snOn2bfAL5J4=;
        b=LckpaE/7jPS+gJtraQcGZqexXQ/vDbIhwFslc3rv7VjTZESSJZ/+wd/wHj5+a3eeZIOeVi
        rKkNfrOOaHSqerCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C4F87138E4;
        Thu,  9 Feb 2023 13:58:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0jkEMAb85GMzAgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 09 Feb 2023 13:58:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 47441A06D8; Thu,  9 Feb 2023 14:58:30 +0100 (CET)
Date:   Thu, 9 Feb 2023 14:58:30 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] block: Do not reread partition table on exclusively open
 device
Message-ID: <20230209135830.a2lhdhnwzbu7uexe@quack3>
References: <92d53d6b-f83d-0767-4f6a-1b897b33b227@huaweicloud.com>
 <Y9oFHssFz2obv83W@infradead.org>
 <1901c3f0-da34-1df1-2443-3426282a6ecb@huaweicloud.com>
 <1b5d3502-353d-8674-cd5d-79283fa8905d@huaweicloud.com>
 <20230208120258.64yhqho252gaydmu@quack3>
 <02e769f7-9a41-80bc-4e47-fa87c18a36b2@huaweicloud.com>
 <20230209090439.w2k37tufbbhk6qq3@quack3>
 <1bf91d5c-6130-43de-7995-af09045d4b98@huaweicloud.com>
 <20230209095729.igkpj23afj6nbxxi@quack3>
 <8ca26a55-f48b-5043-7890-03ccbf541ead@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ca26a55-f48b-5043-7890-03ccbf541ead@huaweicloud.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 09-02-23 19:19:48, Yu Kuai wrote:
> 在 2023/02/09 17:57, Jan Kara 写道:
> > On Thu 09-02-23 17:32:45, Yu Kuai wrote:
> > > 在 2023/02/09 17:04, Jan Kara 写道:
> > > I still prefer to open code blkdev_get_by_dev(), because many operations
> > > is not necessary here. And this way, we can clear GD_NEED_PART_SCAN
> > > inside open_mutex if rescan failed.
> > 
> > I understand many operations are not needed there but this is not a hot
> > path and leaking of bdev internal details into genhd.c is not a good
> > practice either (e.g. you'd have to make blkdev_get_whole() extern).
> 
> I was thinking that disk_scan_partitions() can be moved to bdev.c to
> avoid that...
> > 
> > We could create a special helper for partition rescan in block/bdev.c to
> > hide the details but think that bd_start_claiming() - bd_abort_claiming()
> > trick is the simplest solution to temporarily grab exclusive ownership if
> > we don't have it.
> 
> Now I'm good with this solution. By the way, do you think we must make
> sure the first partition scan will be proceed?

Sorry, I'm not sure what your are asking about here :) Can you please
elaborate more?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
