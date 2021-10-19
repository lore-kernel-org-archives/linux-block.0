Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA4EC433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 13:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F99960FDA
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 13:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbhJSNjC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 09:39:02 -0400
Received: from verein.lst.de ([213.95.11.211]:38330 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235743AbhJSNjC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 09:39:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EF9F268BEB; Tue, 19 Oct 2021 15:36:47 +0200 (CEST)
Date:   Tue, 19 Oct 2021 15:36:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH 2/2] block: attempt direct issue of plug list
Message-ID: <20211019133647.GB19216@lst.de>
References: <20211019120834.595160-1-axboe@kernel.dk> <20211019120834.595160-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019120834.595160-3-axboe@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 19, 2021 at 06:08:34AM -0600, Jens Axboe wrote:
> If we have just one queue type in the plug list, then we can extend our
> direct issue to cover a full plug list as well.

I don't think this description matches what the code does.  My impression
of what the code does it:

If a plug only has requests for a single queue, and that queue does not
use an I/O scheduler, we can just issue the list of requests directly
from the plug.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
