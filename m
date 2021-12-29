Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4ADC433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Dec 2021 17:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237501AbhL2R3H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Dec 2021 12:29:07 -0500
Received: from verein.lst.de ([213.95.11.211]:38284 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237519AbhL2R3H (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Dec 2021 12:29:07 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1229D68AFE; Wed, 29 Dec 2021 18:29:03 +0100 (CET)
Date:   Wed, 29 Dec 2021 18:29:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] make autoclear operation synchronous again
Message-ID: <20211229172902.GC27693@lst.de>
References: <03f43407-c34b-b7b2-68cd-d4ca93a993b8@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03f43407-c34b-b7b2-68cd-d4ca93a993b8@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The subject line is missing the loop: prefix.

This approach looks very reasonable, but a few comments below:

> -	lo->workqueue = alloc_workqueue("loop%d",
> -					WQ_UNBOUND | WQ_FREEZABLE,
> -					0,
> -					lo->lo_number);
> +	if (!lo->workqueue)
> +		lo->workqueue = alloc_workqueue("loop%d",
> +						WQ_UNBOUND | WQ_FREEZABLE,
> +						0, lo->lo_number);

Instead of having to deal with sometimes present workqueues, why
not move the workqueue allocation to loop_add?

> +	/* This is safe: open() is still holding a reference. */
> +	module_put(THIS_MODULE);

Any reason to move the module_put here insted of keeping it at the
end of the function as the old code did?
