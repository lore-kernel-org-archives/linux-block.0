Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E527AC433F5
	for <linux-block@archiver.kernel.org>; Thu, 31 Mar 2022 22:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237760AbiCaWaM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Mar 2022 18:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiCaWaM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Mar 2022 18:30:12 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD85226F0
        for <linux-block@vger.kernel.org>; Thu, 31 Mar 2022 15:28:22 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bh17so2164569ejb.8
        for <linux-block@vger.kernel.org>; Thu, 31 Mar 2022 15:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IfOtZRORB1RxFk7eCF0hr3qD4wSQzXzDaJoIfYDN2NA=;
        b=xglsZC/N7d9NU6+VLYNaqlcD4KR4g+Qg5eSJHkhmddVA0KfUaS89CceKU8AHno+Sa1
         xi8ecZ67yrkBx1kplPqrM9aLkDZ/IHn/t86IjTspKtLZOACmglt+Xi9nWOeDMshjL+Hf
         3+nHOmDv3Co85ofVCSajYYEFFEDIgnveaLGta7yEhFfv8uEdCq2SJ/Uuou9vr8fThSKX
         pLSMxFfv2nsy9BvivOXUIqrnYPSxViND0qiZ2skVt6JHAHSM6TdPY5QROOYtE63vkguG
         vPnv15XwKmoEjd0TWu1bM09kh6E+jQYHGu1tWL5Ipl7YUsEwvdaG6CguMYeOlKMHzIHX
         V+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IfOtZRORB1RxFk7eCF0hr3qD4wSQzXzDaJoIfYDN2NA=;
        b=K/5/WbSMTdmq7qTp1JLxpt8z4Zo6oBiy0uPE4N0pRaKn6T9L8xmJsXzYNpvLy6Hsm1
         Lqovmy589ZMsv9/RpvFjhYqJCWWaiZpgflESebDtCeC1azQae9sUHLfHlseKqZNQoUtu
         giS65EWeRVmrMTySFzfdvgp3QCqWlJXVrt/kI1glagF2GMq31vAO/PaQ4O/cStQnC20O
         wrqshaJk/E+qCW/TvomcTvTP5+YhALXmA4F+p3WxyBvdikqB+KmKDbd8Vj7QiKs2RbR1
         u1smfdjruaoqm9KO6kgh0VDJvPHrKv5uM+Uzl+ZvaQ9A1w1ShdmTeM20nvPmmHmDxL5U
         jJfQ==
X-Gm-Message-State: AOAM5323qAb9nOd51FcI0HyJ1vHuTXfyWDkGCj8VBLjcWKiTxROKBaI9
        yUYp9u+FdFhgGV7Wbv3BA/Y66g==
X-Google-Smtp-Source: ABdhPJxbz4BRLoMPpfz9Pm2McOQMqgdtY8WdC4wri/gj911kG251S0NfI20VcrSlyyKg7x/7kc3m7w==
X-Received: by 2002:a17:906:7952:b0:6da:94c9:cccb with SMTP id l18-20020a170906795200b006da94c9cccbmr6686482ejo.469.1648765701281;
        Thu, 31 Mar 2022 15:28:21 -0700 (PDT)
Received: from [192.168.178.55] (85-127-190-169.dsl.dynamic.surfer.at. [85.127.190.169])
        by smtp.gmail.com with ESMTPSA id y27-20020a170906519b00b006dfaf4466ebsm270582ejk.116.2022.03.31.15.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 15:28:20 -0700 (PDT)
Message-ID: <4dcedb78-355f-ed1a-9af1-27e9e63b5643@linbit.com>
Date:   Fri, 1 Apr 2022 00:28:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Drbd-dev] [PATCH 2/2] drbd: remove check of list iterator
 against head past the loop body
Content-Language: en-US
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        "Bos, H.J." <h.j.bos@vu.nl>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        linux-block@vger.kernel.org,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Mike Rapoport <rppt@kernel.org>, drbd-dev@lists.linbit.com,
        Philipp Reisner <philipp.reisner@linbit.com>
References: <20220331220349.885126-1-jakobkoschel@gmail.com>
 <20220331220349.885126-2-jakobkoschel@gmail.com>
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
In-Reply-To: <20220331220349.885126-2-jakobkoschel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am 01.04.22 um 00:03 schrieb Jakob Koschel:
> When list_for_each_entry() completes the iteration over the whole list
> without breaking the loop, the iterator value will be a bogus pointer
> computed based on the head element.
> 
> While it is safe to use the pointer to determine if it was computed
> based on the head element, either with list_entry_is_head() or
> &pos->member == head, using the iterator variable after the loop should
> be avoided.
> 
> In preparation to limit the scope of a list iterator to the list
> traversal loop, use a dedicated pointer to point to the found element [1].
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>   drivers/block/drbd/drbd_req.c | 42 ++++++++++++++++++++++-------------
>   1 file changed, 27 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
> index c04394518b07..b2571dc77fe6 100644
> --- a/drivers/block/drbd/drbd_req.c
> +++ b/drivers/block/drbd/drbd_req.c
> @@ -332,17 +332,21 @@ static void set_if_null_req_next(struct drbd_peer_device *peer_device, struct dr
>   static void advance_conn_req_next(struct drbd_peer_device *peer_device, struct drbd_request *req)
>   {
>   	struct drbd_connection *connection = peer_device ? peer_device->connection : NULL;
> +	struct drbd_request *iter = req;
>   	if (!connection)
>   		return;
>   	if (connection->req_next != req)
>   		return;
> -	list_for_each_entry_continue(req, &connection->transfer_log, tl_requests) {
> -		const unsigned s = req->rq_state;
> -		if (s & RQ_NET_QUEUED)
> +
> +	req = NULL;
> +	list_for_each_entry_continue(iter, &connection->transfer_log, tl_requests) {
> +		const unsigned int s = iter->rq_state;
> +
> +		if (s & RQ_NET_QUEUED) {
> +			req = iter;
>   			break;
> +		}
>   	}
> -	if (&req->tl_requests == &connection->transfer_log)
> -		req = NULL;
>   	connection->req_next = req;
>   }
>   
> @@ -358,17 +362,21 @@ static void set_if_null_req_ack_pending(struct drbd_peer_device *peer_device, st
>   static void advance_conn_req_ack_pending(struct drbd_peer_device *peer_device, struct drbd_request *req)
>   {
>   	struct drbd_connection *connection = peer_device ? peer_device->connection : NULL;
> +	struct drbd_request *iter = req;
>   	if (!connection)
>   		return;
>   	if (connection->req_ack_pending != req)
>   		return;
> -	list_for_each_entry_continue(req, &connection->transfer_log, tl_requests) {
> -		const unsigned s = req->rq_state;
> -		if ((s & RQ_NET_SENT) && (s & RQ_NET_PENDING))
> +
> +	req = NULL;
> +	list_for_each_entry_continue(iter, &connection->transfer_log, tl_requests) {
> +		const unsigned int s = iter->rq_state;
> +
> +		if ((s & RQ_NET_SENT) && (s & RQ_NET_PENDING)) {
> +			req = iter;
>   			break;
> +		}
>   	}
> -	if (&req->tl_requests == &connection->transfer_log)
> -		req = NULL;
>   	connection->req_ack_pending = req;
>   }
>   
> @@ -384,17 +392,21 @@ static void set_if_null_req_not_net_done(struct drbd_peer_device *peer_device, s
>   static void advance_conn_req_not_net_done(struct drbd_peer_device *peer_device, struct drbd_request *req)
>   {
>   	struct drbd_connection *connection = peer_device ? peer_device->connection : NULL;
> +	struct drbd_request *iter = req;
>   	if (!connection)
>   		return;
>   	if (connection->req_not_net_done != req)
>   		return;
> -	list_for_each_entry_continue(req, &connection->transfer_log, tl_requests) {
> -		const unsigned s = req->rq_state;
> -		if ((s & RQ_NET_SENT) && !(s & RQ_NET_DONE))
> +
> +	req = NULL;
> +	list_for_each_entry_continue(iter, &connection->transfer_log, tl_requests) {
> +		const unsigned int s = iter->rq_state;
> +
> +		if ((s & RQ_NET_SENT) && !(s & RQ_NET_DONE)) {
> +			req = iter;
>   			break;
> +		}
>   	}
> -	if (&req->tl_requests == &connection->transfer_log)
> -		req = NULL;
>   	connection->req_not_net_done = req;
>   }
>   

Hi Jakob,

Both of these look good to me, thanks.

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

Regards, Christoph
