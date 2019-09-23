Return-Path: <SRS0=JlK2=XS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14186C4CECF
	for <linux-block@archiver.kernel.org>; Mon, 23 Sep 2019 20:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D007E20673
	for <linux-block@archiver.kernel.org>; Mon, 23 Sep 2019 20:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BX3GqwsB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfIWUXQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Sep 2019 16:23:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54672 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfIWUXQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Sep 2019 16:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aA6G5j/GWFQWf58bWS2Roiwr5zclNDQNpoKs51CyLPM=; b=BX3GqwsBgnQQgV++O4xX6CkcI
        JhotC/8SeJ562+p9UL/7eJKXVJBN0CSZRnC6ua7vx2gicvuDtoLdPz283sNtiDMcVuPdnW8j8pkpv
        mERlNKstfpOaXZa8+uONVcrkp50NFFOiWfrusLXapduXsF+SEtqUrSynFqDjd7x+S2OK9bLgCWbyf
        6RtphSKrMLULAL9Swczng10X0aonz1hJidhrTOn7dHI+Xd17ClfcSO/0EJpNxGKHc5icWscGkMKPp
        edRY97RSGf2vs78ZpvIcbZZJTfmz/OYdCuN0VeoNTLYYBDM9ypOuwlTBTwEHYrIUubeo0stALWp8l
        Bh5h/Fy3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCUrY-0007gq-ND; Mon, 23 Sep 2019 20:23:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 65451305E42;
        Mon, 23 Sep 2019 22:22:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ADE2420D80D40; Mon, 23 Sep 2019 22:23:10 +0200 (CEST)
Date:   Mon, 23 Sep 2019 22:23:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 1/2] sched/wait: Add wait_threshold
Message-ID: <20190923202310.GA2386@hirez.programming.kicks-ass.net>
References: <cover.1569139018.git.asml.silence@gmail.com>
 <d99ce2f7c98d4408aea50f515bbb6b89bc7850e8.1569139018.git.asml.silence@gmail.com>
 <20190923071932.GD2349@hirez.programming.kicks-ass.net>
 <3e359937-5b19-8a4c-4243-ba2edff68504@gmail.com>
 <20190923192742.GH2369@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923192742.GH2369@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 23, 2019 at 09:27:42PM +0200, Peter Zijlstra wrote:

> Also, is anything actually using wait_queue_entry::private ? I'm
> not finding any in a hurry.

That is; outside of default_wake_function(). I don't see a sensible
reason for that field to be 'void *' nor for the name 'private'.

But _that_ is something we can fix later.
