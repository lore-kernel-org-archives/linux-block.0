Return-Path: <SRS0=t87n=EI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A167C00A89
	for <linux-block@archiver.kernel.org>; Mon,  2 Nov 2020 18:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 600A522226
	for <linux-block@archiver.kernel.org>; Mon,  2 Nov 2020 18:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K+gfwNBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgKBSMp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Nov 2020 13:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgKBSMp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Nov 2020 13:12:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473A0C0617A6;
        Mon,  2 Nov 2020 10:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tzLpJEtqWMoAnuZtioMuRPejBU3helvAx3OnKp5WyT4=; b=K+gfwNBhSTHctxo7GZiCazthuJ
        i7/UcMkPU6eDSMzvQagAC4kJJ6q8TBj23rOLaAkkxbILe5cwPbOnbIray2do6ta8FtzHrvqznk5lv
        2Qxfu8C6iW3Es6Mi/wIwYE2yI86zxSCtrB6aEsbbiCJqhvdEXjbjqdWoue3sPVOp/xfN3MyyN0/Jr
        8Fl1JcFLYsZSthool5iJ3c/2vllWq33UAZs/mJ3S7cFVwhAec8CMwbUD43yebsjy7U1dVABCpkd0l
        UgdXYrqbAAQJo5WQmJ2nHlALg4VqG7M8jH/x7/TvrJqeRN7Nu/YBcssAwhCQ+Bljm5jMlgdUeWYjV
        2siQtS2Q==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZeJq-0004v4-I3; Mon, 02 Nov 2020 18:12:38 +0000
Date:   Mon, 2 Nov 2020 18:12:38 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        David Runge <dave@sleepmap.de>, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>, Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 3/3] blk-mq: Use llist_head for blk_cpu_done
Message-ID: <20201102181238.GA17806@infradead.org>
References: <20201029131212.dsulzvsb6pahahbs@linutronix.de>
 <20201029140536.GA6376@infradead.org>
 <20201029145623.3zry7o6nh6ks5tjj@linutronix.de>
 <20201029145743.GA19379@infradead.org>
 <d2c15411-5b21-535b-6e07-331ebe22f8c8@grimberg.me>
 <20201029210103.ocufuvj6i4idf5hj@linutronix.de>
 <deb40e55-d228-06c8-8719-fc8657a0a19b@grimberg.me>
 <20201031104108.wjjdiklqrgyqmj54@linutronix.de>
 <3bbfb5e1-c5d7-8f3b-4b96-6dc02be0550d@kernel.dk>
 <20201102095533.fxc2xpauzsoju7cm@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102095533.fxc2xpauzsoju7cm@linutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 02, 2020 at 10:55:33AM +0100, Sebastian Andrzej Siewior wrote:
> On 2020-10-31 09:00:49 [-0600], Jens Axboe wrote:
> > There really aren't any rules for this, and it's perfectly legit to
> > complete from process context. Maybe you're a kthread driven driver and
> > that's how you handle completions. The block completion path has always
> > been hard IRQ safe, but possible to call from anywhere.
> 
> I'm not trying to put restrictions and forbidding completions from a
> kthread. I'm trying to avoid the pointless softirq dance for no added
> value. We could:

> to not break that assumption you just mentioned and provide 
> |static inline void blk_mq_complete_request_local(struct request *rq)
> |{
> |                 rq->q->mq_ops->complete(rq);
> |}
> 
> so that completion issued from from process context (like those from
> usb-storage) don't end up waking `ksoftird' (running at SCHED_OTHER)
> completing the requests but rather performing it right away. The softirq
> dance makes no sense here.

Agreed.  But I don't think your above blk_mq_complete_request_local
is all that useful either as ->complete is defined by the caller,
so we could just do a direct call.  Basically we should just
return false from blk_mq_complete_request_remote after updating
the state when called from process context.  But given that IIRC
we are not supposed to check what state we are called from
we'll need a helper just for updating the state instead and
ensure the driver uses the right helper.  Now of course we might
have process context callers that still want to bounce to the
submitting CPU, but in that case we should go directly to a
workqueue or similar.

Either way doing this properly will probabl involve an audit of all
drivers, but I think that is worth it.
