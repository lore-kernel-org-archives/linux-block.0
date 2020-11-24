Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BA8C2D0E4
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 03:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E27B22085B
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 03:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgKXD2d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Nov 2020 22:28:33 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37275 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgKXD2c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Nov 2020 22:28:32 -0500
Received: by mail-pl1-f193.google.com with SMTP id bj5so9147154plb.4
        for <linux-block@vger.kernel.org>; Mon, 23 Nov 2020 19:28:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o6xqCpcCwQxDNvNzkySXeO3yCgRU5kI353/INUpoWBA=;
        b=AWpy7nY75OeVDveLNG1B5LtkfQR8Srcaog5nHiDh1Fp8uuHAdVhwn2i4tQwHlDshof
         NfasFw862hPPxXnuKyoPYEC4F3L91WDhDPv5lXh1loroOFeCCWnpXqJxt0T6Q0wkyYbB
         gMAN3htOmv7BsSbGTG1ziyugn6j76EObA2CRUCWQ01YNh48twYStxq3RUugXO4Nrg4OS
         +mNfLwXatK0ZQSPI97ArJHGWjEHs7skDuljJUm2K1ohvOtDbYF/mOVquaVgHIml+dVpa
         qWk/hsZyyrM4mfodY/MFVLRkjr54XcnuWoWY5jpBSfBJhApKGcmhjZ88U0RpJJQo/Ekz
         ciDw==
X-Gm-Message-State: AOAM530nAlOXdRo2gnGyAdf7k5BRYA5MHj92FN1/zVfLyM2sDPLMz1sG
        uMqXuD1qPYilKOc4XLuWyHo1BYH5/Oc=
X-Google-Smtp-Source: ABdhPJzBxocinQ6eFQejqenY+0JGzhM9v713BTYKJWRGlvHc6HuZpoIZvQzSpVQT8kJrPHKAbOl8FQ==
X-Received: by 2002:a17:902:d346:b029:d9:d097:ed15 with SMTP id l6-20020a170902d346b02900d9d097ed15mr2095625plk.1.1606188510393;
        Mon, 23 Nov 2020 19:28:30 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id 12sm826500pjn.19.2020.11.23.19.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 19:28:29 -0800 (PST)
Subject: Re: [PATCH blktests 3/5] tests/nvmeof-mp/012: fix the schedulers list
To:     Yi Zhang <yi.zhang@redhat.com>, osandov@osandov.com
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me
References: <20201124010427.18595-1-yi.zhang@redhat.com>
 <20201124010427.18595-4-yi.zhang@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <241aba9c-b57b-e81a-63b9-d79a3178d946@acm.org>
Date:   Mon, 23 Nov 2020 19:28:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201124010427.18595-4-yi.zhang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/23/20 5:04 PM, Yi Zhang wrote:
> There is no cfg scheduler and new added kyber scheduler in lastest kernel,
              ^^^
              cfq?
> so get the scheduler from sysfs

[ ... ]

>  	# Load all I/O scheduler kernel modules
>  	for m in "/lib/modules/$(uname -r)/kernel/block/"*.ko; do
> @@ -17,15 +17,17 @@ test_io_schedulers() {
>  	for mq in y n; do
>  		use_blk_mq ${mq} || return $?
>  		dev=$(get_bdev 0) || return $?
> -		for sched in noop deadline bfq cfq; do
> -			set_scheduler "$(basename "$(readlink -f "${dev}")")" $sched \
> +		dm=$(basename "$(readlink -f "${dev}")") || return $?
> +		scheds=$(sed 's/[][]//g' /sys/block/"$dm"/queue/scheduler) || return $?
> +		for sched in $scheds; do
> +			set_scheduler "$dm" "$sched" \

Similar code occurs in tests/srp/012. Please introduce a function for
retrieving the scheduler list and also update tests/srp/012.

Thanks,

Bart.
