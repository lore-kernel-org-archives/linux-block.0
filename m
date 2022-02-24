Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57105C433FE
	for <linux-block@archiver.kernel.org>; Thu, 24 Feb 2022 13:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbiBXNeo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Feb 2022 08:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbiBXNen (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Feb 2022 08:34:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E8B16DAF7
        for <linux-block@vger.kernel.org>; Thu, 24 Feb 2022 05:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FsO7bPKCV3C+M1TmyA8utq7bBJP2VWHvNICABqAl79U=; b=S7udAxLeP/5cwJAjGJh4uUL0Ry
        CcU+7HikmsczEpk++c4m8HqRS7wR08qeINQ8FJKz5mYPcL3oDMMTxGpc/vWlAjmKFWKTMz9N0SKmM
        BH8o4jn9w2gVBHn6lhKn7G7FOEWzDVkHbEFsMcUAU34NGYHXAGOu/cz7GEQmX09DadRgetvKqrOLH
        5H90zoraVUu6qPB1t+GTb+DPbVqF2yNoO5FGPpq9JWWdADWYa+BOxup3gZM44oC6ONha6VVhYBkx+
        ytuwHUnchJeSegXZo26fF3rxI5NQ/veEON4lUWRGmdNfdc3aKUe4gRZpyozB26wPVD2G9IQOZHa6Q
        o3NVLx+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNEG1-000x30-BW; Thu, 24 Feb 2022 13:34:09 +0000
Date:   Thu, 24 Feb 2022 05:34:09 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     mst@redhat.com, jasowang@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] virtio-blk: Check the max discard segment for discard
 request
Message-ID: <YheJUTK8BKCjEQYF@infradead.org>
References: <20220223133627.102-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223133627.102-1-xieyongji@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 23, 2022 at 09:36:27PM +0800, Xie Yongji wrote:
> Currently we have a BUG_ON() to make sure the number of sg list
> does not exceed queue_max_segments() in virtio_queue_rq().
> However, the block layer uses queue_max_discard_segments()
> instead of queue_max_segments() to limit the sg list for
> discard requests. So the BUG_ON() might be triggered if
> virtio-blk device reports a larger value for max discard
> segment than queue_max_segments(). To fix it, this patch
> checks the max discard segment for the discard request
> in the BUG_ON() instead.

This looks god, but jut removing the BUG_ON might be even better.
