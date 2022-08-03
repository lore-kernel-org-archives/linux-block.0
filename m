Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6714FC19F28
	for <linux-block@archiver.kernel.org>; Wed,  3 Aug 2022 17:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236781AbiHCRuF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Aug 2022 13:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbiHCRuE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Aug 2022 13:50:04 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8924B0FA
        for <linux-block@vger.kernel.org>; Wed,  3 Aug 2022 10:50:03 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 992A068AA6; Wed,  3 Aug 2022 19:49:59 +0200 (CEST)
Date:   Wed, 3 Aug 2022 19:49:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [GIT PULL] Block driver changes for 5.20-rc1
Message-ID: <20220803174959.GB21218@lst.de>
References: <87f60512-9242-49d1-eae1-394eb7a34760@kernel.dk> <CAHk-=wi+HuC_bs7VMTJSjp0vug9DRMY9+jKcsQryU9Eqofdxbg@mail.gmail.com> <20220803173037.GA20921@lst.de> <CAHk-=wggzgFLY1CgLgBRmmpz6s3ZmktV+-sFfBYWeiiBb0VXsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wggzgFLY1CgLgBRmmpz6s3ZmktV+-sFfBYWeiiBb0VXsQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 03, 2022 at 10:42:32AM -0700, Linus Torvalds wrote:
> Warnings are fatal. Deal with it. If you think it's ok to have
> warnings in your code, go do another project.

Please stop this BS.  I'm the first one to fix every single warning
reported, because I absoutely want warning free code to see problems.
But that does not mean it is "fatal".  It is bad and should go away
by either fixing the code, or if the warning is too broken disable
it in the compiler.  But that does not in any way mean code that
creates warning on some compilers is completely untested and by
definition broken.

We've fixed the warning the day it was reported because of just that,
and we'd always do.  But that doesn't make it whole giant drama.

> The fact is, apparently -Werror _did_ find it, and the people involved

There is nothing about Werror breaking it.  The buildbot reported it,
and that usually reports warnings and errors, so it did not make any
difference.

> I want whatever went wrong in that process fixed. Why did you make a
> pull request to Jens, and then never notified him about the problems
> in it?

Because so far we've never made a big fuzz about a configuation
so obscrube that it takes build bot more than a week to find it.  We
just fix it and go on with life.  But now that I see that you somehow
see it a personal insult I'll be more careful about it.  But to be
honest, while I agree with you 100% that code should be warning free
I'm really amazed about all the drama this created.
