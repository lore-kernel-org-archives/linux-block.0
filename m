Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A15DC38142
	for <linux-block@archiver.kernel.org>; Tue, 31 Jan 2023 09:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjAaJKk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Jan 2023 04:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbjAaJKX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2023 04:10:23 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF31A1164F
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 01:07:31 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 07ECB68AA6; Tue, 31 Jan 2023 09:54:44 +0100 (CET)
Date:   Tue, 31 Jan 2023 09:54:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] block: Fix the blk_mq_destroy_queue() documentation
Message-ID: <20230131085442.GA3139@lst.de>
References: <20230130211233.831613-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130211233.831613-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 30, 2023 at 01:12:33PM -0800, Bart Van Assche wrote:
> Commit 2b3f056f72e5 moved a blk_put_queue() call from
> blk_mq_destroy_queue() into its callers. Reflect this change in the
> documentation block above blk_mq_destroy_queue().

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
