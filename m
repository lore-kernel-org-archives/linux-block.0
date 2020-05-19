Return-Path: <SRS0=keWk=7B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8DDC433E0
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 15:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B42472075F
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 15:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgESPaG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 May 2020 11:30:06 -0400
Received: from verein.lst.de ([213.95.11.211]:44595 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgESPaG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 11:30:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id F2F2D68B02; Tue, 19 May 2020 17:30:00 +0200 (CEST)
Date:   Tue, 19 May 2020 17:30:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 5/9] blk-mq: don't set data->ctx and data->hctx in
 blk_mq_alloc_request_hctx
Message-ID: <20200519153000.GB22286@lst.de>
References: <20200518093155.GB35380@T590> <87imgty15d.fsf@nanos.tec.linutronix.de> <20200518115454.GA46364@T590> <20200518131634.GA645@lst.de> <20200518141107.GA50374@T590> <20200518165619.GA17465@lst.de> <20200519015420.GA70957@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519015420.GA70957@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 19, 2020 at 09:54:20AM +0800, Ming Lei wrote:
> As Thomas clarified, workqueue hasn't such issue any more, and only other
> per CPU kthreads can run until the CPU clears the online bit.
> 
> So the question is if IO can be submitted from such kernel context?

What other per-CPU kthreads even exist?

> > INACTIVE is set to the hctx, and it is set by the last CPU to be
> > offlined that is mapped to the hctx.  once the bit is set the barrier
> > ensured it is seen everywhere before we start waiting for the requests
> > to finish.  What is missing?:
> 
> memory barrier should always be used as pair, and you should have mentioned
> that the implied barrier in test_and_set_bit_lock pair from sbitmap_get()
> is pair of smp_mb__after_atomic() in blk_mq_hctx_notify_offline().

Documentation/core-api/atomic_ops.rst makes it pretty clear that the
special smp_mb__before_atomic and smp_mb__after_atomic barriers are only
used around the set_bit/clear_bit/change_bit operations, and not on the
test_bit side.  That is also how they are used in all the callsites I
checked.

> Then setting tag bit and checking INACTIVE in blk_mq_get_tag() can be ordered,
> same with setting INACTIVE and checking tag bit in blk_mq_hctx_notify_offline().

Buy yes, even if not that would take care of it.

> BTW, smp_mb__before_atomic() in blk_mq_hctx_notify_offline() isn't needed.

True.
