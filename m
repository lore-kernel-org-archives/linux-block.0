Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC76BC43334
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 02:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiGZCGC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jul 2022 22:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbiGZCF7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jul 2022 22:05:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5CD69FDB
        for <linux-block@vger.kernel.org>; Mon, 25 Jul 2022 19:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658801156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s0/ER/yqIKgv2RYg0RZXPipIzo4s+ny7GH4DpsRUcBc=;
        b=FlNE2nat6WPUjTyUYqaOZlsv8+z6ZIWJANebaFblhzSP+Kl+6MyFRbvRJLj+KU0O+seBNg
        GqSp748OPeC0+FIJpgH6FjMR6MaSJLP77fdBa6EYBOfrnSyXIXNdCIsizs42q4AgvrWqwf
        XEz1a8RkhggNJw53NVzseaM0B87mIhY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-2ceZoup2NVSpm0y8M5ho4A-1; Mon, 25 Jul 2022 22:05:53 -0400
X-MC-Unique: 2ceZoup2NVSpm0y8M5ho4A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1F98280F2A4;
        Tue, 26 Jul 2022 02:05:52 +0000 (UTC)
Received: from T590 (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC1AA2026D64;
        Tue, 26 Jul 2022 02:05:48 +0000 (UTC)
Date:   Tue, 26 Jul 2022 10:05:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [bug report] nvme/rdma: nvme connect failed after offline one
 cpu on host side
Message-ID: <Yt9L9iGrkhDnK9aq@T590>
References: <CAHj4cs9+F5F-v_2m=MYd8B=dXVgTBrtGikTTzfBU8_cX8fb0=g@mail.gmail.com>
 <CAHj4cs_RUuiOw4pzSD+fv70p6izVMZ8z7mc+E0Kv0Rh8zriWCQ@mail.gmail.com>
 <2c42c70a-8eb4-a095-1d2b-139614ebd903@grimberg.me>
 <YsOKnb7MWLCeJxBE@T590>
 <0a8099e6-6e28-da1f-7b4b-0ea04fa8f9d6@grimberg.me>
 <YsY64iMxnLtucKsP@T590>
 <6c79d36f-1e74-c3b9-bded-0b1f7223dead@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c79d36f-1e74-c3b9-bded-0b1f7223dead@grimberg.me>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 07, 2022 at 10:28:22AM +0300, Sagi Grimberg wrote:
> 
> > > > > > update the subject to better describe the issue:
> > > > > > 
> > > > > > So I tried this issue on one nvme/rdma environment, and it was also
> > > > > > reproducible, here are the steps:
> > > > > > 
> > > > > > # echo 0 >/sys/devices/system/cpu/cpu0/online
> > > > > > # dmesg | tail -10
> > > > > > [  781.577235] smpboot: CPU 0 is now offline
> > > > > > # nvme connect -t rdma -a 172.31.45.202 -s 4420 -n testnqn
> > > > > > Failed to write to /dev/nvme-fabrics: Invalid cross-device link
> > > > > > no controller found: failed to write to nvme-fabrics device
> > > > > > 
> > > > > > # dmesg
> > > > > > [  781.577235] smpboot: CPU 0 is now offline
> > > > > > [  799.471627] nvme nvme0: creating 39 I/O queues.
> > > > > > [  801.053782] nvme nvme0: mapped 39/0/0 default/read/poll queues.
> > > > > > [  801.064149] nvme nvme0: Connect command failed, error wo/DNR bit: -16402
> > > > > > [  801.073059] nvme nvme0: failed to connect queue: 1 ret=-18
> > > > > 
> > > > > This is because of blk_mq_alloc_request_hctx() and was raised before.
> > > > > 
> > > > > IIRC there was reluctance to make it allocate a request for an hctx even
> > > > > if its associated mapped cpu is offline.
> > > > > 
> > > > > The latest attempt was from Ming:
> > > > > [PATCH V7 0/3] blk-mq: fix blk_mq_alloc_request_hctx
> > > > > 
> > > > > Don't know where that went tho...
> > > > 
> > > > The attempt relies on that the queue for connecting io queue uses
> > > > non-admined irq, unfortunately that can't be true for all drivers,
> > > > so that way can't go.
> > > 
> > > The only consumer is nvme-fabrics, so others don't matter.
> > > Maybe we need a different interface that allows this relaxation.
> > > 
> > > > So far, I'd suggest to fix nvme_*_connect_io_queues() to ignore failed
> > > > io queue, then the nvme host still can be setup with less io queues.
> > > 
> > > What happens when the CPU comes back? Not sure we can simply ignore it.
> > 
> > Anyway, it is a not good choice to fail the whole controller if only one
> > queue can't be connected.
> 
> That is irrelevant.
> 
> > I meant the queue can be kept as non-LIVE, and
> > it should work since no any io can be issued to this queue when it is
> > non-LIVE.
> 
> The way that nvme-pci behaves is to create all the queues and either
> have them idle when their mapped cpu is offline, and have the queue
> there and ready when the cpu comes back. It is the simpler approach and
> I would like to have it for fabrics too, but to establish a fabrics
> queue we need to send a request (connect) to the controller. The fact
> that we cannot simply get a reference to a request for a given hw queue
> is baffling to me.
> 
> > Just wondering why we can't re-connect the io queue and set LIVE after
> > any CPU in the this hctx->cpumask becomes online? blk-mq could add one
> > pair of callbacks for driver for handing this queue change.
> Certainly possible, but you are creating yet another interface solely
> for nvme-fabrics that covers up for the existing interface that does not
> satisfy what nvme-fabrics (the only consumer of it) would like it to do.

I guess you meant that the others(rdma and tcp) use non-managed queue,
so they needn't such change?

But it isn't true actually, blk-mq/nvme still can't handle it well. From
blk-mq's viewpoint, if all CPUs in hctx->cpumask are offline, it will
treat the hctx as inactive and not workable, and refuses to allocate
request from this hctx, no matter if the underlying queue irq is managed
or not.

Now after 14dc7a18abbe ("block: Fix handling of offline queues in
blk_mq_alloc_request_hctx(), it may break controller setup easily if
any CPU is offline.

I'd suggest to fix the issue in unified way since nvme-fabric needs to be
covered, then nvme's user experience can be improved.

BTW, I guess rdma/tcp/fc's queue may take extra or bigger resources than
nvme pci, if resource are only allocated until the queue is active, queue
resource utilization may be improved.



Thanks,
Ming

