Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14D2C4338F
	for <linux-block@archiver.kernel.org>; Sun, 15 Aug 2021 07:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9D0E61038
	for <linux-block@archiver.kernel.org>; Sun, 15 Aug 2021 07:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbhHOHIA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Aug 2021 03:08:00 -0400
Received: from verein.lst.de ([213.95.11.211]:51233 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235664AbhHOHH5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Aug 2021 03:07:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1B2986736F; Sun, 15 Aug 2021 09:07:25 +0200 (CEST)
Date:   Sun, 15 Aug 2021 09:07:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: Re: [dm-devel] [PATCH 4/8] block: support delayed holder
 registration
Message-ID: <20210815070724.GA23276@lst.de>
References: <20210804094147.459763-1-hch@lst.de> <20210804094147.459763-5-hch@lst.de> <20210814211309.GA616511@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210814211309.GA616511@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Aug 14, 2021 at 02:13:09PM -0700, Guenter Roeck wrote:
> On Wed, Aug 04, 2021 at 11:41:43AM +0200, Christoph Hellwig wrote:
> > device mapper needs to register holders before it is ready to do I/O.
> > Currently it does so by registering the disk early, which can leave
> > the disk and queue in a weird half state where the queue is registered
> > with the disk, except for sysfs and the elevator.  And this state has
> > been a bit promlematic before, and will get more so when sorting out
> > the responsibilities between the queue and the disk.
> > 
> > Support registering holders on an initialized but not registered disk
> > instead by delaying the sysfs registration until the disk is registered.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Mike Snitzer <snitzer@redhat.com>
> 
> This patch results in lockdep splats when booting from flash.
> Reverting it fixes the proboem.

Should be fixed by:
https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.15/drivers&id=6e4df4c6488165637b95b9701cc862a42a3836ba
