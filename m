Return-Path: <SRS0=JlK2=XS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7E5C4CECF
	for <linux-block@archiver.kernel.org>; Mon, 23 Sep 2019 19:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB2120B7C
	for <linux-block@archiver.kernel.org>; Mon, 23 Sep 2019 19:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OywFVHdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfIWT1q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Sep 2019 15:27:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46594 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfIWT1p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Sep 2019 15:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WVIoWsK1jLddXUNnNoYLXIn98UncMl2WWv8vMlp/XIk=; b=OywFVHdH1BOWczhEITQgThKZe9
        9zDCC7HcqNpHuoK6lYmTjN3eGfXsZTTslsujszPktBq/thH2ie9UKgYC4ViVRYhO+GDpxr9PWwSJu
        kq6nQasdPh5kZRa1G3feP8NgWjooaKidJ4ADPRnIbVq7+8srsVyt7HhPrEfp9/6lDGF/dzKTn7HPx
        caVqvuYddK4QkPuPkWcmR1nmMkcYbBjH0C5oxhFbEKZDWH6+0BYrkkEppVIl7ApewJsjnSEu1zc7K
        QAH3N8VDLEv7F0aAgFKDdoys9QrO/4mDzyufT4HIX+sZtN+WD5wcoIC0bkQkD90grtxZxmgkutfpf
        erJdb5iA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCTzs-0006Vf-BA; Mon, 23 Sep 2019 19:27:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CEFA7305E42;
        Mon, 23 Sep 2019 21:26:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1685820C3E177; Mon, 23 Sep 2019 21:27:42 +0200 (CEST)
Date:   Mon, 23 Sep 2019 21:27:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] sched/wait: Add wait_threshold
Message-ID: <20190923192742.GH2369@hirez.programming.kicks-ass.net>
References: <cover.1569139018.git.asml.silence@gmail.com>
 <d99ce2f7c98d4408aea50f515bbb6b89bc7850e8.1569139018.git.asml.silence@gmail.com>
 <20190923071932.GD2349@hirez.programming.kicks-ass.net>
 <3e359937-5b19-8a4c-4243-ba2edff68504@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3e359937-5b19-8a4c-4243-ba2edff68504@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

On Mon, Sep 23, 2019 at 07:37:46PM +0300, Pavel Begunkov wrote:
> Just in case duplicating a mail from the cover-letter thread:

Just because every patch should have a self contained and coherent
Changelog.

> It could be done with @cond indeed, that's how it works for now.
> However, this addresses performance issues only.
>=20
> The problem with wait_event_*() is that, if we have a counter and are
> trying to wake up tasks after each increment, it would schedule each
> waiting task O(threshold) times just for it to spuriously check @cond
> and go back to sleep. All that overhead (memory barriers, registers
> save/load, accounting, etc) turned out to be enough for some workloads
> to slow down the system.
>=20
> With this specialisation it still traverses a wait list and makes
> indirect calls to the checker callback, but the list supposedly is
> fairly  small, so performance there shouldn't be a problem, at least for
> now.
>=20
> Regarding semantics; It should wake a task when a value passed to
> wake_up_threshold() is greater or equal then a task's threshold, that is
> specified individually for each task in wait_threshold_*().
>=20
> In pseudo code:
> ```
> def wake_up_threshold(n, wait_queue):
> 	for waiter in wait_queue:
> 		waiter.wake_up_if(n >=3D waiter.threshold);
> ```
>=20
> Any thoughts how to do it better? Ideas are very welcome.
>=20
> BTW, this monster is mostly a copy-paste from wait_event_*(),
> wait_bit_*(). We could try to extract some common parts from these
> three, but that's another topic.

I don't think that is another topic at all. It is a quality of
implementation issue. We already have too many copies of all that (3).

So basically you want to fudge the wake function to do the/a @cond test,
not unlike what wait_bit already does, but differenly.

I'm really rather annoyed with C for not having proper lambda functions;
that would make all this so much easier. Anyway, let me have a poke at
this in the morning, it's late already.

Also, is anything actually using wait_queue_entry::private ? I'm
not finding any in a hurry.


