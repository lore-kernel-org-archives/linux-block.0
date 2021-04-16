Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C19C433B4
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 09:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BF586115B
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 09:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238478AbhDPJHq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 05:07:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27924 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235236AbhDPJHq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 05:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618564041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+wMsZ8Ea8gNm8RDgnIP3hOgRT7j4TBX+oKP32cZ43c0=;
        b=EGKRAJnQc2DRN4Czw6IZj8qoatn4x8fa8Xa7JncxgWD0u72zklRWcQQ+FvLJXrhgX33oiZ
        bNBnSt4I3jHYMT6lGjph5IMONz69ZIffaYmTM0v5ARAxRbDOngDWb2eDY4Yvr0M7XLaBH/
        ZHaeZpKuK+6Fc7QwAm4ZVftqXn3CyaA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-9TNrUrp4Maa7T95z6bRG0Q-1; Fri, 16 Apr 2021 05:07:19 -0400
X-MC-Unique: 9TNrUrp4Maa7T95z6bRG0Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B662487A826;
        Fri, 16 Apr 2021 09:07:18 +0000 (UTC)
Received: from T590 (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ABCBA5D9C0;
        Fri, 16 Apr 2021 09:07:06 +0000 (UTC)
Date:   Fri, 16 Apr 2021 17:07:01 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     snitzer@redhat.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: Re: [PATCH] block: introduce QUEUE_FLAG_POLL_CAP flag
Message-ID: <YHlTtVtTEBpxa8Gh@T590>
References: <20210401021927.343727-12-ming.lei@redhat.com>
 <20210416080037.26335-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416080037.26335-1-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 16, 2021 at 04:00:37PM +0800, Jeffle Xu wrote:
> Hi,
> How about this patch to remove the extra poll_capable() method?
> 
> And the following 'dm: support IO polling for bio-based dm device' needs
> following change.
> 
> ```
> +       /*
> +        * Check for request-based device is remained to
> +        * dm_mq_init_request_queue()->blk_mq_init_allocated_queue().
> +        * For bio-based device, only set QUEUE_FLAG_POLL when all underlying
> +        * devices supporting polling.
> +        */
> +       if (__table_type_bio_based(t->type)) {
> +               if (dm_table_supports_poll(t)) {
> +                       blk_queue_flag_set(QUEUE_FLAG_POLL_CAP, q);
> +                       blk_queue_flag_set(QUEUE_FLAG_POLL, q);
> +               }
> +               else {
> +                       blk_queue_flag_clear(QUEUE_FLAG_POLL, q);
> +                       blk_queue_flag_clear(QUEUE_FLAG_POLL_CAP, q);
> +               }
> +       }
> ```

Frankly speaking, I don't see any value of using QUEUE_FLAG_POLL_CAP for
DM, and the result is basically subset of treating DM as always being capable
of polling.

Also underlying queue change(either limits or flag) won't be propagated
to DM/MD automatically. Strictly speaking it doesn't matter if all underlying
queues are capable of supporting polling at the exact time of 'write sysfs/poll',
cause any of them may change in future.

So why not start with the simplest approach(always capable of polling)
which does meet normal bio based polling requirement?



Thanks,
Ming

