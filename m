Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2A5C433FE
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 12:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C40823A3C
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 12:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgLHM5w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 07:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgLHM5w (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Dec 2020 07:57:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DE9C061749
        for <linux-block@vger.kernel.org>; Tue,  8 Dec 2020 04:57:12 -0800 (PST)
Date:   Tue, 8 Dec 2020 13:57:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607432230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XKwBP8F64HqqEOqVbrdLVgdD7U+GBrY0UADzThR7GiU=;
        b=wlUtUP/EKOWAo80ezYxAX6M63+C2kksjj26WPE2uHdfhW5V2RYe9sUMxJAuS2yzXfVJQtV
        KuQHdJ+gbsxxlJVDc7MclRpnJbWUFChbWCbyLzXrtDZl3zJ/QH/cxQ2vlnHOPY1jhBxswv
        L/nGH/F+LknEKCtv/jGPrdvbavnGAm03PUK79kHWEo0/LGkVjyL2ya1CyqiNHZ7ddbHN4h
        ON+ppCSSbhq/f4XZn7k7HkPJh/Ue09fHeTdMVg+iNOpxJhiaS40yJ8jJQaPm3vnWqA0cCB
        1FvWas7ipU/P5OGGMBojLqdfp5SB4KFnCHTFlOD0e+ydGopjN4ei743FhyEtKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607432230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XKwBP8F64HqqEOqVbrdLVgdD7U+GBrY0UADzThR7GiU=;
        b=DcD218yrg0J+kU5g3H2poD5jKTmP/c7o+X79JJNxvIpSp/wKRKL3Ty2PjRNmoknX5tRb50
        BAuE58aBCMY7qLDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/3] blk-mq: Always complete remote completions requests
 in softirq
Message-ID: <20201208125709.5epgbpmqp56bf243@linutronix.de>
References: <20201204191356.2516405-1-bigeasy@linutronix.de>
 <20201204191356.2516405-3-bigeasy@linutronix.de>
 <de7f392a-fbac-f7bc-662a-5f40dd4c0aa6@kernel.dk>
 <20201208082220.hhel5ubeh4uqrwnd@linutronix.de>
 <20201208084409.koeftbpnvesp4xtv@beryllium.lan>
 <20201208113653.awqz4zggmy37vbog@beryllium.lan>
 <20201208114936.sfe2jpmbjulcpyjk@linutronix.de>
 <20201208124148.4dxdu6dp5m3mudff@beryllium.lan>
 <20201208125224.m2xt66ladp63fa3t@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201208125224.m2xt66ladp63fa3t@linutronix.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-12-08 13:52:25 [+0100], To Daniel Wagner wrote:
> On 2020-12-08 13:41:48 [+0100], Daniel Wagner wrote:
> > On Tue, Dec 08, 2020 at 12:49:36PM +0100, Sebastian Andrzej Siewior wro=
te:
> > > On 2020-12-08 12:36:53 [+0100], Daniel Wagner wrote:
> > > > Obvious in this configuration there are no remote completions (veri=
fied
> > > > it).
> > >=20
> > > do you complete on a remote CPU if you limit the queues to one (this =
is
> > > untested of course)?
> >=20
> > nvme0n1/ completed   11913011 remote    6718563 56.40%
> >=20
> > yes, but how is this relevant? I thought Jens complain was about the
> > additional indirection via the softirq context
> >=20
> > -		rq->q->mq_ops->complete(rq);
> > +	blk_mq_trigger_softirq(rq);
> >=20
> > and not the remote completion path. I can benchmark it out but I don't
> > know if it's really helping in the discussion.
=E2=80=A6 blurp

Yes, you are right. Even cross-CPU completion for single-queue was
already completing in softirq. So the only change is for multiqueue
devices which you just demonstrated that it does not happen.
Thank you!

Sebastian
