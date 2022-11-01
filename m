Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C27BC4332F
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 15:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiKAPOX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 11:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiKAPOD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 11:14:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6521EC73;
        Tue,  1 Nov 2022 08:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N7lnL7FHyu2J8E5a/w9v2ec/Wn33wozwDMPuPkUy2q4=; b=KEB9ZVg+nk0NWYtqmIE/B9+xzz
        vvTISzxF5kwQaIE9hX/ulRaA9e6sPR/LyMv3m81GplNEF07daeZ9IafejFcUwHsmH62VIxCOUFaEv
        mBTrPjBk/Jxaku3n7IfoDYFOt9AcPEcU9oYpwjvOrLkirpmeZKa6fiXkEljmjCUwmm6QnFRIQ//dA
        RW7kHWhjKSe4KMb9+vjPKSanFhaRuRD/9f7t28oo2GnZrg9/AS9rVcTxRbQuC9dSe75M0FabeXjUl
        rrDGRbgFwqvEyMQh82FVs55p4AjXGdvTKkZQbDLbQrS3Ey0Gqbb/b4VHtX5+fPNmnhTkXHqpq1geC
        1bCps7DA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opstk-005kZi-3u; Tue, 01 Nov 2022 15:09:52 +0000
Date:   Tue, 1 Nov 2022 08:09:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 1/7] block: Prevent the use of REQ_FUA with read
 operations
Message-ID: <Y2E2wFnbeUzAPjo0@infradead.org>
References: <20221031022642.352794-1-damien.lemoal@opensource.wdc.com>
 <20221031022642.352794-2-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031022642.352794-2-damien.lemoal@opensource.wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 31, 2022 at 11:26:36AM +0900, Damien Le Moal wrote:
> +	/*
> +	 * REQ_FUA does not apply to read requests because:
> +	 * - There is no way to reliably force media access for read operations
> +	 *   with a block device that does not support FUA.
> +	 * - Not all block devices support FUA for read operations (e.g. ATA
> +	 *   devices with NCQ support turned off).
> +	 */
> +	if (!op_is_write(rq->cmd_flags) && (rq->cmd_flags & REQ_FUA)) {
> +		blk_mq_end_request(rq, BLK_STS_NOTSUPP);

How could this even happen?  If we want a debug check,  I think it
should be in submit_bio and a WARN_ON_ONCE.
