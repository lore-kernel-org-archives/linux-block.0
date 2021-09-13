Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF60FC433EF
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 12:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4B9360FBF
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 12:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbhIMMpx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Sep 2021 08:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbhIMMpv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Sep 2021 08:45:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F8FC061574
        for <linux-block@vger.kernel.org>; Mon, 13 Sep 2021 05:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uCC25ADfudGen8eHagfsx5W4+kdd6B787Bb8bF/6FZs=; b=J1O2mgTgRxnExGeS3TAf5lLHt7
        rkQG9p/8stzbyX+YMt0Nh2SV+p3L8mDhK2wCjEMVcWFGohz1/EfJwfpesjYWY/ZHLfCttLrhCCOmf
        QfxhgG/InB1eQy0+EbanBzp7ZqLFoLC/dckTezRfB0skRyZSAIQI0IUKYpfGL6MdLqzAuK4zSer9M
        mZ1Sy6Beto7qExQXpbZbjp0bmMOc/u5FhmXa3xHipU9boPKQk/tnz6YNdjpbk/vs4kre8kPN9mUTy
        uYLkNZTumibm8Z4CTpFlloX6Dy5GbTA89wYlR9CJz8BfZT4iz2Wuw4grdHW54GajbOmAWjX8VvP16
        zBROjYFQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPlHY-00DTWF-7k; Mon, 13 Sep 2021 12:42:28 +0000
Date:   Mon, 13 Sep 2021 13:41:56 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, hch@infradead.org,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        yixingchen@bytedance.com
Subject: Re: [PATCH 3/3] nbd: Use invalidate_gendisk() helper on disconnect
Message-ID: <YT9HFOTnBFWMUE74@infradead.org>
References: <20210913112557.191-1-xieyongji@bytedance.com>
 <20210913112557.191-4-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913112557.191-4-xieyongji@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 13, 2021 at 07:25:57PM +0800, Xie Yongji wrote:
> +		invalidate_gendisk(nbd->disk);
> +		if (nbd->config->bytesize)
> +			kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);

I wonder if the invalidate helper should just use
set_capacity_and_notify to take care of the notification in the proper
way.  This adds an uevent to loop, and adds the RESIZE=1 argument to
nbd, but it feels like the right thing to do.
