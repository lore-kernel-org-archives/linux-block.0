Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335D7C433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 09:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D76060FC3
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 09:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhJRJYV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 05:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhJRJYU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 05:24:20 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D8DC06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 02:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=Q8P7aSjYvQxE4eNb0jRmzZxCic
        gKpr3MHWhV8LjvRqGHszWGBUSe1h0+8wH+J385x5puh796cimPIvMQXJ4G2UI4i0z44MdwWjZhDZ8
        1woZiN6FzDDmooKoUxKLDOT+TbKkMVlI0hVN0lPoSlJylVnyAoMVZgwOeZucwwxy9bvcZPyI6nfHW
        X4laiwWb9y1ftr6i4kJdZ9T8ZK8GGN4NwwH7wPSMR3Pmv8aSiyF6aTpw8LnXmaBJVURMCUZkNQMea
        DdTWVc8ijvx2GOIfKumtOio3JBk3V0HPAblIHKQcbdrhA/A+IpEkr1qZj/WcoxOLmfA/lI5B0ivo6
        oYe1fqWw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcOqO-00En1T-Se; Mon, 18 Oct 2021 09:22:08 +0000
Date:   Mon, 18 Oct 2021 02:22:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 14/14] block: remove some blk_mq_hw_ctx debugfs entries
Message-ID: <YW08wEeR6r5h6CbD@infradead.org>
References: <20211017013748.76461-1-axboe@kernel.dk>
 <20211017013748.76461-15-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017013748.76461-15-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
