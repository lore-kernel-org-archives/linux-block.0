Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEB8C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 16:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCAE62087E
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 16:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="znq+fTgc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfCRQ0D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:26:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32851 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfCRQ0D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 12:26:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id i19so11626652pfd.0
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2019 09:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cUscf38WuHw/6CRtCjGBOmERQXd4dmutO0qrnxAL9nE=;
        b=znq+fTgc76k/hT+k+LOXD9SwWU9zrMKqCnutwAdfDZDDXlhsmAJMqsDEnTm/+05x63
         7A5QOSHzt/2Xm2HsqvNGjqikBpQAeUceDckAVisE65AVD6iAXT8KLXdQbqigm3dIaee5
         GJqrPZgJuDZoWOMiGJqx1z2bNzyZPZvsrw0qjGlCSHM+HVGhY9GRWGncObNBIVVaNlnW
         GSynupzHP/R3Q+6lUrzx5tU3AR8/apsNBi5L7M+CErHUuVaFlTs1yHnv6dlqxn7tkZHH
         ZA9ToqWnw+XekLdMUvgtzFFl883KUQoZ9iaNAfhvQ7PKAVv+zPyWbE8pEM9nUuIzKB84
         W3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cUscf38WuHw/6CRtCjGBOmERQXd4dmutO0qrnxAL9nE=;
        b=XoadfznSkFHQFxjOvVZ19LcHpg0aT8QrBx6+u/JYji7HVvv0DGOKbCmDKdtTTBPlzZ
         10WBjWjjlfqohEoVZRY7mwz92KpXFDIyjQ1kuyo9gk4BRr9Djjpf4m1lk+TQvEn+0/iZ
         z81Ws2f+U1uBuGeXq8YCLjsQKZD9uk1MNQLpoKlfGalPp3oN4HfOGNTtZS/9fbUd3VZE
         7p1IO6IWpzLmt6iE4LpPTT6F5tEsesiKrszQ+kq0/CV4MyCjL6JmW+cF53R1bIOpe8sh
         Wbml0gVoqesSP95jac7lddcoP7LJCzJfk+tCOwqVh8jqMb554/8lq9hetDHczzNpPR8q
         XHYg==
X-Gm-Message-State: APjAAAWFyc58bY+gihXQ/qc6RPNYdrL+LoLl3ro8jDUkzif65rPk2FP0
        9C32rx2VWzJoISToU2aVctc1EI/AxPuuUQ==
X-Google-Smtp-Source: APXvYqzqWP0FG871fQ9cNYp0JQCeilTr7PbmpgSV8wDsBn8NXEDbTxD1Tx1+aNOF4dKxfn6eZmTFcw==
X-Received: by 2002:a63:540c:: with SMTP id i12mr18355811pgb.69.1552926361713;
        Mon, 18 Mar 2019 09:26:01 -0700 (PDT)
Received: from [10.111.76.104] (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id h3sm6589977pfb.31.2019.03.18.09.26.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 09:26:00 -0700 (PDT)
Subject: Re: [PATCH 01/18] lightnvm: pblk: fix warning in pblk_l2p_init()
To:     Igor Konopko <igor.j.konopko@intel.com>, javier@javigon.com,
        hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-2-igor.j.konopko@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <5527ef9e-0e09-7bd8-9d2d-b9638425c86e@lightnvm.io>
Date:   Mon, 18 Mar 2019 09:25:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190314160428.3559-2-igor.j.konopko@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/14/19 9:04 AM, Igor Konopko wrote:
> This patch fixes a compilation warning caused by improper format
> specifier provided in pblk_l2p_init().
> 
> Fixes: fe0c220 ("lightnvm: pblk: cleanly fail when there is not enough memory")
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
>   drivers/lightnvm/pblk-init.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index 1940f89..1e227a0 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -159,7 +159,7 @@ static int pblk_l2p_init(struct pblk *pblk, bool factory_init)
>   					| __GFP_RETRY_MAYFAIL | __GFP_HIGHMEM,
>   					PAGE_KERNEL);
>   	if (!pblk->trans_map) {
> -		pblk_err(pblk, "failed to allocate L2P (need %ld of memory)\n",
> +		pblk_err(pblk, "failed to allocate L2P (need %zu of memory)\n",
>   				map_size);
>   		return -ENOMEM;
>   	}
> 

Thanks Igor. I pulled it into the original patch.
