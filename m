Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA4FC3815B
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 13:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEDCA206E9
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 13:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgDTNuA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:50:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35530 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgDTNuA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 09:50:00 -0400
Received: by mail-pg1-f195.google.com with SMTP id t11so5084095pgg.2;
        Mon, 20 Apr 2020 06:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dqyDrH9kmK2QYyWvzW477WYOv3bhBEOkoTNugmt8Z9A=;
        b=COpyHZBQ5clBBd3OLT1zfnIv/+wy9OzvWCmyXh9MQVNqXPw6OGYiP9Kd/SXWUBLHdD
         AGsjfX56FCQfTZjl5ZdTTN0o+2a64LgTWIGfyhRbKKrLMvIXIwM2yLvbsFzKqFtdkzJF
         zyfk2JPRMD1xaFE9OOxvq01G63ugv53Df7O+sC0FZH7xaVfCLWfK68OFAq+qA6MzaoWf
         OIWk1tfO/ltLgYpOfDmPF8b/8no2VSgtRolCB+8QAYVo+ETGE5ldxwIQATFz6aETCFTh
         l+s6Xpqr7nNxoLWxvMDGiT9oeg3V1bsgypkW7AiUvwVumgY9vp6M5CYwRtQ6cgoYABmd
         aoGQ==
X-Gm-Message-State: AGi0PubI2O4HUq+FD1pQRGsj9b/lRl/4Ijmw32GFVuX+jtiCfmpO9BN8
        uZY8FANwDegmCHLn+rhrolI=
X-Google-Smtp-Source: APiQypJ1hvdBWQ805lF9hZGCScgsHPzgj67vtc33+YpTsUjOhC6W/SrIjdaDC5JoovDrZWpBc0o3Rg==
X-Received: by 2002:a62:1d48:: with SMTP id d69mr6461327pfd.102.1587390599504;
        Mon, 20 Apr 2020 06:49:59 -0700 (PDT)
Received: from [100.124.9.192] ([104.129.199.3])
        by smtp.gmail.com with ESMTPSA id e22sm1248730pgh.14.2020.04.20.06.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 06:49:58 -0700 (PDT)
Subject: Re: [PATCH 2/4] loop: Factor out configuring loop from status.
To:     Martijn Coenen <maco@android.com>, axboe@kernel.dk, hch@lst.de,
        ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, Chaitanya.Kulkarni@wdc.com
References: <20200420080409.111693-1-maco@android.com>
 <20200420080409.111693-3-maco@android.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <888a008e-bfa0-6323-413b-5c4bf2485726@acm.org>
Date:   Mon, 20 Apr 2020 06:49:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420080409.111693-3-maco@android.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/20/20 1:04 AM, Martijn Coenen wrote:
>   static int
> -loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
> +loop_set_from_status(struct loop_device *lo, const struct loop_info64 *info)
>   {

An additional question: since this function sets the status of 'lo' 
based on the information in 'info', would "loop_set_status" or 
"loop_set_status_from_info" be a better name for this function?

Thanks,

Bart.
