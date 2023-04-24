Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895A9C77B61
	for <linux-block@archiver.kernel.org>; Mon, 24 Apr 2023 05:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjDXF4o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 01:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjDXF42 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 01:56:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0979540E3
        for <linux-block@vger.kernel.org>; Sun, 23 Apr 2023 22:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZX9Vh4doPoYSR1kfkWGTC9AbyNPTNXp09JPMVIBSC5s=; b=kZ6h2QKwpnetof32OqO6IE1iWr
        bLAO9ayYB09L9HJrk250nvoBfBZ0mQ+opjXy0cFCxyD8kFVBLF30cJTBWqwFRyTpVJGQw6CpwrZxl
        dxhPq23cLpKATHV2zwFQhaf/6IvSiOJ3YzenQ80PQk4phk4UwRkh5fIm/ALqSBhA8Bqo4mbyNnZ0d
        Zqmx3Bqtb865FhBPopJ2RMxAujt7PcvCgEe0aDIO1v1Uw0F3iCray5GzDeo5dgRk+LlGXPRz/tWXJ
        HhtYw/wUZMneHzatqPC2/hVdRfXe7VUmZrCZQEAQ8/gA2rSPGYUtmMHpnDZjlV9Mo2zArOvcXgI6t
        oKNlG5cg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pqp9V-00FPoz-1Q;
        Mon, 24 Apr 2023 05:54:17 +0000
Date:   Sun, 23 Apr 2023 22:54:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: Cleanup set_capacity()/bdev_set_nr_sectors()
Message-ID: <ZEYZiWPzuFdb8aS6@infradead.org>
References: <20230421043101.3079-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421043101.3079-1-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 21, 2023 at 01:31:01PM +0900, Damien Le Moal wrote:
> The code for setting a block device capacity (bd_nr_sectors field of
> struct block_device) is duplicated in set_capacity() and
> bdev_set_nr_sectors(). Clean this up by turning set_capacity() into an
> inline function calling bdev_set_nr_sectors() and move
> bdev_set_nr_sectors() code to block/bdev.c instead of having this
> function in block/partitions/core.c.

I don't think bdev_set_nr_sectors should be exported.  So given that
all this is a slow path anyway, please keep set_capacity out of
line as well and don't export bdev_set_nr_sectors.
