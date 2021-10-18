Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20356C433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 12:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 071DF60FC3
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 12:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhJRMbP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 08:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhJRMbO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 08:31:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EB4C06161C;
        Mon, 18 Oct 2021 05:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WBserNfkxzWuAaoiJYW4mlYzlUU5tE1+Wq5CZi1NIso=; b=EUsBdKJsQ3G0snlh4UOhGLlYHG
        +11+3A34aVc3iuD8YlrP0mtt8EoeZv9NqA3rLK9eujb5cd73jKcvlYUKKklbz97b9L75oJORFNNVo
        3AYfQXSGMP1eJcGBQTGd611vVt/oIta9mvXfc+BY6K70E98NJVbdFpD4HQ2L+efKz+KRF3uANYjxl
        uuosFBumN42YATxURhr/EnfcULXhCFuMKr02Tmk2XtIHZ23eOyciWu6UEn3SMkh73Ht3QHZe+GSpk
        vydm8byGuJAH0X16dqzh9B22Mf+oZGSNjGuNEGEQEKcRIj5HVgp13VzYBrwZNWBvV29OBKgWresd+
        SP6RZpyg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcRip-00AwMD-BO; Mon, 18 Oct 2021 12:26:48 +0000
Date:   Mon, 18 Oct 2021 13:26:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     axboe@kernel.dk, hch@lst.de, sunhao.th@gmail.com,
        hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] block: fix incorrect references to disk objects
Message-ID: <YW1n91DAaVyuISVV@casper.infradead.org>
References: <20211018115807.21103-1-qiang.zhang1211@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018115807.21103-1-qiang.zhang1211@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 18, 2021 at 07:58:07PM +0800, Zqiang wrote:
> When adding partitions to the disk, the reference count of the disk
> object is increased. then alloc partition device and called
> device_add(), if the device_add() return error, the reference
> count of the disk object will be reduced twice, at put_device(pdev)
> and put_disk(disk). this leads to the end of the object's life cycle
> prematurely, and trigger following calltrace.
> 
>   __init_work+0x2d/0x50 kernel/workqueue.c:519
>   synchronize_rcu_expedited+0x3af/0x650 kernel/rcu/tree_exp.h:847
>   bdi_remove_from_list mm/backing-dev.c:938 [inline]
>   bdi_unregister+0x17f/0x5c0 mm/backing-dev.c:946
>   release_bdi+0xa1/0xc0 mm/backing-dev.c:968
>   kref_put include/linux/kref.h:65 [inline]
>   bdi_put+0x72/0xa0 mm/backing-dev.c:976
>   bdev_free_inode+0x11e/0x220 block/bdev.c:408
>   i_callback+0x3f/0x70 fs/inode.c:226
>   rcu_do_batch kernel/rcu/tree.c:2508 [inline]
>   rcu_core+0x76d/0x16c0 kernel/rcu/tree.c:2743
>   __do_softirq+0x1d7/0x93b kernel/softirq.c:558
>   invoke_softirq kernel/softirq.c:432 [inline]
>   __irq_exit_rcu kernel/softirq.c:636 [inline]
>   irq_exit_rcu+0xf2/0x130 kernel/softirq.c:648
>   sysvec_apic_timer_interrupt+0x93/0xc0
> 
> Return directly after calling the put_device().
> 
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

Fixes: 9d3b8813895d ("block: change the refcounting for partitions")
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
