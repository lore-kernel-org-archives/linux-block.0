Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEC0C433EF
	for <linux-block@archiver.kernel.org>; Thu,  7 Jul 2022 08:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbiGGIHw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Jul 2022 04:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbiGGIHk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Jul 2022 04:07:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D2DC33E36
        for <linux-block@vger.kernel.org>; Thu,  7 Jul 2022 01:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657181258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dLP0ZQf4DS0wiGvKT82c/eZrRLWzEvLrVUVmEQgB3dg=;
        b=iecGLsJj+YJUP6RrtX675kjzG/d3r+XBj5yXfLKyrF2DwN3E1nvrHKuPsWQ8VSa4co85Sf
        DuDtMZ52Ot82OXUmRKR25duFSC2WIPSuBzoypF3+/8T+U56xdPlKMgIMxVo8eE/AQYD8/E
        zAxQb1Ms7EnHWG3Fv6aXl2lUMMTBKpU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-55-nOh_LXgGMrKJq5suNPFwgw-1; Thu, 07 Jul 2022 04:07:35 -0400
X-MC-Unique: nOh_LXgGMrKJq5suNPFwgw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9EA5D3821C06;
        Thu,  7 Jul 2022 08:07:34 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AFCA52EF99;
        Thu,  7 Jul 2022 08:07:30 +0000 (UTC)
Date:   Thu, 7 Jul 2022 16:07:25 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [bug report] nvme/rdma: nvme connect failed after offline one
 cpu on host side
Message-ID: <YsaUPT+6Brqw49gM@T590>
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
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
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

Isn't the exact issue reported by Yi?  If there is one cpu offline, the
controller may not be setup in case of 1:1 mapping, do you think this
way is reasonable?

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

It is because the connection need one request from specified hctx, this
way is anti blk-mq queue design.

Previously kernel panic is caused, but now controller can't be setup if
any io queue can't be connected.

> 
> > Just wondering why we can't re-connect the io queue and set LIVE after
> > any CPU in the this hctx->cpumask becomes online? blk-mq could add one
> > pair of callbacks for driver for handing this queue change.
> Certainly possible, but you are creating yet another interface solely
> for nvme-fabrics that covers up for the existing interface that does not
> satisfy what nvme-fabrics (the only consumer of it) would like it to do.

The interface can be well defined, and may have generic usage, such as, delay
allocating request pool until the queue becomes active(any cpu in its
mapping becomes online) for saving memory consumption.



Thanks,
Ming

