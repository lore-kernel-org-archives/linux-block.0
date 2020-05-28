Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EC4C433DF
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 05:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C0AA21475
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 05:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLBH3UJU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbgE1FTw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 01:19:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25253 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725308AbgE1FTw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 01:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590643190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P3Y/gDbakCJK9wXnR6lxW0ZGicPSiuYSicce1VScLbk=;
        b=VLBH3UJU7OwCDfTvbNE2BwR1rkQqd5MPrJGjY8SPhorpcHlqH5xgJKmHvkG1iHH+6eZcVG
        acvWZ59QJNVQ2suxiAiKBBewphkucF+HSTjEMHTf4Me8ROzt5QLPfA3CtoFiNTPVMilU9W
        BftomcaCPvzMf4UYqJRtGb8PyCQwQ3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-P3sOQXgBMZWUT-of1TbBtA-1; Thu, 28 May 2020 01:19:46 -0400
X-MC-Unique: P3sOQXgBMZWUT-of1TbBtA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4854C80B700;
        Thu, 28 May 2020 05:19:45 +0000 (UTC)
Received: from T590 (ovpn-12-189.pek2.redhat.com [10.72.12.189])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A88145C1B0;
        Thu, 28 May 2020 05:19:37 +0000 (UTC)
Date:   Thu, 28 May 2020 13:19:32 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] blk-mq: drain I/O when all CPUs in a hctx are offline
Message-ID: <20200528051932.GA1008129@T590>
References: <20200527180644.514302-1-hch@lst.de>
 <20200527180644.514302-9-hch@lst.de>
 <7acc7ab5-02f9-e6ee-e95f-175bc0df9cbc@acm.org>
 <20200528014601.GC933147@T590>
 <1ec7922c-f2b0-08ec-5849-f4eb7f71e9e7@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ec7922c-f2b0-08ec-5849-f4eb7f71e9e7@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 27, 2020 at 08:33:48PM -0700, Bart Van Assche wrote:
> On 2020-05-27 18:46, Ming Lei wrote:
> > On Wed, May 27, 2020 at 04:09:19PM -0700, Bart Van Assche wrote:
> >> On 2020-05-27 11:06, Christoph Hellwig wrote:
> >>> --- a/block/blk-mq-tag.c
> >>> +++ b/block/blk-mq-tag.c
> >>> @@ -180,6 +180,14 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
> >>>  	sbitmap_finish_wait(bt, ws, &wait);
> >>>  
> >>>  found_tag:
> >>> +	/*
> >>> +	 * Give up this allocation if the hctx is inactive.  The caller will
> >>> +	 * retry on an active hctx.
> >>> +	 */
> >>> +	if (unlikely(test_bit(BLK_MQ_S_INACTIVE, &data->hctx->state))) {
> >>> +		blk_mq_put_tag(tags, data->ctx, tag + tag_offset);
> >>> +		return -1;
> >>> +	}
> >>>  	return tag + tag_offset;
> >>>  }
> >>
> >> The code that has been added in blk_mq_hctx_notify_offline() will only
> >> work correctly if blk_mq_get_tag() tests BLK_MQ_S_INACTIVE after the
> >> store instructions involved in the tag allocation happened. Does this
> >> mean that a memory barrier should be added in the above function before
> >> the test_bit() call?
> > 
> > Please see comment in blk_mq_hctx_notify_offline():
> > 
> > +       /*
> > +        * Prevent new request from being allocated on the current hctx.
> > +        *
> > +        * The smp_mb__after_atomic() Pairs with the implied barrier in
> > +        * test_and_set_bit_lock in sbitmap_get().  Ensures the inactive flag is
> > +        * seen once we return from the tag allocator.
> > +        */
> > +       set_bit(BLK_MQ_S_INACTIVE, &hctx->state);
> 
> From Documentation/atomic_bitops.txt: "Except for a successful
> test_and_set_bit_lock() which has ACQUIRE semantics and
> clear_bit_unlock() which has RELEASE semantics."

test_bit(BLK_MQ_S_INACTIVE, &data->hctx->state) is called exactly after
one tag is allocated, that means test_and_set_bit_lock is successful before
the test_bit(). The ACQUIRE semantics guarantees that test_bit(BLK_MQ_S_INACTIVE)
is always done after successful test_and_set_bit_lock(), so tag bit is
always set before testing BLK_MQ_S_INACTIVE.
 
See Documentation/memory-barriers.txt:
 (5) ACQUIRE operations.

     This acts as a one-way permeable barrier.  It guarantees that all memory
     operations after the ACQUIRE operation will appear to happen after the
     ACQUIRE operation with respect to the other components of the system.
     ACQUIRE operations include LOCK operations and both smp_load_acquire()
     and smp_cond_load_acquire() operations.

> 
> My understanding is that operations that have acquire semantics pair
> with operations that have release semantics. I haven't been able to find
> any documentation that shows that smp_mb__after_atomic() has release
> semantics. So I looked up its definition. This is what I found:
> 
> $ git grep -nH 'define __smp_mb__after_atomic'
> arch/ia64/include/asm/barrier.h:49:#define __smp_mb__after_atomic()
> barrier()
> arch/mips/include/asm/barrier.h:133:#define __smp_mb__after_atomic()
> smp_llsc_mb()
> arch/s390/include/asm/barrier.h:50:#define __smp_mb__after_atomic()
> barrier()
> arch/sparc/include/asm/barrier_64.h:57:#define __smp_mb__after_atomic()
> barrier()
> arch/x86/include/asm/barrier.h:83:#define __smp_mb__after_atomic()	do {
> } while (0)
> arch/xtensa/include/asm/barrier.h:20:#define __smp_mb__after_atomic()	
> barrier()
> include/asm-generic/barrier.h:116:#define __smp_mb__after_atomic()
> __smp_mb()
> 
> My interpretation of the above is that not all smp_mb__after_atomic()
> implementations have release semantics. Do you agree with this conclusion?

I understand smp_mb__after_atomic() orders set_bit(BLK_MQ_S_INACTIVE)
and reading the tag bit which is done in blk_mq_all_tag_iter().

So the two pair of OPs are ordered:

1) if one request(tag bit) is allocated before setting BLK_MQ_S_INACTIVE,
the tag bit will be observed in blk_mq_all_tag_iter() from blk_mq_hctx_has_requests(),
so the request will be drained.

OR

2) if one request(tag bit) is allocated after setting BLK_MQ_S_INACTIVE,
the request(tag bit) will be released and retried on another CPU
finally, see __blk_mq_alloc_request().

Cc Paul and linux-kernel list.


Thanks,
Ming

