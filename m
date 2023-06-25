Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FBDEB64DA
	for <linux-block@archiver.kernel.org>; Sun, 25 Jun 2023 00:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjFYA1v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Jun 2023 20:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjFYA1v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Jun 2023 20:27:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E853D10FC
        for <linux-block@vger.kernel.org>; Sat, 24 Jun 2023 17:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687652821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V8s4QvpXwSYPKRFomDkujYHgHMc8jEkRSvTYXcWmxyY=;
        b=UhrzeXKBk5B0CX3tjdkh2eqBO5wMhw8invopDjDlIHwU/qqKIseSp2sJUJMgFWH7A7jv/p
        v4Pp2MDQ2AkSrYzC1NKrz9ACKeRR3ziwAfAmeFZezT3Dm9XlknFxJgR02UUhkHxmEOhJNm
        4Ges59JIhFQyGmmmld5zOfFmIPimNOM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-EjYExB4SO7a-6MQS9Xci3A-1; Sat, 24 Jun 2023 20:26:58 -0400
X-MC-Unique: EjYExB4SO7a-6MQS9Xci3A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 104BC8CC203;
        Sun, 25 Jun 2023 00:26:58 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2376B492B01;
        Sun, 25 Jun 2023 00:26:52 +0000 (UTC)
Date:   Sun, 25 Jun 2023 08:26:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Message-ID: <ZJeJyEnSpVBDd4vb@ovpn-8-16.pek2.redhat.com>
References: <ZJGoWGJ5/fKfIhx+@ovpn-8-23.pek2.redhat.com>
 <27ce75fc-f6c5-7bf3-8448-242ee3e65067@grimberg.me>
 <ZJI/1w8/9pLIyXZ2@ovpn-8-23.pek2.redhat.com>
 <caa80682-3c3e-f709-804a-6ee913e4524f@grimberg.me>
 <ZJL6w+K6e95WWJzV@ovpn-8-23.pek2.redhat.com>
 <ZJMb4f0i9wm8y4pi@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRR0C9sqLp7zhAv@ovpn-8-19.pek2.redhat.com>
 <ZJRcRWyn7o7lLEDM@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRgUXfRuuOoIN1o@ovpn-8-19.pek2.redhat.com>
 <ZJRmd7bnclaNW3PL@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJRmd7bnclaNW3PL@kbusch-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 22, 2023 at 09:19:19AM -0600, Keith Busch wrote:
> On Thu, Jun 22, 2023 at 10:53:05PM +0800, Ming Lei wrote:
> > On Thu, Jun 22, 2023 at 08:35:49AM -0600, Keith Busch wrote:
> > > On Thu, Jun 22, 2023 at 09:51:12PM +0800, Ming Lei wrote:
> > > > On Wed, Jun 21, 2023 at 09:48:49AM -0600, Keith Busch wrote:
> > > > > The point was to contain requests from entering while the hctx's are
> > > > > being reconfigured. If you're going to pair up the freezes as you've
> > > > > suggested, we might as well just not call freeze at all.
> > > > 
> > > > blk_mq_update_nr_hw_queues() requires queue to be frozen.
> > > 
> > > It's too late at that point. Let's work through a real example. You'll
> > > need a system that has more CPU's than your nvme has IO queues.
> > > 
> > > Boot without any special nvme parameters. Every possible nvme IO queue
> > > will be assigned "default" hctx type. Now start IO to every queue, then
> > > run:
> > > 
> > >   # echo 8 > /sys/modules/nvme/parameters/poll_queues && echo 1 > /sys/class/nvme/nvme0/reset_controller
> > > 
> > > Today, we freeze prior to tearing down the "default" IO queues, so
> > > there's nothing entered into them while the driver reconfigures the
> > > queues.
> > 
> > nvme_start_freeze() just prevents new IO from being queued, and old ones
> > may still be entering block layer queue, and what matters here is
> > actually quiesce, which prevents new IO from being queued to
> > driver/hardware.
> > 
> > > 
> > > What you're suggesting will allow IO to queue up in a queisced "default"
> > > queue, which will become "polled" without an interrupt hanlder on the
> > > other side of the reset. The application doesn't know that, so the IO
> > > you're allowing to queue up will time out.
> > 
> > time out only happens after the request is queued to driver/hardware, or after
> > blk_mq_start_request() is called in nvme_queue_rq(), but quiesce actually
> > prevents new IOs from being dispatched to driver or be queued via .queue_rq(),
> > meantime old requests have been canceled, so no any request can be
> > timed out.
> 
> Quiesce doesn't prevent requests from entering an hctx, and you can't
> back it out to put on another hctx later. It doesn't matter that you
> haven't dispatched it to hardware yet. The request's queue was set the
> moment it was allocated, so after you unquiesce and freeze for the new
> queue mapping, the requests previously blocked on quiesce will time out
> in the scenario I've described.
> 
> There are certainly gaps in the existing code where error'ed requests
> can be requeued or stuck elsewhere and hit the exact same problem, but
> the current way at least tries to contain it.

Yeah, but you can't remove the gap at all with start_freeze, that said
the current code has to live with the situation of new mapping change
and old request with old mapping.

Actually I considered to handle this kind of situation before, one approach
is to reuse the bio steal logic taken in nvme mpath:

1) for FS IO, re-submit bios, meantime free request

2) for PT request, simply fail it

It could be a bit violent for 2) even though REQ_FAILFAST_DRIVER is
always set for PT request, but not see any better approach for handling
PT request.


Thanks,
Ming

