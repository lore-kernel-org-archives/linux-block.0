Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A0AC433F5
	for <linux-block@archiver.kernel.org>; Tue, 22 Feb 2022 16:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiBVQHS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Feb 2022 11:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbiBVQHR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Feb 2022 11:07:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF0B7B551
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 08:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=n30GkfiLdix3/NgMgoYO5myhD3
        eZ71hthpkys083yosMeBFiPzXNMxTIqZNK+NnFU4USjITUum+lwSyUjwZwCQyITtK9HpBOae4bfFW
        Lcz2RVoZzd2K1K7GSrOX0gxXTI/72GGwzAMI0s0cxsi21iSqM/dFVpaPmbW5RRir2010soc3LXXet
        T96/DEk+8YYO6UD3ISfRS9VDE9+HPzFT7Aev3GJGs9ohYyt+nT8ocYrZntHwA7sP5siJDmX/RrSME
        m2f1uwHJsAli/A3afIbJMi99HrzlC5pKuNrHaXoK+HW9BAPSSKl9pGOB+Dfs9Z5nxBpkGr0v8dvKi
        vcy4nLyg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMXgh-00AWyF-GD; Tue, 22 Feb 2022 16:06:51 +0000
Date:   Tue, 22 Feb 2022 08:06:51 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, ming.lei@redhat.com,
        damien.lemoal@wdc.com, shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH 2/2] null_blk: null_alloc_page() cleanup
Message-ID: <YhUKG/fQaYtrb+n7@infradead.org>
References: <20220222152852.26043-1-kch@nvidia.com>
 <20220222152852.26043-3-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222152852.26043-3-kch@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

