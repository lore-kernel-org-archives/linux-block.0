Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D499C4332F
	for <linux-block@archiver.kernel.org>; Thu,  3 Nov 2022 16:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiKCQhJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Nov 2022 12:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbiKCQgq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Nov 2022 12:36:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05C41FCE3
        for <linux-block@vger.kernel.org>; Thu,  3 Nov 2022 09:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667493203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fUF+I8EGINVzhDXITd/3muSBjqwK5fHoHzpzwmb86fA=;
        b=SzAJfcsKJSM8tCGv3s8VUti8mvioRZaRnL6+/B5yFwhw3MSzECAs9fWEV/i9iA9ik83UBI
        C8i+V5TTWGMTi3kHoFtMDV8EIAlLy0ZI2Sfk0ZM5nhhzcK5mjwUmd6o70Jn3bs50wwUOS7
        UNXpHkAbdqXbcsb4BAPDIdEdOLrnTwY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-XInoI0sSPg-L9Xr7SODwAA-1; Thu, 03 Nov 2022 12:33:21 -0400
X-MC-Unique: XInoI0sSPg-L9Xr7SODwAA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA37486F12E;
        Thu,  3 Nov 2022 16:33:20 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B7F301415123;
        Thu,  3 Nov 2022 16:33:20 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 2A3GXKK1011752;
        Thu, 3 Nov 2022 12:33:20 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 2A3GXJEQ011749;
        Thu, 3 Nov 2022 12:33:19 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 3 Nov 2022 12:33:19 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Keith Busch <kbusch@meta.com>
cc:     linux-block@vger.kernel.org, dm-devel@redhat.com, axboe@kernel.dk,
        stefanha@redhat.com, ebiggers@kernel.org, me@demsh.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 0/3] fix direct io errors on dm-crypt
In-Reply-To: <20221103152559.1909328-1-kbusch@meta.com>
Message-ID: <alpine.LRH.2.21.2211031224060.10758@file01.intranet.prod.int.rdu2.redhat.com>
References: <20221103152559.1909328-1-kbusch@meta.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi

The patchset seems OK - but dm-integrity also has a limitation that the 
bio vectors must be aligned on logical block size.

dm-writecache and dm-verity seem to handle unaligned bioset, but you 
should check them anyway.

I'm not sure about dm-log-writes.

Mikulas


On Thu, 3 Nov 2022, Keith Busch wrote:

> From: Keith Busch <kbusch@kernel.org>
> 
> The 6.0 kernel made some changes to the direct io interface to allow
> offsets in user addresses. This based on the hardware's capabilities
> reported in the request_queue's dma_alignment attribute.
> 
> dm-crypt requires direct io be aligned to the block size. Since it was
> only ever using the default 511 dma mask, this requirement may fail if
> formatted to something larger, like 4k, which will result in unexpected
> behavior with direct-io.
> 
> There are two parts to fixing this:
> 
>   First, the attribute needs to be moved to the queue_limit so that it
>   can properly stack with device mappers.
> 
>   Second, dm-crypt provides its minimum required limit to match the
>   logical block size.
> 
> Keith Busch (3):
>   block: make dma_alignment a stacking queue_limit
>   dm-crypt: provide dma_alignment limit in io_hints
>   block: make blk_set_default_limits() private
> 
>  block/blk-core.c       |  1 -
>  block/blk-settings.c   |  9 +++++----
>  block/blk.h            |  1 +
>  drivers/md/dm-crypt.c  |  1 +
>  include/linux/blkdev.h | 16 ++++++++--------
>  5 files changed, 15 insertions(+), 13 deletions(-)
> 
> -- 
> 2.30.2
> 

