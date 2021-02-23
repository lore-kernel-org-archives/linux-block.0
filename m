Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEDBC433E6
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 07:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7371D64D5D
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 07:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhBWHkN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 02:40:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54086 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230429AbhBWHji (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 02:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614065884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9TIXmQ0RNQdJ2dixYmYDGqb30SpsFD0g6DsYMu6sBds=;
        b=DWyca4aqaogGVtMlNeq6EHgxOWt7Rv2x/QTc+mMxExoYgfwf4H0wNqiNi1PaCc7VQv30ae
        Amk8DZ27qyzw8NPOYw2v6izoRGKyos4/3KXYlhg3znQCe+ezWBQDWbIn0NB4c9LJ8JrhLN
        4GxAxt9LtXb1ZL8MR/Pu/viEpUzyB3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-__mYrrmxMNSAJof5tMgvHQ-1; Tue, 23 Feb 2021 02:38:02 -0500
X-MC-Unique: __mYrrmxMNSAJof5tMgvHQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39D0A80196C;
        Tue, 23 Feb 2021 07:38:01 +0000 (UTC)
Received: from T590 (ovpn-12-246.pek2.redhat.com [10.72.12.246])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DAEF25D764;
        Tue, 23 Feb 2021 07:37:50 +0000 (UTC)
Date:   Tue, 23 Feb 2021 15:37:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Marian Csontos <mcsontos@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH] blk-settings: make sure that max_sectors is aligned on
 "logical_block_size" boundary. (fwd)
Message-ID: <YDSwyrLeiP/fKgZH@T590>
References: <alpine.LRH.2.02.2102221312070.5407@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2102221312070.5407@file01.intranet.prod.int.rdu2.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 22, 2021 at 01:15:32PM -0500, Mikulas Patocka wrote:
> 
> 
> ---------- Forwarded message ----------
> Date: Thu, 19 Nov 2020 15:36:51 -0500 (EST)
> From: Mikulas Patocka <mpatocka@redhat.com>
> To: David Teigland <teigland@redhat.com>, Jens Axboe <axboe@kernel.dk>
> Cc: heinzm@redhat.com, Zdenek Kabelac <zkabelac@redhat.com>,
>     Marian Csontos <mcsontos@redhat.com>, linux-block@vger.kernel.org,
>     dm-devel@redhat.com
> Subject: [PATCH] blk-settings: make sure that max_sectors is aligned on
>     "logical_block_size" boundary.
> 
> We get these I/O errors when we run md-raid1 on the top of dm-integrity on 
> the top of ramdisk:
> device-mapper: integrity: Bio not aligned on 8 sectors: 0xff00, 0xff
> device-mapper: integrity: Bio not aligned on 8 sectors: 0xff00, 0xff
> device-mapper: integrity: Bio not aligned on 8 sectors: 0xffff, 0x1
> device-mapper: integrity: Bio not aligned on 8 sectors: 0xffff, 0x1
> device-mapper: integrity: Bio not aligned on 8 sectors: 0x8048, 0xff
> device-mapper: integrity: Bio not aligned on 8 sectors: 0x8147, 0xff
> device-mapper: integrity: Bio not aligned on 8 sectors: 0x8246, 0xff
> device-mapper: integrity: Bio not aligned on 8 sectors: 0x8345, 0xbb
> 
> The ramdisk device has logical_block_size 512 and max_sectors 255. The 
> dm-integrity device uses logical_block_size 4096 and it doesn't affect the 
> "max_sectors" value - thus, it inherits 255 from the ramdisk. So, we have 
> a device with max_sectors not aligned on logical_block_size.
> 
> The md-raid device sees that the underlying leg has max_sectors 255 and it
> will split the bios on 255-sector boundary, making the bios unaligned on
> logical_block_size.
> 
> In order to fix the bug, we round down max_sectors to logical_block_size.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org
> 
> ---
>  block/blk-settings.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> Index: linux-2.6/block/blk-settings.c
> ===================================================================
> --- linux-2.6.orig/block/blk-settings.c	2020-10-29 12:20:46.000000000 +0100
> +++ linux-2.6/block/blk-settings.c	2020-11-19 21:20:18.000000000 +0100
> @@ -591,6 +591,16 @@ int blk_stack_limits(struct queue_limits
>  		ret = -1;
>  	}
>  
> +	t->max_sectors = round_down(t->max_sectors, t->logical_block_size / 512);
> +	if (t->max_sectors < PAGE_SIZE / 512)
> +		t->max_sectors = PAGE_SIZE / 512;
> +	t->max_hw_sectors = round_down(t->max_hw_sectors, t->logical_block_size / 512);
> +	if (t->max_sectors < PAGE_SIZE / 512)

	if (t->max_hw_sectors < PAGE_SIZE / 512)

> +		t->max_hw_sectors = PAGE_SIZE / 512;
> +	t->max_dev_sectors = round_down(t->max_dev_sectors, t->logical_block_size / 512);
> +	if (t->max_sectors < PAGE_SIZE / 512)

	if (t->max_dev_sectors < PAGE_SIZE / 512)

> +		t->max_dev_sectors = PAGE_SIZE / 512;

I'd suggest to add a helper(such as, blk_round_down_sectors()) to round_down each
one.

-- 
Ming

