Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8682BC433EF
	for <linux-block@archiver.kernel.org>; Wed,  2 Mar 2022 08:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240082AbiCBIZY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Mar 2022 03:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240088AbiCBIZW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Mar 2022 03:25:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A4EB82CC
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 00:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5NrUbu+ZgnW71bJbKl1P9E2P/k29hNiu61f3MNYu8s4=; b=walHz4nY4MENYzILGeahdzACZr
        y5fHB9m48BvR4snejBmBsDjFvXVlJJcVi+v6PE5kpoC3Q0H66R8utodfy/oHi6lOo/pFQzK2ksq60
        IImmiNCd94WkYykOTPfT77rrJvwvsNOBEByRK5bG8LyksYLXQ47Zr3wOSQELDYiC6Tav/iofGT/fp
        E6Qd/1b76z67QOkTkgusSdLsQDZEYxaxWRiZ916MIp/nIDGwkGMW0vYUKUxRhVsDejBQhpi7Orf/e
        7a6DLqUS9C7PmEoCUmfq09MwkqjurgTjiwXhHycHsRCGvynZnm6gatWr/T36lnOUikWfTulVoK4vr
        QRjUSX6Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPKHj-001qr9-0C; Wed, 02 Mar 2022 08:24:35 +0000
Date:   Wed, 2 Mar 2022 00:24:34 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH 6/6] blk-mq: manage hctx map via xarray
Message-ID: <Yh8pwiR5DWC9ELDD@infradead.org>
References: <20220228090430.1064267-1-ming.lei@redhat.com>
 <20220228090430.1064267-7-ming.lei@redhat.com>
 <Yh4hjS0S3vXfLWlH@infradead.org>
 <Yh7RDCaqiqMmKj1s@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh7RDCaqiqMmKj1s@T590>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 02, 2022 at 10:06:04AM +0800, Ming Lei wrote:
> I did considered xa_for_each(), but it requires rcu read lock.

No, I doesn't.  It just takes a RCU lock internally.

> Also queue_for_each_hw_ctx() is supposed to not run in fast path,
> meantime xa_load() is lightweight enough too, so repeated xa_load()
> is fine here.

I'd rather have the clarity of the proper iterators.
