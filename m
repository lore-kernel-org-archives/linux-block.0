Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D400C2B9F8
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 08:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AB4E613F9
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 08:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhEYIPs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 04:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhEYIPs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 04:15:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D3AC061574
        for <linux-block@vger.kernel.org>; Tue, 25 May 2021 01:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IS8oe6DWcJGa9bQBBDi4fccLjfq1qMG9DdtD8Ef9/pA=; b=aiGi4Md1RIbLISctPoP6SRTcG3
        OwRilm7WXXMZln8sJRa9s8mLMuBmxt8mR6p5Fvu7B7C2124hVmzWe29C0VG25AhXc8j1Q9L1e7DLd
        ql0Kh62XJVHxRaQO9xu9ATLkOI4hNUlHSpChLLY6ldsVTKThQEq4pTCzsOqwM9LkbRnjqj8TjL8Sb
        K9MTg3O+i6I7wh3YNJGqe3GLWRzlVz5F+7Pn8mMR8qg714lBRLoCqWv41wtUG6oZDfDCRcSTLBJ32
        ptnS6ymrx6uccViu0zU+NN5ZQVWDRyFp0DWCi03Z3fR9U8o1SeNq9U3paviyeC2NA6DNLKJtbenT+
        2yOXsitQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1llSC4-003GjB-W0; Tue, 25 May 2021 08:13:47 +0000
Date:   Tue, 25 May 2021 09:13:40 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 05/11] dm: cleanup device_area_is_invalid()
Message-ID: <YKyxtD/1erFemA1p@infradead.org>
References: <20210525022539.119661-1-damien.lemoal@wdc.com>
 <20210525022539.119661-6-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525022539.119661-6-damien.lemoal@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 25, 2021 at 11:25:33AM +0900, Damien Le Moal wrote:
> In device_area_is_invalid(), use bdev_is_zoned() instead of open
> coding the test on the zoned model returned by bdev_zoned_model().
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
