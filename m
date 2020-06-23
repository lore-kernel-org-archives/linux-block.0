Return-Path: <SRS0=PrCR=AE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A6BC433E3
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 14:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C3912072E
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 14:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732734AbgFWOa2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:30:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:56320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732730AbgFWOa2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jun 2020 10:30:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 09A3BAD94;
        Tue, 23 Jun 2020 14:30:26 +0000 (UTC)
Date:   Tue, 23 Jun 2020 16:30:26 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] block: remove retry loop in ioc_release_fn()
Message-ID: <20200623143026.ei3z4wryjbqjdf2x@beryllium.lan>
References: <20200619151718.22338-1-john.ogness@linutronix.de>
 <20200619151718.22338-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619151718.22338-3-john.ogness@linutronix.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 19, 2020 at 05:23:18PM +0206, John Ogness wrote:
> The reverse-order double lock dance in ioc_release_fn() is using a
> retry loop. This is a problem on PREEMPT_RT because it could preempt
> the task that would release q->queue_lock and thus live lock in the
> retry loop.
> 
> RCU is already managing the freeing of the request queue and icq. If
> the trylock fails, use RCU to guarantee that the request queue and
> icq are not freed and re-acquire the locks in the correct order,
> allowing forward progress.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Again, after starring on it for while and reading up and down,
I'd say, it looks good. Also a quick test run with blktests and
lockdep enabled didn't produce any warnings.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
