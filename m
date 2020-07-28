Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AAAC433E0
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 09:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A071C20714
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 09:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7rbYsnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgG1Jdq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:33:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46032 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728130AbgG1Jdp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 05:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595928824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dGU4qL4DU0btEF4z3eSCu70P6IJAwTZBKSCRVuLZFTQ=;
        b=K7rbYsnkaUJtEK90WxB9UhBjxbY+JwV0tvoTB0NcSOdNLFJlr8VKVBZkxTDxUe0MT9oAE0
        5DTSj4/h6NodPx+SNiLEZ9YCyBC43M/C17si7XiPCvDhIFn9dxjBKV3zlJmMWVakjaOP9o
        R4h/YwFvvU6O4WlqMKZBhm48Xd75H8g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-WHshVYmMO3SvupRBQkriyA-1; Tue, 28 Jul 2020 05:33:42 -0400
X-MC-Unique: WHshVYmMO3SvupRBQkriyA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E5EB800597;
        Tue, 28 Jul 2020 09:33:40 +0000 (UTC)
Received: from T590 (ovpn-12-109.pek2.redhat.com [10.72.12.109])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EB1190E63;
        Tue, 28 Jul 2020 09:33:31 +0000 (UTC)
Date:   Tue, 28 Jul 2020 17:33:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Chao Leng <lengchao@huawei.com>,
        Keith Busch <kbusch@kernel.org>, Ming Lin <mlin@kernel.org>
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20200728093326.GC1326626@T590>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me>
 <20200728071859.GA21629@lst.de>
 <20200728091633.GB1326626@T590>
 <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 28, 2020 at 02:24:38AM -0700, Sagi Grimberg wrote:
> 
> > > I like the tagset based interface.  But the idea of doing a per-hctx
> > > allocation and wait doesn't seem very scalable.
> > > 
> > > Paul, do you have any good idea for an interface that waits on
> > > multiple srcu heads?  As far as I can tell we could just have a single
> > > global completion and counter, and each call_srcu would just just
> > > decrement it and then the final one would do the wakeup.  It would just
> > > be great to figure out a way to keep the struct rcu_synchronize and
> > > counter on stack to avoid an allocation.
> > > 
> > > But if we can't do with an on-stack object I'd much rather just embedd
> > > the rcu_head in the hw_ctx.
> > 
> > I think we can do that, please see the following patch which is against Sagi's V5:
> 
> I don't think you can send a single rcu_head to multiple call_srcu calls.

OK, then one variant is to put the rcu_head into blk_mq_hw_ctx, and put
rcu_synchronize into blk_mq_tag_set.


Thanks,
Ming

