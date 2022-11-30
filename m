Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9767C352A1
	for <linux-block@archiver.kernel.org>; Wed, 30 Nov 2022 15:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiK3Pz5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Nov 2022 10:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiK3Pzv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2022 10:55:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0830D81D9E;
        Wed, 30 Nov 2022 07:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rtn/WXCw0wV01K8XKJePt3vHFYfBvU4R/AXIM98Ihms=; b=yy2TohvPNBWn7ruaJrvJfv1ER8
        c0+MmIgJ9iTduM3PrmJ7tMWyiH2RLQ9ghj0MuDl4zW86cCDoGwPfQn0XN1E4DPKfdWef28YgT5B2o
        TcYI4KPhL24HRpqiqLrMfPtKoqZqu/izKuxYY+3SwBwfHxZNGnwDLczaDg3epW0Trs61x/pHosxWF
        m524O23xHwHZt0xA+IqftNKK0n1BWYd6m2RIr9AIpXfOZ+kOvOw/FABKYSPtxNq+uy4TXAsg2hFs4
        z17t24bY4u6mCpQrHQJeJyQLf8ygi9YlMtaPrqLqpV44Z5flNOXgXwNU1rWBgzRppEyRhfFL7h5m1
        ap77dYLg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p0PR4-000ANP-2U; Wed, 30 Nov 2022 15:55:46 +0000
Date:   Wed, 30 Nov 2022 07:55:46 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Li Nan <linan122@huawei.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v2 1/9] blk-iocost: cleanup ioc_qos_write() and
 ioc_cost_model_write()
Message-ID: <Y4d9AjL6BMbVSoUG@infradead.org>
References: <20221130132156.2836184-1-linan122@huawei.com>
 <20221130132156.2836184-2-linan122@huawei.com>
 <Y4d801NjwwT0voKA@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4d801NjwwT0voKA@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 30, 2022 at 07:54:59AM -0800, Christoph Hellwig wrote:
> > +	ret = nbytes;
> 
> ret is an int which bytes is a size_t.  So we at least need a ssize_t
> instead for ret, and even that assumes nbytes never overflows a ssize_t.

A better way might be to initialize ret to 0 at declaration time and
then do

	if (ret)
		return ret;
	return nbytes;
