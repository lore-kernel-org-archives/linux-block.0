Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CB8C001B0
	for <linux-block@archiver.kernel.org>; Tue,  8 Aug 2023 21:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjHHVxg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 17:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjHHVxZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 17:53:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D2810CF
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 09:29:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AAD2D20316;
        Tue,  8 Aug 2023 10:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691490620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UyJL43iibtcNz0S6gJSk65zJptY7QZJTZMhY+M2Didc=;
        b=EKLLDoAl5fv3Cogt+JPVHIkQmaGFJcoqPCRQd7BFB516ywdwTyzYAcXN9TS3Nx3aZ8NKGH
        J/T5s5Opfr5yccLKanbMeWEw+fZDbXe75+ZA3x30Jy1q7m13bIMKVOprRdboRb6yoFDLvt
        4Z+UkLDTuiLO/s8ecqCrLBjin1CJNzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691490620;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UyJL43iibtcNz0S6gJSk65zJptY7QZJTZMhY+M2Didc=;
        b=HD/ozy0SHrhkkqFDpbVK1IUmw9u98yicfxiWncazK1FZSsJGeZTcpdZ2lmzBzC5Knz4asM
        iuc/Y6eoEFxh4uBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FB6C139D1;
        Tue,  8 Aug 2023 10:30:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8MYQIzwZ0mRwNwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 08 Aug 2023 10:30:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EBF80A0769; Tue,  8 Aug 2023 12:30:19 +0200 (CEST)
Date:   Tue, 8 Aug 2023 12:30:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, David Jeffery <djeffery@redhat.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [RFC PATCH] sbitmap: fix batching wakeup
Message-ID: <20230808103019.zvduupwrbalk3ee4@quack3>
References: <20230721095715.232728-1-ming.lei@redhat.com>
 <20230802160553.uv5wn6nfjseniyxx@quack3>
 <ZNH6as/wUkbCMAcN@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNH6as/wUkbCMAcN@fedora>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 08-08-23 16:18:50, Ming Lei wrote:
> On Wed, Aug 02, 2023 at 06:05:53PM +0200, Jan Kara wrote:
> > On Fri 21-07-23 17:57:15, Ming Lei wrote:
> > > From: David Jeffery <djeffery@redhat.com>
> > > 
> > > Current code supposes that it is enough to provide forward progress by just
> > > waking up one wait queue after one completion batch is done.
> > > 
> > > Unfortunately this way isn't enough, cause waiter can be added to
> > > wait queue just after it is woken up.
> > > 
> > > Follows one example(64 depth, wake_batch is 8)
> > > 
> > > 1) all 64 tags are active
> > > 
> > > 2) in each wait queue, there is only one single waiter
> > > 
> > > 3) each time one completion batch(8 completions) wakes up just one waiter in each wait
> > > queue, then immediately one new sleeper is added to this wait queue
> > > 
> > > 4) after 64 completions, 8 waiters are wakeup, and there are still 8 waiters in each
> > > wait queue
> > > 
> > > 5) after another 8 active tags are completed, only one waiter can be wakeup, and the other 7
> > > can't be waken up anymore.
> > > 
> > > Turns out it isn't easy to fix this problem, so simply wakeup enough waiters for
> > > single batch.
> > > 
> > > Cc: David Jeffery <djeffery@redhat.com>
> > > Cc: Kemeng Shi <shikemeng@huaweicloud.com>
> > > Cc: Gabriel Krisman Bertazi <krisman@suse.de>
> > > Cc: Chengming Zhou <zhouchengming@bytedance.com>
> > > Cc: Jan Kara <jack@suse.cz>
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > 
> > I'm sorry for the delay - I was on vacation. I can see the patch got
> > already merged and I'm not strictly against that (although I think Gabriel
> > was experimenting with this exact wakeup scheme and as far as I remember
> > the more eager waking up was causing performance decrease for some
> > configurations). But let me challenge the analysis above a bit. For the
> > sleeper to be added to a waitqueue in step 3), blk_mq_mark_tag_wait() must
> > fail the blk_mq_get_driver_tag() call. Which means that all tags were used
> 
> Here only allocating request by blk_mq_get_tag() is involved, and
> getting driver tag isn't involved.
> 
> > at that moment. To summarize, anytime we add any new waiter to the
> > waitqueue, all tags are used and thus we should eventually receive enough
> > wakeups to wake all of them. What am I missing?
> 
> When running the final retry(__blk_mq_get_tag) before
> sleeping(io_schedule()) in blk_mq_get_tag(), the sleeper has been added to
> wait queue.
> 
> So when two completion batch comes, the two may wake up same wq because
> same ->wake_index can be observed from two completion path, and both two
> wake_up_nr() can return > 0 because adding sleeper into wq and wake_up_nr()
> can be interleaved, then 16 completions just wakeup 2 sleepers added to
> same wq.
> 
> If the story happens on one wq with >= 8 sleepers, io hang will be
> triggered, if there are another two pending wq.

OK, thanks for explanation! I think I see the problem now.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
