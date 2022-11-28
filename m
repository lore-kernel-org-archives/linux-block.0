Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F10C43217
	for <linux-block@archiver.kernel.org>; Mon, 28 Nov 2022 15:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbiK1P2E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Nov 2022 10:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiK1P1R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2022 10:27:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CA324971
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2022 07:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JX52M6ezBQfk19+zBcmYf4kFzl9L0t3mHMEqvGDxLVI=; b=fOUjrSFMlzbtQeVL1YogSL494c
        eUrUmqid+4uTyaaI5t4nmLliCU1HpX642Unnc2PYTD2jW5v+3ae8k5Q/J5CJVut++GR9bkDWdtZsC
        lUhztp8my1QYcBTVNgHaZdiRTFtvpasf5YoidUyb5g18A2x6p3JI+UgWtCpZxWNYF1OUf0tyw1xUg
        WOWISDT3V6CR1fp4mqRSXkNJa26xYz+zVL1hc1DjWfYKtP69IptVb6oeNOhY8vIVYbCAGBYXgg/6o
        ngmsDAUfYMW0/94MpmZ4apvAzn1FiTvIb2T6DMkvVAjJMa5ocDk6mprxF3n0S5Yx4RtdYoY+t+rtS
        p6rQu9mQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ozg0i-002UQc-LK; Mon, 28 Nov 2022 15:25:32 +0000
Date:   Mon, 28 Nov 2022 07:25:32 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: fops: Do not set REQ_SYNC for async IOs
Message-ID: <Y4TS7BDDQEn+uusB@infradead.org>
References: <20221126025550.967914-1-damien.lemoal@opensource.wdc.com>
 <20221126025550.967914-3-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221126025550.967914-3-damien.lemoal@opensource.wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Nov 26, 2022 at 11:55:50AM +0900, Damien Le Moal wrote:
> Taking a blktrace of a simple fio run on a block device file using
> libaio and iodepth > 1 reveals that asynchronous writes are executed as
> sync writes, that is, REQ_SYNC is set for the write BIOs.
> 
> Fix this by modifying dio_bio_write_op() to set REQ_SYNC only for IOs
> that are indeed synchronous ones and set REQ_IDLE only for asynchronous
> IOs.

Well, REQ_SYNC is used for I/O that some is actively waiting for,
which includs aio/io_uring I/O unlike buffered writback.

So I don't think this should be changed.
