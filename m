Return-Path: <SRS0=YKm5=AU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FE4C433E0
	for <linux-block@archiver.kernel.org>; Thu,  9 Jul 2020 18:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FA2820775
	for <linux-block@archiver.kernel.org>; Thu,  9 Jul 2020 18:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="C12cTNyp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgGISsL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgGISsL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Jul 2020 14:48:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267DAC08C5CE
        for <linux-block@vger.kernel.org>; Thu,  9 Jul 2020 11:48:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so2945495wml.3
        for <linux-block@vger.kernel.org>; Thu, 09 Jul 2020 11:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=K2HPIVgVm0dgxb7EaLUKl19vj4OQ2U7k/zjcvE0F17w=;
        b=C12cTNypghgq3UpvDu72ap8Kh5ujeBHp1l9AxE/75jnup1YaKHC8H3TV0pLZq47Q/s
         /9pXaCN1E1hPnq79RViI79AyDKP5ccGrlR3DH62wOOR9TZrQR2I6k6AbIreJTpFmQd9j
         +x4z4S3T96j1hXHRarJ6YlCiWeA28oKU3Ftg0nWGEAkkd8/StS3Yj3IPnjeRe+6kWi/R
         jQRd/YgRNbZc9V1DE5sZJMLibsNYXC9dqtK2BjkxFNBfhurrkmX6s/80Ggxl2Gfmtd+o
         +6UgG6auSn830k2R4HoYEy8UzdEcI2L8vNTkh4z4GPPLGfMcbDYSbbCPO7qDyakfsyPv
         ZzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=K2HPIVgVm0dgxb7EaLUKl19vj4OQ2U7k/zjcvE0F17w=;
        b=JOItp7bUcQGg4tKzmphJxD2Pj9/FjldB+5/2I2DggQRDZaKieHz9stvH1IGg02+lp6
         dFdHhgFFoXMqxuFvY2vqx/kptVwUqXQamqAtSTZRqVdJ91HLhmxiWtGCBUdlHwpjTVds
         m8lnlup+nfX04Pwl09NVnAKrRj95ASjw+OG3QPwF+aFanReELNpXSnspyj6DNZXdIWl5
         sh808WELwdIIQUY4LeVdttqnV3EyfA0L8amzfpnCq8sA8KIMqunn8itNEuAap9F1pS7j
         zHOeGSZJ8E7oeso1mr1zb4HgfAzW/AxsQcMxodzw6oRF9DYdf4yuYp1a0bkHYkH3Jvpe
         P9fA==
X-Gm-Message-State: AOAM533Q+NXa6ZCL3MmYbnhHE3/HY+fJ8k4pb+dNXV9QXhTsOBZsq9Jl
        KM4dNMvsBjaJUQS7jO3QvngruA==
X-Google-Smtp-Source: ABdhPJz18Y4+7V+0l4RwoVP6OG/rAnoNGERkwu8ZWFCPmjLuX1CVY9UEViJ+ytzlPjHVv2hn12GPDg==
X-Received: by 2002:a05:600c:241:: with SMTP id 1mr1284681wmj.119.1594320489519;
        Thu, 09 Jul 2020 11:48:09 -0700 (PDT)
Received: from ?IPv6:2001:16b8:48a0:3f00:587:bfc1:3ea4:c2f6? ([2001:16b8:48a0:3f00:587:bfc1:3ea4:c2f6])
        by smtp.gmail.com with ESMTPSA id k11sm7603742wrd.23.2020.07.09.11.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 11:48:08 -0700 (PDT)
Subject: Re: [PATCH RFC 4/5] block: add a statistic table for io latency
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Florian-Ewald Mueller <florian-ewald.mueller@cloud.ionos.com>
References: <20200708075819.4531-1-guoqing.jiang@cloud.ionos.com>
 <20200708075819.4531-5-guoqing.jiang@cloud.ionos.com>
 <20200708132958.GC3340386@T590>
 <eb2cf4d0-4260-8f10-0ba9-3cbf4ff85449@cloud.ionos.com>
 <b37dd9cd-aebc-88ee-2b09-ac4eb36ca0f7@cloud.ionos.com>
Message-ID: <cc04e449-3d41-3ef7-10c2-c257512d7650@cloud.ionos.com>
Date:   Thu, 9 Jul 2020 20:48:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <b37dd9cd-aebc-88ee-2b09-ac4eb36ca0f7@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

On 7/8/20 4:06 PM, Guoqing Jiang wrote:
> On 7/8/20 4:02 PM, Guoqing Jiang wrote:
>>> Hi Guoqing,
>>>
>>> I believe it isn't hard to write a ebpf based script(bcc or 
>>> bpftrace) to
>>> collect this kind of performance data, so looks not necessary to do it
>>> in kernel.
>>
>> Hi Ming,
>>
>> Sorry, I don't know well about bcc or bpftrace, but I assume they 
>> need to
>> read the latency value from somewhere inside kernel. Could you point
>> how can I get the latency value? Thanks in advance!
>
> Hmm, I suppose biolatency is suitable for track latency, will look 
> into it.

I think biolatency can't trace data if it is not running, also seems no 
place
inside kernel have recorded such information for ebpf to read, correct me
if my understanding is wrong.

And as cloud provider,we would like to know data when necessary instead
of collect data by keep script running because it is expensive than just 
read
node IMHO.

Thanks,
Guoqing
