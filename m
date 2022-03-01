Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0F3C433F5
	for <linux-block@archiver.kernel.org>; Tue,  1 Mar 2022 13:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiCANd1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Mar 2022 08:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiCANd0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Mar 2022 08:33:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3963A198
        for <linux-block@vger.kernel.org>; Tue,  1 Mar 2022 05:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6bAhMsa3i4AuRRZ6laTsHK3Uovgrfw6T0GBt4TW0834=; b=eHKOQpPzuodOiQHbdJ40wTnwxZ
        BvNCYap1sEfCLOZ2gL3f7Erw1ZHyAkZWq6n59Y6XK/BfimvkM1OP2GpIWa8zdVnk7KTQg4fYRf8T9
        JEu5gFfAymNs+myWocPIsQ/I8Jwcb3RPkypHOwsLo4GR2zWdBvpJSUhPCNBNmVv3B9eIXzUzHBzDi
        UBM9fRgVzXp1cfVpxuPlmZ/AtoGwsLW5enBPiluAw+QeTsSJ+2Jnw+2OhVe3RBd2yjT07pyOLfjaC
        bTVdiaTFcEjrkKBS0WHyexidqRxg2TCqNpQQL0y1SuEMD/WQ3ul3PUCXk651pvFBLnFWtyRH6tw0m
        DZlcNC1Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nP2cO-00Gv0r-5W; Tue, 01 Mar 2022 13:32:44 +0000
Date:   Tue, 1 Mar 2022 05:32:44 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH 4/6] block: mtip32xx: don't touch q->queue_hw_ctx
Message-ID: <Yh4gfFM5KZ/cWpk0@infradead.org>
References: <20220228090430.1064267-1-ming.lei@redhat.com>
 <20220228090430.1064267-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228090430.1064267-5-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 28, 2022 at 05:04:28PM +0800, Ming Lei wrote:
> q->queue_hw_ctx is really one blk-mq internal structure for retrieving
> hctx via its index, not supposed to be used by drivers. Meantime drivers
> can get the tags structure easily from tagset.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
