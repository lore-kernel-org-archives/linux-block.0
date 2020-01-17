Return-Path: <SRS0=x5xE=3G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87760C33CB6
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 17:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5129D2082F
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 17:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7dNZrFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgAQRcO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jan 2020 12:32:14 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39272 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726763AbgAQRcO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jan 2020 12:32:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579282332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V/YBTzCrOCnTnUPO3jYLrCWgF4tW5vUC7tcFD9TTyzQ=;
        b=P7dNZrFJE86iM8JVKC9HoKCSaIWT7sowqShoXhnZkbhwq18bmWkKPMebj36TM1iq8obnmm
        8Zri94+6VPblxnqgwzSl76gudkbqd8b90w2AN1kIzeW8gVO4pxhBgg7QD1GUwmpKg8JqRn
        Mf7HxV+oU9CKW71mPgUDExW3GGMU/Bw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-EOGSUIB5MLehJqk8hDdr4Q-1; Fri, 17 Jan 2020 12:32:09 -0500
X-MC-Unique: EOGSUIB5MLehJqk8hDdr4Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECA5118CA241;
        Fri, 17 Jan 2020 17:32:07 +0000 (UTC)
Received: from [10.10.126.209] (ovpn-126-209.rdu2.redhat.com [10.10.126.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C9FC581201;
        Fri, 17 Jan 2020 17:32:06 +0000 (UTC)
Subject: Re: [PATCH] nbd: fix potential NULL pointer fault in connect and
 disconnect process
To:     Sun Ke <sunke32@huawei.com>, josef@toxicpanda.com, axboe@kernel.dk
References: <20200117115005.37006-1-sunke32@huawei.com>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5E21EF96.1010204@redhat.com>
Date:   Fri, 17 Jan 2020 11:32:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20200117115005.37006-1-sunke32@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 01/17/2020 05:50 AM, Sun Ke wrote:
> Connect and disconnect a nbd device repeatedly, will cause
> NULL pointer fault.
> 
> It will appear by the steps:
> 1. Connect the nbd device and disconnect it, but now nbd device
>    is not disconnected totally.
> 2. Connect the same nbd device again immediately, it will fail
>    in nbd_start_device with a EBUSY return value.
> 3. Wait a second to make sure the last config_refs is reduced
>    and run nbd_config_put to disconnect the nbd device totally.
> 4. Start another process to open the nbd_device, config_refs
>    will increase and at the same time disconnect it.

Just to make sure I understood this, for step 4 the process is doing:

open(/dev/nbdX);
ioctl(NBD_DISCONNECT, /dev/nbdX) or nbd_genl_disconnect(for /dev/nbdX)

?

There is no successful NBD_DO_IT / nbd_genl_connect between the open and
disconnect calls at step #4, because it would normally be done at #2 and
that failed. nbd_disconnect_and_put could then reference a null
recv_workq. If we are also racing with a close() then that could free
the device/config from under nbd_disconnect_and_put.

> 
> To fix it, add a NBD_HAS_STARTED flag. Set it in nbd_start_device_ioctl

I'm not sure if we need the new bit. We could just add a check for a non
null task_recv in nbd_genl_disconnect like how nbd_start_device and
nbd_genl_disconnect do.

The new bit might be more clear which is nice. If we got this route,
should the new bit be a runtime_flag like other device state bits?


> and nbd_genl_connect if nbd device is started successfully.
> Clear it in nbd_config_put. Test it in nbd_genl_disconnect and
> nbd_genl_reconfigure.
> 
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
>  drivers/block/nbd.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index b4607dd96185..ddd364e208ab 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -83,6 +83,7 @@ struct link_dead_args {
>  
>  #define NBD_DESTROY_ON_DISCONNECT	0
>  #define NBD_DISCONNECT_REQUESTED	1
> +#define NBD_HAS_STARTED				2
>  
>  struct nbd_config {
>  	u32 flags;
> @@ -1215,6 +1216,7 @@ static void nbd_config_put(struct nbd_device *nbd)
>  		nbd->disk->queue->limits.discard_alignment = 0;
>  		blk_queue_max_discard_sectors(nbd->disk->queue, UINT_MAX);
>  		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, nbd->disk->queue);
> +		clear_bit(NBD_HAS_STARTED, &nbd->flags);
>  
>  		mutex_unlock(&nbd->config_lock);
>  		nbd_put(nbd);
> @@ -1290,6 +1292,8 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *b
>  	ret = nbd_start_device(nbd);
>  	if (ret)
>  		return ret;
> +	else
> +		set_bit(NBD_HAS_STARTED, &nbd->flags);
>  
>  	if (max_part)
>  		bdev->bd_invalidated = 1;
> @@ -1961,6 +1965,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
>  	mutex_unlock(&nbd->config_lock);
>  	if (!ret) {
>  		set_bit(NBD_RT_HAS_CONFIG_REF, &config->runtime_flags);
> +		set_bit(NBD_HAS_STARTED, &nbd->flags);
>  		refcount_inc(&nbd->config_refs);
>  		nbd_connect_reply(info, nbd->index);
>  	}
> @@ -2008,6 +2013,14 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
>  		       index);
>  		return -EINVAL;
>  	}
> +
> +	if (!test_bit(NBD_HAS_STARTED, &nbd->flags)) {
> +		mutex_unlock(&nbd_index_mutex);
> +		printk(KERN_ERR "nbd: device at index %d failed to start\n",
> +		       index);
> +		return -EBUSY;
> +	}
> +
>  	if (!refcount_inc_not_zero(&nbd->refs)) {
>  		mutex_unlock(&nbd_index_mutex);
>  		printk(KERN_ERR "nbd: device at index %d is going down\n",
> @@ -2049,6 +2062,14 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
>  		       index);
>  		return -EINVAL;
>  	}
> +
> +	if (!test_bit(NBD_HAS_STARTED, &nbd->flags)) {
> +		mutex_unlock(&nbd_index_mutex);
> +		printk(KERN_ERR "nbd: device at index %d failed to start\n",
> +		       index);
> +		return -EBUSY;
> +	}
> +
>  	if (!refcount_inc_not_zero(&nbd->refs)) {
>  		mutex_unlock(&nbd_index_mutex);
>  		printk(KERN_ERR "nbd: device at index %d is going down\n",
> 

