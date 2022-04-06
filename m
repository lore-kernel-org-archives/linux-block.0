Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD54C4332F
	for <linux-block@archiver.kernel.org>; Wed,  6 Apr 2022 09:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238480AbiDFJa5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Apr 2022 05:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354292AbiDFJZs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Apr 2022 05:25:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736E14767E3
        for <linux-block@vger.kernel.org>; Tue,  5 Apr 2022 22:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=2GBf4ZnnvBSpC2vVaeKLWh6Fik
        jb9DqD5QI2viAIC2x9E6pOAj0PnJKwpE8CztdAxzxN2/76E1RqrKxW9wq5sJfJ156Txhut0UCL6Rf
        fj0067jIm1eDFYCZCYO/hWRRCAoX2k3kHNhwxnzHBzbir62XWq/vb+HwIEpNkDPM+GFhp3qHJrq3h
        wL8ltm/ZxhvrempV78BtKAixfIAXqOGN3RATPtfcoBLb/IRi3P8KHaHqnptJJti2rOxd9PWnBUBVQ
        IFuo/O6eTqFR6sDC3RFZyZJKI3Z/Zc40C8Eh5gTwEuPzrZmytx+M5NqAcGhRGHZdKqFKnxdvv/j+M
        D0Fsw4rg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbxnI-003n2c-JX; Wed, 06 Apr 2022 05:01:24 +0000
Date:   Tue, 5 Apr 2022 22:01:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, mgurtovoy@nvidia.com, dongli.zhang@oracle.com,
        hch@infradead.org, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v5 2/2] virtio-blk: support mq_ops->queue_rqs()
Message-ID: <Yk0epKFLV6SdO+CM@infradead.org>
References: <20220405150924.147021-1-suwan.kim027@gmail.com>
 <20220405150924.147021-3-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405150924.147021-3-suwan.kim027@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
