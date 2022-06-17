Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B2CC433EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 01:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379457AbiFQBHd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 21:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiFQBHc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 21:07:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BDB66E8
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 18:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655428048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EAdBP9v0Q3mkGXDFeOnPoAZo+l2r5ceuM6IOB5xixn8=;
        b=F68EOC2BaACECapD5yTW8h+N6sFETS6wSKRSg7RX5y6rs/icGQPEdbW+SKC/Oar/hhQDce
        9MO8fZYNd6byv8aioF1UwHngis37+S3atIQ4eLMx/zbsdsa3AKlvGnB5fPbJUHRd+9za5/
        abd+MSuWCyy9Wyylckraa5XuPQCjI3M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-3x7mUX34Mhmh9y5AZS3UYA-1; Thu, 16 Jun 2022 21:07:27 -0400
X-MC-Unique: 3x7mUX34Mhmh9y5AZS3UYA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F14BD3C021B4;
        Fri, 17 Jun 2022 01:07:26 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 99E2840CFD0D;
        Fri, 17 Jun 2022 01:07:23 +0000 (UTC)
Date:   Fri, 17 Jun 2022 09:07:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        linux-block@vger.kernel.org
Subject: Re: Races in sbitmap batched wakeups
Message-ID: <YqvTxl8CvRe1Anr0@T590>
References: <20220616172102.yrxod3ptmhiuvqsw@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616172102.yrxod3ptmhiuvqsw@quack3.lan>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 16, 2022 at 07:21:02PM +0200, Jan Kara wrote:
> Hello!
> 
> I've been debugging some customer reports of tasks hanging (forever)
> waiting for free tags when in fact all tags are free. After looking into it
> for some time I think I know what it happening. First, keep in mind that
> it concerns a device which uses shared tags. There are 127 tags available
> and the number of active queues using these tags is easily 40 or more. So
> number of tags available for each device is rather small. Now I'm not sure
> how batched wakeups can ever work in such situations, but maybe I'm missing
> something.
> 
> So take for example a situation where two tags are available for a device,
> they are both currently used. Now a process comes into blk_mq_get_tag() and
> wants to allocate tag and goes to sleep. Now how can it ever be woken up if
> wake_batch is 4? If the two IOs complete, sbitmap will get two wakeups but
> that's not enough to trigger the batched wakeup to really wakeup the
> waiter...

commit 180dccb0dba4 ("blk-mq: fix tag_get wait task can't be awakened")
is supposed for addressing this kind of issue.

> 
> Even if we have say 4 tags available so in theory there should be enough
> wakeups to fill the batch, there can be the following problem. So 4 tags
> are in use, two processes come to blk_mq_get_tag() and sleep, one on wait
> queue 0, one on wait queue 1. Now four IOs complete so
> sbitmap_queue_wake_up() gets called 4 times and the fourth call decrements
> wait_cnt to 0 so it ends up calling wake_up_nr(wq0, 4). Fine, one of the
> waiters is woken up but the other one is still sleeping in wq1 and there
> are not enough wakeups to fill the batch and wake it up? This is
> essentially because we have lost three wakeups on wq0 because it didn't
> have enough waiters to wake...

But the following completions will wake up the waiter in wq1, given
there are more in-flight.

Thanks,
Ming

