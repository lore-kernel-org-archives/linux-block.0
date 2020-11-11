Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119D2C388F9
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 08:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65471206E3
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 08:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TdaeyMJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgKKIOm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 03:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgKKIOm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 03:14:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F460C0613D1
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2020 00:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lqG3yd/ZtlPxYSC4R57R3qblCvcZ4r75rIj7URvQcpk=; b=TdaeyMJ4y2HG5i8jQGx6R8pl21
        gs6P5r9kDUisUu/j/khzjJ9DqtbP95K4OGBV0QQJ6BobTj2mjd3LRkI+UBIw8/03FXPQzhr/lj75W
        iViCFQpgYEiLmt3cGCox2mXU1FXBpgqw/FkBHOcjzNs54RtnXyHl5MXOFFUx20ERBB1/QWav4MkAy
        8iJDMU7T2+tM2LP5+95O8QwJeH5jkEYgwngrt9fASSfl5Xi1hFloCCcFgR1EErlxkqAfJIc8kqZrv
        unQkhzZj3rinX56iYu+kUDi5+rwl3fNB3EqRNbGfvMRcw+uYpEXbU+vbXYy2S7GIJuBu/YeI50N1X
        eKVlsKrw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kclH7-0006eC-2Z; Wed, 11 Nov 2020 08:14:41 +0000
Date:   Wed, 11 Nov 2020 08:14:41 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 8/9] null_blk: Allow controlling max_hw_sectors limit
Message-ID: <20201111081441.GG23360@infradead.org>
References: <20201111051648.635300-1-damien.lemoal@wdc.com>
 <20201111051648.635300-9-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111051648.635300-9-damien.lemoal@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 11, 2020 at 02:16:47PM +0900, Damien Le Moal wrote:
> Add the module option and configfs attribute max_sectors to allow
> configuring the maximum size of a command issued to a null_blk device.
> This allows exercising the block layer BIO splitting with different
> limits than the default BLK_SAFE_MAX_SECTORS. This is also useful for
> testing the zone append write path of file systems as the max_hw_sectors
> limit value is also used for the max_zone_append_sectors limit.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
