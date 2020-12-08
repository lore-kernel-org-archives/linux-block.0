Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B392C433FE
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 12:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2545223A52
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 12:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgLHMma (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 07:42:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:46266 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729217AbgLHMm3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Dec 2020 07:42:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A9FF9AC55;
        Tue,  8 Dec 2020 12:41:48 +0000 (UTC)
Date:   Tue, 8 Dec 2020 13:41:48 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/3] blk-mq: Always complete remote completions requests
 in softirq
Message-ID: <20201208124148.4dxdu6dp5m3mudff@beryllium.lan>
References: <20201204191356.2516405-1-bigeasy@linutronix.de>
 <20201204191356.2516405-3-bigeasy@linutronix.de>
 <de7f392a-fbac-f7bc-662a-5f40dd4c0aa6@kernel.dk>
 <20201208082220.hhel5ubeh4uqrwnd@linutronix.de>
 <20201208084409.koeftbpnvesp4xtv@beryllium.lan>
 <20201208113653.awqz4zggmy37vbog@beryllium.lan>
 <20201208114936.sfe2jpmbjulcpyjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208114936.sfe2jpmbjulcpyjk@linutronix.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 08, 2020 at 12:49:36PM +0100, Sebastian Andrzej Siewior wrote:
> On 2020-12-08 12:36:53 [+0100], Daniel Wagner wrote:
> > Obvious in this configuration there are no remote completions (verified
> > it).
> 
> do you complete on a remote CPU if you limit the queues to one (this is
> untested of course)?

nvme0n1/ completed   11913011 remote    6718563 56.40%

yes, but how is this relevant? I thought Jens complain was about the
additional indirection via the softirq context

-		rq->q->mq_ops->complete(rq);
+	blk_mq_trigger_softirq(rq);

and not the remote completion path. I can benchmark it out but I don't
know if it's really helping in the discussion.
