Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10CAC4338F
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 05:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98D5960F25
	for <linux-block@archiver.kernel.org>; Wed,  4 Aug 2021 05:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbhHDFfn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Aug 2021 01:35:43 -0400
Received: from verein.lst.de ([213.95.11.211]:45953 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234557AbhHDFfn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Aug 2021 01:35:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2443B67373; Wed,  4 Aug 2021 07:35:28 +0200 (CEST)
Date:   Wed, 4 Aug 2021 07:35:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Martijn Coenen <maco@android.com>
Subject: Re: [PATCH v2 2/3] loop: Select I/O scheduler 'none' from inside
 add_disk()
Message-ID: <20210804053527.GA5711@lst.de>
References: <20210803182304.365053-1-bvanassche@acm.org> <20210803182304.365053-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803182304.365053-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 03, 2021 at 11:23:03AM -0700, Bart Van Assche wrote:
> We noticed that the user interface of Android devices becomes very slow
> under memory pressure. This is because Android uses the zram driver on top
> of the loop driver for swapping,

Sorry, but that is just amazingly stupid.  If you really want to swap
to compressed files introduce that support in the swap code instead of
coming up with dumb driver stacks from hell.
