Return-Path: <SRS0=X1aF=7V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58EAC433E1
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 15:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6B43206C3
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 15:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="weFVJmnC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbgFHP64 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730327AbgFHP6z (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jun 2020 11:58:55 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4184FC08C5C2;
        Mon,  8 Jun 2020 08:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DEM1QDKLTuYOOAV2I363qwhe0+cOx/Bk4o+cESUxXqE=; b=weFVJmnCgIuXHiX1FcPX4jyktF
        671dE2T65mx/hrh7fhEyu2YrBO925nGmg65wEKQmp3j3Ig9l2cfMdUnmHxlOkZ0xT8j40xslP2cim
        vBei7k5h0Jmuecz9qD2mQ4dETBM4lt5rZ7LV9FOPTWkkRq5BwI9FipAWe/cCs8XLHdxQR4IMN2OP4
        bwVhNEbFSuteAySoqFYP00cn9mBany+sJE31Fa/lV5B2fHo4fhIYpXIgqjRMyXB5wp9glL/IgA7uA
        fhZ7jzeHPiXKKaBKRnPIXa8pQJ2M/NJEMJBxyl6dSEF9YbJ+N4WXSB1Kz2f4shaXR22hmN/3pE477
        cf4wsZbQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jiKAW-0008Ip-Gb; Mon, 08 Jun 2020 15:58:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9FB92301DFC;
        Mon,  8 Jun 2020 17:58:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B1392B3CE561; Mon,  8 Jun 2020 17:58:33 +0200 (CEST)
Date:   Mon, 8 Jun 2020 17:58:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, frederic@kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: blk-softirq vs smp_call_function_single_async()
Message-ID: <20200608155833.GC2531@hirez.programming.kicks-ass.net>
References: <20200608115800.GA2531@hirez.programming.kicks-ass.net>
 <20200608154557.GA26611@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608154557.GA26611@infradead.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 08, 2020 at 08:45:57AM -0700, Christoph Hellwig wrote:
> On Mon, Jun 08, 2020 at 01:58:00PM +0200, Peter Zijlstra wrote:
> > Hi Jens,
> > 
> > I've been going through smp_call_function_single_async() users and
> > stumbled upon blk-softirq.c, which has:
> > 
> > static int raise_blk_irq(int cpu, struct request *rq)
> > {
> > 	if (cpu_online(cpu)) {
> > 		call_single_data_t *data = &rq->csd;
> > 
> > 		data->func = trigger_softirq;
> > 		data->info = rq;
> > 		data->flags = 0;
> > 
> > 		smp_call_function_single_async(cpu, data);
> > 		return 0;
> > 	}
> > 
> > 	return 1;
> > }
> > 
> > What, if anything, guarantees rq->csd is not already in use at that
> > time?
> 
> A request can only be completed once.

Sure, but that doesn't help.

CPU0				CPU1

 raise_blk_irq()		BLOCK_SOFTIRQ
   IPI -> CPU1

				// picks up thing from CPU0
				req->complete(req);


	<big hole where CSD is active and request completed>

				<IPI>
				  trigger_softirq()


What happens to a struct request after completion, is it free()d
or reused? If reused, how do we guarantee CSD completion before
free()ing?


