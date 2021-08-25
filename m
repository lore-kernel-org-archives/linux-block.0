Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36988C4338F
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 13:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C3C6610CE
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 13:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbhHYNQI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Aug 2021 09:16:08 -0400
Received: from verein.lst.de ([213.95.11.211]:56174 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232589AbhHYNQI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Aug 2021 09:16:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 06FE86736F; Wed, 25 Aug 2021 15:15:20 +0200 (CEST)
Date:   Wed, 25 Aug 2021 15:15:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] nbd: Fix races introduced by nbd_index_mutex scope
 reduction
Message-ID: <20210825131519.GA19907@lst.de>
References: <40c3ff83-3fce-5408-9579-7df5f9999450@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40c3ff83-3fce-5408-9579-7df5f9999450@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Aug 22, 2021 at 12:46:29AM +0900, Tetsuo Handa wrote:
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> Only compile tested. This patch is a hint for Christoph Hellwig
> who needs to know what the global mutex was serializing...

Thanks a lot for your feedback.  Most of this looks good, except
for a few bits that could be done cleaner, and the fact that
we really should be using a global waitqueue instead of a completion.

Based on the recent syzbot report I'v reshuffled this and will send
a series in a bit.
