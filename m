Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E7AC433EF
	for <linux-block@archiver.kernel.org>; Fri,  5 Nov 2021 00:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40C4A6120E
	for <linux-block@archiver.kernel.org>; Fri,  5 Nov 2021 00:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhKEA02 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 20:26:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41716 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229528AbhKEA02 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Nov 2021 20:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636071829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a5jV1hcUC0+I9vRvJgXJqLgdfcOs/3URUY6isVM/dRE=;
        b=geLpv+q0OSEs4bT17c30+D4ElaNDsDkCbfKessE/uZFMJBPiiac6LpzJxZTLlgqoz4v0pJ
        uvW+L6C3TXi0o2RbwtDwjqzbiLCnZYTpubz5iFmmQU4UPpNhzkYUOMCwihPqwUl8vmMuJo
        fPs7mfjoc+pNBR6QqsXDEgt8wFsKNuw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-OZxFAimGO3-iyyZpdgFXGw-1; Thu, 04 Nov 2021 20:23:47 -0400
X-MC-Unique: OZxFAimGO3-iyyZpdgFXGw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05164871803;
        Fri,  5 Nov 2021 00:23:47 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B523B19EF9;
        Fri,  5 Nov 2021 00:23:32 +0000 (UTC)
Date:   Fri, 5 Nov 2021 08:23:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [bug report] zram: avoid race between zram_remove and
 disksize_store
Message-ID: <YYR5fmwmfvfQzWuZ@T590>
References: <20211104114830.GA4962@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104114830.GA4962@kili>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Dan,

On Thu, Nov 04, 2021 at 02:48:30PM +0300, Dan Carpenter wrote:
> Hello Ming Lei,
> 
> The patch 5a4b653655d5: "zram: avoid race between zram_remove and
> disksize_store" from Oct 25, 2021, leads to the following Smatch
> static checker warning:
> 
> 	drivers/block/zram/zram_drv.c:2044 zram_remove()
> 	warn: 'zram->mem_pool' double freed
> 
> drivers/block/zram/zram_drv.c
>     2002 static int zram_remove(struct zram *zram)
>     2003 {
>     2004         struct block_device *bdev = zram->disk->part0;
>     2005         bool claimed;
>     2006 
>     2007         mutex_lock(&bdev->bd_disk->open_mutex);
>     2008         if (bdev->bd_openers) {
>     2009                 mutex_unlock(&bdev->bd_disk->open_mutex);
>     2010                 return -EBUSY;
>     2011         }
>     2012 
>     2013         claimed = zram->claim;
>     2014         if (!claimed)
>     2015                 zram->claim = true;
>     2016         mutex_unlock(&bdev->bd_disk->open_mutex);
>     2017 
>     2018         zram_debugfs_unregister(zram);
>     2019 
>     2020         if (claimed) {
>     2021                 /*
>     2022                  * If we were claimed by reset_store(), del_gendisk() will
>     2023                  * wait until reset_store() is done, so nothing need to do.
>     2024                  */
>     2025                 ;
>     2026         } else {
>     2027                 /* Make sure all the pending I/O are finished */
>     2028                 sync_blockdev(bdev);
>     2029                 zram_reset_device(zram);
>                          ^^^^^^^^^^^^^^^^^^^^^^^^
> This frees zram->mem_pool in zram_meta_free().
> 
>     2030         }
>     2031 
>     2032         pr_info("Removed device: %s\n", zram->disk->disk_name);
>     2033 
>     2034         del_gendisk(zram->disk);
>     2035 
>     2036         /* del_gendisk drains pending reset_store */
>     2037         WARN_ON_ONCE(claimed && zram->claim);
>     2038 
>     2039         /*
>     2040          * disksize_store() may be called in between zram_reset_device()
>     2041          * and del_gendisk(), so run the last reset to avoid leaking
>     2042          * anything allocated with disksize_store()
>     2043          */
> --> 2044         zram_reset_device(zram);
> 
> This double frees it.

No.

Inside zram_reset_device(), if init_done()(zram->disksize) is zero, zram_reset_device()
returns immediately, otherwise zram->disksize is cleared and zram_meta_free()
is run in zram_reset_device(). Meantime zram->init_lock protects the
reset and disksize_store().

The 2nd zram_reset_device() can only reset device if disksize_store() sets new
zram->disksize and allocates new meta after the 1st zram_reset_device().

Seems smatch static checker need to be improved to cover this case?


Thanks,
Ming

