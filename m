Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8678FC43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 05:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiF2FvK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 01:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiF2FvK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 01:51:10 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58AA2A433
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 22:51:08 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4577B67373; Wed, 29 Jun 2022 07:51:05 +0200 (CEST)
Date:   Wed, 29 Jun 2022 07:51:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v3 8/8] nvme: Enable pipelining of zoned writes
Message-ID: <20220629055105.GA16576@lst.de>
References: <20220627234335.1714393-1-bvanassche@acm.org> <20220627234335.1714393-9-bvanassche@acm.org> <20220628044939.GA22504@lst.de> <858f5f5c-720a-d054-a409-b41c3cfb9717@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <858f5f5c-720a-d054-a409-b41c3cfb9717@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 28, 2022 at 09:30:09AM -0700, Bart Van Assche wrote:
> Regarding zoned writes in Linux, Android devices use F2FS. F2FS submits 
> regular writes (REQ_OP_WRITE) to zoned devices. Patch 4/8 from this patch 
> series disables zone locking in the mq-deadline scheduler if the block 
> driver has set the QUEUE_FLAG_PIPELINE_ZONED_WRITES flag.

Please fix f2fs to use zone appends rather than working around the stack.

