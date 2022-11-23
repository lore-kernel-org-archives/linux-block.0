Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9B3C4332F
	for <linux-block@archiver.kernel.org>; Wed, 23 Nov 2022 10:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbiKWKcf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Nov 2022 05:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbiKWKbf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2022 05:31:35 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468CDE222F
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 02:16:03 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id n3so12083924wrp.5
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 02:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=myxP9QEkyYqaVrVe1TQMCWc6JB21jpqjpRuaT56xqR4=;
        b=ujrxI624TqsSqPUxNaUT0yOYo4gXvhv9lkHeqEaSJCChOnF3bFWDTu+65Y7ONJZzrR
         Yeh6ySwaSJ+gGPbo85lHe3gn8z+/ih4U2lnhMnlMl/xuZ3C6ZVi5TQax/ZNbAKDUnkXM
         sGHxP/4LRjUQswBuU2WMYCadFH2L7QUMPpiBp7xOqW73BI5+bHIYUoyWzKvVZO6J3ONW
         BLFemZclgqfTwFPZ9Pnbln02pXv2RhuPLZ1QUVxTMin7sShjd6HOPxhnGD806EhVpbV+
         mdQn5/jcDckLE1fGGrvoJenhVJxaUS+mtF1X8h0ekypEO2yK0eZNKM52S5J3TxCdUll6
         iJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=myxP9QEkyYqaVrVe1TQMCWc6JB21jpqjpRuaT56xqR4=;
        b=39GjFA+Ty0PBYWet+RT4qXKer+eKL00cHsQCdVJFaXnQ0O7XmISL26OUi5IxZn6eXh
         mK5Gzgdkw7EpaP4aHpZd3o1C3pW+RDU6f08OYPJLQHQZplkMSfUd+mib0ojP2hfeKMsb
         UbxS+IadK7AS2IBzGIZYxiFz6bWQBnNM7rmqX1SigVMJXIVHvT6+TX6kOG6daASPRN34
         hipmq8NzoN9hrGREkHKjTOfzGcd8KAHV4jFK7Vlix5EWrQ2bZ6TQ0Y4jpEjl1K0xatmw
         gEBIAUFzWvOudadEUyk+KdNOqttMGXZqb0EMh9mNDcjUXTv8+kIzlR5QVQiiRt+/POoh
         Ci9A==
X-Gm-Message-State: ANoB5pkEUPRf/x3o2ZdNdaKgApsnC86d6gN+Mt5sF0Fh7iRkqx1x6R+A
        2NEKziuLsIVPLT9e5YMZ67PepD10uBe79sEl
X-Google-Smtp-Source: AA0mqf6QP/aXHYq2bDk7tA2e5u9jknzUIDXixL3OTnNqjdpGBytgmxYg7wZPXNrh/ilSjfqvhPLsCg==
X-Received: by 2002:adf:fe47:0:b0:241:9aea:4396 with SMTP id m7-20020adffe47000000b002419aea4396mr17189386wrs.438.1669198561660;
        Wed, 23 Nov 2022 02:16:01 -0800 (PST)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id y3-20020adfee03000000b002365254ea42sm16246969wrn.1.2022.11.23.02.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 02:16:01 -0800 (PST)
Message-ID: <7d972801-148a-87b2-9fe1-9992b943916f@linbit.com>
Date:   Wed, 23 Nov 2022 11:16:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 1/2] drbd: remove call to memset before free
 device/resource/connection
Content-Language: en-US
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     liwei391@huawei.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, axboe@kernel.dk,
        lars.ellenberg@linbit.com
References: <20221123020355.2470160-1-bobo.shaobowang@huawei.com>
 <20221123020355.2470160-2-bobo.shaobowang@huawei.com>
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
In-Reply-To: <20221123020355.2470160-2-bobo.shaobowang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am 23.11.22 um 03:03 schrieb Wang ShaoBo:
> This revert c2258ffc56f2 ("drbd: poison free'd device, resource and
> connection structs"), add memset is odd here for debugging, there are
> some methods to accurately show what happened, such as kdump.
> 
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---
>  drivers/block/drbd/drbd_main.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index 8532b839a343..78cae4e75af1 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -2217,7 +2217,6 @@ void drbd_destroy_device(struct kref *kref)
>  		kref_put(&peer_device->connection->kref, drbd_destroy_connection);
>  		kfree(peer_device);
>  	}
> -	memset(device, 0xfd, sizeof(*device));
>  	kfree(device);
>  	kref_put(&resource->kref, drbd_destroy_resource);
>  }
> @@ -2309,7 +2308,6 @@ void drbd_destroy_resource(struct kref *kref)
>  	idr_destroy(&resource->devices);
>  	free_cpumask_var(resource->cpu_mask);
>  	kfree(resource->name);
> -	memset(resource, 0xf2, sizeof(*resource));
>  	kfree(resource);
>  }
>  
> @@ -2650,7 +2648,6 @@ void drbd_destroy_connection(struct kref *kref)
>  	drbd_free_socket(&connection->data);
>  	kfree(connection->int_dig_in);
>  	kfree(connection->int_dig_vv);
> -	memset(connection, 0xfc, sizeof(*connection));
>  	kfree(connection);
>  	kref_put(&resource->kref, drbd_destroy_resource);
>  }

Thanks!

Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
