Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3FCC432BE
	for <linux-block@archiver.kernel.org>; Sat, 28 Aug 2021 07:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8B45610A2
	for <linux-block@archiver.kernel.org>; Sat, 28 Aug 2021 07:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbhH1HTZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 Aug 2021 03:19:25 -0400
Received: from verein.lst.de ([213.95.11.211]:35873 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233348AbhH1HTZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Aug 2021 03:19:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DA01767373; Sat, 28 Aug 2021 09:18:32 +0200 (CEST)
Date:   Sat, 28 Aug 2021 09:18:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Hillf Danton <hdanton@sina.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] loop: replace loop_ctl_mutex with loop_idr_spinlock
Message-ID: <20210828071832.GA31755@lst.de>
References: <2642808b-a7d0-28ff-f288-0f4eabc562f7@i-love.sakura.ne.jp> <20210827184302.GA29967@lst.de> <73c53177-be1b-cff1-a09e-ef7979a95200@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73c53177-be1b-cff1-a09e-ef7979a95200@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Aug 28, 2021 at 10:10:36AM +0900, Tetsuo Handa wrote:
> That is, it seems that unregister_transfer_cb() is there in case forced module
> unload of cryptoloop module was requested. And in that case, there is no point
> with crashing the kernel via panic_on_warn == 1 && WARN_ON_ONCE(). Simple printk()
> will be sufficient.

If we have that case for forced module unload a WARN_ON is the right thing.
That being said we can simply do the cmpxchg based protection for that
case as well if you want to keep it.  That will lead to a spurious
loop remove failure with -EBUSY when a concurrent force module removal
for cryptoloop is happening, but if you do something like that you get
to keep the pieces.

> In order to annotate that extra operations that might sleep should not be
> added inside this section. Use of sleepable locks tends to get extra
> operations (e.g. wait for a different mutex / completion) and makes it unclear
> what the lock is protecting. I can imagine a future that someone adds an
> unwanted dependency inside this section if we use mutex here.
> 
> Technically, we can add preempt_diable() after mutex_lock() and
> preempt_enable() before mutex_unlock() in order to annotate that
> extra operations that might sleep should be avoided.
> But idr_alloc(GFP_ATOMIC)/idr_find()/idr_for_each_entry() etc. will be
> fast enough.

Well, split that into a cleanup patch if you think it is worth the
effort, with a good changelog.  Not really part of the bug fix.
