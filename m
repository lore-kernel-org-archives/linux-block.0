Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1099C433F5
	for <linux-block@archiver.kernel.org>; Mon,  6 Dec 2021 06:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbhLFHCk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Dec 2021 02:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238108AbhLFHCh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Dec 2021 02:02:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF42EC0613F8
        for <linux-block@vger.kernel.org>; Sun,  5 Dec 2021 22:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+BOAN3MajWG3UifhMlaAFlqPqCWh8U9Hw0snqJXHzBY=; b=R1ZDUbR+v6mlr4x9UWWADG2y6a
        jQzvj66GeQ8PPEqmwN3jxaOY130f+NyfS2Vaem6GIpCVASGvzVjgMlR6FEkR8R3dIzs0wdjG35M2W
        deFjqn0f5tKuKBDkt21pMoCotYTtTV3o4kVTFtnGDYJg74yPoPLPPvlLGB+laY5pWMZlhDek1LSzM
        UH0TLUycm2dr73RaGX4nEwPSFepPl4yHfaDZQeY8DZhKoMvdhsjcP4W2l5RlJy8g5uOaoXIpVD1pN
        2Y9stFL3rJew57UoLE7Na6pOSfNtKTB08ypcw0D3gATOrzEdkGmr9gA44bgCqSVGnHnC9m5ra/ouK
        KK8CGsWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mu7xt-002itN-IN; Mon, 06 Dec 2021 06:59:09 +0000
Date:   Sun, 5 Dec 2021 22:59:09 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: avoid clearing blk_mq_alloc_data unnecessarily
Message-ID: <Ya20vUb8cldTe4kI@infradead.org>
References: <1ba89cb7-e53c-78c3-1fe4-db9908851e63@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ba89cb7-e53c-78c3-1fe4-db9908851e63@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 03, 2021 at 08:48:09AM -0700, Jens Axboe wrote:
> We already set almost all of what we need here, just the non-plug
> path needs to set nr_tags and clear cached.

How does this avoid clearing?  All partial initializers zero the rest of
the structure.
