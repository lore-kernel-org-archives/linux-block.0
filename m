Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F933C48BE5
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 06:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D024D60FE7
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 06:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhFUGTG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 02:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhFUGTF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 02:19:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980BCC061574;
        Sun, 20 Jun 2021 23:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tPZxBDWA+xTLs08ZBCsBPhVmvbaSIXupcVZapi2EmNo=; b=pBxh0+E/nt+UDuLwx9N26l/rTZ
        wZw4JjV28Kj41wCHWQkFR00QCB8mhRM7lr3qhedeKFYh0wFYjz24wU4XmFnvLQPSMb6G5t6EaQtWF
        33nHda0tNOrj1UCrjaq/RbK7YdFaerwWl5Sa5xA5y4rM0lNugzrV3X6HV1aN5R8s2KTdjcSd6pftF
        oUXA3dXIJqruIyMFItEGhTNH9ImZ8R89y0UXVAp1GT8MdMgSjRMSMy34qp09GdFRvQGmX5ZLxP4M2
        zgikKEEfqNmdEP8XorUxhKVYlfQzNbFmv/vLiNRsRRboEaixNkLZrWbWtuyKdj3ETeM+tjWYwgE/P
        LM7uYdzw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvDE7-00CmMw-IK; Mon, 21 Jun 2021 06:16:11 +0000
Date:   Mon, 21 Jun 2021 07:16:07 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     axboe@kernel.dk, liushixin2@huawei.com, bhelgaas@google.com,
        lee.jones@linaro.org, ulf.hansson@linaro.org,
        guoqing.jiang@cloud.ionos.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: mtip32xx: set the pointer of queue to null after
 cleaning
Message-ID: <YNAupxssJ/6zNyln@infradead.org>
References: <1624191557-5385-1-git-send-email-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624191557-5385-1-git-send-email-zheyuma97@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jun 20, 2021 at 12:19:17PM +0000, Zheyu Ma wrote:
> When 'mtip_block_initialize' fails at 'mtip_hw_get_identify', a series
> of cleanup operations will be performed. But when the execution reaches
> 'put_disk', it will cause refcount underflow. The reason for this error
> is that after cleaning 'dd->queue', 'dd->disk->queue' was not set to
> null at the same time, which caused repeated cleanup work.
> 
> Fix this by set 'dd->disk->queue' to null after cleaning

This should all be fixed by the switch to blk_cleanup_disk and the
preparation for it in linux-next.
