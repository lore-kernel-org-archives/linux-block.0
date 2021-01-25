Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F211EC433E0
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 19:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5EE222B3F
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 19:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbhAZFbB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbhAYJUO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 04:20:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D92C061220;
        Mon, 25 Jan 2021 00:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6x3jwWsE8Pp1a5Oj7dG5Rac0+wUmTjdtsRT6Ukvd5hQ=; b=UQ8+JK+C5EdxVY3h9h7kqA3yxq
        HcO3BJsbTUyaJU6LFWyBBlOSHzCtWbkEJGo+41AOwL/CIl5/c8XgOAaVylnjU7lflirCCksiS2ujD
        pbTzXbUR5YOy48DDHhmrxLlNqsR5zo0u4s/lO6/R1TL+91NfdAtrWWHlrT/txhfG8Qjna6qyOgqyH
        cPrth9syTOHeIujb9kKDlnkcUKHsKZJV0cksqMX088MxcSXh2qismrjgGUx1FrWYEbmbSXLVQCLuT
        x0O1Sfy6fKCTf5xaDI4YltHgAHtVEBRpDHUjDIeKF6pqUpDRsBwnQIYU2XV70jBklmMoPx+2X8BHf
        g+1GQqRg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l3xYb-003yxX-Jo; Mon, 25 Jan 2021 08:49:10 +0000
Date:   Mon, 25 Jan 2021 08:49:09 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/3] blk-mq: Always complete remote completions requests
 in softirq
Message-ID: <20210125084909.GA948851@infradead.org>
References: <20210123201027.3262800-1-bigeasy@linutronix.de>
 <20210123201027.3262800-3-bigeasy@linutronix.de>
 <20210125082259.GB942655@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125082259.GB942655@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 25, 2021 at 08:23:03AM +0000, Christoph Hellwig wrote:
> On Sat, Jan 23, 2021 at 09:10:26PM +0100, Sebastian Andrzej Siewior wrote:
> > Controllers with multiple queues have their IRQ-handelers pinned to a
> > CPU. The core shouldn't need to complete the request on a remote CPU.
> > 
> > Remove this case and always raise the softirq to complete the request.
> 
> What about changing blk_mq_trigger_softirq to take a void * argument
> and thus removing __blk_mq_complete_request_remote entirely?

I'll take this back - that change is in the way of what you do in patch
3.  So this looks good as-is:

Reviewed-by: Christoph Hellwig <hch@lst.de>
