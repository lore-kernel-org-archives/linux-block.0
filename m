Return-Path: <SRS0=ToMJ=6U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B3DC28CBC
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 07:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 710B920721
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 07:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588750091;
	bh=Q5IKctaZwAYAFKNkNm1sdYc7vlBXC9aZoY1Azp7gemk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Lrs1arjYiZj/daNtj/pvQ5jYUqlEHW7ECLT5b/gw9YSguZx8rm5LULUnUrW3Eq/rv
	 IUvMd8cqtymN9DLJ7j5AHRyHWSXqn9lnktVW56XXLgqPuhU8QHuC/cVLdBsEotFq5z
	 gej+d9AVNJ4ID2f6TDfDac2qNAyEkj/VgCXKe/88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgEFH2L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 May 2020 03:28:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbgEFH2I (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 May 2020 03:28:08 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DAB620663;
        Wed,  6 May 2020 07:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588750088;
        bh=Q5IKctaZwAYAFKNkNm1sdYc7vlBXC9aZoY1Azp7gemk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aZc6TQfvplzKOSrvpan4dD5F5qc2rBM8wdgilCeq06x9P84Y9KcX6TMkYdNgpAekT
         IfIKo+FAKwgQdF88wBYvjrTUd+YeZAKqDvF/rNHDr9xER5Yu6Yjq89AmYtKmO3btcn
         2etlXYD3PQMyxIYmDnEIgveRMZ4a+C/reGLNuIfc=
Date:   Wed, 6 May 2020 08:28:03 +0100
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
Message-ID: <20200506072802.GC7021@willie-the-truck>
References: <20200429080728.GB29143@willie-the-truck>
 <20200429094616.GB700644@T590>
 <20200429122757.GA30247@willie-the-truck>
 <20200429134327.GC700644@T590>
 <20200429173400.GC30247@willie-the-truck>
 <20200430003945.GA719313@T590>
 <20200430110429.GI19932@willie-the-truck>
 <20200430140254.GA996887@T590>
 <20200505154618.GA3644@lst.de>
 <20200506012425.GA1177270@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506012425.GA1177270@T590>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 06, 2020 at 09:24:25AM +0800, Ming Lei wrote:
> On Tue, May 05, 2020 at 05:46:18PM +0200, Christoph Hellwig wrote:
> > On Thu, Apr 30, 2020 at 10:02:54PM +0800, Ming Lei wrote:
> > > BLK_MQ_S_INACTIVE is only set when the last cpu of this hctx is becoming
> > > offline, and blk_mq_hctx_notify_offline() is called from cpu hotplug
> > > handler. So if there is any request of this hctx submitted from somewhere,
> > > it has to this last cpu. That is done by blk-mq's queue mapping.
> > > 
> > > In case of direct issue, basically blk_mq_get_driver_tag() is run after
> > > the request is allocated, that is why I mentioned the chance of
> > > migration is very small.
> > 
> > "very small" does not cut it, it has to be zero.  And it seems the
> > new version still has this hack.
> 
> But smp_mb() is used for ordering the WRITE and READ, so it is correct.
> 
> barrier() is enough when process migration doesn't happen.

Without numbers I would just make the smp_mb() unconditional. Your
questionable optimisation trades that for a load of the CPU ID and a
conditional branch, which isn't obviously faster to me. It's also very
difficult to explain to people and relies on a bunch of implicit behaviour
(e.g. racing only with CPU-affine hotplug notifier).

If it turns out that the smp_mb() is worthwhile,  then I'd suggest improving
the comment, perhaps to include the litmus test I cooked previously.

Will
