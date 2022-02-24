Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D774AC433F5
	for <linux-block@archiver.kernel.org>; Thu, 24 Feb 2022 13:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiBXNpr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Feb 2022 08:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiBXNpq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Feb 2022 08:45:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323BD26F4E6;
        Thu, 24 Feb 2022 05:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hFcONjuuKsAiL0XlLdA4lQqn5b/UdYv3AhiZQ+i5KbA=; b=khu6h6awe/0f7QrEf81p3D5MC7
        gl+7TXD1aygpz32KWMgtVJUjE9ir/14GFIe3rNCmM5GIHNhpR2jrEYwfYSKjiWNnUiwf2+c7lBHqJ
        FaIFTA0N4Tpy7XvqlGSuzcyedlhRS4eqo3Mc1YGxIYpJFzmWBmVzoK89gXk5U3pcjMaMlLOJpVfk0
        7S31a+/nNXA/2CKKJt3mrKcfzM4mFhrJQV+O7Gq7dDnX0Wi3gqn9x3X5nNI4ZdByvlPqXyKHLqxxA
        0THz1tX+5A6svQ4FQRnWBZ4uPy0uz7o7wvGcZgckCyebyawY+5bKAYOcpBcRPPLnybhg7PrJy4nYe
        Pr8IFW0Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNEQk-000zjl-13; Thu, 24 Feb 2022 13:45:14 +0000
Date:   Thu, 24 Feb 2022 05:45:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC V5 02/16] blk/rq-qos: prepare to make blk-rq-qos pluggable
Message-ID: <YheL6hlr+B+QmoWN@infradead.org>
References: <20220224090654.54671-1-jianchao.wan9@gmail.com>
 <20220224090654.54671-3-jianchao.wan9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224090654.54671-3-jianchao.wan9@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 24, 2022 at 05:06:40PM +0800, Wang Jianchao (Kuaishou) wrote:
> This patch makes blk-rq-qos policies pluggable as following,
> (1) Add code to maintain the rq_qos_ops. A rq-qos policy need to
>     register itself with rq_qos_register(). The original enum
>     rq_qos_id will be removed in following patch. They will use
>     a dynamic id maintained by rq_qos_ida.
> (2) Add .init callback into rq_qos_ops. We use it to initialize the
>     resource.
> (3) Add /sys/block/x/queue/qos
>     We can use '+name' or "-name" to open or close the blk-rq-qos
>     policy.

This sunds like most of these should be separate patches.

>  {
>  	struct request_queue *q = rqos->q;
> -	const char *dir_name = rq_qos_id_to_name(rqos->id);
> +	const char *dir_name;
> +
> +	if (rqos->ops->name)
> +		dir_name = rqos->ops->name;
> +	else
> +		dir_name = rq_qos_id_to_name(rqos->id);

Plase split out a patch to add the name to all the ops and remove
rq_qos_id_to_name, which can be at the beginning of the series.

> +	spin_lock_irq(&q->rqos_lock);
> +	pos = q->rq_qos;
> +	if (pos) {
> +		while (pos->next)
> +			pos = pos->next;
> +		pos->next = rqos;
> +	} else {
> +		q->rq_qos = rqos;
> +	}

I think another really useful prep patch would be to switch the queue
linkage to use a hlist_head instead of all this open coded list
manipulation.

> +	rqos = rq_qos_by_name(q, qosname);
> +	if ((buf[0] == '+' && rqos)) {
> +		ret = -EEXIST;
> +		goto out;
> +	}
> +
> +	if ((buf[0] == '-' && !rqos)) {

These two conditionals have pretty odd extra braces.
