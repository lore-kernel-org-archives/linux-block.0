Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE224C433ED
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 06:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF31611AC
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 06:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhEFGpm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 02:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhEFGpl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 May 2021 02:45:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29CFC061574
        for <linux-block@vger.kernel.org>; Wed,  5 May 2021 23:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AJBkgynH4O1tEwRF65H4ui0Ot1ElG6tis7tMjIF5rPw=; b=g1T7uyFR1NcxWAgQQxQYJmVMJw
        N/dB0hw3QUJCGVTVJezmDDyF6NbJN00cdWB5ICTg3aYF03VK16uDzphy2pBH352WHBEx44gbi+BrW
        II8DPjRmUfWYs1EUILZdJ0bHmFedqFSp3LwbbO5epRC0o7SEjWhH2k/6aHHuVwWkGG7VQ+J83GvTq
        Cm8NxBAzXn8K9aFEWuCaSTMmF+Gr+bkwAHNa42S2l08YhimLAmPcDDDYJOQNfaVZhPm3t8WQa4Cx5
        9CUNcKRjYtWxs9wAUe03HpZbC0VZ8NWRoZpWqQ1Z2kuMsZAXltK2nUbxnGHW598oTsa1+6YR6qLEx
        P/zFunxg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leXkB-001O4a-Co; Thu, 06 May 2021 06:44:22 +0000
Date:   Thu, 6 May 2021 07:44:19 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
Subject: Re: [PATCH V5 1/4] block: avoid double io accounting for flush
 request
Message-ID: <20210506064419.GB328487@infradead.org>
References: <20210505145855.174127-1-ming.lei@redhat.com>
 <20210505145855.174127-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505145855.174127-2-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 05, 2021 at 10:58:52PM +0800, Ming Lei wrote:
> For flush request, rq->end_io() may be called two times, one is from
> timeout handling(blk_mq_check_expired()), another is from normal
> completion(__blk_mq_end_request()).
> 
> Move blk_account_io_flush() after flush_rq->ref drops to zero, so
> io accounting can be done just once for flush request.
> 
> Fixes: b68663186577 ("block: add iostat counters for flush requests")
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Tested-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Alhought while reviewing this I have to say that the flush code is
one hard to follow mess, and the extra reference doesn't help..
