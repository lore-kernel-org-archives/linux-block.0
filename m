Return-Path: <SRS0=q4M6=7R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B70BC433DF
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 22:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8EBB2074B
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 22:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgFDWuT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Jun 2020 18:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgFDWuT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Jun 2020 18:50:19 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECCFC08C5C0;
        Thu,  4 Jun 2020 15:50:19 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3642E120ED481;
        Thu,  4 Jun 2020 15:50:17 -0700 (PDT)
Date:   Thu, 04 Jun 2020 15:50:16 -0700 (PDT)
Message-Id: <20200604.155016.1381130025313726200.davem@davemloft.net>
To:     a.darwish@linutronix.de
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        tglx@linutronix.de, paulmck@kernel.org, bigeasy@linutronix.de,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
        edumazet@google.com, axboe@kernel.dk, vgoyal@redhat.com,
        linux-block@vger.kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 0/6] seqlock: seqcount_t call sites bugfixes
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200603144949.1122421-1-a.darwish@linutronix.de>
References: <20200603144949.1122421-1-a.darwish@linutronix.de>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 04 Jun 2020 15:50:18 -0700 (PDT)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: "Ahmed S. Darwish" <a.darwish@linutronix.de>
Date: Wed,  3 Jun 2020 16:49:43 +0200

> Since patch #7 and #8 from the series:
> 
>    [PATCH v1 00/25] seqlock: Extend seqcount API with associated locks
>    https://lore.kernel.org/lkml/20200519214547.352050-1-a.darwish@linutronix.de
> 
> are now pending on the lockdep/x86 IRQ state tracking patch series:
> 
>    [PATCH 00/14] x86/entry: disallow #DB more and x86/entry lockdep/nmi
>    https://lkml.kernel.org/r/20200529212728.795169701@infradead.org
> 
>    [PATCH v3 0/5] lockdep: Change IRQ state tracking to use per-cpu variables
>    https://lkml.kernel.org/r/20200529213550.683440625@infradead.org
> 
> This is a repost only of the seqcount_t call sites bugfixes that were on
> top of the seqlock patch series.
> 
> These fixes are independent, and can thus be merged on their own. I'm
> reposting them now so they can at least hit -rc2 or -rc3.
> 
> Changelog-v2:
> 
>   - patch #1: Add a missing up_read() on netdev_get_name() error path
>               exit. Thanks to Dan/kbuild-bot report.
> 
>   - patch #4: new patch, invalid preemptible context found by the new
>               lockdep checks added in the seqlock series + kbuild-bot.

I'll apply patches 1-4 to the net tree.
