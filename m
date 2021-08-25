Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64516C4338F
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 14:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D0166109F
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 14:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240148AbhHYOTg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Aug 2021 10:19:36 -0400
Received: from verein.lst.de ([213.95.11.211]:56354 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241036AbhHYOTf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Aug 2021 10:19:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DD4D36736F; Wed, 25 Aug 2021 16:18:47 +0200 (CEST)
Date:   Wed, 25 Aug 2021 16:18:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] nbd: Fix races introduced by nbd_index_mutex scope
 reduction
Message-ID: <20210825141847.GA24740@lst.de>
References: <40c3ff83-3fce-5408-9579-7df5f9999450@i-love.sakura.ne.jp> <20210825131519.GA19907@lst.de> <16109a71-c366-b27e-8501-51e7fe950729@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16109a71-c366-b27e-8501-51e7fe950729@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 25, 2021 at 10:38:00PM +0900, Tetsuo Handa wrote:
> I guess you might want below diff, for reinit_completion() immediately after
> complete_all() likely resets completion count before all threads sleeping at
> wait_for_completion_timeout() check the completion count.
> Use of simple sequence count will be robuster.

Yes, this is very simple to what I have locally.
