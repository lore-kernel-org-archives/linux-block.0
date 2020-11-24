Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FC3C63798
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 03:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7E692087C
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 03:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgKXD0a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Nov 2020 22:26:30 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37191 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgKXD0a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Nov 2020 22:26:30 -0500
Received: by mail-pl1-f194.google.com with SMTP id bj5so9144770plb.4
        for <linux-block@vger.kernel.org>; Mon, 23 Nov 2020 19:26:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W6//6ZvX6573PLLZNDv+zmQJndnbDNQGVwH9Emnfll4=;
        b=EdIPTqZI+LIvb6KXbepo/jue4SYbvQBNasbhQV/5mDGdHzl7Vxqz4rIUPf0wi1vcA2
         v3nC9vH2LT3Jj9AOFnu0QD9FQxWlKgMekrT9UcsW4jfSwsLNYlnZQQGXUr8rULR/b2WF
         y/xzV4k8+G4VPPQWYxmG/M6i2l2mo5g4E6vMcvrc0bQeVNLuvDo34mdBjTU02mwg9Tm1
         lodOv4cPnM40Pwac0shL8FAn8rsbMB5dw7DiP9y8APuEBc0e7M14vgAXzqKPVKhhMOFe
         7MCCLsHBy0QYeuBtBYZFnjQjLznPHBGwGXRvYtZX29i3VtBdtXL+g+XlOZ4Afutzy7Bu
         KOaA==
X-Gm-Message-State: AOAM530iPsUYD2YtmYxmpt5yUWEp/IkN6L9nGJ5h40LSVGkGWYkWmiQD
        xk7iX23yj506y0oXnYEzLGw=
X-Google-Smtp-Source: ABdhPJwIoYQm3SQdejdxNNHtT3/QFhrIDeHf5HzXiivMyO8uMiBX9DRZW+/udcPOE79FXy+8KGQSsQ==
X-Received: by 2002:a17:902:ba8b:b029:d9:d8b9:f2d7 with SMTP id k11-20020a170902ba8bb02900d9d8b9f2d7mr2300069pls.77.1606188389487;
        Mon, 23 Nov 2020 19:26:29 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id t9sm529323pfq.39.2020.11.23.19.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 19:26:28 -0800 (PST)
Subject: Re: [PATCH blktests 2/5] tests/nvmeof-mp/rc: run nvmeof-mp tests if
 we set multipath=N
To:     Yi Zhang <yi.zhang@redhat.com>, osandov@osandov.com
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me
References: <20201124010427.18595-1-yi.zhang@redhat.com>
 <20201124010427.18595-3-yi.zhang@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <324d227a-7ba2-309f-4298-ea787dfb76c0@acm.org>
Date:   Mon, 23 Nov 2020 19:26:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201124010427.18595-3-yi.zhang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/23/20 5:04 PM, Yi Zhang wrote:
> To enable it, just do bellow step before we run it:
> $ echo "options nvme_core multipath=N" >/etc/modprobe.d/nvme.conf
> 
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>  tests/nvmeof-mp/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
> index d7a7c87..bc78f14 100755
> --- a/tests/nvmeof-mp/rc
> +++ b/tests/nvmeof-mp/rc
> @@ -17,7 +17,7 @@ group_requires() {
>  	# Since the nvmeof-mp tests are based on the dm-mpath driver, these
>  	# tests are incompatible with the NVME_MULTIPATH kernel configuration
>  	# option.
> -	if _have_kernel_option NVME_MULTIPATH; then
> +	if _have_kernel_option NVME_MULTIPATH && _have_module_param_value nvme_core multipath Y; then
>  		SKIP_REASON="CONFIG_NVME_MULTIPATH has been set in .config"
>  		return
>  	fi

Please set different SKIP_REASON string for each case such that it
remains easy for a blktests user to figure out why these tests have been
skipped.

Thanks,

Bart.
