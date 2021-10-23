Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E43AC433EF
	for <linux-block@archiver.kernel.org>; Sat, 23 Oct 2021 04:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEF1E60FC1
	for <linux-block@archiver.kernel.org>; Sat, 23 Oct 2021 04:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhJWEmw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Oct 2021 00:42:52 -0400
Received: from verein.lst.de ([213.95.11.211]:52114 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhJWEmv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Oct 2021 00:42:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A1D9B68BEB; Sat, 23 Oct 2021 06:40:29 +0200 (CEST)
Date:   Sat, 23 Oct 2021 06:40:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: please revert the UFS HPB support
Message-ID: <20211023044029.GA21338@lst.de>
References: <20211021144210.GA28195@lst.de> <yq1ilxp68x3.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq1ilxp68x3.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 22, 2021 at 09:54:44PM -0400, Martin K. Petersen wrote:
> The series went through 40 iterations on the list prior to being merged.
> I don't recall a better approach to reconcile the HPB model with the
> stack being offered during that process?
> 
> As much as I don't like HPB, all the major UFS subsystem stakeholders
> are behind it. The hardware is shipping and various device stacks
> already adopted support for it. At this stage I don't think dropping the
> code is a way forward. I am much more in favor of having a productive
> discussion about how to go about addressing the problems with the
> queuing model...

This is іs not about HPB about a feature beeing a bad idea.  I explained
that at least a dozend times, and there's been no sensible counter
arguments to that but it has been merged anyway.  (FYI Zoned devices
are the obvious and old answer).

But this implementation is simply completely broken from the block
layer POV and we must not release a kernel with that brokenness in it.
