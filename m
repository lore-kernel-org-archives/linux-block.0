Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC5EC433E0
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 11:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD3DD2076B
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 11:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbhA0LYB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 06:24:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:40128 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236028AbhA0LX2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 06:23:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9512AAD26;
        Wed, 27 Jan 2021 11:22:45 +0000 (UTC)
Date:   Wed, 27 Jan 2021 12:22:45 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/3] blk-mq: Always complete remote completions requests
 in softirq
Message-ID: <20210127112245.3ce65mlhlzyfdmyv@beryllium.lan>
References: <20210123201027.3262800-1-bigeasy@linutronix.de>
 <20210123201027.3262800-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210123201027.3262800-3-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jan 23, 2021 at 09:10:26PM +0100, Sebastian Andrzej Siewior wrote:
> Controllers with multiple queues have their IRQ-handelers pinned to a
> CPU. The core shouldn't need to complete the request on a remote CPU.
> 
> Remove this case and always raise the softirq to complete the request.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
