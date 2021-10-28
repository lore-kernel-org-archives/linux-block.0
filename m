Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F82C433EF
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 15:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41E0360527
	for <linux-block@archiver.kernel.org>; Thu, 28 Oct 2021 15:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhJ1PVV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Oct 2021 11:21:21 -0400
Received: from verein.lst.de ([213.95.11.211]:42409 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230225AbhJ1PVU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Oct 2021 11:21:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0194A68BEB; Thu, 28 Oct 2021 17:18:51 +0200 (CEST)
Date:   Thu, 28 Oct 2021 17:18:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Alexander V. Buev" <a.buev@yadro.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mikhail Malygin <m.malygin@yadro.com>, linux@yadro.com
Subject: Re: [PATCH 0/3] implement direct IO with integrity
Message-ID: <20211028151851.GC9468@lst.de>
References: <20211028112406.101314-1-a.buev@yadro.com> <bc336e90-378e-6016-ea1c-d519290dce5f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc336e90-378e-6016-ea1c-d519290dce5f@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 28, 2021 at 09:13:07AM -0600, Jens Axboe wrote:
> A couple of suggestions on this:
> 
> 1) Don't think we need an IOSQE flag, those are mostly reserved for
>    modifiers that apply to (mostly) all kinds of requests
> 2) I think this would be cleaner as a separate command, rather than
>    need odd adjustments and iov assumptions. That also gets it out
>    of the fast path.
> 
> I'd add IORING_OP_READV_PI and IORING_OP_WRITEV_PI for this, I think
> you'd end up with a much cleaner implementation that way.

Agreed.  I also wonder if we could do saner paramter passing.
E.g. pass a separate pointer to the PI data if we find space for
that somewhere in the SQE.
