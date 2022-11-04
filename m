Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6D5C4332F
	for <linux-block@archiver.kernel.org>; Fri,  4 Nov 2022 05:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiKDFOm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Nov 2022 01:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiKDFOm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Nov 2022 01:14:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CDA126
        for <linux-block@vger.kernel.org>; Thu,  3 Nov 2022 22:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KtnH4lY7eWCbdXk4ptyVJPyTaXTOdaPt3O3731FV9hg=; b=hxMGLirp7MKACIB12emHuxiujU
        2pDG1iyhaNmYKrVJRaftU3JHA4Mfy8bXgylUnse7+1wXwUZK9686wuUbxw5+rU4mEF9fbUMEoj3r7
        CIwF/OMfM63VStvVHgIYlwdEdCr4t1XlhRH1vgGCREbuxzUE0BUM8JBOfnw6NO7cZHkT5vo+gkdGO
        VVfOjQ5SQ/x7aBpDiyQWpNDajd/YiyPX7rtYcQGt8MEqBQvTM8lo6FifkkheK6mpaBWh6ezV94G7+
        hR/GmKLV9k7T2wY3vj/diFfd1410serE39zs4NwFb1Ct2qjYedZ3YoBGc3551U1ZZ9cdAKKb7wZvJ
        cSJDAtkA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqp2M-002Q3k-4A; Fri, 04 Nov 2022 05:14:38 +0000
Date:   Thu, 3 Nov 2022 22:14:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com, axboe@kernel.dk,
        stefanha@redhat.com, ebiggers@kernel.org, me@demsh.org,
        mpatocka@redhat.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/3] block: make dma_alignment a stacking queue_limit
Message-ID: <Y2Sfvk1EtG9XwxPC@infradead.org>
References: <20221103152559.1909328-1-kbusch@meta.com>
 <20221103152559.1909328-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103152559.1909328-2-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 03, 2022 at 08:25:57AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Device mappers had always been getting the default 511 dma mask, but
> the underlying device might have a larger alignment requirement. Since
> this value is used to determine alloweable direct-io alignment, this
> needs to be a stackable limit.

This can also remove the just added blk_queue_dma_alignment in
nvme_mpath_alloc_disk again as it is right next to the
blk_set_stacking_limits call.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
