Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12D4C3DA6E
	for <linux-block@archiver.kernel.org>; Fri, 23 Dec 2022 08:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiLWIBp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Dec 2022 03:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiLWIBo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Dec 2022 03:01:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8573631DCB;
        Fri, 23 Dec 2022 00:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dccRK/NCh2GPqlv5x5YSRv6i4zId2ndL7dnL9XPRIwQ=; b=ahiFQR4cd0+5AYmdeV9wNir9tD
        TSoYeBf7IpEs0EIV1w0GpezPG6sJmCJjVz+H6aPBk1DxF4RLmLoO+t8W0WDQM0MdWXSv5hah4+mJj
        E7hVGCKoxvxYiDbTwhianbNH1SbD8PrQlZYIAbIxjrsBW+7MhEqfZihawAq32z0LGO7ylHuqygGEz
        RhqH7agivE+HZikkX+Ge2jl/IW2eNBrWmSDNa3HtIL4Dpq5czxtBShAaQWiAhqX9pgVuWxqReBfFq
        O3DRD4YoP5crjYhUClUKolKQdAVXZ1Yw7ENl27MCTcD/YgFuiUizkEHbZXr1sOGAZxwC5+7zr9V2h
        bYbQ69dA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8czr-0051zM-Ox; Fri, 23 Dec 2022 08:01:39 +0000
Date:   Fri, 23 Dec 2022 00:01:39 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Zhong Jinghua <zhongjinghua@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH-next v2] blk-mq: cleanup unused methods:
 blk_mq_hw_sysfs_store
Message-ID: <Y6VgY5hazTxxiyCt@infradead.org>
References: <20221221083421.786849-1-zhongjinghua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221083421.786849-1-zhongjinghua@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 21, 2022 at 04:34:21PM +0800, Zhong Jinghua wrote:
> We found that the blk_mq_hw_sysfs_store interface has no place to use.
> The object default_hw_ctx_attrs using blk_mq_hw_sysfs_ops only uses
> the show method and does not use the store method.
> 
> Since this patch:
> 4a46f05ebf99 ("blk-mq: move hctx and ctx counters from sysfs to debugfs")
> moved the store method to debugfs, the store method is not used anymore.
> 
> So let me do some tiny work to clean up unused code.

Please also remove the now unused store method from
struct blk_mq_hw_ctx_sysfs_entry.
