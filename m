Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD8DC433EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 10:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbiFQKue (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 06:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381355AbiFQKud (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 06:50:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A52B6BFFF
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 03:50:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 494CF21D99;
        Fri, 17 Jun 2022 10:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655463030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4J2wqj9o1wobHF90Mz4N0GNxzBu4uk4gZsgZOVkg8Mg=;
        b=QtoqxUQBqre0Ot3ls0kbpxxDuzRo5h6ONvG7nlEuXBfeiC/WvZgR9gJUBYNrpI2Hnsk1FS
        ym+07e6SnJvXZPwK9tZGEpphm4Yzo1A0hyp+v4rOsnzRovGkNvn7BRfJKmn2lR+Y3pCKir
        gcWdpA/Dp4/eTCQuSidfaugoTIGo0W0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655463030;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4J2wqj9o1wobHF90Mz4N0GNxzBu4uk4gZsgZOVkg8Mg=;
        b=0N9lgwZfYNa6Bk/ai4XfYJtdnEDpNvoBB7LBWwMIWb3FUBF0u7Pv5TQRD4G0/Ec9RV4zFK
        wajgg/HRy2vqweCg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 16ABA2C141;
        Fri, 17 Jun 2022 10:50:29 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 44BF8A0632; Fri, 17 Jun 2022 12:50:18 +0200 (CEST)
Date:   Fri, 17 Jun 2022 12:50:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
Subject: Re: Races in sbitmap batched wakeups
Message-ID: <20220617105018.53pg4mll7ekuyjpn@quack3.lan>
References: <20220616172102.yrxod3ptmhiuvqsw@quack3.lan>
 <YqvTxl8CvRe1Anr0@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqvTxl8CvRe1Anr0@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri 17-06-22 09:07:18, Ming Lei wrote:
> On Thu, Jun 16, 2022 at 07:21:02PM +0200, Jan Kara wrote:
> > Hello!
> > 
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
> 
> commit 180dccb0dba4 ("blk-mq: fix tag_get wait task can't be awakened")
> is supposed for addressing this kind of issue.

I have observed the deadlock with the above fixes applied.

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
> But the following completions will wake up the waiter in wq1, given
> there are more in-flight.

Well, there is only one more request in flight - from the unblocked waiter.
And once that request completes, it will generate just one wakeup which is
not enough to wake the waiter on wq1 because wake_batch is 4...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
