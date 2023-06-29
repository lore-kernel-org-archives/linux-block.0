Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5523FEB64D9
	for <linux-block@archiver.kernel.org>; Thu, 29 Jun 2023 05:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjF2F2d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jun 2023 01:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjF2F2c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2023 01:28:32 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B62130;
        Wed, 28 Jun 2023 22:28:32 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 57EBB67373; Thu, 29 Jun 2023 07:28:28 +0200 (CEST)
Date:   Thu, 29 Jun 2023 07:28:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, tj@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com,
        ming.lei@redhat.com, hch@lst.de
Subject: Re: [PATCH v3 1/3] blk-mq: always use __blk_mq_alloc_requests() to
 alloc and init rq
Message-ID: <20230629052828.GD16819@lst.de>
References: <20230628124546.1056698-1-chengming.zhou@linux.dev> <20230628124546.1056698-2-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628124546.1056698-2-chengming.zhou@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 28, 2023 at 08:45:44PM +0800, chengming.zhou@linux.dev wrote:
> After these cleanup, __blk_mq_alloc_requests() is the only entry to
> alloc and init rq.

I find the code a little hard to follow now, due to the optional
setting of the ctx.  We also introduce really odd behavior here
if the caller for a hctx-specific allocation doesn't have free
tags, as we'll now run into the normal retry path.

Is this really needed for your timestamp changes?  If not I'd prefer
to skip it.

