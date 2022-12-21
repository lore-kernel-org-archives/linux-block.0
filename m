Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77568C4332F
	for <linux-block@archiver.kernel.org>; Wed, 21 Dec 2022 10:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbiLUKqP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Dec 2022 05:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbiLUKqI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Dec 2022 05:46:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1369A6540
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2022 02:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NVvTHYKeGOdR2VjTX4ZINnL+ls5shgZj5qyaSyTHOso=; b=UjLea5MbYfKKu+BxOeWIyiUJOw
        y9PWEd7zrR35TmWg3MjBXnWhTlx6jvUlS6zpKKCqY+dxBMM4h0iqEuprKh5xoNJtxxAVkTiYySt6e
        LJcBlicIObQF8sZz/HLOy6xRfeQn5bsUXKA0s4ObcldaOp+Nxcwp+NbTntiarKkJArC5Wiy9kjl10
        kDWBqpLwhVbXAOtbeC92N03/syW8vIXNPsaJpZCYMPqUs2W5L97Xam62wLSHmeYa/Y9Rs3QIUglQd
        vACdyfk5f61E5w/8jNndzyqvnRmib1IqfWss/R5YGH9ehX7EEGcrVllLcQZ0bznb2wNYwsg+3quuC
        WerSqOzQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7wbl-00DefD-Vm; Wed, 21 Dec 2022 10:45:58 +0000
Date:   Wed, 21 Dec 2022 02:45:57 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, hch@infradead.org, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2 1/2] virtio-blk: set req->state to MQ_RQ_COMPLETE
 after polling I/O is finished
Message-ID: <Y6Lj5QcLFP87a4d9@infradead.org>
References: <20221220153613.21675-1-suwan.kim027@gmail.com>
 <20221220153613.21675-2-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220153613.21675-2-suwan.kim027@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 21, 2022 at 12:36:12AM +0900, Suwan Kim wrote:
> Driver should set req->state to MQ_RQ_COMPLETE after it finishes to process
> req. But virtio-blk doesn't set MQ_RQ_COMPLETE after virtblk_poll() handles
> req and req->state still remains MQ_RQ_IN_FLIGHT. Fortunately so far there
> is no issue about it because blk_mq_end_request_batch() sets req->state to
> MQ_RQ_IDLE.
> 
> In this patch, virblk_poll() calls blk_mq_complete_request_remote() to set
> req->state to MQ_RQ_COMPLETE before it adds req to a batch completion list.
> So it properly sets req->state after polling I/O is finished.
> 
> Fixes: 4e0400525691 ("virtio-blk: support polling I/O")
> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
