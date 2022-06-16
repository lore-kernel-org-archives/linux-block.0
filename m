Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24271C433EF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 17:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378176AbiFPRVL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 13:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378083AbiFPRVK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 13:21:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542923B01F
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 10:21:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 09B6A1F8BB;
        Thu, 16 Jun 2022 17:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655400068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=liJvFFfI/PNjF7Z7meVsdZcW8OlSams/2ZWmUBAA/5Y=;
        b=WYJ1GxEWT2+pXEM5fncZIsCNRXXqwiIcv5zRm9xhcB6gEnEpq+MtmOAJG3bXw31XRHeD0e
        7Qg1pKmL1Yd5NsTH6BtJeCWRU5wS+b+x8JKPFonigxmN0VU0PasdS4m9Qj/2SM55JZvzP3
        AjGjdoOa97J/sQECLdhC2ht3GxgV0og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655400068;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=liJvFFfI/PNjF7Z7meVsdZcW8OlSams/2ZWmUBAA/5Y=;
        b=BL6hK4k2oRBuMcUgWk6imLvorKWniFYeaOK2+DwgT7idELLGUPQbN6WXBK9T+v3gDOZ1jI
        5PBf7d3TqsqlURBw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F1E892C141;
        Thu, 16 Jun 2022 17:21:07 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 43FEEA062E; Thu, 16 Jun 2022 19:21:02 +0200 (CEST)
Date:   Thu, 16 Jun 2022 19:21:02 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org
Subject: Races in sbitmap batched wakeups
Message-ID: <20220616172102.yrxod3ptmhiuvqsw@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello!

I've been debugging some customer reports of tasks hanging (forever)
waiting for free tags when in fact all tags are free. After looking into it
for some time I think I know what it happening. First, keep in mind that
it concerns a device which uses shared tags. There are 127 tags available
and the number of active queues using these tags is easily 40 or more. So
number of tags available for each device is rather small. Now I'm not sure
how batched wakeups can ever work in such situations, but maybe I'm missing
something.

So take for example a situation where two tags are available for a device,
they are both currently used. Now a process comes into blk_mq_get_tag() and
wants to allocate tag and goes to sleep. Now how can it ever be woken up if
wake_batch is 4? If the two IOs complete, sbitmap will get two wakeups but
that's not enough to trigger the batched wakeup to really wakeup the
waiter...

Even if we have say 4 tags available so in theory there should be enough
wakeups to fill the batch, there can be the following problem. So 4 tags
are in use, two processes come to blk_mq_get_tag() and sleep, one on wait
queue 0, one on wait queue 1. Now four IOs complete so
sbitmap_queue_wake_up() gets called 4 times and the fourth call decrements
wait_cnt to 0 so it ends up calling wake_up_nr(wq0, 4). Fine, one of the
waiters is woken up but the other one is still sleeping in wq1 and there
are not enough wakeups to fill the batch and wake it up? This is
essentially because we have lost three wakeups on wq0 because it didn't
have enough waiters to wake...

Finally, sbitmap_queue_wake_up() is racy and if two of them race together,
they can end up decrementing wait_cnt of wq which does not have any process
queued which again effectively leads to lost wakeups and possibly
indefinitely sleeping tasks.

Now this all looks so broken that I'm unsure whether I'm not missing
something fundamental. Also I'm not quite sure how to fix all this without
basically destroying the batched wakeup feature (but I didn't put too much
thought to this yet). Comments?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
