Return-Path: <SRS0=GKfo=62=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC1CC54E8B
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 08:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D267206D6
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 08:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgELII0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 May 2020 04:08:26 -0400
Received: from verein.lst.de ([213.95.11.211]:39810 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgELIIZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 May 2020 04:08:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1BC1368BEB; Tue, 12 May 2020 10:08:21 +0200 (CEST)
Date:   Tue, 12 May 2020 10:08:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jim Paris <jim@jtan.com>, Geoff Levand <geoff@infradead.org>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-m68k@lists.linux-m68k.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-bcache@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: remove a few uses of ->queuedata
Message-ID: <20200512080820.GA2336@lst.de>
References: <20200508161517.252308-1-hch@lst.de> <CAPcyv4j3gVqrZWCCc2Q-6JizGAQXW0b+R1BcvWCZOvzaukGLQg@mail.gmail.com> <20200509082352.GB21834@lst.de> <CAPcyv4ggb7_rwzGbhHNXSHd+jjSpZC=+DMEztY6Cu8Bc=ZNzag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4ggb7_rwzGbhHNXSHd+jjSpZC=+DMEztY6Cu8Bc=ZNzag@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 09, 2020 at 08:07:14AM -0700, Dan Williams wrote:
> > which are all used in the I/O submission path (generic_make_request /
> > generic_make_request_checks).  This is mostly a prep cleanup patch to
> > also remove the pointless queue argument from ->make_request - then
> > ->queue is an extra dereference and extra churn.
> 
> Ah ok. If the changelogs had been filled in with something like "In
> preparation for removing @q from make_request_fn, stop using
> ->queuedata", I probably wouldn't have looked twice.
> 
> For the nvdimm/ driver updates you can add:
> 
>     Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> ...or just let me know if you want me to pick those up through the nvdimm tree.

I'd love you to pick them up through the nvdimm tree.  Do you want
to fix up the commit message yourself?
