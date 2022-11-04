Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72430C4332F
	for <linux-block@archiver.kernel.org>; Fri,  4 Nov 2022 05:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiKDFPw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Nov 2022 01:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKDFPv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Nov 2022 01:15:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E8D126
        for <linux-block@vger.kernel.org>; Thu,  3 Nov 2022 22:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=hNIDIiFJ5iAx/npn+QbhR1WmnG
        A/cgNgx0UkGuxF6HuKhbJbVbeYJ2l/DcmK9Z0swdQKit1BnBTedN+USMULA/T5RivcKC5qsXWzhdl
        CdhzGBf4his3PzDkMai2/4HjhTBQX1kskkdR0daSZHFcHxZr14hKGhZxjH0EvtSxVULhxL36ubRpN
        3+GGIEs3+qXlhWUumMHjQQcwgAXR0c05sKi1wbAjswfFMKEqYxYwnjNGS6b4jso1ZA4gBYQrmySUu
        4IaP1WdXEhRZasUvYEAoQboEv1Ku7eW99Gj2ZdAGR0ZRIu7SwbL5L5F4P+dghXvGtEF37nZuG6OpJ
        Fy+TqOuA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqp3V-002QAJ-Pk; Fri, 04 Nov 2022 05:15:49 +0000
Date:   Thu, 3 Nov 2022 22:15:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com, axboe@kernel.dk,
        stefanha@redhat.com, ebiggers@kernel.org, me@demsh.org,
        mpatocka@redhat.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 3/3] block: make blk_set_default_limits() private
Message-ID: <Y2SgBQn64z251kge@infradead.org>
References: <20221103152559.1909328-1-kbusch@meta.com>
 <20221103152559.1909328-4-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103152559.1909328-4-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
