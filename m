Return-Path: <SRS0=ToMJ=6U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EF7C28CBC
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 10:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DDFA206DB
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 10:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4QxTMHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbgEFKXD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 May 2020 06:23:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41116 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726354AbgEFKXD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 May 2020 06:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588760581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PukpeG11fFqw2Ff8k8hHO+GA+Yuk3HGPWuxHvN5GeFc=;
        b=C4QxTMHGPc6Qd5VSaAfKTjnLnNXbqmAXyUXdEc2RULkBlGa9H1a98/Z5LXAW3P07yX8XnK
        sS0Za9tFcLqgWLt/JjbOVWhxvI7ZFOM1S0X7JjFV3j/LH7CqOZrAysh/OyN3iOJQZp71OU
        bFYoKPH4AHKug7G5M/knoiv99MH/EFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-CBBG-4rpOS-k2aKRjcNyLA-1; Wed, 06 May 2020 06:22:57 -0400
X-MC-Unique: CBBG-4rpOS-k2aKRjcNyLA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29E3B461;
        Wed,  6 May 2020 10:22:55 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 61EF91C950;
        Wed,  6 May 2020 10:22:45 +0000 (UTC)
Date:   Wed, 6 May 2020 18:22:40 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Will Deacon <will@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org
Subject: Re: [PATCH V8 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200506102240.GA1261234@T590>
References: <20200429134327.GC700644@T590>
 <20200429173400.GC30247@willie-the-truck>
 <20200430003945.GA719313@T590>
 <20200430110429.GI19932@willie-the-truck>
 <20200430140254.GA996887@T590>
 <20200505154618.GA3644@lst.de>
 <20200506012425.GA1177270@T590>
 <20200506072802.GC7021@willie-the-truck>
 <20200506080727.GB1177270@T590>
 <20200506095610.GA8043@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506095610.GA8043@willie-the-truck>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 06, 2020 at 10:56:10AM +0100, Will Deacon wrote:
> On Wed, May 06, 2020 at 04:07:27PM +0800, Ming Lei wrote:
> > On Wed, May 06, 2020 at 08:28:03AM +0100, Will Deacon wrote:
> > > On Wed, May 06, 2020 at 09:24:25AM +0800, Ming Lei wrote:
> > > > On Tue, May 05, 2020 at 05:46:18PM +0200, Christoph Hellwig wrote:
> > > > > On Thu, Apr 30, 2020 at 10:02:54PM +0800, Ming Lei wrote:
> > > > > > BLK_MQ_S_INACTIVE is only set when the last cpu of this hctx is becoming
> > > > > > offline, and blk_mq_hctx_notify_offline() is called from cpu hotplug
> > > > > > handler. So if there is any request of this hctx submitted from somewhere,
> > > > > > it has to this last cpu. That is done by blk-mq's queue mapping.
> > > > > > 
> > > > > > In case of direct issue, basically blk_mq_get_driver_tag() is run after
> > > > > > the request is allocated, that is why I mentioned the chance of
> > > > > > migration is very small.
> > > > > 
> > > > > "very small" does not cut it, it has to be zero.  And it seems the
> > > > > new version still has this hack.
> > > > 
> > > > But smp_mb() is used for ordering the WRITE and READ, so it is correct.
> > > > 
> > > > barrier() is enough when process migration doesn't happen.
> > > 
> > > Without numbers I would just make the smp_mb() unconditional. Your
> > > questionable optimisation trades that for a load of the CPU ID and a
> > > conditional branch, which isn't obviously faster to me. It's also very
> > 
> > The CPU ID is just percpu READ, and unlikely() has been used for
> > optimizing the conditional branch. And smp_mb() could cause CPU stall, I
> > guess, so it should be much slower than reading CPU ID.
> 
> Percpu accesses aren't uniformly cheap across architectures.

I believe percpu access is cheap enough than smp_mb() in almost
every SMP ARCH, otherwise no one would use percpu variable on that
ARCH.

> 
> > Let's see the attached microbench[1], the result shows that smp_mb() is
> > 10+ times slower than smp_processor_id() with one conditional branch.
> 
> Nobody said anything about smp_mb() in a tight loop, so this is hardly
> surprising. Throughput of barrier instructions will hit a ceiling fairly
> quickly, but they don't have to cause stalls in general use. I would expect
> the numbers to converge if you added some back-off to the loops (e.g.
> ndelay() or something). But I was really hoping for some numbers from the
> block layer itself, since that's what we actually care about.

I believe that the microbench is enough to show smp_mb() is much heavier
and slower than smp_processor_id() with conditional branch.

Cause some aio or io uring workload just takes CPU to submit IO without
any delay, and we don't want to take extra CPU unnecessarily in IO
submission side. And IOPS may reach millions or dozens of millions
level. Storage guys have been working very hard to optimize the whole
IO path.

> 
> > [    1.239951] test_foo: smp_mb 738701907 smp_id 62904315 result 0 overflow 5120
> > 
> > The micronbench is run on simple 8cores KVM guest, and cpu is
> > 'Model name:          Intel(R) Core(TM) i7-8665U CPU @ 1.90GHz'.
> > 
> > Result is pretty stable in my 5 runs of VM boot.
> 
> Honestly, I get the impression that you're not particularly happy with me
> putting in the effort to review your patches, so I'll leave it up to
> Christoph as to whether he wants to predicate the concurrency design on
> a hokey microbenchmark.
> 
> FWIW: I agree that the code should work as you have it in v10, I just think
> it's unnecessarily complicated and fragile.

Yeah, it works and it is correct, and we can document the usage, another point
is that CPU hotplug doesn't happen frequently, so we shouldn't introduce extra
cost for handling cpu hotplug in fast IO path, meantime smp_mb() won't
be something which can be ignored, especially in some big machine with
lots of CPU cores.

Thanks,
Ming

