Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858A1C433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 11:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B7EC60238
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 11:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhJYLRO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 07:17:14 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57836 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhJYLRK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 07:17:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9C76C1FD3E;
        Mon, 25 Oct 2021 11:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635160487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sjZAyXn5jG+05FEG8DgYvyLSGFHH/9MVtCf4zkIY++g=;
        b=gllVaCmfzL00sjlkxuaCvvC70v7Z8amLhuSF5kZJvKfb9KyTe35OMWjvFIPgb3nf0Ukmr7
        KCr10VcH9iIkf/bMuJbJKhtOxerUg+iDnR+kRKZ9jE5RW3K/79Yuurrh07s1usy7Xfr8Kv
        tvmrhT9CjclVbHj2bASVammD7H9PthM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635160487;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sjZAyXn5jG+05FEG8DgYvyLSGFHH/9MVtCf4zkIY++g=;
        b=zAu9IqlhwXtOM/tGGUzDeaLgrqW5Hi+Zjhwt/RbTw180T47rI7QlHR+s09OzW1mml/wjRs
        crS2sS8LEJbsGmCw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 71FCBA3B81;
        Mon, 25 Oct 2021 11:14:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4F1D01E0BFB; Mon, 25 Oct 2021 13:14:47 +0200 (CEST)
Date:   Mon, 25 Oct 2021 13:14:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jan Kara <jack@suse.cz>, linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        237826@studenti.unimore.it, 224833@studenti.unimore.it,
        Giacomo Guiduzzi <224804@studenti.unimore.it>,
        238290@studenti.unimore.it,
        PAOLO CROTTI <204572@studenti.unimore.it>
Subject: Re: [PATCH 0/8 v3] bfq: Limit number of allocated scheduler tags per
 cgroup
Message-ID: <20211025111447.GB12157@quack2.suse.cz>
References: <20211006164110.10817-1-jack@suse.cz>
 <D76F0193-9573-44B9-A401-97D2A0DB846B@linaro.org>
 <C7CBAECF-A7F3-4AA0-8F10-D7EC267AD4BE@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C7CBAECF-A7F3-4AA0-8F10-D7EC267AD4BE@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon 25-10-21 09:58:11, Paolo Valente wrote:
> > Il giorno 7 ott 2021, alle ore 18:33, Paolo Valente <paolo.valente@linaro.org> ha scritto:
> >> Il giorno 6 ott 2021, alle ore 19:31, Jan Kara <jack@suse.cz> ha scritto:
> >> 
> >> Hello!
> >> 
> >> Here is the third revision of my patches to fix how bfq weights apply on cgroup
> >> throughput and on throughput of processes with different IO priorities. Since
> >> v2 I've added some more patches so that now IO priorities also result in
> >> service differentiation (previously they had no effect on service
> >> differentiation on some workloads similarly to cgroup weights). The last patch
> >> in the series still needs some work as in the current state it causes a
> >> notable regression (~20-30%) with dbench benchmark for large numbers of
> >> clients. I've verified that the last patch is indeed necessary for the service
> >> differentiation with the workload described in its changelog. As we discussed
> >> with Paolo, I have also found out that if I remove the "waker has enough
> >> budget" condition from bfq_select_queue(), dbench performance is restored
> >> and the service differentiation is still good. But we probably need some
> >> justification or cleaner solution than just removing the condition so that
> >> is still up to discussion. But first seven patches already noticeably improve
> >> the situation for lots of workloads so IMO they stand on their own and
> >> can be merged regardless of how we go about the last patch.
> >> 
> > 
> > Hi Jan,
> > I have just one more (easy-to-resolve) doubt: you seem to have tested
> > these patches mostly on the throughput side.  Did you run a
> > startup-latency test as well?  I can run some for you, if you prefer
> > so. Just give me a few days.
> > 
> 
> We are finally testing your patches a little bit right now, for
> regressions with our typical benchmarks ...

Hum, strange I didn't get your previous email about benchmarks. You're
right I didn't run startup-latency AFAIR. Now that you've started them,
probably there's no big point in me queuing them as well. So thanks for
the benchmarking :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
