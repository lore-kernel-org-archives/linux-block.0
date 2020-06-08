Return-Path: <SRS0=X1aF=7V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF5FC433DF
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 15:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19BE42074B
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 15:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tYxhHcC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbgFHPqG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgFHPqF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jun 2020 11:46:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC225C08C5C2;
        Mon,  8 Jun 2020 08:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xkEjds/9SFilODiUC/kQqzXfuMn8hVAIzYa+YH6izYY=; b=tYxhHcC1PWOW1d5TDWRigUtLNG
        T7gn/AUkKXN1J2v5/ztgWJsutNNKurDZBOyVstNui749MxOHYjrpGy9vUANXZQrGA1yoBkiXsHKop
        NYtAGeECUb5DChYutWdL1uT3AvMPn/8uglMXzcLHt1vqZXa9L+yDa6Tv0QvBLy6ROOgojrpaL5mQg
        BLlsJuFJmWYbrbaPzVvTeFCSOVt2hVdJgmMkqdpdo9mmAd775APJRqpCZVosABUyNex62Yf+/plzS
        +FcNjWsPh8xfZjLD/2n5+Q3+8nSLMyz/2dG8bX6Ns/0hmgluictU+KmvUWHiixBtiaMOQm4zdFcQE
        9M9v83Bg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jiJyH-0001v8-J2; Mon, 08 Jun 2020 15:45:57 +0000
Date:   Mon, 8 Jun 2020 08:45:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, frederic@kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: blk-softirq vs smp_call_function_single_async()
Message-ID: <20200608154557.GA26611@infradead.org>
References: <20200608115800.GA2531@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608115800.GA2531@hirez.programming.kicks-ass.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 08, 2020 at 01:58:00PM +0200, Peter Zijlstra wrote:
> Hi Jens,
> 
> I've been going through smp_call_function_single_async() users and
> stumbled upon blk-softirq.c, which has:
> 
> static int raise_blk_irq(int cpu, struct request *rq)
> {
> 	if (cpu_online(cpu)) {
> 		call_single_data_t *data = &rq->csd;
> 
> 		data->func = trigger_softirq;
> 		data->info = rq;
> 		data->flags = 0;
> 
> 		smp_call_function_single_async(cpu, data);
> 		return 0;
> 	}
> 
> 	return 1;
> }
> 
> What, if anything, guarantees rq->csd is not already in use at that
> time?

A request can only be completed once.
