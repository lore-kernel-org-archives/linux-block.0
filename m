Return-Path: <SRS0=56XS=XT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF22C432C1
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 11:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362D6214AF
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 11:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NkuCyu6W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439006AbfIXLdR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Sep 2019 07:33:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44950 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438702AbfIXLdR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Sep 2019 07:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6YlsGuRqgiV/EQBRpxOK559NlHgYrAL9EgTx9nyDQOQ=; b=NkuCyu6W/NM8LZwPz7z2JX7pl
        n1dbz0nvj4SKPsWoXxfaugHiPu/R0bz0FP6ckp4QUHeqCVfoVMWMpIoi7jYnpBkutQVmNZrHd8F6d
        nBsIGbaU0ZjiGtjiKaaKEVSGSqfsLsj33WUZmVYAchwqTZrnru8tRmt3oYdAEwRrSXV9nIByga9W6
        6OUNpuLSBYv/E1Ts3w9+FvU6MRFpEKfkHkmh1oO1DdeWDvdx19xNHE2qUhGsWFMAv54r2hUgIXwlU
        ZXr18pNldMaSmMBxXJmN2WSrD022Mk6TbsJ2AQkfv51XznXXe2mJhz6YC4M+lCmfNrn7Sn6y/yJ8X
        h0dBFpopA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCj43-0001Vx-7W; Tue, 24 Sep 2019 11:33:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C211C305E35;
        Tue, 24 Sep 2019 13:32:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5A83C29E510E7; Tue, 24 Sep 2019 13:33:00 +0200 (CEST)
Date:   Tue, 24 Sep 2019 13:33:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
Message-ID: <20190924113300.GL2332@hirez.programming.kicks-ass.net>
References: <df612e90-8999-0085-d2d6-4418e044e429@gmail.com>
 <731b2087-7786-5374-68ff-8cba42f0cd68@kernel.dk>
 <759b9b48-1de3-1d43-3e39-9c530bfffaa0@kernel.dk>
 <43244626-9cfd-0c0b-e7a1-878363712ef3@gmail.com>
 <f2608e3d-bb4e-9984-79e8-a2ab4f855c7f@kernel.dk>
 <b999490f-6138-b685-5472-5cd1843b747d@kernel.dk>
 <ed37058b-ee96-7d44-1dc7-d2c48e2ac23f@kernel.dk>
 <20190924094942.GN2349@hirez.programming.kicks-ass.net>
 <6f935fb9-6ebd-1df1-0cd0-69e34a16fa7e@kernel.dk>
 <29e6e06e-351f-c19d-ed7c-51f30c9ca887@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29e6e06e-351f-c19d-ed7c-51f30c9ca887@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 24, 2019 at 12:34:17PM +0200, Jens Axboe wrote:

> Just took a quick look at it, and ran into block/kyber-iosched.c that
> actually uses the private pointer for something that isn't a task
> struct...

Argh... that's some 'creative' abuse of the waitqueue API :/
