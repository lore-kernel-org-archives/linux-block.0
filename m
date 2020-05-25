Return-Path: <SRS0=kLuB=7H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C3EC433E0
	for <linux-block@archiver.kernel.org>; Mon, 25 May 2020 16:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF20F2078B
	for <linux-block@archiver.kernel.org>; Mon, 25 May 2020 16:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590424723;
	bh=T0dctEwXfd9ToVKEHjdJDHuQN2IwRj0pRSV2x6Ky+wM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QcF6P0NzLL15bHFlTHdX046w9tH+rxWP8u4k1xy1b321ueEflCClYQheFfk8+UKQB
	 b3hSWsspvSuothpDQsbZJ1YIn+NKFmmcOtYE55PhgAn09shntWfw1i+MesnOS2hm+J
	 SMwD1T741MqU/r+qSsOAuB1AWyv03BGDQSj+usHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbgEYQin (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 May 2020 12:38:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgEYQin (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 May 2020 12:38:43 -0400
Received: from C02WT3WMHTD6 (unknown [199.255.45.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFD4A2070A;
        Mon, 25 May 2020 16:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590424722;
        bh=T0dctEwXfd9ToVKEHjdJDHuQN2IwRj0pRSV2x6Ky+wM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yQEyYiDYsacz5mKrRIXymZ915zqdz2JT8FFJRIwnQb4AFySm4cPlPLyAwvYQCGSwn
         cc4FL79X/akVrrT325WdkSn0Vtgc9IdHP6AjQWOMb1FeytocxnYTnoSEbUGbuvSR/R
         5kvV8AYhaV2xXWr5uCTBQFWuPTjhv2K1doLcv1eM=
Date:   Mon, 25 May 2020 10:38:39 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: blk-mq: improvement CPU hotplug (simplified version) v3
Message-ID: <20200525163839.GB73686@C02WT3WMHTD6>
References: <20200520170635.2094101-1-hch@lst.de>
 <0cbc37cf-5439-c68c-3581-b3c436932388@acm.org>
 <20200521025744.GC735749@T590>
 <9249e1cc-b6f2-010e-78d2-ead5a1b93464@acm.org>
 <20200521043305.GA741019@T590>
 <7accb5b2-6c7d-0e0d-56df-d06e8d9ac5af@acm.org>
 <20200522023923.GC755458@T590>
 <26169cd9-49b8-b949-aaa3-9745e821c86c@acm.org>
 <20200525040952.GB791214@T590>
 <a89e6b92-8b43-ec1c-8e6b-7b842608ce5d@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a89e6b92-8b43-ec1c-8e6b-7b842608ce5d@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 25, 2020 at 08:32:44AM -0700, Bart Van Assche wrote:
> On 2020-05-24 21:09, Ming Lei wrote:
> > On Sat, May 23, 2020 at 08:19:58AM -0700, Bart Van Assche wrote:
> >> On 2020-05-21 19:39, Ming Lei wrote:
> >>> You may argue that two hw queue may share single managed interrupt, that
> >>> is possible if driver plays the trick. But if driver plays the trick in
> >>> this way, it is driver's responsibility to guarantee that the managed
> >>> irq won't be shutdown if either of the two hctxs are active, such as,
> >>> making sure that hctx->cpumask + hctx->cpumask <= this managed interrupt's affinity.
> >>> It is definitely one strange enough case, and this patch doesn't
> >>> suppose to cover this strange case. But, this patch won't break this
> >>> case. Also just be curious, do you have such in-tree case? and are you
> >>> sure the driver uses managed interrupt?
> >>
> >> I'm concerned about the block drivers that use RDMA (NVMeOF, SRP, iSER,
> >> ...). The functions that accept an interrupt vector argument
> >> (comp_vector), namely ib_alloc_cq() and ib_create_cq(), can be used in
> > 
> > PCI_IRQ_AFFINITY isn't used in RDMA driver, so RDMA NIC uses non-managed
> > irq.
> 
> Something doesn't add up ...
> 
> On a system with eight CPU cores and a ConnectX-3 RDMA adapter (mlx4
> driver; uses request_irq()) I ran the following test:
> * Query the affinity of all mlx4 edge interrupts (mlx4-1@0000:01:00.0 ..
> mlx4-16@0000:01:00.0).
> * Offline CPUs 6 and 7.
> * Query CPU affinity again.
> 
> As one can see below the affinity of the mlx4 interrupts was modified.
> Does this mean that the interrupt core manages more than only interrupts
> registered with PCI_IRQ_AFFINITY?

Interrupts registered with PCI_IRQ_AFFINITY are assigned their cpu affinity mask
at creation time and it never changes for the lifetime of that interrupt.

Interrupts not registerd with that option can have their affinity modified in
various paths.
