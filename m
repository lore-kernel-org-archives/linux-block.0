Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F98FC433EF
	for <linux-block@archiver.kernel.org>; Tue,  1 Mar 2022 13:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbiCANcm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Mar 2022 08:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbiCANcl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Mar 2022 08:32:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A939E550
        for <linux-block@vger.kernel.org>; Tue,  1 Mar 2022 05:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WEKBLRhLNF/mZbOnft8092HNdwGzx3Pc5F5G9SOzHX0=; b=HGFymfs0w2mImbcXFCrCk3YwQI
        lOwuxlSYSftZDo8YW1A8njvk5NruxuGLEt6TByjAuz8z+hJsmcLb/3kid920eIiuldiV82MhuJVEm
        83GjPNjkjZw93g2Kd1t9IItqcjoleGpjpW+hzGdlMgyKCNrqodu6E9Uq20WhBQ8FEa5q1sjmDEwac
        CjSVeAX/eZ1HJ2xJyeYsU8Lsu00gqVvF26oJ1PAAX5sYjp8HBPZx8apPmjORPqv+tIP1yImZwyyK6
        NXxW81L4v4NDTadhcbceD4H4yR/GpOd16Djq6NhdwF/ebCK6wtdYuhmZJ8iz1PwAhk1LaNkqUAn5m
        +U9yKObg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nP2bf-00GuvX-HW; Tue, 01 Mar 2022 13:31:59 +0000
Date:   Tue, 1 Mar 2022 05:31:59 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH 3/6] blk-mq: re-config poll after queue map is changed
Message-ID: <Yh4gTwY5F7uQ8GiN@infradead.org>
References: <20220228090430.1064267-1-ming.lei@redhat.com>
 <20220228090430.1064267-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228090430.1064267-4-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 28, 2022 at 05:04:27PM +0800, Ming Lei wrote:
> queue map can be changed when updating nr_hw_queues, so we need to
> re-config queue's poll capability. Add one helper for doing this job.

s/re-config/reconfigure/g

> +static void blk_mq_config_poll(struct request_queue *q)
> +{
> +	struct blk_mq_tag_set *set = q->tag_set;
> +
> +	if (set->nr_maps > HCTX_TYPE_POLL &&
> +	    set->map[HCTX_TYPE_POLL].nr_queues)
> +		blk_queue_flag_set(QUEUE_FLAG_POLL, q);
> +	else
> +		blk_queue_flag_clear(QUEUE_FLAG_POLL, q);
> +}

Maybe name this blk_mq_update_poll_flag?

