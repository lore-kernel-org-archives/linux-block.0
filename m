Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF76C43387
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 13:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7C9206B6
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 13:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfAHNTP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:19:15 -0500
Received: from verein.lst.de ([213.95.11.211]:34220 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbfAHNTP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Jan 2019 08:19:15 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C4B3968DCF; Tue,  8 Jan 2019 14:19:13 +0100 (CET)
Date:   Tue, 8 Jan 2019 14:19:13 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Regression in v5.0-rc1: Panic at boot
Message-ID: <20190108131913.GA6677@lst.de>
References: <da851333-eadd-163a-8c78-e1f4ec5ec857@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da851333-eadd-163a-8c78-e1f4ec5ec857@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 07, 2019 at 12:41:06PM -0700, Logan Gunthorpe wrote:
> Hey,
> 
> I found a regression in v5.0-rc1 this morning. My system panics on boot.
> I've attached a log of the panic.
> 
> I bisected to find the problematic commit is:
> 
> Fixes: 9d037ad707ed ("block: remove req->timeout_list")
> 
> But it makes no sense to me why this commit would cause a problem like
> this. I've attached a bisect log. I've also tested v5.0-rc1 with this
> commit reverted and that boots fine.
> 
> The traceback seems to indicate the problem is on the bip_get_seed()
> line in t10_pi_complete(). Which suggests that bio_integrity() is
> returning NULL.

Very odd.  Can you try an experiment?  Can you add padding the size
of struct timer_list to struct request to check if that makes the
problem go away?  Then move the padding from the where the field
was to the end and see if that still "helps"?
