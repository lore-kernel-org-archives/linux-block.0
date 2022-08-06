Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59247C25B06
	for <linux-block@archiver.kernel.org>; Sat,  6 Aug 2022 07:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241413AbiHFHoN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Aug 2022 03:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiHFHoM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Aug 2022 03:44:12 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BA411C30
        for <linux-block@vger.kernel.org>; Sat,  6 Aug 2022 00:44:11 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id ED66768AA6; Sat,  6 Aug 2022 09:44:06 +0200 (CEST)
Date:   Sat, 6 Aug 2022 09:44:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [GIT PULL] Block driver changes for 5.20-rc1
Message-ID: <20220806074406.GA12792@lst.de>
References: <87f60512-9242-49d1-eae1-394eb7a34760@kernel.dk> <CAHk-=wi+HuC_bs7VMTJSjp0vug9DRMY9+jKcsQryU9Eqofdxbg@mail.gmail.com> <20220803173037.GA20921@lst.de> <CAHk-=wggzgFLY1CgLgBRmmpz6s3ZmktV+-sFfBYWeiiBb0VXsQ@mail.gmail.com> <20220803174959.GB21218@lst.de> <CAHk-=wjoTqRLnmNVKvtCth7WCtCLXem9y4ZHx2tnsEcK01TToQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjoTqRLnmNVKvtCth7WCtCLXem9y4ZHx2tnsEcK01TToQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 03, 2022 at 10:54:50AM -0700, Linus Torvalds wrote:
> On Wed, Aug 3, 2022 at 10:50 AM Christoph Hellwig <hch@lst.de> wrote:
> > Because so far we've never made a big fuzz about a configuation
> > so obscrube that it takes build bot more than a week to find it.
> 
> That "obscure" config was a bog-standard "build the code".

With a new enough compiler that apparently very few other people, and
most importantly CI tools have.  Again, I'm not arguing this wasn't a
problem, but if there is a mismatch between what compiler you use and
most of the developers and CI infrastructure it isn't a case of
"code that isn't tested at all".
