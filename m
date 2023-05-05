Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEF4C77B7F
	for <linux-block@archiver.kernel.org>; Fri,  5 May 2023 05:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjEEFwR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 May 2023 01:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEEFwQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 May 2023 01:52:16 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C839F83EE
        for <linux-block@vger.kernel.org>; Thu,  4 May 2023 22:52:14 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DB65868AA6; Fri,  5 May 2023 07:52:10 +0200 (CEST)
Date:   Fri, 5 May 2023 07:52:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v4 02/11] block: Fix the type of the second
 bdev_op_is_zoned_write() argument
Message-ID: <20230505055210.GA11748@lst.de>
References: <20230503225208.2439206-1-bvanassche@acm.org> <20230503225208.2439206-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503225208.2439206-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
