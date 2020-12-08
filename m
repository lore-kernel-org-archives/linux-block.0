Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6307BC4361B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 13:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2531823AAC
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 13:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgLHN2s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 08:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgLHN2s (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Dec 2020 08:28:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3870C061749
        for <linux-block@vger.kernel.org>; Tue,  8 Dec 2020 05:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6tiCfJR6aFRhnMavgF650rbdWkThuM/iydZa4685lL0=; b=FU07mVZBVFo+ZcUHkQRy4kXpvC
        H/W3hUTF9UCvT1swRftK51sx4qt1Rj/i3GntwKqrxELyL6Qc2BufqDdIyqrN54R3/R4619lsPpLLN
        XRZQDFeB1z2QFjrT/dWC5Z7A0E7PoROJnQg/2sqz7ePlncYjBOsyDEAKHKg9F4BXGedc8V6bN9vU7
        vuIowLGj0NLdLcD7TaxBsHliHidIJ1uS4oeMsxCxVmYEp7G8Tbsx598Ypn/WlrwOR1Pl1t79qekv2
        jVGINzRmn7obMBv385Z3MS8LcQRyLoXugrOgwzVdxMf4wVIUCDuhqzY+z0n5k0pSucnYxWcRT7RzO
        dLaPjfrA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmd2C-0006mr-Th; Tue, 08 Dec 2020 13:28:04 +0000
Date:   Tue, 8 Dec 2020 13:28:04 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>,
        Mike Galbraith <efault@gmx.de>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 3/3] blk-mq: Use llist_head for blk_cpu_done
Message-ID: <20201208132804.GA25284@infradead.org>
References: <20201204191356.2516405-1-bigeasy@linutronix.de>
 <20201204191356.2516405-4-bigeasy@linutronix.de>
 <20201208132004.GC22219@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208132004.GC22219@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just to clarify what I mean, I think the flow in
blk_mq_complete_request_remote should turn into something like:


	...

	if (rq->cmd_flags & REQ_HIPRI)
		return false;

	if (blk_mq_complete_need_ipi(rq))
		blk_mq_complete_send_ipi(rq);
		return true;
	}

	if (rq->q->nr_hw_queues == 1) {
		blk_mq_raise_softirq(rq);
		return true;
	}

	return false;
}
