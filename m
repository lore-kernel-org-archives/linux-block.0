Return-Path: <SRS0=/Scz=CT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B7AC43461
	for <linux-block@archiver.kernel.org>; Thu, 10 Sep 2020 08:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65EB1206B8
	for <linux-block@archiver.kernel.org>; Thu, 10 Sep 2020 08:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7AUs+v7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgIJIEA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:04:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26235 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729296AbgIJID7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Sep 2020 04:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599725037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SoH5gZb9aZEHYWTTPdo+ibKytr1EsY2lWTBxjA404Zo=;
        b=B7AUs+v7S6751woIU8AEGgnKdb+hZQg3+dwjAXtOPf4HXmc3PDzA6AiD01AqyqsxOT6ats
        +Motb4kyRtpSngoVe1opUF4W7r84seLXAIT7GC1T0slkGqzUdFOmkLQ4WGdf/JDaO2xtkv
        Pu23PwpJ7Tazdx64d9WSa6M4/d4YMDI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-DC3XShtrNyeuG1BVu56zSQ-1; Thu, 10 Sep 2020 04:03:53 -0400
X-MC-Unique: DC3XShtrNyeuG1BVu56zSQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B17580ED92;
        Thu, 10 Sep 2020 08:03:51 +0000 (UTC)
Received: from T590 (ovpn-12-146.pek2.redhat.com [10.72.12.146])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DAEC7E8F1;
        Thu, 10 Sep 2020 08:03:42 +0000 (UTC)
Date:   Thu, 10 Sep 2020 16:03:37 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V4 2/4] blk-mq: implement queue quiesce via percpu_ref
 for BLK_MQ_F_BLOCKING
Message-ID: <20200910080337.GC31286@T590>
References: <20200909104116.1674592-1-ming.lei@redhat.com>
 <20200909104116.1674592-3-ming.lei@redhat.com>
 <20200909160409.GA3356175@dhcp-10-100-145-180.wdl.wdc.com>
 <dae73b2c-c191-c8a6-4287-838ab4962467@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dae73b2c-c191-c8a6-4287-838ab4962467@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 09, 2020 at 01:53:30PM -0700, Sagi Grimberg wrote:
> 
> > >   void blk_mq_quiesce_queue(struct request_queue *q)
> > >   {
> > > -	struct blk_mq_hw_ctx *hctx;
> > > -	unsigned int i;
> > > -	bool rcu = false;
> > > +	bool blocking = !!(q->tag_set->flags & BLK_MQ_F_BLOCKING);
> > > +	bool was_quiesced =__blk_mq_quiesce_queue_nowait(q);
> > > -	__blk_mq_quiesce_queue_nowait(q);
> > > +	if (!was_quiesced && blocking)
> > > +		percpu_ref_kill(&q->dispatch_counter);
> > > -	queue_for_each_hw_ctx(q, hctx, i) {
> > > -		if (hctx->flags & BLK_MQ_F_BLOCKING)
> > > -			synchronize_srcu(hctx->srcu);
> > > -		else
> > > -			rcu = true;
> > > -	}
> > > -	if (rcu)
> > > +	if (blocking)
> > > +		wait_event(q->mq_quiesce_wq,
> > > +				percpu_ref_is_zero(&q->dispatch_counter));
> > > +	else
> > >   		synchronize_rcu();
> > >   }
> > 
> > In the previous version, you had ensured no thread can unquiesce a queue
> > while another is waiting for quiescence. Now that the locking is gone,
> > a thread could unquiesce the queue before percpu_ref reaches zero, so
> > the wait_event() may never complete on the resurrected percpu_ref.
> 
> Yea, where did that go?

The mutex is removed because:

1) As Bart mentioned, blk_mq_quiesce_queue() may be called in context
which doesn't allow sleep.

2) Both percpu_ref_kill() and percpu_ref_resurrect() have been protected by
one global spinlock, so both two can be run concurrently.

3) warning may be triggered when percpu_ref_kill() is run on one DEAD
percpu-refcount, or when percpu_ref_resurrect() is run on one live
percpu-refcount. We can avoid the warning with test_and_{clear|test}_bit
exactly by running the actual quiesce/unquiesce action only once.


Thanks,
Ming

