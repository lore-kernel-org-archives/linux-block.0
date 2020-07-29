Return-Path: <SRS0=8JfY=BI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0310AC433E0
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 15:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D11D5207E8
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 15:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7bKKJwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgG2PuT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jul 2020 11:50:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36502 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726365AbgG2PuS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jul 2020 11:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596037817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SWb+vUYXDjN/e6oxI5FzzleNOmWY03z2eYXHvtXfPIA=;
        b=R7bKKJwFDszpcZWBUfW8BbcWs5xgbD6fR/27he6MB6X6L1SSD6yKK4biRE5jdpwAxIx6wJ
        7cANQ3eayZSB2D1ELRoNxDG7WVE7mH3LPhLvejqAt3t1MafDXf5u1klL0WgtLQmePB8Ub0
        JY5rWhRKJCBR9Ozit1XNi+5a7E8lbeE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-H9X8Ob6RNcSn-S3TUg1zSA-1; Wed, 29 Jul 2020 11:50:13 -0400
X-MC-Unique: H9X8Ob6RNcSn-S3TUg1zSA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A13DF1902EA0;
        Wed, 29 Jul 2020 15:50:11 +0000 (UTC)
Received: from T590 (ovpn-12-176.pek2.redhat.com [10.72.12.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E44E971926;
        Wed, 29 Jul 2020 15:50:01 +0000 (UTC)
Date:   Wed, 29 Jul 2020 23:49:57 +0800
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
Message-ID: <20200729154957.GD1698748@T590>
References: <20200728134938.1505467-1-ming.lei@redhat.com>
 <20200729102856.GA1563056@T590>
 <b80fa58d-34f0-cff5-c3f9-7b3d05a8a1ca@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b80fa58d-34f0-cff5-c3f9-7b3d05a8a1ca@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 29, 2020 at 08:42:31AM -0700, Sagi Grimberg wrote:
> 
> > > In case of BLK_MQ_F_BLOCKING, blk-mq uses SRCU to mark read critical
> > > section during dispatching request, then request queue quiesce is based on
> > > SRCU. What we want to get is low cost added in fast path.
> > > 
> > > However, from srcu_read_lock/srcu_read_unlock implementation, not see
> > > it is quicker than percpu refcount, so use percpu_ref to implement
> > > queue quiesce. This usage is cleaner and simpler & enough for implementing
> > > queue quiesce. The main requirement is to make sure all read sections to observe
> > > QUEUE_FLAG_QUIESCED once blk_mq_quiesce_queue() returns.
> > > 
> > > Also it becomes much easier to add interface of async queue quiesce.
> > 
> > BTW, no obvious IOPS difference is observed with this patch applied when running
> > io on null_blk(blocking, submit_queues=32) in one dual-socket, 32cores system.
> 
> Thanks Ming, can you test for non-blocking on the same setup?

OK, I can do that, but this patch supposes to not affect non-blocking,
care to share your motivation for testing non-blocking?


Thanks,
Ming

