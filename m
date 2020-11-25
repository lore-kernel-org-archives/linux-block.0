Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AE5C63777
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 03:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD02A20782
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 03:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgKYDwB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Nov 2020 22:52:01 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43289 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbgKYDwA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Nov 2020 22:52:00 -0500
Received: by mail-pf1-f193.google.com with SMTP id w202so1049944pff.10
        for <linux-block@vger.kernel.org>; Tue, 24 Nov 2020 19:52:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tlpeFccO61PHmaoj4C/v9kz1BkfpGnKKt2JvzBnDucE=;
        b=U6eENZoqjTkLExxvhyYhjVRnO7deN9qNdjSNqh4JcxgzMajxlTTGicyS1QGQxKzP1j
         uy3xuTFKYqzzAMK567C2JO1jqZA+kvPxuPFcSho5wr4GTH6umAFqBDSp+dZZU9OYp22Y
         yScinqwoSZ2ynfvJNvfgU/uVaFuozu9LaZZmo0rwsb5yIVzhicTrTQYpDlE/lOEBjDUf
         KDut4+D5Mxc9ptHqeN0P3uajDy/Cc024TizGcLeh9t5U/D8IZMSTohZn8bA9A0ADPZMU
         HXONkS92uKRKDi0LHR7/pGHHenoyiOIlI4gz9TlVKiuODwkRl6PT88WuKNDZV/73SXhL
         Z+4g==
X-Gm-Message-State: AOAM530CVccImYRZYwMUjOx4UuzoaziZ0OCz5wb+nSTR06DG6q5WWEDB
        L68QQmcWw6dp3rBcBzvbwUj57uAXy1w=
X-Google-Smtp-Source: ABdhPJzA9E/CY/Ne+7xWSh6gmlvZsy/MRl0y8R/CJPsqUXxmY8a379Fgf3AESt/9gUhcKdPPn3onQg==
X-Received: by 2002:a05:6a00:22c9:b029:198:15b2:bbd3 with SMTP id f9-20020a056a0022c9b029019815b2bbd3mr600168pfj.64.1606276320092;
        Tue, 24 Nov 2020 19:52:00 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id l17sm693137pjy.29.2020.11.24.19.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 19:51:59 -0800 (PST)
Subject: Re: [PATCH blktests 2/5] tests/nvmeof-mp/rc: run nvmeof-mp tests if
 we set multipath=N
To:     Yi Zhang <yi.zhang@redhat.com>, osandov@osandov.com
Cc:     linux-block@vger.kernel.org, sagi@grimberg.me,
        linux-nvme@lists.infradead.org
References: <20201124010427.18595-1-yi.zhang@redhat.com>
 <20201124010427.18595-3-yi.zhang@redhat.com>
 <324d227a-7ba2-309f-4298-ea787dfb76c0@acm.org>
 <04404583-9b7c-571d-7680-9b5253258268@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <3da24cd0-5127-a6e7-ec1d-848c61b12946@acm.org>
Date:   Tue, 24 Nov 2020 19:51:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <04404583-9b7c-571d-7680-9b5253258268@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/24/20 6:04 AM, Yi Zhang wrote:
> Do you mean something like this, could you add more detail here, thanks.
> 
> diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
> index d7a7c87..af700d9 100755
> --- a/tests/nvmeof-mp/rc
> +++ b/tests/nvmeof-mp/rc
> @@ -16,9 +16,9 @@ group_requires() {
> 
>         # Since the nvmeof-mp tests are based on the dm-mpath driver, these
>         # tests are incompatible with the NVME_MULTIPATH kernel
> configuration
> -       # option.
> -       if _have_kernel_option NVME_MULTIPATH; then
> -               SKIP_REASON="CONFIG_NVME_MULTIPATH has been set in .config"
> +       # option and nvme_core: multipath set with Y.
> +       if _have_kernel_option NVME_MULTIPATH &&
> _have_module_param_value nvme_core multipath Y; then
> +               SKIP_REASON="CONFIG_NVME_MULTIPATH has been set in
> .config and nvme_core: multipath should be set with N"
>                 return
>         fi

I may have sent you in the wrong direction. This is what I meant:

	if _have_kernel_option NVME_MULTIPATH &&
	    _have_module_param_value nvme_core multipath Y; then
	    SKIP_REASON="CONFIG_NVME_MULTIPATH has been set in .config and
multipathing has been enabled in the nvme_core kernel module"
	    return
	fi

Thanks,

Bart.
