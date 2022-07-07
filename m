Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DA8C43334
	for <linux-block@archiver.kernel.org>; Thu,  7 Jul 2022 01:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiGGBqY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Jul 2022 21:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiGGBqX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jul 2022 21:46:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A593A2ED6D
        for <linux-block@vger.kernel.org>; Wed,  6 Jul 2022 18:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657158381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=balIyGGcThFGQnZtBoNOoylNjVr91YNMza6Ayzw3JGM=;
        b=E6QKueb65reyFzd2eqFLFyYGlP7cU8dXEKc3MaKHG8mt6rOWwjf+3Z5EsFahghn2lWfBn+
        +xhR76/inbARqWMWYa96S+FE7t6q4Y0aQLil6EL1e+QCecXMSO03ufHUuqQgUdgWt/B2+L
        o+07nfBaIiLy0NNcX8562RrV+T6olxg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-_XOvf8u9PLGwRWov-MAsuw-1; Wed, 06 Jul 2022 21:46:20 -0400
X-MC-Unique: _XOvf8u9PLGwRWov-MAsuw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24558185A7B2;
        Thu,  7 Jul 2022 01:46:20 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 81F4C18ECC;
        Thu,  7 Jul 2022 01:46:15 +0000 (UTC)
Date:   Thu, 7 Jul 2022 09:46:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [bug report] nvme/rdma: nvme connect failed after offline one
 cpu on host side
Message-ID: <YsY64iMxnLtucKsP@T590>
References: <CAHj4cs9+F5F-v_2m=MYd8B=dXVgTBrtGikTTzfBU8_cX8fb0=g@mail.gmail.com>
 <CAHj4cs_RUuiOw4pzSD+fv70p6izVMZ8z7mc+E0Kv0Rh8zriWCQ@mail.gmail.com>
 <2c42c70a-8eb4-a095-1d2b-139614ebd903@grimberg.me>
 <YsOKnb7MWLCeJxBE@T590>
 <0a8099e6-6e28-da1f-7b4b-0ea04fa8f9d6@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a8099e6-6e28-da1f-7b4b-0ea04fa8f9d6@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 06, 2022 at 06:30:43PM +0300, Sagi Grimberg wrote:
> 
> > > > update the subject to better describe the issue:
> > > > 
> > > > So I tried this issue on one nvme/rdma environment, and it was also
> > > > reproducible, here are the steps:
> > > > 
> > > > # echo 0 >/sys/devices/system/cpu/cpu0/online
> > > > # dmesg | tail -10
> > > > [  781.577235] smpboot: CPU 0 is now offline
> > > > # nvme connect -t rdma -a 172.31.45.202 -s 4420 -n testnqn
> > > > Failed to write to /dev/nvme-fabrics: Invalid cross-device link
> > > > no controller found: failed to write to nvme-fabrics device
> > > > 
> > > > # dmesg
> > > > [  781.577235] smpboot: CPU 0 is now offline
> > > > [  799.471627] nvme nvme0: creating 39 I/O queues.
> > > > [  801.053782] nvme nvme0: mapped 39/0/0 default/read/poll queues.
> > > > [  801.064149] nvme nvme0: Connect command failed, error wo/DNR bit: -16402
> > > > [  801.073059] nvme nvme0: failed to connect queue: 1 ret=-18
> > > 
> > > This is because of blk_mq_alloc_request_hctx() and was raised before.
> > > 
> > > IIRC there was reluctance to make it allocate a request for an hctx even
> > > if its associated mapped cpu is offline.
> > > 
> > > The latest attempt was from Ming:
> > > [PATCH V7 0/3] blk-mq: fix blk_mq_alloc_request_hctx
> > > 
> > > Don't know where that went tho...
> > 
> > The attempt relies on that the queue for connecting io queue uses
> > non-admined irq, unfortunately that can't be true for all drivers,
> > so that way can't go.
> 
> The only consumer is nvme-fabrics, so others don't matter.
> Maybe we need a different interface that allows this relaxation.
> 
> > So far, I'd suggest to fix nvme_*_connect_io_queues() to ignore failed
> > io queue, then the nvme host still can be setup with less io queues.
> 
> What happens when the CPU comes back? Not sure we can simply ignore it.

Anyway, it is a not good choice to fail the whole controller if only one
queue can't be connected. I meant the queue can be kept as non-LIVE, and
it should work since no any io can be issued to this queue when it is
non-LIVE.

Just wondering why we can't re-connect the io queue and set LIVE after
any CPU in the this hctx->cpumask becomes online? blk-mq could add one
pair of callbacks for driver for handing this queue change.


thanks,
Ming

