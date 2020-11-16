Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A89C2D0A3
	for <linux-block@archiver.kernel.org>; Mon, 16 Nov 2020 16:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07B5920E65
	for <linux-block@archiver.kernel.org>; Mon, 16 Nov 2020 16:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E0Mfs/V7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732355AbgKPQ60 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Nov 2020 11:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732311AbgKPQ6Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Nov 2020 11:58:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DC9C0613CF
        for <linux-block@vger.kernel.org>; Mon, 16 Nov 2020 08:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fyTdm50DEpkBv6NkUd/ozjg8TFltFwqYhQqiAma5mSw=; b=E0Mfs/V7bciUxr7RQ/4Z05DZpj
        vPqGHebCPLirOhtxUzxI+ff7UD8ZSHFCzK/GfA/nYSIRyIt9WA/10lMkz18K0i6CkdeOctfd6v1A7
        H1B9InCorPmvQHBm1NQWnt9Gbz3FErhu+o54LGUjyi/wkXou0H/NsBOM/xgw8kYDFSNRql9NdeZcT
        vLaDk4CMyCkzJzHIJq9NkUOTibIZ2wIjLFK/Em9HhV63ECt0gIHTPRCiKHEwPAhba9AT762ZCOROs
        7Zi86YlxBTG4a/udbyVdRsWW0gcLSnIiT6b+eljnUXQ2COTebHAACF7D3LDWZxudDeMpvDo7AStnV
        5kBXl98g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kehpf-0006MJ-Gt; Mon, 16 Nov 2020 16:58:23 +0000
Date:   Mon, 16 Nov 2020 16:58:23 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 3/9] block: Align max_hw_sectors to logical blocksize
Message-ID: <20201116165823.GA24227@infradead.org>
References: <20201111130049.967902-1-damien.lemoal@wdc.com>
 <20201111130049.967902-4-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111130049.967902-4-damien.lemoal@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 11, 2020 at 10:00:43PM +0900, Damien Le Moal wrote:
> Block device drivers do not have to call blk_queue_max_hw_sectors() to
> set a limit on request size if the default limit BLK_SAFE_MAX_SECTORS
> is acceptable. However, this limit (255 sectors) may not be aligned
> to the device logical block size which cannot be used as is for a
> request maximum size. This is the case for the null_blk device driver.
> 
> Modify blk_queue_max_hw_sectors() to make sure that the request size
> limits specified by the max_hw_sectors and max_sectors queue limits
> are always aligned to the device logical block size. Additionally, to
> avoid introducing a dependence on the execution order of this function
> with blk_queue_logical_block_size(), also modify
> blk_queue_logical_block_size() to perform the same alignment when the
> logical block size is set after max_hw_sectors.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
