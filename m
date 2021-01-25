Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4105C433E0
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 05:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2852229C4
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 05:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbhAZFbq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbhAYKAN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 05:00:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339FBC0617A9;
        Mon, 25 Jan 2021 00:33:26 -0800 (PST)
Date:   Mon, 25 Jan 2021 09:30:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611563429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fT0yLbgSHXoqxC+Ppvc+ZiBYpclK9xLccUp9T4OyAhY=;
        b=BemnhpDaK7krGlakrswG4b/fJb0d7BgwDGu88JGO2M+isSnyVoDKEmoMM6aSV0B0LOABcF
        KizpKLGwv2O49+9JMQRYLbM6MSz9FbJZJkryfJewzhBzkp90pWv2MQPychF7LvtcQtHwSr
        Rf6lJA9Owe3+mlHcHYG2FGDTYe7QyRNcLGo8FJl+wzksispK8c8fQyTWHz7kpW1SKKHErD
        TXOVq23qAbY6yCP1ZIbIUQXMRk/V8yhVbWRLS/WBpx5V268wwsBNp3YsCEUphps6UV+Woo
        +5zWXHXKI/60yQc2Z2o+7UIvyU8P4klBbu2MWR3H5jEcXhaeOeQtc2CIROhNWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611563429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fT0yLbgSHXoqxC+Ppvc+ZiBYpclK9xLccUp9T4OyAhY=;
        b=S2syWgU3yZgLg/oaHo2t20FatHzVXsIl9VXp9sdRxxBc0ky1BpeVBdetISF1tcmB303Ecv
        R6P97UX0GXtoGCDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/3] blk-mq: Always complete remote completions requests
 in softirq
Message-ID: <20210125083029.utnjqs2s3diqb5vx@linutronix.de>
References: <20210123201027.3262800-1-bigeasy@linutronix.de>
 <20210123201027.3262800-3-bigeasy@linutronix.de>
 <30ce5ce2-8b9a-8873-4b37-c8720300942b@suse.de>
 <20210125082542.GC942655@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210125082542.GC942655@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021-01-25 08:25:42 [+0000], Christoph Hellwig wrote:
> On Mon, Jan 25, 2021 at 08:10:16AM +0100, Hannes Reinecke wrote:
> > I don't get this.
> > This code is about _avoiding_ having to raise a softirq if the driver
> > exports more than one hardware queue.
> > So where exactly does the remote CPU case come in here?
> 
> __blk_mq_complete_request_remote is only called for the case where we
> do not completelky locally.  The case that "degrades" here is where
> the device supports multiple queues, but less than the number of CPUs,
> and we bounce the completion to another CPU.

Does it really "degrade" or just use the softirq more often? The usual
case is run the softirqs in irq_exit() which is just after IPI.

Sebastian
