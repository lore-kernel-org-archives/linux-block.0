Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EB7C433EF
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 06:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF4B661214
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 06:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbhKSGMG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Nov 2021 01:12:06 -0500
Received: from verein.lst.de ([213.95.11.211]:49917 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhKSGMC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Nov 2021 01:12:02 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2A08268AFE; Fri, 19 Nov 2021 07:08:58 +0100 (CET)
Date:   Fri, 19 Nov 2021 07:08:58 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] blk-mq: don't insert FUA request with data into
 scheduler queue
Message-ID: <20211119060857.GA15001@lst.de>
References: <20211118153041.2163228-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118153041.2163228-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 18, 2021 at 11:30:41PM +0800, Ming Lei wrote:
> We never insert flush request into scheduler queue before.
> 
> Recently commit d92ca9d8348f ("blk-mq: don't handle non-flush requests in
> blk_insert_flush") tries to handle FUA data request as normal request.
> This way has caused warning[1] in mq-deadline dd_exit_sched() or io hang in
> case of kyber since RQF_ELVPRIV isn't set for flush request, then
> ->finish_request won't be called.
> 
> Fix the issue by inserting FUA data request with blk_mq_request_bypass_insert()
> when the device supports FUA, just like what we did before.

How we did end up with REQ_ELV set for this request?
