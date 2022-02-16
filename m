Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9BDC433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 07:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiBPHhZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 02:37:25 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiBPHhY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 02:37:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8017B188D6A
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 23:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9s2FbjeGq9Icm/leBeePGBy7havrRGubD+RzoFN8VFA=; b=g+FEGhDxmAVyC7b54WOLoLi179
        qTGTon6LKy7ucLIgc55FUkncea0leSf7O0hYIlOtvJy77GImaMm2XUMF8fY7rGJLj80lUJoId9xFi
        fQvJIQa29MQIx23fmWJEvJ21+04KiO7C2MqLIMFeJecQEMrHW293qnGN5eDUjslWpr7uc3OFOp2aF
        pv/NQuGa4sq9WgG/HwiaOu0Ruv6oZFuZzCFP56pzK0Qx/3o4u3iI0cZ9jcUm4p4GzV06vmZiZX3hN
        4POpipXNDep2R23nL+AqLHOrmFCL9VZsL6EC/DK1wk/Zvj+cRRmnZopxvnOIG22XdVtEVwosLKMib
        0ztywWvg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKErM-005rs5-KI; Wed, 16 Feb 2022 07:36:20 +0000
Date:   Tue, 15 Feb 2022 23:36:20 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Ning Li <lining2020x@163.com>, Tejun Heo <tj@kernel.org>,
        Chunguang Xu <brookxu@tencent.com>
Subject: Re: [PATCH V4 4/8] block: don't check bio in
 blk_throtl_dispatch_work_fn
Message-ID: <YgypdGchjWDwBaYs@infradead.org>
References: <20220216044514.2903784-1-ming.lei@redhat.com>
 <20220216044514.2903784-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216044514.2903784-5-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 16, 2022 at 12:45:10PM +0800, Ming Lei wrote:
> The bio has been checked already before throttling, so no need to check
> it again before dispatching it from throttle queue.
> 
> Add a helper of submit_bio_noacct_nocheck() for this purpose.

Reviewed-by: Christoph Hellwig <hch@lst.de>
