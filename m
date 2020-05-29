Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12DDC433E0
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 01:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC34620829
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 01:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8DVb5Fj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438311AbgE2BNn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 21:13:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59815 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438235AbgE2BNm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 21:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590714819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dn+2f2IgafZyi4AA23TOauEQLxRsqGyFtRoJ5BVY2dM=;
        b=Z8DVb5Fjye1haI88VKpkjmpz1sXbf08u29J2SCZ3yI5p9ViGnTkNGkOfdDjfwKALd8Q6RJ
        VxOD6o/psY80Yw88KrVynV13P6YMizTva/p44NAcVUFIBfG9xFY9dvyoEgvi6MQReG66Ny
        OHExMalz3pifwo2dTjuK2PEaDBsqFiw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-k_QOnMtCPJWWtMBIdjcohQ-1; Thu, 28 May 2020 21:13:35 -0400
X-MC-Unique: k_QOnMtCPJWWtMBIdjcohQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F3DE18A8220;
        Fri, 29 May 2020 01:13:34 +0000 (UTC)
Received: from T590 (ovpn-12-157.pek2.redhat.com [10.72.12.157])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BDD695F7EA;
        Fri, 29 May 2020 01:13:25 +0000 (UTC)
Date:   Fri, 29 May 2020 09:13:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] blk-mq: drain I/O when all CPUs in a hctx are offline
Message-ID: <20200529011321.GA1075489@T590>
References: <20200527180644.514302-1-hch@lst.de>
 <20200527180644.514302-9-hch@lst.de>
 <7acc7ab5-02f9-e6ee-e95f-175bc0df9cbc@acm.org>
 <20200528014601.GC933147@T590>
 <1ec7922c-f2b0-08ec-5849-f4eb7f71e9e7@acm.org>
 <20200528051932.GA1008129@T590>
 <4fb6f0cf-a356-833e-25ab-47f9131c729b@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fb6f0cf-a356-833e-25ab-47f9131c729b@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 28, 2020 at 06:37:47AM -0700, Bart Van Assche wrote:
> On 2020-05-27 22:19, Ming Lei wrote:
> > On Wed, May 27, 2020 at 08:33:48PM -0700, Bart Van Assche wrote:
> >> My understanding is that operations that have acquire semantics pair
> >> with operations that have release semantics. I haven't been able to find
> >> any documentation that shows that smp_mb__after_atomic() has release
> >> semantics. So I looked up its definition. This is what I found:
> >>
> >> $ git grep -nH 'define __smp_mb__after_atomic'
> >> arch/ia64/include/asm/barrier.h:49:#define __smp_mb__after_atomic()
> >> barrier()
> >> arch/mips/include/asm/barrier.h:133:#define __smp_mb__after_atomic()
> >> smp_llsc_mb()
> >> arch/s390/include/asm/barrier.h:50:#define __smp_mb__after_atomic()
> >> barrier()
> >> arch/sparc/include/asm/barrier_64.h:57:#define __smp_mb__after_atomic()
> >> barrier()
> >> arch/x86/include/asm/barrier.h:83:#define __smp_mb__after_atomic()	do {
> >> } while (0)
> >> arch/xtensa/include/asm/barrier.h:20:#define __smp_mb__after_atomic()	
> >> barrier()
> >> include/asm-generic/barrier.h:116:#define __smp_mb__after_atomic()
> >> __smp_mb()
> >>
> >> My interpretation of the above is that not all smp_mb__after_atomic()
> >> implementations have release semantics. Do you agree with this conclusion?
> > 
> > I understand smp_mb__after_atomic() orders set_bit(BLK_MQ_S_INACTIVE)
> > and reading the tag bit which is done in blk_mq_all_tag_iter().
> > 
> > So the two pair of OPs are ordered:
> > 
> > 1) if one request(tag bit) is allocated before setting BLK_MQ_S_INACTIVE,
> > the tag bit will be observed in blk_mq_all_tag_iter() from blk_mq_hctx_has_requests(),
> > so the request will be drained.
> > 
> > OR
> > 
> > 2) if one request(tag bit) is allocated after setting BLK_MQ_S_INACTIVE,
> > the request(tag bit) will be released and retried on another CPU
> > finally, see __blk_mq_alloc_request().
> > 
> > Cc Paul and linux-kernel list.
> 
> I do not agree with the above conclusion. My understanding of
> acquire/release labels is that if the following holds:
> (1) A store operation that stores the value V into memory location M has
> a release label.
> (2) A load operation that reads memory location M has an acquire label.
> (3) The load operation (2) retrieves the value V that was stored by (1).
> 
> that the following ordering property holds: all load and store
> instructions that happened before the store instruction (1) in program
> order are guaranteed to happen before the load and store instructions
> that follow (2) in program order.
> 
> In the ARM manual these semantics have been described as follows: "A
> Store-Release instruction is multicopy atomic when observed with a
> Load-Acquire instruction".
> 
> In this case the load-acquire operation is the
> "test_and_set_bit_lock(nr, word)" statement from the sbitmap code. That
> code is executed indirectly by blk_mq_get_tag(). Since there is no
> matching store-release instruction in __blk_mq_alloc_request() for
> 'word', ordering of the &data->hctx->state and 'tag' memory locations is
> not guaranteed by the acquire property of the "test_and_set_bit_lock(nr,
> word)" statement from the sbitmap code.

If the order isn't guaranteed, either of the following two documents has to be wrong:

Documentation/memory-barriers.txt:
	...
	In all cases there are variants on "ACQUIRE" operations and "RELEASE" operations
	for each construct.  These operations all imply certain barriers:
	
	 (1) ACQUIRE operation implication:
	
	     Memory operations issued after the ACQUIRE will be completed after the
	     ACQUIRE operation has completed.

Documentation/atomic_bitops.txt:
	...
	Except for a successful test_and_set_bit_lock() which has ACQUIRE semantics and
	clear_bit_unlock() which has RELEASE semantics.

Setting the tag bit is part of successful test_and_set_bit_lock(), which has ACQUIRE
semantics, and any Memory operations(test_bit(INACTIVE)) after the ACQUIRE will be
completed after the ACQUIRE has completed according to the above two documents.

Thanks,
Ming

