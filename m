Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B65C433EF
	for <linux-block@archiver.kernel.org>; Wed, 23 Mar 2022 12:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbiCWMUG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Mar 2022 08:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbiCWMUF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Mar 2022 08:20:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0847E5044A
        for <linux-block@vger.kernel.org>; Wed, 23 Mar 2022 05:18:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 00CE4210F6;
        Wed, 23 Mar 2022 12:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648037911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i2DB626gFsUhdn+l7x5jPjr1PXcfjj3YGGUq7OJS2l0=;
        b=F67jI+IABKomn/EoyFqhQohQHHJhhDSo0JkCNrS8Y9kEnDTogX/pffLNU5a2YDei1sS3cx
        ejxIc7+GaRhB3eJ2tZdFt6K8mkQWxvWfIElUouVHNZnFmfTOnFhS0uWFWEGlYShJdMVCua
        ObSKbT+6UMKeD9Y9oOwDBcOclsx6D68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648037911;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i2DB626gFsUhdn+l7x5jPjr1PXcfjj3YGGUq7OJS2l0=;
        b=E0zNcfEYxEZWU3brZ8GIHcQFN5Yp94/MpUr7fOGDeiP9y/6W9PVZKE1Ms80g1xfL7mNIIp
        oZQdMpXPaCyJtQDw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C42D6A3B87;
        Wed, 23 Mar 2022 12:18:30 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 18871A0610; Wed, 23 Mar 2022 13:18:30 +0100 (CET)
Date:   Wed, 23 Mar 2022 13:18:30 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 7/8] loop: remove lo_refcount and avoid lo_mutex in
 ->open / ->release
Message-ID: <20220323121830.55g7dlbhmpfz4m2g@quack3.lan>
References: <20220316084519.2850118-1-hch@lst.de>
 <20220316084519.2850118-8-hch@lst.de>
 <20220316112258.6hjksrv7yqiqcncu@quack3.lan>
 <26f0d3da-d45e-72aa-de2f-62ead4d2c25b@I-love.SAKURA.ne.jp>
 <20220316143855.sqm2dk77rbvxtxh7@quack3.lan>
 <20220322110908.GA28931@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322110908.GA28931@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 22-03-22 12:09:08, Christoph Hellwig wrote:
> On Wed, Mar 16, 2022 at 03:38:55PM +0100, Jan Kara wrote:
> > Well, but another effect of READ_ONCE() / WRITE_ONCE() is that it
> > effectively forces the compiler to not store any intermediate value in
> > bd_openers. If you have code like bdev->bd_openers++, and bd_openers has
> > value say 1, the compiler is fully within its rights if unlocked reader
> > sees values, 1, 0, 3, 2. It would have to be a vicious compiler but the C
> > standard allows that and some of the optimizations compilers end up doing
> > result in code which is not far from this (read more about KCSAN and the
> > motivation behind it for details). So data_race() annotation is *not*
> > enough for unlocked bd_openers usage.
> > 
> > > Use of atomic_t for lo->lo_disk->part0->bd_openers does not help, for
> > > currently lo->lo_mutex is held in order to avoid races. That is, it is
> > > disk->open_mutex which loop_clr_fd() needs to hold when accessing
> > > lo->lo_disk->part0->bd_openers.
> > 
> > It does help because with atomic_t, seeing any intermediate values is not
> > possible even for unlocked readers.
> 
> The Linux memory model guarantees atomic reads from 32-bit integers.
> But if it makes everyone happier I could do a READ_ONCE here.

Sure, the read is atomic wrt other CPU instructions, but it is not atomic
wrt how the compiler decides to implement bdi->bd_openers++. So we need to
make these bd_openers *updates* atomic so that the unlocked reads are
really safe. That being said I consider the concerns mostly theoretical so
I don't insist but some checker will surely complain sooner rather than
later.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
