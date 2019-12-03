Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2846EC432C0
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 15:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17BA20656
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 15:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKUIn2qv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfLCPqD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Dec 2019 10:46:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42104 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725848AbfLCPqD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Dec 2019 10:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575387962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kc5rkL3td8wGQyELKRpVhUJRs7tCH4UJEAnN2TRUY9w=;
        b=GKUIn2qvXUnNcF6HL7WBhWaGat3NxO8U4ONaCOJiHsCBye9yrfHywkqSBipQPoDtj/xsHx
        +H51T1zqmVZSnRpH6RDv3dgI1go6GkfWPtxjVhX5GQ1OIZa091FlnLLoR7caDSFa9tJD6m
        sOa2r2Im5sMW8mb4kjAlqd281oM9SPY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-b_5q-eTlOdeE_p0bfQ0z6w-1; Tue, 03 Dec 2019 10:45:59 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85E38186EA76;
        Tue,  3 Dec 2019 15:45:57 +0000 (UTC)
Received: from [10.10.124.173] (ovpn-124-173.rdu2.redhat.com [10.10.124.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC6F367E5D;
        Tue,  3 Dec 2019 15:45:56 +0000 (UTC)
Subject: Re: [PATCH] nbd: fix shutdown and recv work deadlock
To:     sunke32@huawei.com, nbd@other.debian.org, axboe@kernel.dk,
        josef@toxicpanda.com, linux-block@vger.kernel.org
References: <20191202215150.10250-1-mchristi@redhat.com>
Cc:     stable@vger.kernel.org
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5DE68334.8090605@redhat.com>
Date:   Tue, 3 Dec 2019 09:45:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20191202215150.10250-1-mchristi@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: b_5q-eTlOdeE_p0bfQ0z6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Josef and Jens,

Ignore this patch. It could also deadlock but in a different way, and it
looks like there are other possible issues with races and refcounts. I
will send some new patches.


On 12/02/2019 03:51 PM, Mike Christie wrote:
> This fixes a regression added with:
> 
> commit e9e006f5fcf2bab59149cb38a48a4817c1b538b4
> Author: Mike Christie <mchristi@redhat.com>
> Date:   Sun Aug 4 14:10:06 2019 -0500
> 
>     nbd: fix max number of supported devs
> 
> where we can deadlock during device shutdown. The problem will occur if
> userpsace has done a NBD_CLEAR_SOCK call, then does close() before the
> recv_work work has done its nbd_config_put() call. If recv_work does the
> last call then it will do destroy_workqueue which will then be stuck
> waiting for the work we are running from.
> 
> This fixes the issue by having nbd_start_device_ioctl flush the work
> queue on both the failure and success cases and has a refcount on the
> nbd_device while it is flushing the work queue.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Mike Christie <mchristi@redhat.com>
> ---
>  drivers/block/nbd.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 57532465fb83..f8597d2fb365 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1293,13 +1293,15 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *b
>  
>  	if (max_part)
>  		bdev->bd_invalidated = 1;
> +
> +	refcount_inc(&nbd->config_refs);
>  	mutex_unlock(&nbd->config_lock);
>  	ret = wait_event_interruptible(config->recv_wq,
>  					 atomic_read(&config->recv_threads) == 0);
> -	if (ret) {
> +	if (ret)
>  		sock_shutdown(nbd);
> -		flush_workqueue(nbd->recv_workq);
> -	}
> +	flush_workqueue(nbd->recv_workq);
> +
>  	mutex_lock(&nbd->config_lock);
>  	nbd_bdev_reset(bdev);
>  	/* user requested, ignore socket errors */
> @@ -1307,6 +1309,7 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *b
>  		ret = 0;
>  	if (test_bit(NBD_RT_TIMEDOUT, &config->runtime_flags))
>  		ret = -ETIMEDOUT;
> +	nbd_config_put(nbd);
>  	return ret;
>  }
>  
> 

