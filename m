Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E98C433FE
	for <linux-block@archiver.kernel.org>; Thu, 28 Apr 2022 03:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242078AbiD1DTk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Apr 2022 23:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239209AbiD1DTi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Apr 2022 23:19:38 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD2C286FB
        for <linux-block@vger.kernel.org>; Wed, 27 Apr 2022 20:16:25 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id p6so3186399plf.9
        for <linux-block@vger.kernel.org>; Wed, 27 Apr 2022 20:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ry1jS4pZIjHZJ/ds3XGvpaBq1+Ha+A1h+ogQMPOU2pk=;
        b=tjnSyImvPfc6il0ntOVL0whkr/yawDM5rwHAH/4swk3kvUC/Bo5WnJEQdTq1YbuUfj
         0Y0Y3X6h5BD0ByKYzeI50syUnbjtECn80OWj1nfhBvOAOtWPPZRurVm9JaTRyTzrzTxb
         p9MtF+yQ6qdR5V0PNyEJppYErF4poyB3FVLtFHwguDTo1zpfHgHVupeEd218MW0xSA8o
         9Vo3cWlB3FXmHksjM5797B1VSmZfFK2YN8ISo+nHdFXvN6eHmmUolu4FRFz4rzsnj/1A
         we/BWwNN7Fq6qAkWxC/LaG27F7SGhwhqmrANS+b8mnDlRmtsTvOhZ0xCuCsoCahiu4uO
         yB7w==
X-Gm-Message-State: AOAM531haHzk9K0k6aS283fNuENDMXfj0uJYr+Gx6/gMlJw48s1zdAN5
        BNsfbEubt5TtFF4LUtMXT6UYOuTEdiE=
X-Google-Smtp-Source: ABdhPJyVuIHNVGXEJ/ETX12t+DgIRE/tRQ23tzaR4z/J5QFnB0ktSIJk/JWj+WDKvV5EDIq1T0nxxA==
X-Received: by 2002:a17:90b:3ec8:b0:1d9:6cbb:8222 with SMTP id rm8-20020a17090b3ec800b001d96cbb8222mr22092813pjb.104.1651115785286;
        Wed, 27 Apr 2022 20:16:25 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090ade0100b001cb3feaddfcsm3595995pjv.2.2022.04.27.20.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 20:16:24 -0700 (PDT)
Message-ID: <0aad33af-e021-95a9-2219-7e516206148a@acm.org>
Date:   Wed, 27 Apr 2022 20:16:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH blktests 3/3] tests/scsi: Add tests for SCSI devices with
 gap zones
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Omar Sandoval <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20220427213143.2490653-1-bvanassche@acm.org>
 <20220427213143.2490653-4-bvanassche@acm.org>
 <20220428003933.jgq3yznlhquacf2m@shindev>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220428003933.jgq3yznlhquacf2m@shindev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/27/22 17:39, Shinichiro Kawasaki wrote:
> On Apr 27, 2022 / 14:31, Bart Van Assche wrote:
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> 
> Hi Bart, the desciption is missing, so I expect you will add it later.
> 
> I think the added test cases fit better with zbd group rather than scsi group
> since the gap between zone capacity and zone size exists for non-scsi ZNS
> devices also. What do you think?

Hi Shinichiro,

Thanks for having taken a look. I will add a description and move these 
tests to the zbd group.

Bart.
