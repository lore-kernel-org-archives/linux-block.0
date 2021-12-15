Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7CCC433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Dec 2021 02:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbhLOCvT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Dec 2021 21:51:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37579 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233288AbhLOCvS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Dec 2021 21:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639536678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8k4wLWesikC0TwaBhFaKS2KZwCqUpEoGxYxwRrBzSY8=;
        b=MbCGYHGAGRGFaNMA76LsvxeiyAwpktty1Xt7VejqkL73CQtoyhbX8aivMG4uE7NunXQ7O8
        wZ73LFYTvrZgWQ4baWc3u5dyJYQfacx7MhRIfElgbPNT/c43E0+gWf8XbSX74a3NMK88Eq
        l+Z7SjD2dmtnKOaMTgD4+JRvZDbVXrY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-YrF1xOYKOLO1_JrSGxxkzg-1; Tue, 14 Dec 2021 21:51:15 -0500
X-MC-Unique: YrF1xOYKOLO1_JrSGxxkzg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8D4E10168C0;
        Wed, 15 Dec 2021 02:51:13 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6483A6FB9F;
        Wed, 15 Dec 2021 02:51:11 +0000 (UTC)
Date:   Wed, 15 Dec 2021 10:51:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v2] block: reduce kblockd_mod_delayed_work_on() CPU
 consumption
Message-ID: <YblYGbONJip1hNfu@T590>
References: <0eb94fa3-a1d0-f9b3-fb51-c22eaad225a7@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0eb94fa3-a1d0-f9b3-fb51-c22eaad225a7@kernel.dk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 14, 2021 at 01:49:34PM -0700, Jens Axboe wrote:
> Dexuan reports that he's seeing spikes of very heavy CPU utilization when
> running 24 disks and using the 'none' scheduler. This happens off the
> sched restart path, because SCSI requires the queue to be restarted async,
> and hence we're hammering on mod_delayed_work_on() to ensure that the work
> item gets run appropriately.
> 
> Avoid hammering on the timer and just use queue_work_on() if no delay
> has been specified.
> 
> Reported-and-tested-by: Dexuan Cui <decui@microsoft.com>
> Link: https://lore.kernel.org/linux-block/BYAPR21MB1270C598ED214C0490F47400BF719@BYAPR21MB1270.namprd21.prod.outlook.com/
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 1378d084c770..c1833f95cb97 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1484,6 +1484,8 @@ EXPORT_SYMBOL(kblockd_schedule_work);
>  int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork,
>  				unsigned long delay)
>  {
> +	if (!delay)
> +		return queue_work_on(cpu, kblockd_workqueue, &dwork->work);
>  	return mod_delayed_work_on(cpu, kblockd_workqueue, dwork, delay);

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

