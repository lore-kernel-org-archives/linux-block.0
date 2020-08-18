Return-Path: <SRS0=KeVv=B4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC507C433E1
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 12:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABCB7206B5
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 12:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVRBvpJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgHRMna (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHRMn0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Aug 2020 08:43:26 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5FFC061389;
        Tue, 18 Aug 2020 05:43:26 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id i20so3812175qkk.8;
        Tue, 18 Aug 2020 05:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lkwb0MC1U017Rc+5srV075yc1RB+zhRumqNLjycHzv0=;
        b=bVRBvpJp1Jn3uK4vw5rxeYNaki/0jZ+GS2lYPzzIV5OyXDx5QK7LCUwXDm4HV0NE6o
         TiwR7qCy6OmPidfUP06gFR//msKvhh2t/wcJfhMYjQ5kikNkqq52A/MnK8bJjBQeHFeD
         89hEQKRV/MGCerWOTPNYyNEOHFoiNZGXfFdooR7eKsrFi0G5RQUvq8W1TD6nsj8o1piV
         MQCHcS8OwsPucbVPmnclJXx8urib9+VQgJA1bGQ8kRPPMEZ7NPjJoi2nZpLT0v2Vpx8w
         qGP07cIEq7Mn1tV2MJi9qdwCMJPOvhrJvLpVvd0IwiiJ4xeqffik42fjpO5Qegcc+8CT
         Z8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lkwb0MC1U017Rc+5srV075yc1RB+zhRumqNLjycHzv0=;
        b=FxMqO/Kctj90Oif71RQzkcKzEfyu/WDku8fSgmJm/i2PwB+FKxStDpVIUmqdL0hUsu
         1Qqc4NsB2yp6xZoM+JUJjtTgpWZy1QGGKcBPLzqTOUu/SzyImuiOWjvrIaPOGY2J1XbF
         QpZWsNvjWWfuobi1VAFxAx0QnKA2XHHY9gLprid2cVad7W2RwiD3D2TMDuZi6UNPjHjp
         NXq8oBaad5joIfGR/nb2xuFZJ2bHgVIVMyqtKFzxZrCKH5khUCoUlgQphMxoO1CFSiXv
         BEQF9CSs8vrAf1rUMOuiQ1/Q7G0H6vX5TDLOCXkOxdgboPYzE4yENC6OzkoOmbgACcLV
         nqfQ==
X-Gm-Message-State: AOAM5316eAyVOarlNmw8bW7YyC9gtqq0AKc+b8AopjP1PBhdBFPOAuld
        /VHNrQ7RAEZPD+bqW/+QqHMe54ej4SNNlZ20
X-Google-Smtp-Source: ABdhPJzTrG9BNxDVZf15ZutpPQz8+OfOrVXp0M8eC/IHCYASQVuHRRYCad4iCp+6VqUxQdtC2GOPsg==
X-Received: by 2002:a37:47cc:: with SMTP id u195mr16979523qka.39.1597754605328;
        Tue, 18 Aug 2020 05:43:25 -0700 (PDT)
Received: from [192.168.1.181] (pool-173-75-208-99.phlapa.fios.verizon.net. [173.75.208.99])
        by smtp.gmail.com with ESMTPSA id y9sm21581828qka.0.2020.08.18.05.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 05:43:24 -0700 (PDT)
Subject: Re: [PATCH] block: rnbd: rnbd-srv: silence uninitialized variable
 warning
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20200818040317.5926-1-brookebasile@gmail.com>
 <20200818052957.GA2253299@ubuntu-n2-xlarge-x86>
From:   Brooke Basile <brookebasile@gmail.com>
Message-ID: <2fd7f9c7-8558-0f81-6a8f-1366f1feb8a2@gmail.com>
Date:   Tue, 18 Aug 2020 08:43:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200818052957.GA2253299@ubuntu-n2-xlarge-x86>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/18/20 1:29 AM, Nathan Chancellor wrote:
> I don't think this is a proper fix since the root cause of the warning
> appears to be that we are ignoring the return value of
> rnbd_bio_map_kern. Should we not set err to that value like this
> (completely untested)?
> 
> Cheers,
> Nathan
> 
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
> index 0fb94843a495..1b71cb2a885d 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -148,7 +148,8 @@ static int process_rdma(struct rtrs_srv *sess,
>   	/* Generate bio with pages pointing to the rdma buffer */
>   	bio = rnbd_bio_map_kern(data, sess_dev->rnbd_dev->ibd_bio_set, datalen, GFP_KERNEL);
>   	if (IS_ERR(bio)) {
> -		rnbd_srv_err(sess_dev, "Failed to generate bio, err: %ld\n", PTR_ERR(bio));
> +		err = PTR_ERR(bio);
> +		rnbd_srv_err(sess_dev, "Failed to generate bio, err: %ld\n", err);
>   		goto sess_dev_put;
>   	}
>   
> 

Ah, I see what you mean.  Thanks for the fix!

Best,
Brooke Basile
