Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8FCC433FE
	for <linux-block@archiver.kernel.org>; Tue, 11 Oct 2022 06:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiJKGGq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Oct 2022 02:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJKGGq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Oct 2022 02:06:46 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3D68683F
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 23:06:45 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2AA4667373; Tue, 11 Oct 2022 08:06:41 +0200 (CEST)
Date:   Tue, 11 Oct 2022 08:06:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        damien.lemoal@opensource.wdc.com, johannes.thumshirn@wdc.com,
        bvanassche@acm.org, ming.lei@redhat.com,
        shinichiro.kawasaki@wdc.com, vincent.fu@samsung.com
Subject: Re: [RFC PATCH 0/6] block: add and use tagset init helper
Message-ID: <20221011060640.GA3121@lst.de>
References: <20221010170026.49808-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010170026.49808-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 10, 2022 at 10:00:20AM -0700, Chaitanya Kulkarni wrote:
> Hi,
> 
> The newly added helper blk_mq_init_alloc_tag_set() replaces existing
> call to blk_mq_alloc_tag_set() and takes following arguments to
> initialize tag_set before calling blk_mq_alloc_tag_set() :-

As said before I'm working on proper refcounting for the tagsets.
Please don't do arbitrary and somewhat questionable cleanups in this
area for now, thank you!
