Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E24C56202
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 16:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4421221E9
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 16:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390284AbgKZQab (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 11:30:31 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:46083 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390011AbgKZQaa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 11:30:30 -0500
Received: by mail-pg1-f178.google.com with SMTP id w4so2076250pgg.13
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2020 08:30:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ifkGmc8mND+qMLzPASunlgScgpmcRlcaiOr+D93U+SY=;
        b=lndNq3qaBqIBi3RT8Ki3ls22TgXKoEY7mQNo7xJ07w12MmVx3DWBWwIGkYaXcRIF/e
         Erzq1HaCDDUt22PJlDJyf7sql3opMrBvTpdZn3hY64E8whrporq21x7v36d5YFLBq/on
         zSmI0/LbNeGBC16/AhfE7FIR8QUtjp9xzg5eZNQj3gYNf+HcdFcGIHL0h+keImi9UgFI
         gyL379sprdAaWIn3GuyLIyGs6Jed+2D0fWBVAwHddBxe3XtlyRMOi2D/GEj5l7YM7JWu
         Ev7gBxFTQEeyzu2U/It53sar6kbrsf8Bw7brd6zKftqPr/56DGhAj18UQLOshQyrlC8H
         ojPQ==
X-Gm-Message-State: AOAM531yd2qLlFPSoyvYG03X9XenmYWqHNQ6wfAKpXxbrL4ZXV1gQsOy
        /zJPPwIFlUwbIUhzYiQmzNc=
X-Google-Smtp-Source: ABdhPJyoJjePWFaBIoXwfXZ+BXPnfyVGyk14GMlM6KSqnB50vUSSjdUYY6MZhqNcmISXr/p6Ec0D6Q==
X-Received: by 2002:a17:90b:93:: with SMTP id bb19mr4538489pjb.102.1606408230289;
        Thu, 26 Nov 2020 08:30:30 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id a16sm5261301pfl.125.2020.11.26.08.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 08:30:29 -0800 (PST)
Subject: Re: [PATCH V3 blktests 4/5] common/rc: _have_iproute2 fix for "ip -V"
 change
To:     Yi Zhang <yi.zhang@redhat.com>, osandov@osandov.com
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me
References: <20201126083532.27509-1-yi.zhang@redhat.com>
 <20201126083532.27509-5-yi.zhang@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <deef3eb7-2e2b-7e9b-572d-248200e2eb4d@acm.org>
Date:   Thu, 26 Nov 2020 08:30:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201126083532.27509-5-yi.zhang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/20 12:35 AM, Yi Zhang wrote:
> With below commit, the version will be updated base on the tag
> fbef6555 replace SNAPSHOT with auto-generated version string

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

