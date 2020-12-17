Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48BDC4361B
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 18:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EC29238EC
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 18:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgLQSmg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Dec 2020 13:42:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:49476 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728163AbgLQSmg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Dec 2020 13:42:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E38ADAD57;
        Thu, 17 Dec 2020 18:41:54 +0000 (UTC)
Date:   Thu, 17 Dec 2020 19:41:54 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/3] blk-mq: Always complete remote completions requests
 in softirq
Message-ID: <20201217184154.hn5pjiaasti3m7e7@beryllium.lan>
References: <20201204191356.2516405-1-bigeasy@linutronix.de>
 <20201204191356.2516405-3-bigeasy@linutronix.de>
 <de7f392a-fbac-f7bc-662a-5f40dd4c0aa6@kernel.dk>
 <20201208131319.GB22219@infradead.org>
 <20201217164308.ueki3scv3oxt4uta@linutronix.de>
 <e3ca3c82-cddc-ea06-39ae-48605abc77eb@kernel.dk>
 <20201217181639.byvly7dvpbdxmeu5@beryllium.lan>
 <1c11b5eb-4e3f-120e-2228-89f63c26bf29@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c11b5eb-4e3f-120e-2228-89f63c26bf29@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 17, 2020 at 11:22:58AM -0700, Jens Axboe wrote:
> Not only slightly hidden, b4 gets me v2 as well. Which isn't surprising,
> since it's just a patch in a reply. I'll fix it up, but would've been
> great if a v3 series had been posted, or at least a v3 of patch 3 in
> that thread sent properly.

Yep.

BTW, if you like you can add my

Reviewed-by: Daniel Wagner <dwagner@suse.de>

