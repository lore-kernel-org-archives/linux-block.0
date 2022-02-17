Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27094C433EF
	for <linux-block@archiver.kernel.org>; Thu, 17 Feb 2022 08:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbiBQIv6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Feb 2022 03:51:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238114AbiBQIv5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Feb 2022 03:51:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA249B3E5C;
        Thu, 17 Feb 2022 00:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sC+LewyGKMDd/BmHen0z+IXBCaKKq6it50ic719oF/M=; b=PX4k7bmHFZe0oO4xPaU1eK61Pi
        mT9ufmPOt/kjr2VYeCWawW+Tsn9wN3337XJ5AEhcfhfGX1hrbMxd1gm6BoZMyuS/Ca7OzxGEODsJD
        Tc2bLmjsUFtC/0s++Zsqq/uF6MwRXVTNQQI30Phw2qyJvsyOh3HhBwJOwZnf/v/pmb+0M04RqaykY
        N5Ggv2s/FDhqxSk2XBggRePuQ714MKqcks3RKlFJoZVbGXxs2/lhOiJBVF5NtLjPVmV11STkN4avJ
        Z74OD7/VVxO6zd7uVPMizdDyMm78a0kzF4A9AgjSWTivdXsfzrVX9pMMZnabLMdp0tSqBCZE8962Q
        8uPmmnPQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKcVo-009bOS-ST; Thu, 17 Feb 2022 08:51:40 +0000
Date:   Thu, 17 Feb 2022 00:51:40 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC V4 3/6] blk-iolatency: make iolatency pluggable
Message-ID: <Yg4MnC3JydI4WmLC@infradead.org>
References: <20220217031349.98561-1-jianchao.wan9@gmail.com>
 <20220217031349.98561-4-jianchao.wan9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217031349.98561-4-jianchao.wan9@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +static inline struct rq_qos *blkcg_rq_qos(struct request_queue *q)
> +{
> +	return rq_qos_by_id(q, blkcg_iolatency_ops.id);
> +}

This just has a single user, so open code it.

> +static int blk_iolatency_init(struct request_queue *q);
> +
>  static struct rq_qos_ops blkcg_iolatency_ops = {
> +	.name = "blk-iolat",
> +	.flags = RQOS_FLAG_CGRP_POL,
>  	.throttle = blkcg_iolatency_throttle,
>  	.done_bio = blkcg_iolatency_done_bio,
>  	.exit = blkcg_iolatency_exit,
> +	.init = blk_iolatency_init,
>  };

I'd move this structure below blk_iolatency_init to avoid the forward
declaration of blk_iolatency_init
