Return-Path: <SRS0=X1aF=7V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5A6C433E0
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 11:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48B0F2078D
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 11:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W/PQ7iAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbgFHL6D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jun 2020 07:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbgFHL6D (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jun 2020 07:58:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA18C08C5C2;
        Mon,  8 Jun 2020 04:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=VMeCjq5pB2mlhYrwj1qUoEnDE395x17IC3jK6gcC+QQ=; b=W/PQ7iANIEicjFcoxgsAIm7fP9
        b7Oxeqp3v3JXpsG+cfsl8rw30CGpuebvSaxJPyev8TSHAo8dN3l6cRD9BO9kMmKgCwRS1y3gUa+Ef
        F5F6Prg+7+wZpvfHz2tRWi9DZWDzLyYeVFHGbki/hcTdDpYQjxEOGYlk/u5dgtZdFmd2ZW4N8LyOF
        bJuXjOw2fiUNuTWrY/xoxHzzzyR2DF/PyPd8zV/BrtZkUMukkmyp6+a1SvxBvSC0+LcKuECabNrFA
        a8MnJ7wIPEaNs0H8TZ3RXit/KfZbEpsmKMVjdlndJxKVdiBmdGXpb8uDvFmXTb7RUIDIB2mx3icxK
        B4Ha6X2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jiGPi-0006l1-BG; Mon, 08 Jun 2020 11:58:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A6B643019CE;
        Mon,  8 Jun 2020 13:58:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8EF1D202436EE; Mon,  8 Jun 2020 13:58:00 +0200 (CEST)
Date:   Mon, 8 Jun 2020 13:58:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     frederic@kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: blk-softirq vs smp_call_function_single_async()
Message-ID: <20200608115800.GA2531@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

I've been going through smp_call_function_single_async() users and
stumbled upon blk-softirq.c, which has:

static int raise_blk_irq(int cpu, struct request *rq)
{
	if (cpu_online(cpu)) {
		call_single_data_t *data = &rq->csd;

		data->func = trigger_softirq;
		data->info = rq;
		data->flags = 0;

		smp_call_function_single_async(cpu, data);
		return 0;
	}

	return 1;
}

What, if anything, guarantees rq->csd is not already in use at that
time?

The purpose of that CSD is to make the BLOCK_SOFTIRQ go, but there's
plenty of other ways to tickle that, afaict. So if that races vs someone
else, and that completes whatever was needed, then can't we get to
raise_blk_irq() again, even though the csd is still enqueued?

Worse; it has: data->flags = 0; so our early exit will not happen, even
when it should.
