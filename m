Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A644EC282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 14:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C262083B
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 14:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfBDO2x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:28:53 -0500
Received: from verein.lst.de ([213.95.11.211]:49103 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfBDO2x (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Feb 2019 09:28:53 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B9FE368D93; Mon,  4 Feb 2019 15:28:51 +0100 (CET)
Date:   Mon, 4 Feb 2019 15:28:51 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>, Zachary Hays <zhays@lexmark.com>,
        Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] mmc: block: handle complete_work on the system_highpri
 workqueue
Message-ID: <20190204142851.GA12581@lst.de>
References: <1548965800-3080-1-git-send-email-zhays@lexmark.com> <CAPDyKFpcmyKnF-QPBV1vbTfGdSYN30GayZSA5O9Gm_EbZjfdAw@mail.gmail.com> <20190204082527.GA5953@lst.de> <CAPDyKFoB+BV-ea4ctYixoJJvY=5f-NMm29iSTRTo5xbzKaPLgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoB+BV-ea4ctYixoJJvY=5f-NMm29iSTRTo5xbzKaPLgg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 04, 2019 at 01:30:37PM +0100, Ulf Hansson wrote:
> Although, I am not sure why having our own mmc workqueue, would fix
> this problem. Couldn't we hit the same kind of deadlock anyways you
> think?

Maybe I misunderstood the issue.  I thought the problem was that
the one rescuer kblockd thread is executing some block submission
work item, which is blocking because it waits for something in
completion handling.

Now with another workqueue we have two rescuer threads, one that
exectures all completions, which shouldn't depend on items in
the submission queue, and another one executing the block layer
submission, which might or might not depend on something happening
to another request in the completion workqueue.
