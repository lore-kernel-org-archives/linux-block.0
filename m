Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4094C56202
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 16:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCC22221E2
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 16:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390011AbgKZQbb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 11:31:31 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46896 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730181AbgKZQba (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 11:31:30 -0500
Received: by mail-pl1-f196.google.com with SMTP id f5so1352770plj.13
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2020 08:31:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sAd42amj9f2C4mx3yl4ovRpJPs9IZ4Qy5bcEqP84rIE=;
        b=e4tLgKC4AemA3Sa0dyEYPBMjMUjqQP7sF/5oY8DXXQm4O4+wGFy7Ny8PJR/anErmrq
         fJP6fy4o4058vYiHIamCxRn1h59pvlhChbUl9u1Gd5B22FQrmZbi6lbAm9g6RYErZPPY
         2KLs8lU0WFDV1kbRpaHB/bYRtFWS2zAeJAGNiFBCAD7DO7FcXUZxPO2/t4IPpmNTOitf
         pdIwFf3TCs0ZYTGO4isLvww061GQqou3RUWxYtuBv9+DnWRDfAQ3Dx9LXKGWwnMWB2zN
         wvj6f4YLMuV8eWETir/T5BdQ3Pk6DnNVmQgLH707y1WnzZ6nLN5hTKXZ+ozamemOzqnd
         Hebw==
X-Gm-Message-State: AOAM531ukRHS3H1l3AS678fJRL/KlsWOCUEsw/IPTrYcQgONbmcsmLDh
        tbtbBQVQGBXM+jpXdZ3ElY0=
X-Google-Smtp-Source: ABdhPJwvA6zWhWW27udzLt0xEIbgV08WY9y94+8iULd9Hs3laDqPTrcBYmuYz6EM5F9CHTBg9JTVxw==
X-Received: by 2002:a17:902:9a4c:b029:d6:a250:ab9f with SMTP id x12-20020a1709029a4cb02900d6a250ab9fmr3389313plv.20.1606408290007;
        Thu, 26 Nov 2020 08:31:30 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id h70sm5273090pfe.49.2020.11.26.08.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 08:31:29 -0800 (PST)
Subject: Re: [PATCH V3 blktests 5/5] common/multipath-over-rdma: allow to set
 use_siw
To:     Yi Zhang <yi.zhang@redhat.com>, osandov@osandov.com
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me
References: <20201126083532.27509-1-yi.zhang@redhat.com>
 <20201126083532.27509-6-yi.zhang@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <86b955bf-6714-0739-3601-d290db8cf04e@acm.org>
Date:   Thu, 26 Nov 2020 08:31:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201126083532.27509-6-yi.zhang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/20 12:35 AM, Yi Zhang wrote:
> With this change, we can change to use siw for nvme-rdma/nvmeof-mp/srp
> testing from cmdline:
> 
> $ use_siw=1 nvme-trtype=rdma ./check nvme/
> $ use_siw=1 ./check nvmeof-mp/
> $ use_siw=1 ./check srp/
> 
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>  common/multipath-over-rdma | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
> index ba6fa0d..b12dec3 100644
> --- a/common/multipath-over-rdma
> +++ b/common/multipath-over-rdma
> @@ -12,7 +12,7 @@ filesystem_type=ext4
>  fio_aux_path=/tmp/fio-state-files
>  memtotal=$(sed -n 's/^MemTotal:[[:blank:]]*\([0-9]*\)[[:blank:]]*kB$/\1/p' /proc/meminfo)
>  max_ramdisk_size=$((1<<25))
> -use_siw=
> +use_siw=${use_siw:-""}
>  ramdisk_size=$((memtotal*(1024/16)))  # in bytes
>  if [ $ramdisk_size -gt $max_ramdisk_size ]; then
>  	ramdisk_size=$max_ramdisk_size

Reviewed-by: Bart Van Assche <bvanassche@acm.org>



