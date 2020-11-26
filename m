Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE346C56202
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 03:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 665E321741
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 03:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387527AbgKZDyT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 22:54:19 -0500
Received: from mail-pg1-f177.google.com ([209.85.215.177]:41791 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387526AbgKZDyT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 22:54:19 -0500
Received: by mail-pg1-f177.google.com with SMTP id s63so558194pgc.8
        for <linux-block@vger.kernel.org>; Wed, 25 Nov 2020 19:54:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ljeqi4iuVJAeyFS6+4rMz1sERhKaFo1LuqTr/QOmZEA=;
        b=JGneV5uzaLVozd3xTaJVRnnVyxOIOq8SUXxaTviqLFvuuxjJ2zhDdasxAxVxfaCl1m
         JYckTHk0ddGgP6I6V74dYXyGgqmh81h9kKO/ej0s2qYbpuOdKbLttvQXdaod0Xz7jONk
         CH7uSYXjhT6urj2WultbLcP/+MCGmLMJDNQXGxCEC5SMGtIjKBoH8NluLfqXRJ6OrcLJ
         AvJIJ2RyzNsfWVa75nRQ9gx6g/YjqPA03HUoN/LbXMrUT6NBJLsxnMj8kmVeX0hcNvxY
         wLqIyQsixQES8M4l3taWsuzfo+C6niGHYXjI0Er/wYDINaIlaNqAA8WsLbJtzbvTakYb
         KM8w==
X-Gm-Message-State: AOAM530DF79frGn+FVYKRpE2jv/Xw9b8IOxt6zXwb1qynDoniZxFntYN
        ynt40XvScS87wARm0q2YJrY=
X-Google-Smtp-Source: ABdhPJxsTRwIdRAmKUbH8b6cTyngSGjo6dFo/s5E7G4QMLRevScdt6KalCIbpl8mYK3Xau8h7oY8tA==
X-Received: by 2002:a17:90a:7e0f:: with SMTP id i15mr1255407pjl.93.1606362858857;
        Wed, 25 Nov 2020 19:54:18 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id a123sm3229515pfd.218.2020.11.25.19.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 19:54:17 -0800 (PST)
Subject: Re: [PATCH V2 blktests 2/5] tests/nvmeof-mp/rc: run nvmeof-mp tests
 if we set multipath=N
To:     Yi Zhang <yi.zhang@redhat.com>, osandov@osandov.com
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me
References: <20201125073205.8788-1-yi.zhang@redhat.com>
 <20201125073205.8788-3-yi.zhang@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <91045630-3a91-15ca-511b-d50db339b82d@acm.org>
Date:   Wed, 25 Nov 2020 19:54:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201125073205.8788-3-yi.zhang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/24/20 11:32 PM, Yi Zhang wrote:
> To enable it, just do bellow step before we run it:
> $ echo "options nvme_core multipath=N" >/etc/modprobe.d/nvme.conf

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
