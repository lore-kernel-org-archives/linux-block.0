Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A0CC43381
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 01:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CBC664E21
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 01:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbhBXBQ6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 20:16:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37088 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233582AbhBXAlN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 19:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614127176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5yWW5XOpCbYIsCmTqtOH2R27GfGNH2jDGr2dQJVGvIg=;
        b=DhY+1TQulG3ACS6oENCGF/pLufm1me2E+wUofmA3R0VWyedDOCqv6TxbeEExVhdzbcBB4D
        KMFuC7PVyteygVvpg8CJEtgjGfGEaLrZXj38LMpy3tlfILpVu/Rz5JnUWvfEvXraGD3IcY
        Z6JAU5oy/IolePFyTzhJ7llyKc/cYL0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-uKtNNRe4ON2UvIook1-IRA-1; Tue, 23 Feb 2021 19:39:32 -0500
X-MC-Unique: uKtNNRe4ON2UvIook1-IRA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B0D7835E21;
        Wed, 24 Feb 2021 00:39:31 +0000 (UTC)
Received: from T590 (ovpn-12-117.pek2.redhat.com [10.72.12.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BB3B66F998;
        Wed, 24 Feb 2021 00:39:21 +0000 (UTC)
Date:   Wed, 24 Feb 2021 08:39:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <msnitzer@redhat.com>,
        Marian Csontos <mcsontos@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH v2] blk-settings: make sure that max_sectors is aligned
 on "logical_block_size" boundary
Message-ID: <YDWgNbz9ZX2Rjc+X@T590>
References: <alpine.LRH.2.02.2102221312070.5407@file01.intranet.prod.int.rdu2.redhat.com>
 <YDSwyrLeiP/fKgZH@T590>
 <alpine.LRH.2.02.2102231125170.27597@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2102231125170.27597@file01.intranet.prod.int.rdu2.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 23, 2021 at 11:28:27AM -0500, Mikulas Patocka wrote:
> 
> 
> On Tue, 23 Feb 2021, Ming Lei wrote:
> 
> > I'd suggest to add a helper(such as, blk_round_down_sectors()) to round_down each
> > one.
> 
> Yes - Here I'm sending the updated patch.
> 
> > -- 
> > Ming
> 
> From: Mikulas Patocka <mpatocka@redhat.com>
> 
> We get I/O errors when we run md-raid1 on the top of dm-integrity on the
> top of ramdisk.
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
>  block/blk-settings.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> Index: linux-2.6/block/blk-settings.c
> ===================================================================
> --- linux-2.6.orig/block/blk-settings.c	2021-02-23 17:18:59.000000000 +0100
> +++ linux-2.6/block/blk-settings.c	2021-02-23 17:23:58.000000000 +0100
> @@ -481,6 +481,14 @@ void blk_queue_io_opt(struct request_que
>  }
>  EXPORT_SYMBOL(blk_queue_io_opt);
>  
> +static unsigned int blk_round_down_sectors(unsigned int sectors, unsigned int lbs)
> +{
> +	sectors = round_down(sectors, lbs >> SECTOR_SHIFT);
> +	if (sectors < PAGE_SIZE >> SECTOR_SHIFT)
> +		sectors = PAGE_SIZE >> SECTOR_SHIFT;
> +	return sectors;
> +}
> +
>  /**
>   * blk_stack_limits - adjust queue_limits for stacked devices
>   * @t:	the stacking driver limits (top device)
> @@ -607,6 +615,10 @@ int blk_stack_limits(struct queue_limits
>  		ret = -1;
>  	}
>  
> +	t->max_sectors = blk_round_down_sectors(t->max_sectors, t->logical_block_size);
> +	t->max_hw_sectors = blk_round_down_sectors(t->max_hw_sectors, t->logical_block_size);
> +	t->max_dev_sectors = blk_round_down_sectors(t->max_dev_sectors, t->logical_block_size);
> +
>  	/* Discard alignment and granularity */
>  	if (b->discard_granularity) {
>  		alignment = queue_limit_discard_alignment(b, start);

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

