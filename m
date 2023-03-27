Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F393C761AF
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 12:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjC0M2r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 08:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjC0M2n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 08:28:43 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E85C3AA8
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 05:28:41 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r11so8587350wrr.12
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 05:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112; t=1679920120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7JE7QdvKaZYNiC+EHD6Zp12m/upgFyEAxrLdJhc4mQQ=;
        b=2L0cR5VE2NFhVPykwsr4iw3GlHlZuOz/yTvn7XLSW0BbgbuceoOqdTYO3ba2irsviG
         tqODrs0635EEPHYkxxMW6IP5tFr+qNcFFuZsCaEN5jSFRvtzh4aodQEruC0iH7w8RGPf
         w4v4HSAzC4/lTVdvhrdGUAHvQLybaEoXo0jQSluLK4+n8sBIGulmpBtWxlhiETyPS6+9
         FDxT8anFyaMOG+pEsCtl34lHodYnMqdtqWKoNYT4DA+1PTHED3jOL4KcEavojhBrKQDM
         3RkwnlBekLln7xj7/MPlqU+ZeUa//7ckmCFfRFueD1q8Opy3xng9vUWcSqI/5Jq09eFX
         xBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679920120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7JE7QdvKaZYNiC+EHD6Zp12m/upgFyEAxrLdJhc4mQQ=;
        b=cPcBSPTPT5VTFSUiInzM1PXDylKNziZOBE/XbBVhNc75w/k/fyywknfeXebQerJDP9
         4DXjRw/lPT4WZwiim/Bx5iw7xLYBH8NKPB7d3+O+uBq1pktLsklLzeGU5oEr+PMW6C02
         xQR28424yRMzRggC/mLdo2By5jImFmn6mq/0iIqoT4UWioERdj32DOVLRorbKN2SimQd
         DGPmyFa/IDVP04OikE1LXv/KtwcLjspsdOiDGHXc/hmJVJMfLFXJ9Kb9dpdjw8VHvpEq
         bDxdM3Z8+Y1EgCz8Oh69ftUMRX8a/Fh6EYAj/LLDZ0swwbBGZBqlMyXVb+/IXGWnlSaa
         Xz+A==
X-Gm-Message-State: AAQBX9cLSNIXq76KwYFhvqvHtStOYAauc+id1VvGEb7VnZ3bXKd6TH1l
        foLJEoUzblZadTKtgglhny63yg==
X-Google-Smtp-Source: AKy350aYLU0BuXDE6SXKbUGRw51RJogCMJNwzIn8Anvk+Et3prniahCnvNWUrpjPpBnsQ7XeEp0+nQ==
X-Received: by 2002:a5d:6a87:0:b0:2d0:c73d:ef2a with SMTP id s7-20020a5d6a87000000b002d0c73def2amr9184389wru.24.1679920119730;
        Mon, 27 Mar 2023 05:28:39 -0700 (PDT)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id t13-20020adfe10d000000b002db1b66ea8fsm11525226wrz.57.2023.03.27.05.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 05:28:38 -0700 (PDT)
Message-ID: <a989f01e-79a9-44a4-3603-ba4eeeb86dea@linbit.com>
Date:   Mon, 27 Mar 2023 14:28:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH resent] drbd: Fix exception handling in
 nla_put_drbd_cfg_context()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <8d193937-532f-959f-9b84-d911984508aa@web.de>
 <941709b5-d940-42c9-5f31-7ed56e3e6151@web.de>
Content-Language: en-US
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
In-Reply-To: <941709b5-d940-42c9-5f31-7ed56e3e6151@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am 25.03.23 um 15:07 schrieb Markus Elfring:
> Date: Fri, 17 Mar 2023 18:32:05 +0100
> 
> The label “nla_put_failure” was used to jump to another pointer check
> despite of the detail in the implementation of the function
> “nla_put_drbd_cfg_context” that it was determined already that
> the corresponding variable contained a null pointer.
> 
> * Thus return directly after a call of the function
>   “nla_nest_start_noflag” failed.
> 
> * Delete an extra pointer check which became unnecessary
>   with this refactoring.
> 
> 
> This issue was detected by using the Coccinelle software.
> 
> Fixes: 543cc10b4cc5c60aa9fcc62705ccfb9998bf4697 ("drbd: drbd_adm_get_status needs to show some more detail")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/block/drbd/drbd_nl.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index f49f2a5282e1..9cb947127472 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -3187,7 +3187,7 @@ static int nla_put_drbd_cfg_context(struct sk_buff *skb,
>  	struct nlattr *nla;
>  	nla = nla_nest_start_noflag(skb, DRBD_NLA_CFG_CONTEXT);
>  	if (!nla)
> -		goto nla_put_failure;
> +		return -EMSGSIZE;
>  	if (device &&
>  	    nla_put_u32(skb, T_ctx_volume, device->vnr))
>  		goto nla_put_failure;
> @@ -3205,8 +3205,7 @@ static int nla_put_drbd_cfg_context(struct sk_buff *skb,
>  	return 0;
> 
>  nla_put_failure:
> -	if (nla)
> -		nla_nest_cancel(skb, nla);
> +	nla_nest_cancel(skb, nla);
>  	return -EMSGSIZE;
>  }
> 
> --
> 2.40.0
> 

Sorry, I fail to see how this is an improvement over the status quo,
much less a "fix".

Can you identify the issue with the current code and can you explain how
your patch makes it better?

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
