Return-Path: <SRS0=FZnh=BK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B3EC433E0
	for <linux-block@archiver.kernel.org>; Fri, 31 Jul 2020 00:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9C782082E
	for <linux-block@archiver.kernel.org>; Fri, 31 Jul 2020 00:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hdpJ5tEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbgGaA25 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jul 2020 20:28:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38780 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730800AbgGaA24 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jul 2020 20:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596155335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9OWTPiMfSRJxshvx6fPA2F7HS2YyXzXf7Obr9RHhwHY=;
        b=hdpJ5tEqYM1g4tX069RdpgMQu8r6wbxrG+QYjaP13aeyLrBSD2/+heqecXKIbXWXuOEFnR
        i9OueTiiRNWn42brsjMm2Z31qUo6XJTTGgeAcqvupshv8MKQIZBbb/acVSGMgj9onqOr9m
        bkAMCy2U7FROBOTF6w6URSHXRv+r7NI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-_s1wQzlfPm6ORVb8396lFQ-1; Thu, 30 Jul 2020 20:28:50 -0400
X-MC-Unique: _s1wQzlfPm6ORVb8396lFQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC9FE800465;
        Fri, 31 Jul 2020 00:28:48 +0000 (UTC)
Received: from T590 (ovpn-12-75.pek2.redhat.com [10.72.12.75])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B2C11992D;
        Fri, 31 Jul 2020 00:28:42 +0000 (UTC)
Date:   Fri, 31 Jul 2020 08:28:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [RFC PATCH] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
Message-ID: <20200731002838.GB1717993@T590>
References: <20200728134938.1505467-1-ming.lei@redhat.com>
 <20200729102856.GA1563056@T590>
 <b80fa58d-34f0-cff5-c3f9-7b3d05a8a1ca@grimberg.me>
 <20200729154957.GD1698748@T590>
 <f3ead535-070d-40ec-08b8-56e2c1cd7ba4@grimberg.me>
 <20200730145325.GA1710335@T590>
 <57689a6d-9e6f-bb28-dd5f-f575988e7cb6@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57689a6d-9e6f-bb28-dd5f-f575988e7cb6@grimberg.me>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 30, 2020 at 09:10:48AM -0700, Sagi Grimberg wrote:
> 
> > > > > > > In case of BLK_MQ_F_BLOCKING, blk-mq uses SRCU to mark read critical
> > > > > > > section during dispatching request, then request queue quiesce is based on
> > > > > > > SRCU. What we want to get is low cost added in fast path.
> > > > > > > 
> > > > > > > However, from srcu_read_lock/srcu_read_unlock implementation, not see
> > > > > > > it is quicker than percpu refcount, so use percpu_ref to implement
> > > > > > > queue quiesce. This usage is cleaner and simpler & enough for implementing
> > > > > > > queue quiesce. The main requirement is to make sure all read sections to observe
> > > > > > > QUEUE_FLAG_QUIESCED once blk_mq_quiesce_queue() returns.
> > > > > > > 
> > > > > > > Also it becomes much easier to add interface of async queue quiesce.
> > > > > > 
> > > > > > BTW, no obvious IOPS difference is observed with this patch applied when running
> > > > > > io on null_blk(blocking, submit_queues=32) in one dual-socket, 32cores system.
> > > > > 
> > > > > Thanks Ming, can you test for non-blocking on the same setup?
> > > > 
> > > > OK, I can do that, but this patch supposes to not affect non-blocking,
> > > > care to share your motivation for testing non-blocking?
> > > 
> > > I think it will be a significant improvement to have a single code path.
> > > The code will be more robust and we won't need to face issues that are
> > > specific for blocking.
> > > 
> > > If the cost is negligible, I think the upside is worth it.
> > > 
> > 
> > rcu_read_lock and rcu_read_unlock has been proved as efficient enough,
> > and I don't think percpu_refcount is better than it, so I'd suggest to
> > not switch non-blocking into this way.
> 
> It's not a matter of which is better, its a matter of making the code
> more robust because it has a single code-path. If moving to percpu_ref
> is negligible, I would suggest to move both, I don't want to have two
> completely different mechanism for blocking vs. non-blocking.

RCU and SRCU have been different mechanism already.

> 
> > BTW, in case of blocking, one hctx may dispatch at most one request because there
> > is only single .run_work, even though when .queue_rq() is slept, that said
> > blk_mq_submit_bio() queues bio in sync style. This way won't be very efficient.
> > So percpu_refcount should be good enough for blocking code path, but may not be
> > well enough for non-blocking case.
> 
> Not sure what you mean, the percpu_ref is taken exactly where rcu is
> taken, not sure what is the difference.

My point is that blocking can't be efficient enough, when .queue_rq() is
slept, no any request can be queued to this hctx any more.


thanks,
Ming

