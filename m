Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95ED7C432BE
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 16:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AFEB60F5E
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 16:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237866AbhH3QuU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Aug 2021 12:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhH3QuU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Aug 2021 12:50:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C7EC061575;
        Mon, 30 Aug 2021 09:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6rHApL/Np9+9ugLAs48I8ACfdCP2s/Ndc6zPCQ0cfq0=; b=f/rDqmUDQgkWbrA8o/5V0HBaL4
        nvG1ecXU08POhUXxJ0fFrvCemil25t6qZB9NY51MaQdPngfABasVxRDYEWat0fDdDMn5M+POL0DUm
        /o4gK5VwrFvqdh+McNmadh4EJpTbEbRtWHaNlPYjf4YW3oLqfRIEh5caabE2guzyHerkzNEIKj9xO
        S7egjaEm2UrVqVS98UCrS4g64L7N5nmEqRz2873j8dmhQde8Gx18kWRQK9LHI7G2WNJf4rPg9U2oJ
        ACi+HZ3ehMxleZOJhi5Yrdjd01ojYLPFPe/9e8BZm4muVHEEQLy5SgmVXk1Fwm8xw+mw4jNwXwqM9
        cvT3pCcQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKkST-000L1o-4j; Mon, 30 Aug 2021 16:48:46 +0000
Date:   Mon, 30 Aug 2021 17:48:29 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        kvm@vger.kernel.org, stefanha@redhat.com, oren@nvidia.com,
        linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH 1/1] virtio-blk: add num_io_queues module parameter
Message-ID: <YS0L3RIiPfb9d5Xx@infradead.org>
References: <20210830120023.22202-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830120023.22202-1-mgurtovoy@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 30, 2021 at 03:00:23PM +0300, Max Gurtovoy wrote:
> +static int virtblk_queue_count_set(const char *val,
> +		const struct kernel_param *kp)
> +{
> +	unsigned int n;
> +	int ret;
> +
> +	ret = kstrtouint(val, 10, &n);
> +	if (ret != 0 || n > nr_cpu_ids)
> +		return -EINVAL;
> +	return param_set_uint(val, kp);
> +}


Thi can use param_set_uint_minmax.
