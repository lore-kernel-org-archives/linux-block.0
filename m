Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9362C433FE
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 10:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD99F60FD8
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 10:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhJRKTL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 06:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhJRKTG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 06:19:06 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7388C0617AB
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 03:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JNkYBR1cUnWL9qB3sXUo+Ez1w3yqDn6fqjYIclntqoo=; b=FNoSMUIUdWJExxlEBtTC8aFNIf
        BLnfLY+A3UbEZat8dKrFHXL1G2fG8KN0DjkrY+cRCyPsLeWo6ecbwtfwILgC/aD5QiFwL7+R8p+ZW
        eec7PLlh4c545JEVg5h6QvUR4UZ7uBfNodUHa6JQFkH+yDlCKe8n6McecHigbYMM2Z+AIxeymPOST
        KDAvWCz3ZFNWfSpyDJzvZCyW/hB0ZFC4hYk7HRh8fiVVWVZkhXw6+nXt295YF0/w5RV6cCN6Ptnp7
        0ho5H/y7VsxZydlv5tPUaqnrLYrY92ov2GpcPmo/3nI/RZfrzoJongQzbwktk0VPRLx8o3AgDf72f
        fv2qwCSw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcPgk-00Ex0a-DI; Mon, 18 Oct 2021 10:16:14 +0000
Date:   Mon, 18 Oct 2021 03:16:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 1/6] block: add a struct io_comp_batch argument to
 fops->iopoll()
Message-ID: <YW1JbjL3LT6Ah/89@infradead.org>
References: <20211017020623.77815-1-axboe@kernel.dk>
 <20211017020623.77815-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017020623.77815-2-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> -int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, unsigned int flags)
> +int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, struct io_comp_batch *iob,

> +int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, struct io_comp_batch *iob,
> +		unsigned int flags);

> +	int (*iopoll)(struct kiocb *kiocb, struct io_comp_batch *, unsigned int flags);

Please avoid overly long lines like this.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
