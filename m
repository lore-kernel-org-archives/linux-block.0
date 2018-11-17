Return-Path: <SRS0=MdGt=N4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5391C43441
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 10:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3A720817
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 10:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpMWYXHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3A720817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbeKQUTz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 17 Nov 2018 15:19:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:48356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbeKQUTz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Nov 2018 15:19:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2880A206BB;
        Sat, 17 Nov 2018 10:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542449025;
        bh=H80ELgAmb0oFAbVUpYbGzFXpxU0+0qqQfrigZJCPJnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GpMWYXHQgJu/0sKC9d6CuLz/3umTStUgmqrA6crdjvMwpeWe3qYBMFBPtnt9g6mNb
         gSWW2aWdva79DIGhycVwWGZVlbr0iKD7CyespPGmdlB9fHoeyr7GrYmnBoHsjtz7+f
         19uJFyrwK7B0Zk6VinY7ADlcBvK5nyAostuf/dDY=
Date:   Sat, 17 Nov 2018 11:03:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH V2 for-4.21 2/2] blk-mq: alloc q->queue_ctx as normal
 array
Message-ID: <20181117100342.GB1482@kroah.com>
References: <20181116112311.4117-1-ming.lei@redhat.com>
 <20181116112311.4117-3-ming.lei@redhat.com>
 <20181116140623.GC4595@kroah.com>
 <20181117023417.GC8872@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117023417.GC8872@ming.t460p>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Nov 17, 2018 at 10:34:18AM +0800, Ming Lei wrote:
> On Fri, Nov 16, 2018 at 06:06:23AM -0800, Greg Kroah-Hartman wrote:
> > On Fri, Nov 16, 2018 at 07:23:11PM +0800, Ming Lei wrote:
> > > Now q->queue_ctx is just one read-mostly table for query the
> > > 'blk_mq_ctx' instance from one cpu index, it isn't necessary
> > > to allocate it as percpu variable. One simple array may be
> > > more efficient.
> > 
> > "may be", have you run benchmarks to be sure?  If so, can you add the
> > results of them to this changelog?  If there is no measurable
> > difference, then why make this change at all?
> 
> __blk_mq_get_ctx() is used in fast path, what do you think about which
> one is more efficient?
> 
> - *per_cpu_ptr(q->queue_ctx, cpu);
> 
> - q->queue_ctx[cpu]

You need to actually test to see which one is faster, you might be
surprised :)

In other words, do not just guess.

> At least the latter isn't worse than the former.

How do you know?

> Especially q->queue_ctx is just a read-only look-up table, it doesn't
> make sense to make it percpu any more.
> 
> Not mention q->queue_ctx[cpu] is more clean/readable.

Again, please test to verify this.

thanks,

greg k-h
