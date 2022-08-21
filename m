Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8C9C00140
	for <linux-block@archiver.kernel.org>; Sun, 21 Aug 2022 05:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiHUFnQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Aug 2022 01:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiHUFnO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Aug 2022 01:43:14 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA0DB28
        for <linux-block@vger.kernel.org>; Sat, 20 Aug 2022 22:43:11 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 88BF968AA6; Sun, 21 Aug 2022 07:43:07 +0200 (CEST)
Date:   Sun, 21 Aug 2022 07:43:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v2 1/2] null_blk: Modify the behavior of
 null_map_queues()
Message-ID: <20220821054307.GA25702@lst.de>
References: <20220815170043.19489-1-bvanassche@acm.org> <20220815170043.19489-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815170043.19489-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
