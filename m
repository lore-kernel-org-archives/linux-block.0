Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D93BC433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 10:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B2960FD8
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 10:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhJRKWq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 06:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhJRKWp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 06:22:45 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBE5C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 03:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3UmdD2sEDFAh9eOU8uaGAMP4NRWtHfoSS9ZTrsKuAps=; b=Ww4+uQZx4hX/rnNFk994WDB6uo
        W8XgP7l31cmOwLKf6TeOuTYmBxOjB1gb88Tj36+ITkDl5Ej71tQJDnyXzFuvZV7p1qQM5FtBIBWeH
        M5mQ9sG/VHB79KjLmlKVx1fAauWRHwvtb+wJuv+AnXuUggqVSSJC7LvecmF2TCq0q8X0s+cnVUMmu
        ZiWV146YUljhi8631GECdW4ODq8BYN/8y7LtJTqFJkS/3Z/YWgucHQVeVL9icc21kcsFmPr49bRRm
        fP4cbxYKwh/X2hI+H404oHKmz9reeHgejamTNsyZ3MMgukq2FjWnhwQBuWpHZUUC2TL55HHfK/dV4
        lfHtOmUg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcPkw-00EyTk-PD; Mon, 18 Oct 2021 10:20:34 +0000
Date:   Mon, 18 Oct 2021 03:20:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 5/6] io_uring: utilize the io batching infrastructure for
 more efficient polled IO
Message-ID: <YW1KchZqw+a2s+4N@infradead.org>
References: <20211017020623.77815-1-axboe@kernel.dk>
 <20211017020623.77815-6-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017020623.77815-6-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 16, 2021 at 08:06:22PM -0600, Jens Axboe wrote:
> Wire up using an io_comp_batch for f_op->iopoll(). If the lower stack
> supports it, we can handle high rates of polled IO more efficiently.
> 
> This raises the single core efficiency on my system from ~6.1M IOPS to
> ~6.6M IOPS running a random read workload at depth 128 on two gen2
> Optane drives.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
