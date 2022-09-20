Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D407DC6FA82
	for <linux-block@archiver.kernel.org>; Tue, 20 Sep 2022 07:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiITH2P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Sep 2022 03:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiITH2O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2022 03:28:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4E2108D
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 00:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lVy1sbKWY8zwbL5O7wDbJAjwxBvzi1Hjx2AKofExrCs=; b=uea5TIdcjoS2OZMpObMTIEMtBU
        F3Cs5F2v41whiVc8iUA8l2oGb3WJnFfQ5YN5f787Atqh7Rd3zwGkf9DU0UtYsk+ogceV3BgC8h71J
        5L9CFgKt94e0MbDOjFNjnOJIXfPdALjcFOgM3vHVodMsDyCbLouPFl5ku1UC70xN736Elx9D+/WPr
        tRfT+hV47ZyoiDfztFRrNFRk8NecmN9WW/b1UgorknqrmXAPzn3rqc8pZhKyADtbrHMqEmH6IUKqY
        95d2oAqlKxRVqVpoy7UmynDD5gm/xDIdJqTf9cONesTaOAetZn7ZefLX/3hvk1QTum8v63fHfsJ1r
        PGTZF+uQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaXfq-001M6r-Ux; Tue, 20 Sep 2022 07:28:06 +0000
Date:   Tue, 20 Sep 2022 00:28:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Zdenek Kabelac <zkabelac@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH 1/4] brd: make brd_insert_page return bool
Message-ID: <YylrhlggwZQ2STN1@infradead.org>
References: <alpine.LRH.2.02.2209151604410.13231@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2209160458590.543@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2209160458590.543@file01.intranet.prod.int.rdu2.redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 16, 2022 at 04:59:19AM -0400, Mikulas Patocka wrote:
> brd_insert_page returns a pointer to struct page, however the pointer is
> never used (it is only compared against NULL), so to clean-up the code, we
> make it return bool.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
