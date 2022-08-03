Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36143C19F28
	for <linux-block@archiver.kernel.org>; Wed,  3 Aug 2022 17:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbiHCRax (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Aug 2022 13:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbiHCRao (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Aug 2022 13:30:44 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734BC13D32
        for <linux-block@vger.kernel.org>; Wed,  3 Aug 2022 10:30:43 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DA67E68AA6; Wed,  3 Aug 2022 19:30:37 +0200 (CEST)
Date:   Wed, 3 Aug 2022 19:30:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [GIT PULL] Block driver changes for 5.20-rc1
Message-ID: <20220803173037.GA20921@lst.de>
References: <87f60512-9242-49d1-eae1-394eb7a34760@kernel.dk> <CAHk-=wi+HuC_bs7VMTJSjp0vug9DRMY9+jKcsQryU9Eqofdxbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi+HuC_bs7VMTJSjp0vug9DRMY9+jKcsQryU9Eqofdxbg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 02, 2022 at 02:18:57PM -0700, Linus Torvalds wrote:
> This code cannot have gotten much testing at all.

[...]

> And no, I don't want some "fix up broken code after the fact" commit
> on top. I want that code excised, and I don't want to see another pull
> request before it's (a) gone and (b) somebody has looked at where the
> testing of this COMPLETELY failed.
> 

Umm.  The warning is as you said totally reasonable, and we fixed it as
soon as we got the report.  But it turns out my compiler certainly did
not report it (gcc version 10.2.1 20210110 (Debian 10.2.1-6)), Jens's
apparently also did not, and the regular build bot that is running on
tons of architectures did not report it until 9 days after the patch
was commited and pushed out, and until after Jens pulled it.

So while the complaint that we failed to get it into the same pull
request is entirely reasonable, the statement that it cannot have
gotten much testing at all is a bit ridiculous.  It's also not that
"I does not compile at all", but rather that -Werror makes a useful
but mostly harmless warning fatal.
