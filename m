Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3713FC433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Dec 2021 17:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhL2RjG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Dec 2021 12:39:06 -0500
Received: from verein.lst.de ([213.95.11.211]:38313 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231466AbhL2RjG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Dec 2021 12:39:06 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9614568B05; Wed, 29 Dec 2021 18:39:02 +0100 (CET)
Date:   Wed, 29 Dec 2021 18:39:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCHv2 1/3] block: introduce rq_list_for_each_safe macro
Message-ID: <20211229173902.GA28058@lst.de>
References: <20211227164138.2488066-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227164138.2488066-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 27, 2021 at 08:41:36AM -0800, Keith Busch wrote:
> While iterating a list, a particular request may need to be removed for
> special handling. Provide an iterator that can safely handle that.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

(except for the fact that it, just like the other rq_list helpers
really should go into blk-mq.h, where all request related bits moved
early in this cycle)
