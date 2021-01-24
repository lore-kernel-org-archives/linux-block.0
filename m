Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A1FC433E0
	for <linux-block@archiver.kernel.org>; Sun, 24 Jan 2021 16:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1C0B22AAA
	for <linux-block@archiver.kernel.org>; Sun, 24 Jan 2021 16:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbhAXQjv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Jan 2021 11:39:51 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:37601 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbhAXQju (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Jan 2021 11:39:50 -0500
Received: by mail-pg1-f171.google.com with SMTP id z21so7311816pgj.4
        for <linux-block@vger.kernel.org>; Sun, 24 Jan 2021 08:39:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pt65GlXwf76DZ1LYRGzxRJe9I+7Kcrgh557dbUouhEs=;
        b=dlDsMc4QxETTYpOqooFRxDwNcWKpUQME8i7t7pMb5bdMumjuy1n43356cATaNByBi/
         96/b3yM2NAohHtCFqPrAc8eyb1IYiFvTHS7LwunGQ7kd/maLQ3J4QdS17VhyzO8F34BE
         6W+yMMstTrGvUxMm5oLcpPmV7zWvK+4VRNmwMR+L/QBvnq2kCvydofQSv28DjFrrC+Nq
         0ah4tCBEuwhvf0Tre9+bR2DOWZ+gUPsl8qgW7+5/nYyDngGZSJMA2N1jBYdjoXLJI5/i
         jOfL+117UhGUsEVycYo1HLroOhROfKykk89PaRDvb0s2qXa4paRJPP6CC0PLDPbrWYOK
         OE/w==
X-Gm-Message-State: AOAM531xBhPmOJjnA/73SZmSYrlmqmRDe+leg7e9pHjT+6ucIgw+PKiV
        Y1yzSFUlQaBhuWcACrU/tNHtQlT6zWw=
X-Google-Smtp-Source: ABdhPJyVMU0pcAX2DOoblhS3/zILaTbOVk+U9seAp8XkPYNV0BTLHYxJo8uIoER9a4zPJhF1ecHz0A==
X-Received: by 2002:a63:ec4f:: with SMTP id r15mr14309638pgj.344.1611506349732;
        Sun, 24 Jan 2021 08:39:09 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:c1e4:1a69:ee7d:c77b? ([2601:647:4000:d7:c1e4:1a69:ee7d:c77b])
        by smtp.gmail.com with ESMTPSA id ga4sm15615220pjb.53.2021.01.24.08.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 08:39:08 -0800 (PST)
Subject: Re: [PATCH blktests] nvmeof-mp/rc: fix nvmeof-mp failure when
 NVME_TARGET_PASSTHRU enabled
To:     Yi Zhang <yi.zhang@redhat.com>, osandov@fb.com
Cc:     linux-block@vger.kernel.org
References: <20210124052644.6925-1-yi.zhang@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <99bde154-0388-26cd-19ed-354053f3f52a@acm.org>
Date:   Sun, 24 Jan 2021 08:39:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210124052644.6925-1-yi.zhang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/23/21 9:26 PM, Yi Zhang wrote:
> $ ./check nvmeof-mp/001
> nvmeof-mp/001 (Log in and log out)                           [passed]
>     runtime  0.400s  ...  0.457s
> rmdir: failed to remove 'subsystems/nvme-test/passthru/admin_timeout': Not a directory
> rmdir: failed to remove 'subsystems/nvme-test/passthru/device_path': Not a directory
> rmdir: failed to remove 'subsystems/nvme-test/passthru/enable': Not a directory
> rmdir: failed to remove 'subsystems/nvme-test/passthru/io_timeout': Not a directory
> 
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>  tests/nvmeof-mp/rc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
> index c77526f..ab7770f 100755
> --- a/tests/nvmeof-mp/rc
> +++ b/tests/nvmeof-mp/rc
> @@ -265,8 +265,8 @@ stop_nvme_target() {
>  			rm -f -- ports/*/subsystems/* &&
>  			for d in {*/*/*/*,*/*}; do
>  				[ -e "$d" ] &&
> -					[ "$(basename "$(dirname "$d")")" != ana_groups ] &&
> -					rmdir "$d"
> +				[[ ! "$(basename "$(dirname "$d")")" =~ ana_groups|passthru ]] &&
> +				rmdir "$d"
>  			done
>  	)
>  	unload_module nvmet_rdma &&
> 

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
