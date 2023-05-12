Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A465C77B75
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 14:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241064AbjELOce (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 10:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240646AbjELOcd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 10:32:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF85C1209C
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 07:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ns36MqEZYhZUGwQRVcFPJaU+UR93Jlmnff880GJ8W2s=; b=tJ5dtS5zseFHeEU8GJH3nUp6lT
        S4gDpKwk3xXibd7y7UDwD9h+H0L3PfcRxhYp9xTE6YIpfqFg6jTPok09JOVefqNWYCli8gulgSGnB
        S2betxGyNmW0Ojf/xuzaO0bzAz2VSoGgS2ttLBDEXEkZ0AwAetvbY7wBQZ5fUli2z6awdVi6S0WYu
        GV7gosRcrx2gmPtuvoPmNdgDx6zc6rYU6Dur3/fuwn3HRXZFupwQn0qkPsV1ByiZULgQiDzpTAJQp
        VC6Rpqy1MSWIHJugczeQuqML0+YhFeK7Noh67ACa3aqDDbtYtnHFatlV40tn79Q9177L9m6ttHS5l
        tg04nT9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pxToq-00CBZm-1b;
        Fri, 12 May 2023 14:32:28 +0000
Date:   Fri, 12 May 2023 07:32:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Chaitanya Kulkarni <kch@nvidia.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] zram: consolidate zram_bio_read()_zram_bio_write()
Message-ID: <ZF5N/Pg0f9bxhY2B@infradead.org>
References: <20230512082958.6550-1-kch@nvidia.com>
 <20230512082958.6550-3-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512082958.6550-3-kch@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 12, 2023 at 01:29:57AM -0700, Chaitanya Kulkarni wrote:
> zram_bio_read() and zram_bio_write() are 26 lines rach and share most of
> the code except call to zram_bdev_read() and zram_bvec_write() calls.
> Consolidate code into single zram_bio_rw() to remove the duplicate code
> and an extra function that is only needed for 2 lines of code :-

And it adds an extra conditional to every page in the fast path..
