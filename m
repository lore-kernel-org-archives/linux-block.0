Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92415C43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 19:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C4CA22DFB
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 19:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbhAZFbR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbhAYJUO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 04:20:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D746C061794;
        Mon, 25 Jan 2021 00:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j//jmpTMMIX1qFdQL7zVyhGRSx0ek9fg+isx268q0ig=; b=o6Qe0tEoHyLc+FhqyfnvQk7R3Z
        i7r6/HZ3NVNNSJkNE+XuQW/pekOqvJwaZskdSwSO5LoiWdvzvfnCXERRrWhE3T/MevKQZNz06AIe2
        0w8pyIRx8rykCCTs9oQ1Cl9PC1RsY3tDVbwkDuedlbVLk4ROBY2UFfHIyNBvN88RfFvId868G2rgQ
        g/Xw1jenZkNOXyL3h2yDo96cITqlov8ODmqUUoVzIYJIil+Rsx8Zg6ltixJHFw1vHklVPNprdzclZ
        EkNy9Czomc/7zgtUfjEg0KMst4wGRbX3g6pN/UGKMRQZ6/7OXeARKC2/lr9Bb6BcO0AGuMqQphzSh
        kEeP0Y+A==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l3xBu-003xca-6D; Mon, 25 Jan 2021 08:25:46 +0000
Date:   Mon, 25 Jan 2021 08:25:42 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/3] blk-mq: Always complete remote completions requests
 in softirq
Message-ID: <20210125082542.GC942655@infradead.org>
References: <20210123201027.3262800-1-bigeasy@linutronix.de>
 <20210123201027.3262800-3-bigeasy@linutronix.de>
 <30ce5ce2-8b9a-8873-4b37-c8720300942b@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30ce5ce2-8b9a-8873-4b37-c8720300942b@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 25, 2021 at 08:10:16AM +0100, Hannes Reinecke wrote:
> I don't get this.
> This code is about _avoiding_ having to raise a softirq if the driver
> exports more than one hardware queue.
> So where exactly does the remote CPU case come in here?

__blk_mq_complete_request_remote is only called for the case where we
do not completelky locally.  The case that "degrades" here is where
the device supports multiple queues, but less than the number of CPUs,
and we bounce the completion to another CPU.
