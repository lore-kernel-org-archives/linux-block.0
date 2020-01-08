Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8E6C282DD
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 15:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71811206F0
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 15:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FynjTV8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgAHPBI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:01:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51552 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728219AbgAHPBI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jan 2020 10:01:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yEV5QGTKJfmAEQlA0pFIJS99yfvEeNFsvYRdckWbGg8=; b=FynjTV8KYD8A4OOYY3cEwtGwv
        7IYOW61UdMX8HZePDqEwHG6e7JXhgpj3um653692zfj/lc+hmM6Aa2g1OcU08aCEDXwZtz9iaSBUt
        gIBKgYIDxpdtCa13BBxmdcCTZGTQY4r3F3fv1chmMoCmseu990j0sN4ZOjGsmNmBA4rAFVciS6UjO
        YDXH1nt0t55dw25pXBD0L9WnT/s2A9kn8nJdJnobpoSlz2rlWMOQvdPu4Wtaqjf/VZU52xc6UccA5
        sU2wVqY4pVgMsPJ5EQy3djpVPEb3cQJftHMdrnisw10VQPiPmTt3oTssGOHWrAYZB8fgq+Tq0pSmJ
        SSb2mymow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipCpW-0006Th-R2; Wed, 08 Jan 2020 15:01:06 +0000
Date:   Wed, 8 Jan 2020 07:01:06 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, ming.lei@redhat.com,
        houtao1@huawei.com, hch@lst.de, yi.zhang@huawei.com,
        zhengchuan@huawei.com
Subject: Re: [PATCH] block: cache index instead of part self to avoid
 use-after-free
Message-ID: <20200108150106.GA18991@infradead.org>
References: <20200106073510.10825-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106073510.10825-1-yuyufen@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 06, 2020 at 03:35:10PM +0800, Yufen Yu wrote:
> When delete partition executes concurrently with IOs issue,
> it may cause use-after-free on part in disk_map_sector_rcu()
> as following:
> 
> blk_account_io_start(req1)  delete_partition  blk_account_io_start(req2)
> 
> rcu_read_lock()
> disk_map_sector_rcu
> part = rcu_dereference(ptbl->part[4])
>                            rcu_assign_pointer(ptbl->part[4], NULL);
>                            rcu_assign_pointer(ptbl->last_lookup, NULL);
> rcu_assign_pointer(ptbl->last_lookup, part);
> 
>                            hd_struct_kill(part)
> !hd_struct_try_get
>   part = &rq->rq_disk->part0;
> rcu_read_unlock()
>                            __delete_partition
>                            call_rcu
>                                             rcu_read_lock
>                                             disk_map_sector_rcu
>                                             part = rcu_dereference(ptbl->last_lookup);
> 
>                            delete_partition_work_fn
>                            free(part)
>                                             hd_struct_try_get(part)
>                                             BUG_ON use-after-free
> 
> req1 try to get 'ptbl->part[4]', while the part is beening
> deleted. Although the delete_partition() will set last_lookup
> as NULL, req1 can overwrite it as 'part[4]' again.
> 
> After calling call_rcu() and free() for the part, req2 can
> access the part by last_lookup, resulting in use after free.
> 
> In fact, this bug has been reported by syzbot:
>     https://lkml.org/lkml/2019/1/4/357
> 
> To fix the bug, we try to cache index of part[] instead of
> part[i] itself in last_lookup. Even if the index may been
> re-assign, others can either get part[i] as value of NULL,
> or get the new allocated part[i] after call_rcu. Both of
> them is okay.
> 
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
