Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D45C433FE
	for <linux-block@archiver.kernel.org>; Wed,  5 Jan 2022 18:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242734AbiAESSq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jan 2022 13:18:46 -0500
Received: from verein.lst.de ([213.95.11.211]:54117 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242824AbiAESSo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Jan 2022 13:18:44 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2B56268AFE; Wed,  5 Jan 2022 19:18:41 +0100 (CET)
Date:   Wed, 5 Jan 2022 19:18:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, mgurtovoy@nvidia.com
Subject: Re: [PATCHv3 3/4] block: introduce rq_list_move
Message-ID: <20220105181840.GB12168@lst.de>
References: <20220105170518.3181469-1-kbusch@kernel.org> <20220105170518.3181469-4-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105170518.3181469-4-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 05, 2022 at 09:05:17AM -0800, Keith Busch wrote:
> When iterating a list, a particular request may need to be moved for
> special handling. Provide a helper function to achieve that so drivers
> don't need to reimplement rqlist manipulation.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
