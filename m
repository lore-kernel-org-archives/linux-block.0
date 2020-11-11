Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3691DC388F9
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 08:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9D54206CA
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 08:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R0VJS8yn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgKKINv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 03:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKKINv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 03:13:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E7CC0613D1
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2020 00:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u7t/Y246OgwKTR5Xc/mNQIinG5fkUZhtFaxkGpTY5Ns=; b=R0VJS8yngSXJsIqhP7OtQ3/xKs
        Zw9ouHAo4JOQsceCkhXuOZP3R1XOjASrG1OZq9pAJpzC3mYw+cmbNnl5WLrnjCkq4aXf74IrrK9Vh
        mEwtYSI0V5R16EIksVI/Vjki+aSYwqqqp9gFwVopW34n71YOWDvj/7CVfNHxPz92c/QZ5U7jRvjR6
        x8xOU+O4UI71d8JxnjzX5i99SAnMnV0Nx2rhnRRXQKMmkis6yNEl8vqwHQvBVF5eeNVb4qSGBvpzt
        oueZEPgbb6qAdK1jVws29pyNIyMPqw0kMFSImx5TiDtyDIB8klYiI3y1Qfqjite8m00xOXJsSCbzg
        vKr0Lzng==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kclGH-0006bi-GW; Wed, 11 Nov 2020 08:13:49 +0000
Date:   Wed, 11 Nov 2020 08:13:49 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 6/9] null_blk: cleanup discard handling
Message-ID: <20201111081349.GE23360@infradead.org>
References: <20201111051648.635300-1-damien.lemoal@wdc.com>
 <20201111051648.635300-7-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111051648.635300-7-damien.lemoal@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 11, 2020 at 02:16:45PM +0900, Damien Le Moal wrote:
>  static inline blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd,
> -						     enum req_opf op)
> +						enum req_opf op, sector_t sector,

This adds an overly long line.

> +	if (op == REQ_OP_DISCARD) {
> +		null_handle_discard(dev, sector, nr_sectors);
> +		return 0;

Maybe add a return value to null_handle_discard to simplify this a bit?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
