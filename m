Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B9DC43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 06:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiF2GK7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 02:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiF2GKi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 02:10:38 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC8B1C925
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 23:10:37 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1AB2C67373; Wed, 29 Jun 2022 08:10:34 +0200 (CEST)
Date:   Wed, 29 Jun 2022 08:10:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v3 8/8] nvme: Enable pipelining of zoned writes
Message-ID: <20220629061033.GA16858@lst.de>
References: <20220627234335.1714393-1-bvanassche@acm.org> <20220627234335.1714393-9-bvanassche@acm.org> <20220628044939.GA22504@lst.de> <858f5f5c-720a-d054-a409-b41c3cfb9717@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <858f5f5c-720a-d054-a409-b41c3cfb9717@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[look like my previously reply accidentally lost the first half,
 so here is is]

On Tue, Jun 28, 2022 at 09:30:09AM -0700, Bart Van Assche wrote:
> Agreed that the NVMe specification allows to reorder outstanding commands. 
> Are there any NVMe controllers that do this if multiple zoned write 
> commands are outstanding for a single zone? I do not expect that an NVMe 
> controller would reorder write commands in such a way that an I/O error is 
> introduced.

NVMe not only allows reordering, but actually requires it due to the
round robin command arbitrary. Moreoever once you are on IP based
transports there is plenty of reordering that can and will go on before
even reaching the controller.
