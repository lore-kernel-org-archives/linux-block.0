Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533E7C433F5
	for <linux-block@archiver.kernel.org>; Wed,  5 Jan 2022 18:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242826AbiAESTC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jan 2022 13:19:02 -0500
Received: from verein.lst.de ([213.95.11.211]:54118 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242799AbiAESS7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Jan 2022 13:18:59 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id F0FC868AFE; Wed,  5 Jan 2022 19:18:56 +0100 (CET)
Date:   Wed, 5 Jan 2022 19:18:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, mgurtovoy@nvidia.com
Subject: Re: [PATCHv3 4/4] nvme-pci: fix queue_rqs list splitting
Message-ID: <20220105181856.GC12168@lst.de>
References: <20220105170518.3181469-1-kbusch@kernel.org> <20220105170518.3181469-5-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105170518.3181469-5-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 05, 2022 at 09:05:18AM -0800, Keith Busch wrote:
> If command prep fails, current handling will orphan subsequent requests
> in the list. Consider a simple example:
> 
>   rqlist = [ 1 -> 2 ]
> 
> When prep for request '1' fails, it will be appended to the
> 'requeue_list', leaving request '2' disconnected from the original
> rqlist and no longer tracked. Meanwhile, rqlist is still pointing to the
> failed request '1' and will attempt to submit the unprepped command.
> 
> Fix this by updating the rqlist accordingly using the request list
> helper functions.
> 
> Fixes: d62cbcf62f2f ("nvme: add support for mq_ops->queue_rqs()")
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
