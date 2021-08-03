Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253DCC4338F
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 01:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFD0560FC2
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 01:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbhHCByd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Aug 2021 21:54:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55619 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233208AbhHCByc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Aug 2021 21:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627955662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kdPvJ8WpeAFRdll/Nc38pRnvFOYYQxUov/alIMDK00U=;
        b=JJqETkcHTNImluQP8uzPBZ+GGCTy1V88/LGwi87rkOS8d6VVITjMbaRMafKG0ma1//iLwj
        BvpvrQlRextsWvUtESee7QHDU767EsO1ZpvyCscPHYpvWWdqn5XIQ7F2C4nIiIhhaGiwNC
        AM6qRuOlNU+g321QJuGdkgCVuFdrv0U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-UDyvyexiPu67logZMSunGQ-1; Mon, 02 Aug 2021 21:54:21 -0400
X-MC-Unique: UDyvyexiPu67logZMSunGQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 470911084F53;
        Tue,  3 Aug 2021 01:54:19 +0000 (UTC)
Received: from T590 (ovpn-13-136.pek2.redhat.com [10.72.13.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D04B1ABD8;
        Tue,  3 Aug 2021 01:54:11 +0000 (UTC)
Date:   Tue, 3 Aug 2021 09:54:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Martijn Coenen <maco@android.com>
Subject: Re: [PATCH 1/2] loop: Prevent that an I/O scheduler is assigned
Message-ID: <YQihyvnN3msaNyDW@T590>
References: <20210803000200.4125318-1-bvanassche@acm.org>
 <20210803000200.4125318-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803000200.4125318-2-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 02, 2021 at 05:01:59PM -0700, Bart Van Assche wrote:
> Loop devices have a single hardware queue. Hence, the block layer function
> elevator_get_default() selects the mq-deadline scheduler for loop devices.
> Using the mq-deadline scheduler or any other I/O scheduler for loop devices
> incurs unnecessary overhead. Make the loop driver pass the flag
> BLK_MQ_F_NOSCHED to the block layer core such that no I/O scheduler can be
> associated with block devices. This approach has an advantage compared to
> letting udevd change the loop I/O scheduler to none, namely that
> synchronize_rcu() does not get called.
> 
> It is intentional that the flag BLK_MQ_F_SHOULD_MERGE is preserved.
> 
> This patch reduces the Android boot time on my test setup with 0.5 seconds.

Can you investigate why none reduces Android boot time? Or reproduce &
understand it by a fio simulation on your setting?

> 
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Martijn Coenen <maco@android.com>
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/block/loop.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index f8486d9b75a4..9fca3ab3988d 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -2333,7 +2333,8 @@ static int loop_add(int i)
>  	lo->tag_set.queue_depth = 128;
>  	lo->tag_set.numa_node = NUMA_NO_NODE;
>  	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
> -	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING;
> +	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING |
> +		BLK_MQ_F_NO_SCHED;

Loop directio needs io merge, so it isn't good to set NO_SCHED
unconditionally, see:

40326d8a33d5 ("block/loop: allow request merge for directio mode")

Thanks,
Ming

