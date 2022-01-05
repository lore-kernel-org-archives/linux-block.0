Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E5DC433F5
	for <linux-block@archiver.kernel.org>; Wed,  5 Jan 2022 18:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242817AbiAESSG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jan 2022 13:18:06 -0500
Received: from verein.lst.de ([213.95.11.211]:54110 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242799AbiAESSE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Jan 2022 13:18:04 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id A342C68AFE; Wed,  5 Jan 2022 19:17:59 +0100 (CET)
Date:   Wed, 5 Jan 2022 19:17:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, mgurtovoy@nvidia.com
Subject: Re: [PATCHv3 1/4] block: move rq_list macros to blk-mq.h
Message-ID: <20220105181759.GA12168@lst.de>
References: <20220105170518.3181469-1-kbusch@kernel.org> <20220105170518.3181469-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105170518.3181469-2-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 05, 2022 at 09:05:15AM -0800, Keith Busch wrote:
> Move the request list macros to the header file that defines that struct
> they operate on.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
