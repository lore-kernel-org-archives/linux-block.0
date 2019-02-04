Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11F5C282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 08:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88726217D6
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 08:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfBDIZ2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:25:28 -0500
Received: from verein.lst.de ([213.95.11.211]:47476 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbfBDIZ2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Feb 2019 03:25:28 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 6D7D468D93; Mon,  4 Feb 2019 09:25:27 +0100 (CET)
Date:   Mon, 4 Feb 2019 09:25:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Zachary Hays <zhays@lexmark.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] mmc: block: handle complete_work on the system_highpri
 workqueue
Message-ID: <20190204082527.GA5953@lst.de>
References: <1548965800-3080-1-git-send-email-zhays@lexmark.com> <CAPDyKFpcmyKnF-QPBV1vbTfGdSYN30GayZSA5O9Gm_EbZjfdAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpcmyKnF-QPBV1vbTfGdSYN30GayZSA5O9Gm_EbZjfdAw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 04, 2019 at 07:24:43AM +0100, Ulf Hansson wrote:
> > The above results in multiple hung tasks that lead to failures to boot.
> >
> > Switching complete_work to the system_highpri queue avoids this
> > because system_highpri is not flagged with WQ_MEM_RECLAIM. This allows
> > the host to be released without getting blocked by other claims tasks.
> >
> 
> Thanks for fix and the detailed description to the problem!

I don't think this is correct, though.  If you think of the swap
(or memory reclaim of file backed pages) case on mmc, completing
a mmc request can very much be critical for completing that memory
reclaim.  Thus we absolutely do need a WQ_MEM_RECLAIM workqueue.
You probably want to create a private WQ_MEM_RECLAIM workqueue in the
mmc code for that.
