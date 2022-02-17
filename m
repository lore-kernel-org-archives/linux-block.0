Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8643C433F5
	for <linux-block@archiver.kernel.org>; Thu, 17 Feb 2022 03:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiBQDAc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 22:00:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiBQDAb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 22:00:31 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CD011798C
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 19:00:18 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id 10so3551782plj.1
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 19:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=N60qr2krIAjXbDIrmScAICdv9KtrKPICkqaKlx8WkGM=;
        b=c80wYtRFkO6AOaiuqPTXpb/f10Jdb53VzVcSdM4Ope0zVGssdPIhZ6ZjX+PCgSaro+
         1uFUhNI/STauWf6uqVH6BlZ0T+AvBAVs4n/5gtRx8Q3PPepU8CTAO83R0F+6ahfo9zKY
         now12eflm1+llaacTjC3ZoBlP8ciky7yCmafNQnjTc6zjtoPfAm84aLx2fPNDpJxfNj2
         FtEQ84Ro2djp1YOXDS5UxVpLHM35eKLSa61RjaEAXsRqTRme/rsEVV5Y1qV/NSwPeZe2
         lVrRhdTS2liU7NgJBd2YvWX1MLnV/BnbcZf/d35BOh1vfCXs0KuVcBqxedywXa6kBLeg
         2+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N60qr2krIAjXbDIrmScAICdv9KtrKPICkqaKlx8WkGM=;
        b=uRKRYE9Y4DFbQSpMmFCUiSkLHj2BQnp35ZbF7ejT0KWc+hH9hhF8b2qg5gKRucTZHJ
         RTvTcPhatH7snWkMlG6Qs9Jkymi1G6uPKawBwqGK1cR92o3Vd8FaKD+jf46uct7obHed
         yJmwbLiYlqsN+0Dq/FKrdempgSjzZNipj4OXKMM8YOedt88q6xxXc+kkBFdYfA+FZW54
         1Y2sboGPPDDF9jVyjkia/Cyml2zcSSkXACoRwqcjMW0PJ8cD8ODdW1HDMQDCIVrljxM7
         o+9md7v3hhzpUnURiBkHxgphDR1i4Ky1HttjLY0jnUbC1uJ+O51yiksedXqufmtXdsWK
         nguQ==
X-Gm-Message-State: AOAM533gh9Q5oEM2SYrgSoh+9RjIOH06MOUdmgyCztvwhnud0oemaWvB
        wOPhXYfgNxbPJzQwFNxrRNY=
X-Google-Smtp-Source: ABdhPJyK/TayBrEJbcMxiXvfCxx0dV3bnTBjFtt6pymkLzKBLkvAdvBj/SDj7rlooiXR5xdnpbjsFw==
X-Received: by 2002:a17:903:1207:b0:14d:537b:40f6 with SMTP id l7-20020a170903120700b0014d537b40f6mr923722plh.50.1645066818162;
        Wed, 16 Feb 2022 19:00:18 -0800 (PST)
Received: from [172.20.119.15] ([61.16.102.71])
        by smtp.gmail.com with ESMTPSA id o8sm320805pfu.90.2022.02.16.19.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 19:00:17 -0800 (PST)
Message-ID: <8e2a7c6a-01b2-39f5-758c-467fed461488@gmail.com>
Date:   Thu, 17 Feb 2022 11:00:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [[RFC blktests]] test/block/032: add test cases for switching
 queue qos
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "osandov@osandov.com" <osandov@osandov.com>
References: <20220216115947.85220-1-jianchao.wan9@gmail.com>
 <44ef4a68-054e-9b96-b40a-f9d1e65ddb0b@nvidia.com>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
In-Reply-To: <44ef4a68-054e-9b96-b40a-f9d1e65ddb0b@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2022/2/17 1:34 上午, Chaitanya Kulkarni wrote:
> On 2/16/22 03:59, Wang Jianchao (Kuaishou) wrote:
>> Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
>> ---
>>   tests/block/032     | 62 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/block/032.out |  2 ++
>>   2 files changed, 64 insertions(+)
>>   create mode 100644 tests/block/032
>>   create mode 100644 tests/block/032.out
>>
>> diff --git a/tests/block/032 b/tests/block/032
> 
> 
> Can you please add some comments to make it easier to read for someone
> who's new to the blktests framework ?
> 

I will add some comment to explain what does the test case do in next version.

Thanks
Jianchao
 
