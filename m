Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331B4EB64D8
	for <linux-block@archiver.kernel.org>; Thu, 22 Jun 2023 13:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjFVNwG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Jun 2023 09:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjFVNwF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jun 2023 09:52:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD6819AD
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 06:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687441884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+froBx8zvPBtR/eIa8M7bzJNTnSzCJDlFkDT6qHX2Qc=;
        b=RJDvEd3scWyJIvFtWtrtGjXmL75a6DKNMXMIFwbPfq4QOOYoPT+oZvGXVrEm/qbaV9i8Dn
        5omihwJCNluQAJHE18y+uqn6oTjQqdAHSG8VQCaD7ypNe1kT2RHxh2YSsTCXUmzwVAqKmY
        r1uEa5kRVeG8/NjXtVBr5p5+JtSf8UU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-vkccfEBqO3e6dLb-MV3YuA-1; Thu, 22 Jun 2023 09:51:22 -0400
X-MC-Unique: vkccfEBqO3e6dLb-MV3YuA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D2433C15FA9;
        Thu, 22 Jun 2023 13:51:22 +0000 (UTC)
Received: from ovpn-8-19.pek2.redhat.com (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B45B422B0;
        Thu, 22 Jun 2023 13:51:16 +0000 (UTC)
Date:   Thu, 22 Jun 2023 21:51:12 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Message-ID: <ZJRR0C9sqLp7zhAv@ovpn-8-19.pek2.redhat.com>
References: <20230620013349.906601-1-ming.lei@redhat.com>
 <86c10889-4d4a-1892-9779-a5f7b4e93392@grimberg.me>
 <ZJGoWGJ5/fKfIhx+@ovpn-8-23.pek2.redhat.com>
 <27ce75fc-f6c5-7bf3-8448-242ee3e65067@grimberg.me>
 <ZJI/1w8/9pLIyXZ2@ovpn-8-23.pek2.redhat.com>
 <caa80682-3c3e-f709-804a-6ee913e4524f@grimberg.me>
 <ZJL6w+K6e95WWJzV@ovpn-8-23.pek2.redhat.com>
 <ZJMb4f0i9wm8y4pi@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJMb4f0i9wm8y4pi@kbusch-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 21, 2023 at 09:48:49AM -0600, Keith Busch wrote:
> On Wed, Jun 21, 2023 at 09:27:31PM +0800, Ming Lei wrote:
> > On Wed, Jun 21, 2023 at 01:13:05PM +0300, Sagi Grimberg wrote:
> > > 
> > > > > > > > Hello,
> > > > > > > > 
> > > > > > > > The 1st three patch fixes io hang when controller removal interrupts error
> > > > > > > > recovery, then queue is left as frozen.
> > > > > > > > 
> > > > > > > > The 4th patch fixes io hang when controller is left as unquiesce.
> > > > > > > 
> > > > > > > Ming, what happened to nvme-tcp/rdma move of freeze/unfreeze to the
> > > > > > > connect patches?
> > > > > > 
> > > > > > I'd suggest to handle all drivers(include nvme-pci) in same logic for avoiding
> > > > > > extra maintain burden wrt. error handling, but looks Keith worries about the
> > > > > > delay freezing may cause too many requests queued during error handling, and
> > > > > > that might cause user report.
> > > > > 
> > > > > For nvme-tcp/rdma your patch also addresses IO not failing over because
> > > > > they block on queue enter. So I definitely want this for fabrics.
> > > > 
> > > > The patch in the following link should fix these issues too:
> > > > 
> > > > https://lore.kernel.org/linux-block/ZJGmW7lEaipT6saa@ovpn-8-23.pek2.redhat.com/T/#u
> > > > 
> > > > I guess you still want the paired freeze patch because it makes freeze &
> > > > unfreeze more reliable in error handling. If yes, I can make one fabric
> > > > only change for you.
> > > 
> > > Not sure exactly what reliability is referred here.
> > 
> > freeze and unfreeze have to be called strictly in pair, but nvme calls
> > the two from different contexts, so unfreeze may easily be missed, and
> > causes mismatched freeze count. There has many such reports so far.
> > 
> > > I agree that there
> > > is an issue with controller delete during error recovery. The patch
> > > was a way to side-step it, great. But it addressed I/O blocked on enter
> > > and not failing over.
> > > 
> > > So yes, for fabrics we should have it. I would argue that it would be
> > > the right thing to do for pci as well. But I won't argue if Keith feels
> > > otherwise.
> > 
> > Keith, can you update with us if you are fine with moving
> > nvme_start_freeze() into nvme_reset_work() for nvme pci driver?
> 
> The point was to contain requests from entering while the hctx's are
> being reconfigured. If you're going to pair up the freezes as you've
> suggested, we might as well just not call freeze at all.

blk_mq_update_nr_hw_queues() requires queue to be frozen.


Thanks,
Ming

