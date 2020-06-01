Return-Path: <SRS0=rAsZ=7O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F41C433E0
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 07:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C3F2206C3
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 07:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Irig6FEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgFAHez (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jun 2020 03:34:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48369 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726860AbgFAHez (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Jun 2020 03:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590996894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZxFsW4NLg/cOdmRdqJJ6J/Eed6bhnmzjhY54muUYYhc=;
        b=Irig6FEx6aYubiJ7Uq+A9ALRiR+A4R6GIMmjnXTOQ3y6ErXlcrtZHLEvrNnDtdMbnasnL+
        MGmf939N4N/8sDec+fjPrEqbIIbPxWu0pgKXHMbpI2ijRyj35K4TF2F5kkyDVp8+sDITC3
        Wrp7mGjadD1HOSRffEbRFQjkcskKq7M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-LYiRjeexMiG5PdRpq5oO6A-1; Mon, 01 Jun 2020 03:34:52 -0400
X-MC-Unique: LYiRjeexMiG5PdRpq5oO6A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76C4A107ACF2;
        Mon,  1 Jun 2020 07:34:51 +0000 (UTC)
Received: from T590 (ovpn-13-152.pek2.redhat.com [10.72.13.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 66C7B768DE;
        Mon,  1 Jun 2020 07:34:45 +0000 (UTC)
Date:   Mon, 1 Jun 2020 15:34:40 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH] block: check for page size in queue_logical_block_size()
Message-ID: <20200601073440.GD1181806@T590>
References: <20200601005520.420719-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601005520.420719-1-mfo@canonical.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, May 31, 2020 at 09:55:20PM -0300, Mauricio Faria de Oliveira wrote:
> It's possible for a block driver to set logical block size to
> a value greater than page size incorrectly; e.g. bcache takes
> the value from the superblock, set by the user w/ make-bcache.
> 
> This causes a BUG/NULL pointer dereference in the path:
> 
>   __blkdev_get()
>   -> set_init_blocksize() // set i_blkbits based on ...
>      -> bdev_logical_block_size()
>         -> queue_logical_block_size() // ... this value
>   -> bdev_disk_changed()
>      ...
>      -> blkdev_readpage()
>         -> block_read_full_page()
>            -> create_page_buffers() // size = 1 << i_blkbits
>               -> create_empty_buffers() // give size/take pointer
>                  -> alloc_page_buffers() // return NULL
>                  .. BUG!
> 
> Because alloc_page_buffers() is called with size > PAGE_SIZE,
> thus it initializes head = NULL, skips the loop, return head;
> then create_empty_buffers() gets (and uses) the NULL pointer.
> 
> This has been around longer than commit ad6bf88a6c19 ("block:
> fix an integer overflow in logical block size"); however, it
> increased the range of values that can trigger the issue.
> 
> Previously only 8k/16k/32k (on x86/4k page size) would do it,
> as greater values overflow unsigned short to zero, and queue_
> logical_block_size() would then use the default of 512.
> 
> Now the range with unsigned int is much larger, and one user
> with an (incorrect) 512k value, which happened to be zero'ed
> previously and work fine, hits the issue -- the zero is gone,
> and queue_logical_block_size() does return 512k (> PAGE_SIZE)

There is only very limited such potential users(loop, virtio-blk,
xen-blkfront), so could you fix the user instead of working around
queue_logical_block_size()?


thanks, 
Ming

