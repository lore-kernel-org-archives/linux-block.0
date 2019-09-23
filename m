Return-Path: <SRS0=JlK2=XS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE947C3A5A6
	for <linux-block@archiver.kernel.org>; Mon, 23 Sep 2019 07:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59D220820
	for <linux-block@archiver.kernel.org>; Mon, 23 Sep 2019 07:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ghzSBv0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390878AbfIWHTm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Sep 2019 03:19:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40042 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729404AbfIWHTm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Sep 2019 03:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ycpk1YiwPb/Tbr+693kk82MkGbYMJrQgSJFb5bbpHPw=; b=ghzSBv0Na1HFvhyhj5bATlwqp
        D/cF3iVNybe8tkimAk7EXEtl8I8mXPKPEHqFQYh8Mu59XuOsGVYhkn8DkcDizK/QfQBfQp8Ji+5DK
        SrbrZKqSnYCljgtaZGfsGEkCSqNsSQDJKrTDWSmRMJdWhhrVh4gVw4zd70z8FayB12QDUYVvusyFy
        6VMacB5ILeuiXZC4qdvV5o4Feh+sTOCBiAITTwk7hXqVx7tRSFIfklqG2s87y79Bg3rXOTr+AtU/T
        lBK9RMlErFeZooh4CqdfmKUbEosQ+g3OGjTGK5u4CeOKhiJwwV2ABNseiEGOXnx/emVRzRSjMyHxN
        +d6pCty/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCIdE-0000ui-TI; Mon, 23 Sep 2019 07:19:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 931FB303DFD;
        Mon, 23 Sep 2019 09:18:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8EE3529E3288E; Mon, 23 Sep 2019 09:19:32 +0200 (CEST)
Date:   Mon, 23 Sep 2019 09:19:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] sched/wait: Add wait_threshold
Message-ID: <20190923071932.GD2349@hirez.programming.kicks-ass.net>
References: <cover.1569139018.git.asml.silence@gmail.com>
 <d99ce2f7c98d4408aea50f515bbb6b89bc7850e8.1569139018.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d99ce2f7c98d4408aea50f515bbb6b89bc7850e8.1569139018.git.asml.silence@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Sep 22, 2019 at 11:08:50AM +0300, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> Add wait_threshold -- a custom wait_event derivative, that waits until
> a value is equal to or greater than the specified threshold.

This is quite insufficient justification for this monster... what exact
semantics do you want?

Why can't you do this exact same with a slightly more complicated @cond
?
