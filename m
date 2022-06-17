Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B212C433EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 11:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381445AbiFQLbX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 07:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiFQLbW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 07:31:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC806CAAF
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 04:31:21 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 23E4721E26;
        Fri, 17 Jun 2022 11:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655465480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3mkt4Xj3BRO9nNSiU3y5uYmGa6wMjztYn5H9HmmUDRY=;
        b=mBqCP4TJqxRVLtse60Vedy3GRfitXmnrbAspZAuyd9fik/HQjShmo2g6au2HLLp1OYX0n/
        iKwHhmtvgHBXpPOlWm2c9+Q7/cVDX7LyPQ9Ca1ggHN6ipsDfn8BKlWCMtJc8IP8dXw3dmV
        1/GWwQ1kwpMqqk98enhpjcp0Gno5OSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655465480;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3mkt4Xj3BRO9nNSiU3y5uYmGa6wMjztYn5H9HmmUDRY=;
        b=NfNOeDBlCbXVrdycMmR4ox6lNiwTzLVNlY0WU1HwhIJ+the2XkvelsdYbdeOawJo54eCuG
        zQB7Wemi8PoieYDA==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CAA7B2C141;
        Fri, 17 Jun 2022 11:31:19 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8047CA0632; Fri, 17 Jun 2022 13:31:12 +0200 (CEST)
Date:   Fri, 17 Jun 2022 13:31:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
Subject: Re: Races in sbitmap batched wakeups
Message-ID: <20220617113112.rlmx7npkavwkhcxx@quack3>
References: <20220616172102.yrxod3ptmhiuvqsw@quack3.lan>
 <9a0f1ea5-c62c-4439-b80f-0319b9a15fd5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a0f1ea5-c62c-4439-b80f-0319b9a15fd5@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi!

On Fri 17-06-22 09:40:11, Yu Kuai wrote:
> 在 2022/06/17 1:21, Jan Kara 写道:
> > I've been debugging some customer reports of tasks hanging (forever)
> > waiting for free tags when in fact all tags are free. After looking into it
> > for some time I think I know what it happening. First, keep in mind that
> > it concerns a device which uses shared tags. There are 127 tags available
> > and the number of active queues using these tags is easily 40 or more. So
> > number of tags available for each device is rather small. Now I'm not sure
> > how batched wakeups can ever work in such situations, but maybe I'm missing
> > something.
> > 
> > So take for example a situation where two tags are available for a device,
> > they are both currently used. Now a process comes into blk_mq_get_tag() and
> > wants to allocate tag and goes to sleep. Now how can it ever be woken up if
> > wake_batch is 4? If the two IOs complete, sbitmap will get two wakeups but
> > that's not enough to trigger the batched wakeup to really wakeup the
> > waiter...
> > 
> > Even if we have say 4 tags available so in theory there should be enough
> > wakeups to fill the batch, there can be the following problem. So 4 tags
> > are in use, two processes come to blk_mq_get_tag() and sleep, one on wait
> > queue 0, one on wait queue 1. Now four IOs complete so
> > sbitmap_queue_wake_up() gets called 4 times and the fourth call decrements
> > wait_cnt to 0 so it ends up calling wake_up_nr(wq0, 4). Fine, one of the
> > waiters is woken up but the other one is still sleeping in wq1 and there
> > are not enough wakeups to fill the batch and wake it up? This is
> > essentially because we have lost three wakeups on wq0 because it didn't
> > have enough waiters to wake...
> 
> From what I see, if tags are shared for multiple devices, wake_batch
> should make sure that all waiter will be woke up:
> 
> For example:
> there are total 64 tags shared for two devices, then wake_batch is 4(if
> both devices are active).  If there are waiters, which means at least 32
> tags are grabed, thus 8 queues will ensure to wake up at least once
> after 32 tags are freed.

Well, yes, wake_batch is updated but as my example above shows it is not
enough to fix "wasted" wakeups.

> > Finally, sbitmap_queue_wake_up() is racy and if two of them race together,
> > they can end up decrementing wait_cnt of wq which does not have any process
> > queued which again effectively leads to lost wakeups and possibly
> > indefinitely sleeping tasks.
> > 
> 
> BTW, I do this implementation have some problems on concurrent
> scenario, as described in following patch:
> 
> https://lore.kernel.org/lkml/20220415101053.554495-4-yukuai3@huawei.com/

Yes, as far as I can see you have identified similar races as I point out
in this email. But I'm not sure whether your patch fixes all the
possibilities for lost wakeups...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
