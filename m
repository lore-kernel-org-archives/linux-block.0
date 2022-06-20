Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6962CC43334
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 11:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240648AbiFTL5s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 07:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241440AbiFTL5q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 07:57:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F9618352
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 04:57:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D2C721FDA7;
        Mon, 20 Jun 2022 11:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655726263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ec1iQOPjXCeWZEf7/MJvJty9ykl6Dpzupwy5ot3CSec=;
        b=Ny87mYO031P3QJN2j5+JGiNg45+nA8EFAt4wkFIsq9gxVPPCUt6FBFsw3ev45q7AtNJQC3
        AP3QMa0vRt/mQ64OemLB3B8a9nPV1mSP2uA93MI0mRP5hQAQOg0EoN56kDGWamLT/lpMC0
        oNPl+WGbrdIpJ2r/rVKs5JCwBm0Cd5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655726263;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ec1iQOPjXCeWZEf7/MJvJty9ykl6Dpzupwy5ot3CSec=;
        b=YZTdf2MAsPPNIAikLi5CNr8fOeXLSQl6YkPFlGtO/PzPAges67/lqjNAUZx5GSDjew9Hgv
        YI6jdYoGwWJZsyBA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6A57A2C15D;
        Mon, 20 Jun 2022 11:57:43 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9F8D3A0636; Mon, 20 Jun 2022 13:57:40 +0200 (CEST)
Date:   Mon, 20 Jun 2022 13:57:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Laibin Qiu <qiulaibin@huawei.com>
Subject: Re: Races in sbitmap batched wakeups
Message-ID: <20220620115740.dnj56do2egfzrebo@quack3.lan>
References: <20220616172102.yrxod3ptmhiuvqsw@quack3.lan>
 <9a0f1ea5-c62c-4439-b80f-0319b9a15fd5@huawei.com>
 <20220617113112.rlmx7npkavwkhcxx@quack3>
 <65beb6c4-6780-1f48-866b-63d4c4625c31@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65beb6c4-6780-1f48-866b-63d4c4625c31@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello!

On Fri 17-06-22 20:50:17, Yu Kuai wrote:
> 在 2022/06/17 19:31, Jan Kara 写道:
> > On Fri 17-06-22 09:40:11, Yu Kuai wrote:
> > > 在 2022/06/17 1:21, Jan Kara 写道:
> > > > I've been debugging some customer reports of tasks hanging (forever)
> > > > waiting for free tags when in fact all tags are free. After looking into it
> > > > for some time I think I know what it happening. First, keep in mind that
> > > > it concerns a device which uses shared tags. There are 127 tags available
> > > > and the number of active queues using these tags is easily 40 or more. So
> > > > number of tags available for each device is rather small. Now I'm not sure
> > > > how batched wakeups can ever work in such situations, but maybe I'm missing
> > > > something.
> > > > 
> > > > So take for example a situation where two tags are available for a device,
> > > > they are both currently used. Now a process comes into blk_mq_get_tag() and
> > > > wants to allocate tag and goes to sleep. Now how can it ever be woken up if
> > > > wake_batch is 4? If the two IOs complete, sbitmap will get two wakeups but
> > > > that's not enough to trigger the batched wakeup to really wakeup the
> > > > waiter...
> > > > 
> > > > Even if we have say 4 tags available so in theory there should be enough
> > > > wakeups to fill the batch, there can be the following problem. So 4 tags
> > > > are in use, two processes come to blk_mq_get_tag() and sleep, one on wait
> > > > queue 0, one on wait queue 1. Now four IOs complete so
> > > > sbitmap_queue_wake_up() gets called 4 times and the fourth call decrements
> > > > wait_cnt to 0 so it ends up calling wake_up_nr(wq0, 4). Fine, one of the
> > > > waiters is woken up but the other one is still sleeping in wq1 and there
> > > > are not enough wakeups to fill the batch and wake it up? This is
> > > > essentially because we have lost three wakeups on wq0 because it didn't
> > > > have enough waiters to wake...
> > > 
> > >  From what I see, if tags are shared for multiple devices, wake_batch
> > > should make sure that all waiter will be woke up:
> > > 
> > > For example:
> > > there are total 64 tags shared for two devices, then wake_batch is 4(if
> > > both devices are active).  If there are waiters, which means at least 32
> > > tags are grabed, thus 8 queues will ensure to wake up at least once
> > > after 32 tags are freed.
> > 
> > Well, yes, wake_batch is updated but as my example above shows it is not
> > enough to fix "wasted" wakeups.
> 
> Tags can be preempted, which means new thread can be added to waitqueue
> only if there are no free tags.

Yes.

> With the above condition, I can't think of any possibility how the
> following scenario can be existed(dispite the wake ups can be missed):
> 
> Only wake_batch tags are still in use, while multiple waitqueues are
> still active.
> 
> If you think this is possible, can you share the initial conditions and
> how does it end up to the problematic scenario?

Very easily AFAICT. I've described the scenario in my original email but
let me maybe write it here with more detail. Let's assume we have 4 tags
available for our device, wake_batch is 4, wait_index is 0, wait_cnt is 4
for all waitqueues. All four tags are currently in use.

Now task T1 comes, wants a new tag:
blk_mq_get_tag()
  bt_wait_ptr() -> gets ws 0, wait_index incremented to 1
  goes to sleep on ws 0

Now task T2 comes, wants a new tag:
blk_mq_get_tag()
  bt_wait_ptr() -> gets ws 1, wait_index incremented to 2
  goes to sleep on ws 1

Now all four requests complete, this generates 4 calls to
sbitmap_queue_wake_up() for ws 0, which decrements wait_cnt on ws 0 to 0
and we do wake_up_nr(&ws->wait, 4). This wakes T1.

T1 allocates a tag, does IO, IO completes. sbitmap_queue_wake_up() is
called for ws 1. wait_cnt is decremented to 3.

Now there's no IO in flight but we still have task sleeping in ws 1.
Everything is stuck until someone submits more IO (which may never happen
because everything ends up waiting on completion of IO T2 does).

Note that I have given an example with 4 tags available but in principle
the problem can happen with up to (wake_batch - 1) * SBQ_WAIT_QUEUES tags.
Hum, spelling it out so exactly this particular problem should be probably
fixed by changing the code in sbitmap_queue_recalculate_wake_batch() to not
force wake_batch to 4 if there is higher number of total tags available?
Laibin? That would be at least a quick fix for this particular problem.

And AFAICS this is independent problem from the one you are fixing in your
patch...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
