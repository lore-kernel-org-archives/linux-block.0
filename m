Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F68C04A95
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 06:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbiI2Gze (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 02:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbiI2Gzd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 02:55:33 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124F86527A
        for <linux-block@vger.kernel.org>; Wed, 28 Sep 2022 23:55:31 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 65FDB68BFE; Thu, 29 Sep 2022 08:55:28 +0200 (CEST)
Date:   Thu, 29 Sep 2022 08:55:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     axboe@kernel.dk, hch@lst.de, damien.lemoal@opensource.wdc.com,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 1/2] block: adapt blk_mq_plug() to not plug for
 writes that require a zone lock
Message-ID: <20220929065528.GA31325@lst.de>
References: <20220929062425.91254-1-p.raghav@samsung.com> <CGME20220929062427eucas1p25a6efd73d6cdf8d481adb42f9d4006c3@eucas1p2.samsung.com> <20220929062425.91254-2-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929062425.91254-2-p.raghav@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 29, 2022 at 08:24:24AM +0200, Pankaj Raghav wrote:
> The current implementation of blk_mq_plug() disables plugging for all
> operations that involves a transfer to the device as we just check if
> the last bit in op_is_write() function.
> 
> Modify blk_mq_plug() to disable plugging only for REQ_OP_WRITE and
> REQ_OP_WRITE_ZEROS as they might require a zone lock.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
