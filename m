Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485FFC433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 07:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30F0A60F9C
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 07:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhJYHMp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 03:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbhJYHMo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 03:12:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AA4C061745;
        Mon, 25 Oct 2021 00:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=13par5P3O3Yr1aY5hrw8Hsu+bh
        tpiT5Ufi3nCgyGLzC2VfBPU/s+BhykB69rpKxhwlXC8gbk6y7OWZUXH+vazwtcjwWgNhp8OR4erpl
        MhW4i6nj4re/CBgKw5JVr9YeLW+Dram1jsL4wPDZBPdjZRxm34u5eAYFmUODQhYeHFtwzEyjm7CCg
        eHKilCJFM9nj/OTr8EDDyLtSlepXMmkVhq6iBXy2/+wY4Lt9oCNNJzDfisJaJWiaWv/8007GwPnsk
        zHpoqjpqggfRwmUfHLfLEDJ/SFhsRWwpqXaZx9t4gDjqpn1r+gWQKtXlipSOm3yWI8SFZkTUuKN2D
        aPj6cYDA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1meu7i-00FWUE-NZ; Mon, 25 Oct 2021 07:10:22 +0000
Date:   Mon, 25 Oct 2021 00:10:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        tglx@linutronix.de, Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 1/2] blk-mq: Add blk_mq_complete_request_direct()
Message-ID: <YXZYXgumJuluIJkk@infradead.org>
References: <20211025070658.1565848-1-bigeasy@linutronix.de>
 <20211025070658.1565848-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025070658.1565848-2-bigeasy@linutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
