Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A927DC4332F
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 02:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJUCRq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 22:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJUCRp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 22:17:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6963022C82D
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 19:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666318663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3wfZoVowO6Py/wjl4vhF7RwkKxmnd9Ad7naZOiL71wc=;
        b=R/ykXpCsycJpqn5Ti0iGLU+4EWJE8wcxzUhGCxf2tKIyAFujDP+8pXzqp2waqZNUj/opnl
        dssLKQSo1FS9CqOv6gMo+nRLqvQO/ShVchvo7rS2/pK0pAFvIaeMWBNpNpiB9M0chWzoUl
        UMU61Y/HPTQHjQ1E2n+Wn+z+DSM/ld4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-249-SoDK5o2fOhuKeHeVxr-z1A-1; Thu, 20 Oct 2022 22:17:37 -0400
X-MC-Unique: SoDK5o2fOhuKeHeVxr-z1A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A77BE3804510;
        Fri, 21 Oct 2022 02:17:36 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F1770C1912A;
        Fri, 21 Oct 2022 02:17:27 +0000 (UTC)
Date:   Fri, 21 Oct 2022 10:17:19 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 03/10] block: Micro-optimize get_max_segment_size()
Message-ID: <Y1IBLyT1+JahApf/@T590>
References: <20221019222324.362705-1-bvanassche@acm.org>
 <20221019222324.362705-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019222324.362705-4-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 19, 2022 at 03:23:17PM -0700, Bart Van Assche wrote:
> This patch removes a conditional jump from get_max_segment_size(). The
> x86-64 assembler code for this function without this patch is as follows:
> 
> 206             return min_not_zero(mask - offset + 1,
>    0x0000000000000118 <+72>:    not    %rax
>    0x000000000000011b <+75>:    and    0x8(%r10),%rax
>    0x000000000000011f <+79>:    add    $0x1,%rax
>    0x0000000000000123 <+83>:    je     0x138 <bvec_split_segs+104>
>    0x0000000000000125 <+85>:    cmp    %rdx,%rax
>    0x0000000000000128 <+88>:    mov    %rdx,%r12
>    0x000000000000012b <+91>:    cmovbe %rax,%r12
>    0x000000000000012f <+95>:    test   %rdx,%rdx
>    0x0000000000000132 <+98>:    mov    %eax,%edx
>    0x0000000000000134 <+100>:   cmovne %r12d,%edx
> 
> With this patch applied:
> 
> 206             return min(mask - offset, (unsigned long)lim->max_segment_size - 1) + 1;
>    0x000000000000003f <+63>:    mov    0x28(%rdi),%ebp
>    0x0000000000000042 <+66>:    not    %rax
>    0x0000000000000045 <+69>:    and    0x8(%rdi),%rax
>    0x0000000000000049 <+73>:    sub    $0x1,%rbp
>    0x000000000000004d <+77>:    cmp    %rbp,%rax
>    0x0000000000000050 <+80>:    cmova  %rbp,%rax
>    0x0000000000000054 <+84>:    add    $0x1,%eax
> 
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-merge.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 58fdc3f8905b..35a8f75cc45d 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -186,6 +186,14 @@ static inline unsigned get_max_io_size(struct bio *bio,
>  	return max_sectors & ~(lbs - 1);
>  }
>  
> +/**
> + * get_max_segment_size() - maximum number of bytes to add as a single segment
> + * @lim: Request queue limits.
> + * @start_page: See below.
> + * @offset: Offset from @start_page where to add a segment.
> + *
> + * Returns the maximum number of bytes that can be added as a single segment.
> + */
>  static inline unsigned get_max_segment_size(const struct queue_limits *lim,
>  		struct page *start_page, unsigned long offset)
>  {
> @@ -194,11 +202,10 @@ static inline unsigned get_max_segment_size(const struct queue_limits *lim,
>  	offset = mask & (page_to_phys(start_page) + offset);
>  
>  	/*
> -	 * overflow may be triggered in case of zero page physical address
> -	 * on 32bit arch, use queue's max segment size when that happens.
> +	 * Prevent an overflow if mask = ULONG_MAX and offset = 0 by adding 1
> +	 * after having calculated the minimum.
>  	 */
> -	return min_not_zero(mask - offset + 1,
> -			(unsigned long)lim->max_segment_size);
> +	return min(mask - offset, (unsigned long)lim->max_segment_size - 1) + 1;
>  }

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

