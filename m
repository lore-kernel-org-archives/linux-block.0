Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F200AC433EF
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 00:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE78561152
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 00:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243656AbhIXATP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Sep 2021 20:19:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58949 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243657AbhIXATO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Sep 2021 20:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632442661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WIfs5IMyxBPj7NY1EDgnzf1lb1Jk51F4xwbJsvlqTuE=;
        b=Xreu43MM4VLWR7fZj3T3enw2PKSeQSRl5XOp/Z2uET8+2XYo9+ZFlbe2XA7so73pGQqH1L
        GRSd5/0BFQC3L90y1HY/rHY8v/aqgnB6XkEQzvpMNmCriqDHRnBoOVku4wtBfnXLZ9UO8A
        Tbq4wCgHfK2hcMNJdHV5ufpaerE1I5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-JKrSBRkvM1yOukNTJx21Yg-1; Thu, 23 Sep 2021 20:17:40 -0400
X-MC-Unique: JKrSBRkvM1yOukNTJx21Yg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6223A40C1;
        Fri, 24 Sep 2021 00:17:39 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B3BC5BAE0;
        Fri, 24 Sep 2021 00:17:30 +0000 (UTC)
Date:   Fri, 24 Sep 2021 08:17:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] loop: don't print warnings if the underlying filesystem
 doesn't support discard
Message-ID: <YU0ZJgBicy4xjbU3@T590>
References: <alpine.LRH.2.02.2109231539520.27863@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2109231539520.27863@file01.intranet.prod.int.rdu2.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 23, 2021 at 03:48:27PM -0400, Mikulas Patocka wrote:
> Hi
> 
> When running the lvm testsuite, we get a lot of warnings 
> "blk_update_request: operation not supported error, dev loop0, sector 0 op 
> 0x9:(WRITE_ZEROES) flags 0x800800 phys_seg 0 prio class 0". The lvm 
> testsuite puts the loop device on tmpfs and the reason for the warning is 
> that tmpfs supports fallocate, but doesn't support FALLOC_FL_ZERO_RANGE.
> 
> I've created this patch to silence the warnings.
> 
> Mikulas
> 
> 
> 
> From: Mikulas Patocka <mpatocka@redhat.com>
> 
> The loop driver checks for the fallocate method and if it is present, it
> assumes that the filesystem can do FALLOC_FL_ZERO_RANGE and
> FALLOC_FL_PUNCH_HOLE requests. However, some filesystems (such as fat, or
> tmpfs) have the fallocate method, but lack the capability to do
> FALLOC_FL_ZERO_RANGE and/or FALLOC_FL_PUNCH_HOLE.
> 
> This results in syslog warnings "blk_update_request: operation not
> supported error, dev loop0, sector 0 op 0x9:(WRITE_ZEROES) flags 0x800800
> phys_seg 0 prio class 0"
> 
> This patch sets RQF_QUIET to silence the warnings.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org
> 
> ---
>  drivers/block/loop.c |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/block/loop.c
> ===================================================================
> --- linux-2.6.orig/drivers/block/loop.c	2021-09-23 17:06:57.000000000 +0200
> +++ linux-2.6/drivers/block/loop.c	2021-09-23 21:29:39.000000000 +0200
> @@ -493,7 +493,16 @@ static int lo_fallocate(struct loop_devi
>  	ret = file->f_op->fallocate(file, mode, pos, blk_rq_bytes(rq));
>  	if (unlikely(ret && ret != -EINVAL && ret != -EOPNOTSUPP))
>  		ret = -EIO;
> - out:
> +out:
> +
> +	/*
> +	 * Some filesystems have the fallocate method, but lack the capability
> +	 * to do FALLOC_FL_ZERO_RANGE and/or FALLOC_FL_PUNCH_HOLE requests.
> +	 * We do not want a syslog warning in this case.
> +	 */
> +	if (ret == -EOPNOTSUPP)
> +		rq->rq_flags |= RQF_QUIET;
> +

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

