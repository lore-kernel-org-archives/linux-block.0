Return-Path: <SRS0=ToMJ=6U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F9CC28CBC
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 09:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85E1C2082E
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 09:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588758977;
	bh=EB4eSq5Opzx1YZKxeyObDp5eLGs+r4ly82NKQNUBwfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MrvarCIaiQe287AtPdXNSUgHHMENn/3g+E/zgh+nauHb3vwd+Rm5Rhx7kUOvmA0o7
	 0TEMmraS7tjoljdsrCR1oBzjnNRuyunXj6rU3VLnuNYXVyi+cwHbuJWTM7KtQoqtRB
	 bTpEeKqAlCq0GppmPGF2meDq6TDkMVNywoIpTXgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgEFJ4R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 May 2020 05:56:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728640AbgEFJ4Q (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 May 2020 05:56:16 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CEEB2075A;
        Wed,  6 May 2020 09:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588758976;
        bh=EB4eSq5Opzx1YZKxeyObDp5eLGs+r4ly82NKQNUBwfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LuNCWfE+eLjUdPeyZTkZijSNH26KcrrzjQWrzHdNkUvOGPU5Vo6aqxIGuUW9GucLv
         +2dhkt0XVlDjfAIS7J8qWWUlwa1QdW99OObn3ZKCntts9HuWKAfmkjxpAg36Q4QHAj
         HOIqDPto5m0BXHWKtoUn0bveS0vey6mLBAwmK9yU=
Date:   Wed, 6 May 2020 10:56:10 +0100
From:   Will Deacon <will@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org
Subject: Re: [PATCH V8 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200506095610.GA8043@willie-the-truck>
References: <20200429122757.GA30247@willie-the-truck>
 <20200429134327.GC700644@T590>
 <20200429173400.GC30247@willie-the-truck>
 <20200430003945.GA719313@T590>
 <20200430110429.GI19932@willie-the-truck>
 <20200430140254.GA996887@T590>
 <20200505154618.GA3644@lst.de>
 <20200506012425.GA1177270@T590>
 <20200506072802.GC7021@willie-the-truck>
 <20200506080727.GB1177270@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506080727.GB1177270@T590>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 06, 2020 at 04:07:27PM +0800, Ming Lei wrote:
> On Wed, May 06, 2020 at 08:28:03AM +0100, Will Deacon wrote:
> > On Wed, May 06, 2020 at 09:24:25AM +0800, Ming Lei wrote:
> > > On Tue, May 05, 2020 at 05:46:18PM +0200, Christoph Hellwig wrote:
> > > > On Thu, Apr 30, 2020 at 10:02:54PM +0800, Ming Lei wrote:
> > > > > BLK_MQ_S_INACTIVE is only set when the last cpu of this hctx is becoming
> > > > > offline, and blk_mq_hctx_notify_offline() is called from cpu hotplug
> > > > > handler. So if there is any request of this hctx submitted from somewhere,
> > > > > it has to this last cpu. That is done by blk-mq's queue mapping.
> > > > > 
> > > > > In case of direct issue, basically blk_mq_get_driver_tag() is run after
> > > > > the request is allocated, that is why I mentioned the chance of
> > > > > migration is very small.
> > > > 
> > > > "very small" does not cut it, it has to be zero.  And it seems the
> > > > new version still has this hack.
> > > 
> > > But smp_mb() is used for ordering the WRITE and READ, so it is correct.
> > > 
> > > barrier() is enough when process migration doesn't happen.
> > 
> > Without numbers I would just make the smp_mb() unconditional. Your
> > questionable optimisation trades that for a load of the CPU ID and a
> > conditional branch, which isn't obviously faster to me. It's also very
> 
> The CPU ID is just percpu READ, and unlikely() has been used for
> optimizing the conditional branch. And smp_mb() could cause CPU stall, I
> guess, so it should be much slower than reading CPU ID.

Percpu accesses aren't uniformly cheap across architectures.

> Let's see the attached microbench[1], the result shows that smp_mb() is
> 10+ times slower than smp_processor_id() with one conditional branch.

Nobody said anything about smp_mb() in a tight loop, so this is hardly
surprising. Throughput of barrier instructions will hit a ceiling fairly
quickly, but they don't have to cause stalls in general use. I would expect
the numbers to converge if you added some back-off to the loops (e.g.
ndelay() or something). But I was really hoping for some numbers from the
block layer itself, since that's what we actually care about.

> [    1.239951] test_foo: smp_mb 738701907 smp_id 62904315 result 0 overflow 5120
> 
> The micronbench is run on simple 8cores KVM guest, and cpu is
> 'Model name:          Intel(R) Core(TM) i7-8665U CPU @ 1.90GHz'.
> 
> Result is pretty stable in my 5 runs of VM boot.

Honestly, I get the impression that you're not particularly happy with me
putting in the effort to review your patches, so I'll leave it up to
Christoph as to whether he wants to predicate the concurrency design on
a hokey microbenchmark.

FWIW: I agree that the code should work as you have it in v10, I just think
it's unnecessarily complicated and fragile.

/me goes to review other things

Will
