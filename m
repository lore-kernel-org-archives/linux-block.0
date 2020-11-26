Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045D5C63777
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 03:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6E3F21741
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 03:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbgKZD7h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 22:59:37 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:40913 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730187AbgKZD7h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 22:59:37 -0500
Received: by mail-pf1-f181.google.com with SMTP id b6so439518pfp.7
        for <linux-block@vger.kernel.org>; Wed, 25 Nov 2020 19:59:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5yglJxjwYOkl0rNuyQ29ZKEbLkJAv4ilYSu4c1LwI5M=;
        b=hPK8cMxG5v4TfNPwNnFhEo5rAr3WD5RLY7H+199Wd+7IAZnP9OCUTrhvFnz03t0DvC
         qg8/i+OO6/xKL3mr1YI3ZaiD4KeCbRurLFhiXk6dEWC7kQpmc+9qkeQdTJEjCNdKkQm8
         aUz5ftu4+/f0Ln/riiah1AnXaPtj/giqGOMvoD9YjP0zzY920Y1u0rniuJeLdUl2WMLA
         qG9UoyPpn8gxcmrWesgc/LvcYvbYPV8d7xXk/zw7dsU9NYehpQsJjAaoj3K9o3f8qfXw
         2mgxs0DNDEWYYO9n4b3jYG0E88XP9Sad2ZTypsrP+KGU8TmnxvFJmv146al/2WsKx4Gb
         V+qA==
X-Gm-Message-State: AOAM532aFbwSIGXsQmtHnywgK/MitDOPU1wkrJRQWPcZP3s6JQtxDmDS
        QaGGLfwORyWqIiDYdj0lvTk=
X-Google-Smtp-Source: ABdhPJxpgwOGNcDQAEnCwGBJTqqjuuhBy4zFzcRG7KVa+kViVTwxo0EVr9fizGOA4Osvddcx9MtNHw==
X-Received: by 2002:a17:90a:f994:: with SMTP id cq20mr1280074pjb.62.1606363177065;
        Wed, 25 Nov 2020 19:59:37 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id v18sm3019913pfn.35.2020.11.25.19.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 19:59:36 -0800 (PST)
Subject: Re: [PATCH V2 blktests 3/5] nvmeof-mp/012, srp/012: fix the scheduler
 list
To:     Yi Zhang <yi.zhang@redhat.com>, osandov@osandov.com
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me
References: <20201125073205.8788-1-yi.zhang@redhat.com>
 <20201125073205.8788-4-yi.zhang@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <7fb6260a-4e3d-f023-7471-266188771f39@acm.org>
Date:   Wed, 25 Nov 2020 19:59:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201125073205.8788-4-yi.zhang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/24/20 11:32 PM, Yi Zhang wrote:
> +# Get block dev scheduler list
> +get_scheduler_list() {
> +	local b=$1 p
> +	p=/sys/block/"$b"/queue/scheduler
> +	if [ -e "$p" ]; then
> +		scheds=$(sed 's/[][]//g' /sys/block/"$b"/queue/scheduler)
> +		echo "$scheds"
> +	else
> +		return 1
> +	fi
> +}

Can the echo statement and the 'scheds' assignment be left out? This is
what I have in mind:

	sed 's/[][]//g' /sys/block/"$b"/queue/scheduler

Otherwise this patch looks good to me.

Thanks,

Bart.
