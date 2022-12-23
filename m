Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B79C4332F
	for <linux-block@archiver.kernel.org>; Fri, 23 Dec 2022 05:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiLWFhZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Dec 2022 00:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiLWFhY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Dec 2022 00:37:24 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6DB38B1;
        Thu, 22 Dec 2022 21:37:23 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4771A6732D; Fri, 23 Dec 2022 06:37:19 +0100 (CET)
Date:   Fri, 23 Dec 2022 06:37:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de, john.garry@huawei.com
Subject: Re: [PATCH 01/13] blk-mq: avoid sleep in blk_mq_alloc_request_hctx
Message-ID: <20221223053718.GA2676@lst.de>
References: <20221223125223.1687670-1-shikemeng@huaweicloud.com> <20221223125223.1687670-2-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223125223.1687670-2-shikemeng@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 23, 2022 at 08:52:11PM +0800, Kemeng Shi wrote:
> +	if (WARN_ON_ONCE(((!flags) & (BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_RESERVED))))

This check does not make any sense.  I think what you want is

	if (WARN_ON_ONCE(!(flags & BLK_MQ_REQ_NOWAIT) ||
	    WARN_ON_ONCE(!(flags & BLK_MQ_REQ_RESERVED))))
