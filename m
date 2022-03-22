Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13506C433EF
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 11:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbiCVLKl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Mar 2022 07:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiCVLKj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 07:10:39 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0C3B6
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 04:09:12 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5E9D268AFE; Tue, 22 Mar 2022 12:09:08 +0100 (CET)
Date:   Tue, 22 Mar 2022 12:09:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 7/8] loop: remove lo_refcount and avoid lo_mutex in
 ->open / ->release
Message-ID: <20220322110908.GA28931@lst.de>
References: <20220316084519.2850118-1-hch@lst.de> <20220316084519.2850118-8-hch@lst.de> <20220316112258.6hjksrv7yqiqcncu@quack3.lan> <26f0d3da-d45e-72aa-de2f-62ead4d2c25b@I-love.SAKURA.ne.jp> <20220316143855.sqm2dk77rbvxtxh7@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316143855.sqm2dk77rbvxtxh7@quack3.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 16, 2022 at 03:38:55PM +0100, Jan Kara wrote:
> Well, but another effect of READ_ONCE() / WRITE_ONCE() is that it
> effectively forces the compiler to not store any intermediate value in
> bd_openers. If you have code like bdev->bd_openers++, and bd_openers has
> value say 1, the compiler is fully within its rights if unlocked reader
> sees values, 1, 0, 3, 2. It would have to be a vicious compiler but the C
> standard allows that and some of the optimizations compilers end up doing
> result in code which is not far from this (read more about KCSAN and the
> motivation behind it for details). So data_race() annotation is *not*
> enough for unlocked bd_openers usage.
> 
> > Use of atomic_t for lo->lo_disk->part0->bd_openers does not help, for
> > currently lo->lo_mutex is held in order to avoid races. That is, it is
> > disk->open_mutex which loop_clr_fd() needs to hold when accessing
> > lo->lo_disk->part0->bd_openers.
> 
> It does help because with atomic_t, seeing any intermediate values is not
> possible even for unlocked readers.

The Linux memory model guarantees atomic reads from 32-bit integers.
But if it makes everyone happier I could do a READ_ONCE here.
