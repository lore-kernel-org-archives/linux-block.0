Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6475C433EF
	for <linux-block@archiver.kernel.org>; Fri, 25 Mar 2022 09:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343996AbiCYJk7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Mar 2022 05:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358477AbiCYJk6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Mar 2022 05:40:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175E11FA46
        for <linux-block@vger.kernel.org>; Fri, 25 Mar 2022 02:39:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C40D0210F1;
        Fri, 25 Mar 2022 09:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648201160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7G9EIXoAPdb1ajdlPCiZb3cMqrCwY++/iRz3nA26Srs=;
        b=HYoIdsEuhIMnTp/lAUfZU34v7lBGapQ+E31QVyBuJuFXBdC3qxQlLhp1nOYzU59IVb59vr
        qHWAZm0dAnht445g1YOeXe225nslEOm+u1WLwDRA+YUvzZJKu+esffZp9CTx6ItCUbi/Hi
        wkFC0O0yJS20zSkhRVjgeVXV1ID1OMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648201160;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7G9EIXoAPdb1ajdlPCiZb3cMqrCwY++/iRz3nA26Srs=;
        b=daqCe2EBtod8UxeysNTu59gPb0sRGX5kVAUZWcN3AzuDd9B12Qa6LQal/8t4G51rokqHPC
        pcVe61f+efTC3WBA==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id ADABEA3B89;
        Fri, 25 Mar 2022 09:39:20 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5FD76A0610; Fri, 25 Mar 2022 10:39:20 +0100 (CET)
Date:   Fri, 25 Mar 2022 10:39:20 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: Re: [PATCH 01/13] nbd: use the correct block_device in nbd_ioctl
Message-ID: <20220325093920.l3hjhed2babptxbz@quack3.lan>
References: <20220324075119.1556334-1-hch@lst.de>
 <20220324075119.1556334-2-hch@lst.de>
 <20220324122041.itc55zladc5sax5p@quack3.lan>
 <20220324132322.2t3y4evcxunlpvzm@quack3.lan>
 <20220324171148.GA28007@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324171148.GA28007@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 24-03-22 18:11:48, Christoph Hellwig wrote:
> On Thu, Mar 24, 2022 at 02:23:22PM +0100, Jan Kara wrote:
> > Should't we call __invalidate_device() for the partition bdev here? Because
> > if the NBD device has partitions, filesystem will be mounted on this
> > partition and we want to invalidate it. Similarly the partition buffer
> > cache is different from the buffer cache of the whole device and we should
> > invalidate the partition one. In fact in cases like this I think we need
> > to invalidate all the partitions and filesystems that are there on this
> > disk so neither the old, nor the new code looks quite correct to me. Am I
> > missing something?
> 
> Well, that assumes just one partition is used, which kinda defeats the
> purpose of partitions.  I can exclude the __invalidate_device to not
> change from one kind of broken to another, but I suspect the real
> question is why we have this __invalidate_device call at all.

I suppose it tries to cleanup after effectively hot-unplugging the device.
But I think we don't need to untangle that in this patch set. I'd just
prefer we would not change one questionable behavior for another similarly
questionable one...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
