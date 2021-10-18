Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC3EC433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 15:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1860E60720
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 15:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhJRPXC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 11:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbhJRPXB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 11:23:01 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB80C06161C;
        Mon, 18 Oct 2021 08:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qdA7CjRcPwCYtjVh9OqTBm4JHNI4+iblQ2/ftiRLpF8=; b=JTUHAgmN0hiAZHe2GoQqf+R9jx
        4uPdGgN0U5WR/ePhvqRSl5PDgT+RnmiGTNe/YSAVuHBPifjtWxq+5iiDxVNzSiiueAE477wozL/dB
        O3czChHOY8qQd6PIlnJt0h5GkyWfME/N+Jz38hoWX0qwhPGtD/UbHNwCFbT/4/7/0MhFJFp+igUGc
        xL5ZfkT60HSjyqhcF79iTA5/r7eLt6eI2qyTb3BVjNF4rXB5Gy0/m6QUaLCgpcYEfR4VAca6TufiA
        a4X54W/oIMF1xjGJuSnocRB/EYleuIzrCTxyq07tHpdaeKcJnEeldKixGm+GcY5mnzKjuQPBVKoZa
        PKQMSXrA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcURW-00GHYF-3g; Mon, 18 Oct 2021 15:20:50 +0000
Date:   Mon, 18 Oct 2021 08:20:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        tglx@linutronix.de, Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 1/2] blk-mq: Add blk_mq_complete_request_direct()
Message-ID: <YW2Q0ikJR13NWgGD@infradead.org>
References: <20211018135559.244400-1-bigeasy@linutronix.de>
 <20211018135559.244400-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018135559.244400-2-bigeasy@linutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 18, 2021 at 03:55:58PM +0200, Sebastian Andrzej Siewior wrote:
> +static inline void blk_mq_complete_request_direct(struct request *rq,
> +						  void (*complete)(struct request *rq))

Pleae avoid the overly long line.

ote that by doing the normal two tab indent for the continuation that
would be super trivial and way more readable.
