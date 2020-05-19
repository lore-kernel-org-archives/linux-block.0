Return-Path: <SRS0=keWk=7B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF39C433E0
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 01:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 665E9206D4
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 01:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALsyPQAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgESByk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 May 2020 21:54:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20529 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726285AbgESByk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 May 2020 21:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589853279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4yys6bX/FatFVJntJ9h7HAJj5KjOatxO42EYgJrA/Vo=;
        b=ALsyPQAew9SV2rUqXMI/C5JR3vWwMMXuhi4LFwC0uZpquLcZZ64Ad02MyvjN+xJUwQHrtG
        Jxxq+f+KKugk9F6KjJvgM5trfhGlgABi3HMNwxiMmINp4gLB1aKH7I26UziYX+rfnuaoDp
        Z/Sz2e1/E+FHMPxj6k0C4UATmPM35fI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-eIqTsDWvPM2boNH6umar8A-1; Mon, 18 May 2020 21:54:32 -0400
X-MC-Unique: eIqTsDWvPM2boNH6umar8A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04DC08015CE;
        Tue, 19 May 2020 01:54:31 +0000 (UTC)
Received: from T590 (ovpn-13-68.pek2.redhat.com [10.72.13.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8110A10013D9;
        Tue, 19 May 2020 01:54:24 +0000 (UTC)
Date:   Tue, 19 May 2020 09:54:20 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 5/9] blk-mq: don't set data->ctx and data->hctx in
 blk_mq_alloc_request_hctx
Message-ID: <20200519015420.GA70957@T590>
References: <20200518093155.GB35380@T590>
 <87imgty15d.fsf@nanos.tec.linutronix.de>
 <20200518115454.GA46364@T590>
 <20200518131634.GA645@lst.de>
 <20200518141107.GA50374@T590>
 <20200518165619.GA17465@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518165619.GA17465@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 18, 2020 at 06:56:19PM +0200, Christoph Hellwig wrote:
> On Mon, May 18, 2020 at 10:11:07PM +0800, Ming Lei wrote:
> > On Mon, May 18, 2020 at 03:16:34PM +0200, Christoph Hellwig wrote:
> > > On Mon, May 18, 2020 at 07:54:54PM +0800, Ming Lei wrote:
> > > > 
> > > > I guess I misunderstood your point, sorry for that.
> > > > 
> > > > The requirement is just that the request needs to be allocated on one online
> > > > CPU after INACTIVE is set, and we can use a workqueue to do that.
> > > 
> > > I've looked over the code again, and I'm really not sure why we need that.
> > > Presumable the CPU hotplug code ensures tasks don't get schedule on the
> > > CPU running the shutdown state machine, so if we just do a retry of the
> > 
> > percpu kthread still can be scheduled on the cpu to be online, see
> > is_cpu_allowed(). And bound wq has been used widely in fs code.
> 
> s/to be online/to be offlined/ I guess.
> 
> Shouldn't all the per-cpu kthreads also stop as part of the offlining?
> If they don't quiesce before the new blk-mq stop state I think we need
> to make sure they do.  It is rather pointless to quiesce the requests
> if a thread that can submit I/O is still live.

As Thomas clarified, workqueue hasn't such issue any more, and only other
per CPU kthreads can run until the CPU clears the online bit.

So the question is if IO can be submitted from such kernel context?

> 
> > > 
> > >     http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-mq-hotplug.2
> > > 
> > 
> > After preempt_disable() is removed, the INACTIVE bit is set in the CPU
> > to be offline, and the bit can be read on all other CPUs, so other CPUs
> > may not get synced with the INACTIVE bit.
> 
> INACTIVE is set to the hctx, and it is set by the last CPU to be
> offlined that is mapped to the hctx.  once the bit is set the barrier
> ensured it is seen everywhere before we start waiting for the requests
> to finish.  What is missing?:

memory barrier should always be used as pair, and you should have mentioned
that the implied barrier in test_and_set_bit_lock pair from sbitmap_get()
is pair of smp_mb__after_atomic() in blk_mq_hctx_notify_offline().

Then setting tag bit and checking INACTIVE in blk_mq_get_tag() can be ordered,
same with setting INACTIVE and checking tag bit in blk_mq_hctx_notify_offline().

Then such usage is basically same with previous use of smp_mb() in blk_mq_get_driver_tag()
in earlier version.

BTW, smp_mb__before_atomic() in blk_mq_hctx_notify_offline() isn't needed.

Thanks,
Ming

