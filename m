Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8455C433EF
	for <linux-block@archiver.kernel.org>; Mon,  6 Dec 2021 06:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238189AbhLFHBj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Dec 2021 02:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238108AbhLFHBi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Dec 2021 02:01:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AE7C0613F8
        for <linux-block@vger.kernel.org>; Sun,  5 Dec 2021 22:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t59vrRjhc1dnfsnCGAwarRQWg1GUsm2sj5AUDx208yQ=; b=CTLKc5ypaxHsUEM4UFv/VWWR8e
        1Jjrns6f2qNN8sOL9F1zSimniu4P1k2mPD+dCHdOS+ql6bnlXpEx5AYEXwHY9HkC98X09sC6BDwp+
        xsGznbh+rmXA4rUMmHhTeL886rtkCan9QAkuy0LD/IU2QP9+jQ8mBFgJRiqoSPughYe/znuj24mH1
        5AEFWiWPgzVH6yqmAGfg2lLMRIYicsEyFAzQ+2RjRyCiES84jD8qiVDTn/JmjJP4MQXzD1IDj6kb2
        a1aanJ2FwHqMjtf/wD7ANRHnkkr3hht29gh9ypfa9s5jIj9E/0vLkG2xIsYvq3FPrpWq2yb9Oh/sZ
        qUHT8Mcg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mu7ww-002inz-DU; Mon, 06 Dec 2021 06:58:10 +0000
Date:   Sun, 5 Dec 2021 22:58:10 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] block: move direct_IO into our own read_iter handler
Message-ID: <Ya20gsKLF4eo4X/4@infradead.org>
References: <20211203153829.298893-1-axboe@kernel.dk>
 <20211203153829.298893-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203153829.298893-3-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 03, 2021 at 08:38:29AM -0700, Jens Axboe wrote:
> Don't call into generic_file_read_iter() if we know it's O_DIRECT, just
> set it up ourselves and call our own handler. This avoids an indirect call
> for O_DIRECT.
> 
> Fall back to filemap_read() if we fail.

Please also do it for the write side, having a partial ->direct_IO is a
really bad idea.
