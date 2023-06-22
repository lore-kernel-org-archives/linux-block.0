Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF1EEB64DB
	for <linux-block@archiver.kernel.org>; Thu, 22 Jun 2023 15:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjFVPTZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Jun 2023 11:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjFVPTY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jun 2023 11:19:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1828E42
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 08:19:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D1AE6187F
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 15:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A163C433CD;
        Thu, 22 Jun 2023 15:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687447162;
        bh=5/DP6sm4OvRXNhw3lfTvZLQV1+Agd8hDIBi4tC75pYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CjJ3s2zoc9UZvDSaZZabIq+PT/GDGFJbbk8ZoJl9UMHjq+nxZvEvQ8lbpdw9t+8NT
         Wvsd0aneCs7BQnix9hQKL4A2gLHTeVroRjtIwcUcPSvNwQZGKgl2SYT+DnwwZCKrwE
         eBLTxFdCkbkAQD/9d+bbPIINNJRX1DjuWblp00Dg+o6osAOInuHhXkzLt4svrdW0K5
         nS6/6eLIWpQesmPu10/GqhjH2O3tVqAXRbONY7yP0drdnDLXGA/TzK78ikw0QuNWlh
         HKYAaKuIIwUDzVPd1XfMhHxGu/gfwd+kjjLvxzxNTW7myN83Vr+41XyLJeroXKoe8o
         9tmOt0TJC/38Q==
Date:   Thu, 22 Jun 2023 09:19:19 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Message-ID: <ZJRmd7bnclaNW3PL@kbusch-mbp.dhcp.thefacebook.com>
References: <86c10889-4d4a-1892-9779-a5f7b4e93392@grimberg.me>
 <ZJGoWGJ5/fKfIhx+@ovpn-8-23.pek2.redhat.com>
 <27ce75fc-f6c5-7bf3-8448-242ee3e65067@grimberg.me>
 <ZJI/1w8/9pLIyXZ2@ovpn-8-23.pek2.redhat.com>
 <caa80682-3c3e-f709-804a-6ee913e4524f@grimberg.me>
 <ZJL6w+K6e95WWJzV@ovpn-8-23.pek2.redhat.com>
 <ZJMb4f0i9wm8y4pi@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRR0C9sqLp7zhAv@ovpn-8-19.pek2.redhat.com>
 <ZJRcRWyn7o7lLEDM@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRgUXfRuuOoIN1o@ovpn-8-19.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJRgUXfRuuOoIN1o@ovpn-8-19.pek2.redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 22, 2023 at 10:53:05PM +0800, Ming Lei wrote:
> On Thu, Jun 22, 2023 at 08:35:49AM -0600, Keith Busch wrote:
> > On Thu, Jun 22, 2023 at 09:51:12PM +0800, Ming Lei wrote:
> > > On Wed, Jun 21, 2023 at 09:48:49AM -0600, Keith Busch wrote:
> > > > The point was to contain requests from entering while the hctx's are
> > > > being reconfigured. If you're going to pair up the freezes as you've
> > > > suggested, we might as well just not call freeze at all.
> > > 
> > > blk_mq_update_nr_hw_queues() requires queue to be frozen.
> > 
> > It's too late at that point. Let's work through a real example. You'll
> > need a system that has more CPU's than your nvme has IO queues.
> > 
> > Boot without any special nvme parameters. Every possible nvme IO queue
> > will be assigned "default" hctx type. Now start IO to every queue, then
> > run:
> > 
> >   # echo 8 > /sys/modules/nvme/parameters/poll_queues && echo 1 > /sys/class/nvme/nvme0/reset_controller
> > 
> > Today, we freeze prior to tearing down the "default" IO queues, so
> > there's nothing entered into them while the driver reconfigures the
> > queues.
> 
> nvme_start_freeze() just prevents new IO from being queued, and old ones
> may still be entering block layer queue, and what matters here is
> actually quiesce, which prevents new IO from being queued to
> driver/hardware.
> 
> > 
> > What you're suggesting will allow IO to queue up in a queisced "default"
> > queue, which will become "polled" without an interrupt hanlder on the
> > other side of the reset. The application doesn't know that, so the IO
> > you're allowing to queue up will time out.
> 
> time out only happens after the request is queued to driver/hardware, or after
> blk_mq_start_request() is called in nvme_queue_rq(), but quiesce actually
> prevents new IOs from being dispatched to driver or be queued via .queue_rq(),
> meantime old requests have been canceled, so no any request can be
> timed out.

Quiesce doesn't prevent requests from entering an hctx, and you can't
back it out to put on another hctx later. It doesn't matter that you
haven't dispatched it to hardware yet. The request's queue was set the
moment it was allocated, so after you unquiesce and freeze for the new
queue mapping, the requests previously blocked on quiesce will time out
in the scenario I've described.

There are certainly gaps in the existing code where error'ed requests
can be requeued or stuck elsewhere and hit the exact same problem, but
the current way at least tries to contain it.
