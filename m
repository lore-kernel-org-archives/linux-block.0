Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97A6C433F5
	for <linux-block@archiver.kernel.org>; Sat, 20 Nov 2021 03:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbhKTECW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Nov 2021 23:02:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37050 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236167AbhKTECV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Nov 2021 23:02:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637380758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7jCE40jKoyCHYgJNTQgwVs3JjoQYLOmzMBpItFwtg4M=;
        b=E7Yh7ZSrjPXwAZ8y1WyMXTLXgfo6MamFzqiz94/6TM46OaBihj2IbTwXmusgjgE2Pmj0xe
        GacVwQfnwLu1oijYD+liS9dnDRlTfxk68+8tWPOobxk/WKcOusi1F23tziwpt9xVmC9v1k
        q7KjE3nBOuBsGM6xF2EjRW/pMPfz0CE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-E1ObOZQiMXCqC1R3C1Jitg-1; Fri, 19 Nov 2021 22:59:16 -0500
X-MC-Unique: E1ObOZQiMXCqC1R3C1Jitg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC88E806689;
        Sat, 20 Nov 2021 03:59:15 +0000 (UTC)
Received: from T590 (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E475119811;
        Sat, 20 Nov 2021 03:59:02 +0000 (UTC)
Date:   Sat, 20 Nov 2021 11:58:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Tim Walker <tim.t.walker@seagate.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Yi Zhang <yi.zhang@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] blk-mq: don't insert FUA request with data into
 scheduler queue
Message-ID: <YZhygSJylK4WeRNq@T590>
References: <20211118153041.2163228-1-ming.lei@redhat.com>
 <163732851304.44181.8545954410705439362.b4-ty@kernel.dk>
 <BFC93946-13B3-43EC-9E30-8A980CD5234F@seagate.com>
 <3DEFF083-6C67-4864-81A5-454A7DAC16C0@seagate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3DEFF083-6C67-4864-81A5-454A7DAC16C0@seagate.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 19, 2021 at 04:49:34PM +0000, Tim Walker wrote:
> 
> 
> ﻿On  19 Nov 2021 Tim Walker wrote:
> 
> >
> >
> >On Thu, 18 Nov 2021 23:30:41 +0800, Ming Lei wrote:
> >> We never insert flush request into scheduler queue before.
> >>
> >> Recently commit d92ca9d8348f ("blk-mq: don't handle non-flush requests in
> >> blk_insert_flush") tries to handle FUA data request as normal request.
> >> This way has caused warning[1] in mq-deadline dd_exit_sched() or io hang in
> >> case of kyber since RQF_ELVPRIV isn't set for flush request, then
> >> ->finish_request won't be called.
> >>
> >> [...]
> >
> >Applied, thanks!
> >
> >[1/1] blk-mq: don't insert FUA request with data into scheduler queue
> >      commit: 2b504bd4841bccbf3eb83c1fec229b65956ad8ad
> >
> >Best regards,
> >--
> >Jens Axboe
> >
> >
> >
> 
> I know the discussion is over, >

This thread is just for fixing one recent regression caused by queuing
FUA data into scheduler queue, and actually direct dispach has
been done for very long time, but I don't mean it is reasonable.

> but I can't figure out why we treat FUA as a flush. A FUA write only
> applies to the command at hand, and is not required to flush any previous
> command's data from the device's volatile write cache. Similarly for a
> read request - servicing a read from media is really more the rule than
> the exception (lots of workload dependencies here...), so why would a
> FUA read bypass the scheduler?

Is there linux kernel FUA read users? Just run a quick grep, seems FUA
is just used for sync write.

> The device is always free to service any request from media or cache (
> as long as it follows the applicable volatile write and read cache settings),
> so normally we don't know how it is treating the request, so it doesn't seem
> to matter. 
> 
> Consider a FUA write: Why does the fact that we intend that write to bypass
> the device volatile write cache mean it should bypass the scheduler? All the
> other traffic-shaping algorithms that help effectively schedule writes are
> still applicable. E.g. we know we can delay/coalesce them a bit to allow
> reads to be prioritized, but I can't figure out why we would fast-track a
> FUA write. Isn't the value to the system for scheduling still valid, even
> though we are forcing the data to go to media?

It shouldn't be hard to to queue FUA into scheduler, but details need to
consider, such as, if FUA can be merged with normal IO, maybe others.

Also do you have any test or benchmark result to support the change of
queuing FUA to scheduler?


Thanks,
Ming

