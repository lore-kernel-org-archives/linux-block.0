Return-Path: <SRS0=St9l=EG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1482C388F9
	for <linux-block@archiver.kernel.org>; Sat, 31 Oct 2020 10:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0D4A2224D
	for <linux-block@archiver.kernel.org>; Sat, 31 Oct 2020 10:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EVjglqXR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HeDt+NJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgJaKlM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 31 Oct 2020 06:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgJaKlL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 31 Oct 2020 06:41:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC3DC0613D5;
        Sat, 31 Oct 2020 03:41:11 -0700 (PDT)
Date:   Sat, 31 Oct 2020 11:41:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604140869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xObs7EwbaHNBrpibRpna/d2c5MAikT9OMjntatKbx7Q=;
        b=EVjglqXRDCtsJn/PocF4fkuRzKOPmWAC3LphY07rJjdyo9NVjN3p6cY7AyYSpvNPMXWTz0
        gXNJGYudSzeEylRNyCckodwGupAeQrergKsE85lv58ay7O1ibhP9uInKcs0WppYg1Uamny
        KsoTG+JH4KaX488LbfW7VNXVEmpLx7Ohij5mfWfL42MG0oKcQdmgbl2LRML2mtvpga8LFt
        CTCrml5KzKO9DYpkKtnAI+KveFvhASo+RnYs5bfl/jMB7WPJn2ZCKJpuf/D0dFQhKJE9Q9
        z6dsvAIq2rhCB7Y2PKkSF/b2g91xXOdPmTmLvsdgf9e34Wp4VjCuSCxlOWZ2Cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604140869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xObs7EwbaHNBrpibRpna/d2c5MAikT9OMjntatKbx7Q=;
        b=HeDt+NJW5y3d8Va4BDSNOYWNbm9DNqXWCddsA9uNtH7jzDJAnuQR3f+tl0WS6ecS39fH26
        pawk9B8qcGs+dIAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        David Runge <dave@sleepmap.de>, linux-rt-users@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>, Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 3/3] blk-mq: Use llist_head for blk_cpu_done
Message-ID: <20201031104108.wjjdiklqrgyqmj54@linutronix.de>
References: <20201028065616.GA24449@infradead.org>
 <20201028141251.3608598-1-bigeasy@linutronix.de>
 <20201028141251.3608598-3-bigeasy@linutronix.de>
 <20201029131212.dsulzvsb6pahahbs@linutronix.de>
 <20201029140536.GA6376@infradead.org>
 <20201029145623.3zry7o6nh6ks5tjj@linutronix.de>
 <20201029145743.GA19379@infradead.org>
 <d2c15411-5b21-535b-6e07-331ebe22f8c8@grimberg.me>
 <20201029210103.ocufuvj6i4idf5hj@linutronix.de>
 <deb40e55-d228-06c8-8719-fc8657a0a19b@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <deb40e55-d228-06c8-8719-fc8657a0a19b@grimberg.me>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-10-29 14:07:59 [-0700], Sagi Grimberg wrote:
> > in which context?
> 
> Not sure what is the question.

The question is in which context do you complete your requests. My guess
by now is "usually softirq/NAPI and context in rare error case".

> > But this is probably nr_hw_queues > 1?
> 
> Yes.

So this means it will either complete directly or issue an IPI.

> > but running it in softirq on the remote CPU would still allow of other
> > packets to come on the remote CPU (which would block BLOCK sofirq if
> > NET_RX is already running).
> 
> Not sure I understand your comment, if napi triggers on core X and we
> complete from that, it will trigger IPI to core Y, and there with patch #2
> is will trigger softirq instead of calling ->complete directly no?

This is correct. But trigger softirq does not mean that it will wake
`ksoftirqd' as it is the case for the usb-storage right now. In your
case (completing from NAPI/sofitrq (or for most other driver which
complete in their IRQ handler)) it means:
- trigger IPI
- IPI will OR the BLOCK-softirq bit.
- on exit from IPI it will invoke do_softirq() (unless softirq is
  already pending and got interrupted by the IPI) and complete the
  Block request.

Sebastian
