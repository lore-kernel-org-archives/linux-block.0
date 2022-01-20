Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED89AC433EF
	for <linux-block@archiver.kernel.org>; Thu, 20 Jan 2022 12:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238941AbiATM4Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jan 2022 07:56:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21961 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236052AbiATM4P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jan 2022 07:56:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642683375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HnjzfSKHnTIW/FDreC+CYQQVdtBa2Yo1in7OBWnPmf0=;
        b=EqW21FaptfKYZsDWWj7Zw6RU7trvGdzGuoDHTMJ9MW1opFET3v2LXE8V9NkNpDLy6HXHfO
        bN6+PIgyhIJEP74Af1j1O9OW0pjuG6u3F6twTzOTyt/k2V3G0FWlCRqa+Oo0znJH3ms/9A
        v1GlRlIbEVuJwcbD34DDBK4Y6uhBA28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-L3eZGrybOe6NN07JrSBFNg-1; Thu, 20 Jan 2022 07:56:14 -0500
X-MC-Unique: L3eZGrybOe6NN07JrSBFNg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 996668144E1;
        Thu, 20 Jan 2022 12:56:12 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 01FDB7D72C;
        Thu, 20 Jan 2022 12:56:07 +0000 (UTC)
Date:   Thu, 20 Jan 2022 20:56:03 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] block: hold queue lock while iterating in
 diskstats_show
Message-ID: <Yelb4+r5KuV67tO0@T590>
References: <20220120105248.117025-1-dwagner@suse.de>
 <20220120105248.117025-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120105248.117025-3-dwagner@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 20, 2022 at 11:52:48AM +0100, Daniel Wagner wrote:
> The request queues can be freed while we operate on them. Make sure we

It shouldn't be freed here.

> hold a reference when using blk_mq_queue_tag_busy_iter.
> 
> RIP: blk_mq_queue_tag_busy_iter

Any chance to pose the whole stack trace?

> Call Trace:
>  ? blk_mq_hctx_mark_pending
>  ? diskstats_show
>  ? blk_mq_hctx_mark_pending
>  blk_mq_in_flight
>  diskstats_show
>  ? klist_next
>  seq_read
>  proc_reg_read
>  vfs_read
>  ksys_read
>  do_syscall_64
>  entry_SYSCALL_64_after_hwframe
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  block/genhd.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index c9d4386dd177..0e163055a4e6 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1167,10 +1167,13 @@ static int diskstats_show(struct seq_file *seqf, void *v)
>  		if (bdev_is_partition(hd) && !bdev_nr_sectors(hd))
>  			continue;
>  		part_stat_read_all(hd, &stat);
> +		if (blk_queue_enter(gp->queue, BLK_MQ_REQ_NOWAIT))
> +			continue;

The disk device's refcnt is supposed to be grabbed by class device
iterator code, so queue shouldn't be released in diskstats_show().

Not mention blk_queue_enter() won't prevent disk from being released...

thanks,
Ming

