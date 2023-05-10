Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA21C7EE23
	for <linux-block@archiver.kernel.org>; Wed, 10 May 2023 02:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbjEJCR5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 May 2023 22:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjEJCR4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 May 2023 22:17:56 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613CE213C
        for <linux-block@vger.kernel.org>; Tue,  9 May 2023 19:17:55 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ab0595fc69so10980005ad.0
        for <linux-block@vger.kernel.org>; Tue, 09 May 2023 19:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683685075; x=1686277075;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wMJx/u/pBYVd7Zt4eeqFR3I/fhY0U5ZXB++bJG0vXno=;
        b=SZEUJlGBuDB3sRwE0D/8GD4meNu7D2ZykHyEdRQA1nG96faLOaQgdSi1FM2VUR0ol5
         YPn5q3KPXEgKzUTYl273YA6Q1D/unrkk6BLetzJwChr9/rmC30chg7a+zcGj7Lry5fKR
         MYGt+7K9yLWgCeqqhDTRIG7MBhVtRHY3NdA0dWRvK23W4vsoADNG6KcoLDp/vaW0cW/t
         zFYd5hSRNZqG666tV13mzwZlMiK0f0lAAn8UgkwN26oN+mKNXsHpcrAm2rMnK460oA4i
         R66nv95do3v/+lvUQu2FZu3WcxBTdyE42eNvTy/uue2e6pO18KhV1WY2IlreC+Agj89d
         NnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683685075; x=1686277075;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wMJx/u/pBYVd7Zt4eeqFR3I/fhY0U5ZXB++bJG0vXno=;
        b=ZUXMqhFHxhJ31gIBFy2/2voCfrBJtPnleXIKJahqAm8RpxYQrBgJekNsmGHJKGaDSe
         iWJ/inCK0oBeyzsrKAI2F8nDrWb+yoBvVa6+vpOkSjEM0/QTkzpIwLtTo2lP7apSClm4
         G+0LEWc7oGD+H1qBt8XGi6UkpP8vAxJ0PENyFirnd67Hd08umPCkVdZjgBcxBnxpWI4p
         eF+jFV/FrmTbUFepiL1OHEQdVHjFfb/I3Sq4dxP2TaxhQ/n37BQ+E8gUoZOday2mlicj
         eztx++1Rhr0R+rJV0olCMdTfsRM5OGZjqSz7yf1VIa9zNv2NkYj6kygL6DP6yWpGagiz
         tw2Q==
X-Gm-Message-State: AC+VfDz1VJt7RCBgEjqCzGWGKAJr9qkB8pbcSigNi6SKK06zTV8sQx9x
        zun8GDafkKZoCsW0RtVznz+bXKTTUnNhhe5+C6Y=
X-Google-Smtp-Source: ACHHUZ63SBLSE29exYA5LPsG2pRkV8oXtGxZr/XXJIPvu7KlYtPUBOSp7qEDUVJiCI/bIb/nd/mjUg==
X-Received: by 2002:a17:902:cec7:b0:1ac:6153:50b3 with SMTP id d7-20020a170902cec700b001ac615350b3mr15056493plg.5.1683685074847;
        Tue, 09 May 2023 19:17:54 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id bb5-20020a170902bc8500b001ab05aaae2fsm2361211plb.107.2023.05.09.19.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 19:17:54 -0700 (PDT)
Message-ID: <1155743b-2073-b778-1ec5-906300e0570a@kernel.dk>
Date:   Tue, 9 May 2023 20:17:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [bug report] BUG: kernel NULL pointer dereference, address:
 0000000000000048
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        Guangwu Zhang <guazhang@redhat.com>,
        linux-block@vger.kernel.org, io-uring@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>, Ming Lei <ming.lei@redhat.com>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <CAGS2=YosaYaUTEMU3uaf+y=8MqSrhL7sYsJn8EwbaM=76p_4Qg@mail.gmail.com>
 <ecb54b0d-a90e-a2c9-dfe5-f5cec70be928@huaweicloud.com>
 <cde5d326-4dcb-5b9c-9d58-fb1ef4b7f7a8@huaweicloud.com>
 <007af59f-4f4c-f779-a1b6-aaa81ff640b3@huaweicloud.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <007af59f-4f4c-f779-a1b6-aaa81ff640b3@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/9/23 8:00?PM, Yu Kuai wrote:
> Hi,
> 
> ? 2023/05/10 9:49, Yu Kuai ??:
>> Hi,
>>
>> ? 2023/05/10 9:29, Yu Kuai ??:
>>> Hi,
>>>
>>> ? 2023/05/10 8:49, Guangwu Zhang ??:
>>>> Hi,
>>>>
>>>> We found this kernel NULL pointer issue with latest
>>>> linux-block/for-next, please check it.
>>>>
>>>> Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>>>
>>>>
>>>> [  112.483804] BUG: kernel NULL pointer dereference, address: 0000000000000048
>>
>> Base on this offset, 0x48 match bio->bi_blkg, so I guess this is because
>> bio is NULL, so the problem is that passthrough request insert into
>> elevator.
>>
> Sorry that attached patch has some problem, please try this one.

Let's please fix this in bfq, this isn't a core issue and it's not a
good idea to work around it there.

-- 
Jens Axboe

