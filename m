Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED24C433DF
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 03:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60DFC2078C
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 03:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfHgC2P3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgE2Dxg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 23:53:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53529 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbgE2Dxf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 23:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590724413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tLVztUdG71N2GEyZAgALhdDmfmTPgewakQAC+BFs32s=;
        b=EfHgC2P3XFMlW1FKelPdMwqnWyU3xstrRJ2ibe9xD18dkMJjET04UDNg5Ju1GMsXQNBeoZ
        rsvcZzEGpjtNQkRP0fSw5MiToLSKYhsSQW4MEwpxd5v/Pt/uLcO74s3VwnoAMSX7FPcGK/
        tGEgQrNK5QMI8tNtQM3wxh2RqX8AjIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-6sBSXuhCMjGg9s7jYzPvVg-1; Thu, 28 May 2020 23:53:30 -0400
X-MC-Unique: 6sBSXuhCMjGg9s7jYzPvVg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B6EC18A0760;
        Fri, 29 May 2020 03:53:28 +0000 (UTC)
Received: from T590 (ovpn-12-157.pek2.redhat.com [10.72.12.157])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 08B0560C81;
        Fri, 29 May 2020 03:53:19 +0000 (UTC)
Date:   Fri, 29 May 2020 11:53:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] blk-mq: drain I/O when all CPUs in a hctx are offline
Message-ID: <20200529035315.GD1075489@T590>
References: <20200527180644.514302-1-hch@lst.de>
 <20200527180644.514302-9-hch@lst.de>
 <7acc7ab5-02f9-e6ee-e95f-175bc0df9cbc@acm.org>
 <20200528014601.GC933147@T590>
 <1ec7922c-f2b0-08ec-5849-f4eb7f71e9e7@acm.org>
 <20200528051932.GA1008129@T590>
 <4fb6f0cf-a356-833e-25ab-47f9131c729b@acm.org>
 <20200528172121.GN2869@paulmck-ThinkPad-P72>
 <20200529015304.GC1075489@T590>
 <20200529030728.GW2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529030728.GW2869@paulmck-ThinkPad-P72>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Paul,

On Thu, May 28, 2020 at 08:07:28PM -0700, Paul E. McKenney wrote:
> On Fri, May 29, 2020 at 09:53:04AM +0800, Ming Lei wrote:
> > Hi Paul,
> > 
> > Thanks for your response!
> > 
> > On Thu, May 28, 2020 at 10:21:21AM -0700, Paul E. McKenney wrote:
> > > On Thu, May 28, 2020 at 06:37:47AM -0700, Bart Van Assche wrote:
> > > > On 2020-05-27 22:19, Ming Lei wrote:
> > > > > On Wed, May 27, 2020 at 08:33:48PM -0700, Bart Van Assche wrote:
> > > > >> My understanding is that operations that have acquire semantics pair
> > > > >> with operations that have release semantics. I haven't been able to find
> > > > >> any documentation that shows that smp_mb__after_atomic() has release
> > > > >> semantics. So I looked up its definition. This is what I found:
> > > > >>
> > > > >> $ git grep -nH 'define __smp_mb__after_atomic'
> > > > >> arch/ia64/include/asm/barrier.h:49:#define __smp_mb__after_atomic()
> > > > >> barrier()
> > > > >> arch/mips/include/asm/barrier.h:133:#define __smp_mb__after_atomic()
> > > > >> smp_llsc_mb()
> > > > >> arch/s390/include/asm/barrier.h:50:#define __smp_mb__after_atomic()
> > > > >> barrier()
> > > > >> arch/sparc/include/asm/barrier_64.h:57:#define __smp_mb__after_atomic()
> > > > >> barrier()
> > > > >> arch/x86/include/asm/barrier.h:83:#define __smp_mb__after_atomic()	do {
> > > > >> } while (0)
> > > > >> arch/xtensa/include/asm/barrier.h:20:#define __smp_mb__after_atomic()	
> > > > >> barrier()
> > > > >> include/asm-generic/barrier.h:116:#define __smp_mb__after_atomic()
> > > > >> __smp_mb()
> > > > >>
> > > > >> My interpretation of the above is that not all smp_mb__after_atomic()
> > > > >> implementations have release semantics. Do you agree with this conclusion?
> > > > > 
> > > > > I understand smp_mb__after_atomic() orders set_bit(BLK_MQ_S_INACTIVE)
> > > > > and reading the tag bit which is done in blk_mq_all_tag_iter().
> > > > > 
> > > > > So the two pair of OPs are ordered:
> > > > > 
> > > > > 1) if one request(tag bit) is allocated before setting BLK_MQ_S_INACTIVE,
> > > > > the tag bit will be observed in blk_mq_all_tag_iter() from blk_mq_hctx_has_requests(),
> > > > > so the request will be drained.
> > > > > 
> > > > > OR
> > > > > 
> > > > > 2) if one request(tag bit) is allocated after setting BLK_MQ_S_INACTIVE,
> > > > > the request(tag bit) will be released and retried on another CPU
> > > > > finally, see __blk_mq_alloc_request().
> > > > > 
> > > > > Cc Paul and linux-kernel list.
> > > > 
> > > > I do not agree with the above conclusion. My understanding of
> > > > acquire/release labels is that if the following holds:
> > > > (1) A store operation that stores the value V into memory location M has
> > > > a release label.
> > > > (2) A load operation that reads memory location M has an acquire label.
> > > > (3) The load operation (2) retrieves the value V that was stored by (1).
> > > > 
> > > > that the following ordering property holds: all load and store
> > > > instructions that happened before the store instruction (1) in program
> > > > order are guaranteed to happen before the load and store instructions
> > > > that follow (2) in program order.
> > > > 
> > > > In the ARM manual these semantics have been described as follows: "A
> > > > Store-Release instruction is multicopy atomic when observed with a
> > > > Load-Acquire instruction".
> > > > 
> > > > In this case the load-acquire operation is the
> > > > "test_and_set_bit_lock(nr, word)" statement from the sbitmap code. That
> > > > code is executed indirectly by blk_mq_get_tag(). Since there is no
> > > > matching store-release instruction in __blk_mq_alloc_request() for
> > > > 'word', ordering of the &data->hctx->state and 'tag' memory locations is
> > > > not guaranteed by the acquire property of the "test_and_set_bit_lock(nr,
> > > > word)" statement from the sbitmap code.
> > > 
> > > I feel like I just parachuted into the middle of the conversation,
> > > so let me start by giving a (silly) example illustrating the limits of
> > > smp_mb__{before,after}_atomic() that might be tangling things up.
> > > 
> > > But please please please avoid doing this in real code unless you have
> > > an extremely good reason included in a comment.
> > > 
> > > void t1(void)
> > > {
> > > 	WRITE_ONCE(a, 1);
> > > 	smp_mb__before_atomic();
> > > 	WRITE_ONCE(b, 1);  // Just Say No to code here!!!
> > > 	atomic_inc(&c);
> > > 	WRITE_ONCE(d, 1);  // Just Say No to code here!!!
> > > 	smp_mb__after_atomic();
> > > 	WRITE_ONCE(e, 1);
> > > }
> > > 
> > > void t2(void)
> > > {
> > > 	r1 = READ_ONCE(e);
> > > 	smp_mb();
> > > 	r2 = READ_ONCE(d);
> > > 	smp_mb();
> > > 	r3 = READ_ONCE(c);
> > > 	smp_mb();
> > > 	r4 = READ_ONCE(b);
> > > 	smp_mb();
> > > 	r5 = READ_ONCE(a);
> > > }
> > > 
> > > Each platform must provide strong ordering for either atomic_inc()
> > > on the one hand (as ia64 does) or for smp_mb__{before,after}_atomic()
> > > on the other (as powerpc does).  Note that both ia64 and powerpc are
> > > weakly ordered.
> > > 
> > > So ia64 could see (r1 == 1 && r2 == 0) on the one hand as well as (r4 ==
> > > 1 && r5 == 0).  So clearly smp_mb_{before,after}_atomic() need not have
> > > any ordering properties whatsoever.
> > > 
> > > Similarly, powerpc could see (r3 == 1 && r4 == 0) on the one hand as well
> > > as (r2 == 1 && r3 == 0) on the other.  Or even both at the same time.
> > > So clearly atomic_inc() need not have any ordering properties whatsoever.
> > > 
> > > But the combination of smp_mb__before_atomic() and the later atomic_inc()
> > > does provide full ordering, so that no architecture can see (r3 == 1 &&
> > > r5 == 0), and either of r1 or r2 can be substituted for r3.
> > > 
> > > Similarly, atomic_inc() and the late4r smp_mb__after_atomic() also
> > > provide full ordering, so that no architecture can see (r1 == 1 && r3 ==
> > > 0), and either r4 or r5 can be substituted for r3.
> > > 
> > > 
> > > So a call to set_bit() followed by a call to smp_mb__after_atomic() will
> > > provide a full memory barrier (implying release semantics) for any write
> > > access after the smp_mb__after_atomic() with respect to the set_bit() or
> > > any access preceding it.  But the set_bit() by itself won't have release
> > > semantics, nor will the smp_mb__after_atomic(), only their combination
> > > further combined with some write following the smp_mb__after_atomic().
> > > 
> > > More generally, there will be the equivalent of smp_mb() somewhere between
> > > the set_bit() and every access following the smp_mb__after_atomic().
> > > 
> > > Does that help, or am I missing the point?
> > 
> > Yeah, it does help.
> > 
> > BTW, can we replace the smp_mb__after_atomic() with smp_mb() for
> > ordering set_bit() and the memory OP following the smp_mb()?
> 
> Placing an smp_mb() between set_bit() and a later access will indeed
> order set_bit() with that later access.
> 
> That said, I don't know this code well enough to say whether or not
> that ordering is sufficient.

Another pair is in blk_mq_get_tag(), and we expect the following two
memory OPs are ordered:

1) set bit in successful test_and_set_bit_lock(), which is called
from sbitmap_get()

2) test_bit(BLK_MQ_S_INACTIVE, &data->hctx->state)

Do you think that the above two OPs are ordered?

Thanks,
Ming

