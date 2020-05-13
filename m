Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA74AC2D0FC
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 12:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE7A424927
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 12:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qY7ztIIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgEMM5V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 08:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbgEMM5V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 08:57:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B15C061A0C
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 05:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7DIlHnDqsqJI5UrLc69QEs+OXdxtRlXyjw0XKAVC5Tw=; b=qY7ztIImiZBMTD7Onif8PJC/6+
        M2444yx3ewXMW6kXdU02kF+tRl96Wuqi95rJMazUxX5bu3g7TOBs3FT1ix039LLr50yIcoQkKO2qV
        arOxM4N9Yv8oePRRY6lTw+IuiT8kiUqrrekyW1M5nrM9ssUaEi1qCOUFU/iSs+HSwXfxbYn7G8yOP
        Cv8YZQlpQW8UWPpwL42pIojW9jXPuepHPD9UpSrVnw55sZGDKGc8/HPEsyKhoKG9Z9l8z+tRb3wZE
        XO9CFs8iTvhfMvq3ucr5XcA4fyLLF79Lkv6+Vmct2BDC6O4zm0cGrOglYTZP6h5MhCUGbNqHQc5GU
        heuGDQYg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYqwq-0002TW-3z; Wed, 13 May 2020 12:57:20 +0000
Date:   Wed, 13 May 2020 05:57:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 7/9] blk-mq: remove dead check from
 blk_mq_dispatch_rq_list
Message-ID: <20200513125720.GG23958@infradead.org>
References: <20200513095443.2038859-1-ming.lei@redhat.com>
 <20200513095443.2038859-8-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513095443.2038859-8-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 13, 2020 at 05:54:41PM +0800, Ming Lei wrote:
> When BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE is returned from
> .queue_rq, the 'list' variable always holds this rq which isn't
> queued to LLD successfully.
> 
> So blk_mq_dispatch_rq_list() always returns false from the branch
> of '!list_empty(list)'.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
