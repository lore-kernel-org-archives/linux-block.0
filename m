Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854E0C433F5
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 05:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C57F611EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 05:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhJSGBn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 02:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhJSGBn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 02:01:43 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29477C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 22:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uqBpNvwozqpO5cJevDam9cIk3h5aolQx4t+cN7rWris=; b=jY9el7/rZaI3/HiNpp7kro4g6G
        FlH0nm3NMJCXDpUagWvR/e+sRv+vnsbPcz6Mg4hf+pJhQg9rZcT8rjL+xDO5Dk+Z1kSDw/NKbKUjX
        +LYm1PgJEelRzDovSwjj099deNTVfG0d42JYXuKhnVuwswSTImO3c5KisRoJsrUZSjAVhcVr7AmGj
        9je20xKiLj95wlbSS5FU/m2uONGKwzAk9GwuHvTZfuWXSVHEVCNYBa6PyPumBajD2xBUgODkWwbPe
        eBhbEbIVMwpFOJhF/eYS9w0jDvcuPXAVR98krN6jxcY9WOBToy/eIM9iV0GuSfxlHcoVsc75SLMkd
        iqVCLgbw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mci9q-000Dmi-Ib; Tue, 19 Oct 2021 05:59:30 +0000
Date:   Mon, 18 Oct 2021 22:59:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: move bdev_read_only() into the header
Message-ID: <YW5ewrzjVuqEtPaC@infradead.org>
References: <b737f789-6a1a-19e2-7c1c-6d9d24447af1@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b737f789-6a1a-19e2-7c1c-6d9d24447af1@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 18, 2021 at 11:44:39AM -0600, Jens Axboe wrote:
> This is called for every write in the fast path, move it inline next
> to get_disk_ro() which is called internally.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
