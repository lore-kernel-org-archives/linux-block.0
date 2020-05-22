Return-Path: <SRS0=5dBz=7E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6FEC433DF
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 16:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B514420679
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 16:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SNa6ZJDj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgEVQjU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 May 2020 12:39:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44600 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgEVQjT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 May 2020 12:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8OmNhX8P6hsaXiRZDKUBUMQjeMukKlzzGx4//zwIpCI=; b=SNa6ZJDj6oroJjon29xMbzAjGe
        QkkzzexMe6l9wA1sLWK8+fKpqOS3SXo7IJQc4JIBNh34NuGgpKMnlY74y+HLkikTciBq5zLRV71YT
        Ar/5PMNhsBxvLI41GHs3sK+l67eaH+gjwpQt8/sq9jbnn0oXMRdG9I4z+5mE821fe69SKjuESitjW
        X/6P7oMwCoiEXadoQSyWZb1q33EMeo1T73RpdvHhJ2BucC5XUkJ7qair5s/+ekDuWYZY4PlbLX7YR
        PId4sYnpxXKJez/i1HNU+qZvLtQfJpdXX8khVTn6slS4bzRiyqlnYcNvvzCbKLlEGG6oJuGz7VA5C
        7s4ZPGrg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcAhU-0006It-Cd; Fri, 22 May 2020 16:39:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 41C16306102;
        Fri, 22 May 2020 18:39:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F13E520BDB125; Fri, 22 May 2020 18:39:08 +0200 (CEST)
Date:   Fri, 22 May 2020 18:39:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Phillip Susi <psusi@ubuntu.com>,
        Vivek Goyal <vgoyal@redhat.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH v1 04/25] block: nr_sects_write(): Disable preemption on
 seqcount write
Message-ID: <20200522163908.GP325280@hirez.programming.kicks-ass.net>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200519214547.352050-5-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519214547.352050-5-a.darwish@linutronix.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 19, 2020 at 11:45:26PM +0200, Ahmed S. Darwish wrote:
> For optimized block readers not holding a mutex, the "number of sectors"
> 64-bit value is protected from tearing on 32-bit architectures by a
> sequence counter.
> 
> Disable preemption before entering that sequence counter's write side
> critical section. Otherwise, the read side can preempt the write side
> section and spin for the entire scheduler tick. If the reader belongs to
> a real-time scheduling class, it can spin forever and the kernel will
> livelock.
> 
> Fixes: c83f6bf98dc1 ("block: add partition resize function to blkpg ioctl")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  block/blk.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/block/blk.h b/block/blk.h
> index 0a94ec68af32..151f86932547 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -470,9 +470,11 @@ static inline sector_t part_nr_sects_read(struct hd_struct *part)
>  static inline void part_nr_sects_write(struct hd_struct *part, sector_t size)
>  {
>  #if BITS_PER_LONG==32 && defined(CONFIG_SMP)
> +	preempt_disable();
>  	write_seqcount_begin(&part->nr_sects_seq);
>  	part->nr_sects = size;
>  	write_seqcount_end(&part->nr_sects_seq);
> +	preempt_enable();
>  #elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPTION)
>  	preempt_disable();
>  	part->nr_sects = size;

This does look like something that include/linux/u64_stats_sync.h could
help with.
