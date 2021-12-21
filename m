Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065C3C433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Dec 2021 16:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239591AbhLUQVs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Dec 2021 11:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236213AbhLUQVr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Dec 2021 11:21:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC50C061574
        for <linux-block@vger.kernel.org>; Tue, 21 Dec 2021 08:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QMre7yUdiStof2atRavqSpTRCc6/AnhtGt+tSsPd3MY=; b=e6utLqY6kTAViu0kjZBWn9FCY8
        CO3PbjwYjfVjEqZzalVtljhrMW7lUfROG5LF7f0fhLqLbx5m14XQVmYDW2s+KSNi1+bfKxJ8fvhS5
        pzKdTDajTaahR55SZbdVO58PIH3rbm1Cy6kIViPaVpZXLjofQWmW+E1bJILNkGl6tbQhwCzRND5KM
        UbYNdq/3lDqvEfjHIyLETIPUHOe/m7f3hvdIDSBwMub0K45Ux3t9zliwM9F3nZ47HGQJUew1rqzAL
        5TeoQUa9N25SuKeAYfvV/lJxhCvXsr9GgEk5yS0J16nPXxvATyWba8IO8YQ7U1IMl8B1Lc8eYIay2
        e1amTxMA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzhtT-007Xsf-Lh; Tue, 21 Dec 2021 16:21:39 +0000
Date:   Tue, 21 Dec 2021 08:21:39 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH 0/3] blk-mq/dm-rq: support BLK_MQ_F_BLOCKING for dm-rq
Message-ID: <YcH/E4JNag0QYYAa@infradead.org>
References: <20211221141459.1368176-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221141459.1368176-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 21, 2021 at 10:14:56PM +0800, Ming Lei wrote:
> Hello,
> 
> dm-rq may be built on blk-mq device which marks BLK_MQ_F_BLOCKING, so
> dm_mq_queue_rq() may become to sleep current context.
> 
> Fixes the issue by allowing dm-rq to set BLK_MQ_F_BLOCKING in case that
> any underlying queue is marked as BLK_MQ_F_BLOCKING.
> 
> DM request queue is allocated before allocating tagset, this way is a
> bit special, so we need to pre-allocate srcu payload, then use the queue
> flag of QUEUE_FLAG_BLOCKING for locking dispatch.

What is the benefit over just forcing bio-based dm-mpath for these
devices?
