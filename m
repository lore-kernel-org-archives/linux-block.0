Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AD3C43334
	for <linux-block@archiver.kernel.org>; Tue, 19 Jul 2022 17:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238226AbiGSRMT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jul 2022 13:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238316AbiGSRMO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jul 2022 13:12:14 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7455058844
        for <linux-block@vger.kernel.org>; Tue, 19 Jul 2022 10:12:13 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id bf13so14044791pgb.11
        for <linux-block@vger.kernel.org>; Tue, 19 Jul 2022 10:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=xlsTXlXgkqcwZmlKCHkSKeWcBmUe/4Yks4XD/IOGgJ8=;
        b=ZQIQV7tJormcdXT5Y2BwVjedCW7zwEhbrZ4sYHPgObfAxoVc9msrDpayMhUw1YxOTY
         exrX/3rKOc3Y+Y+EQoIWutn6Ux8jV3GscFW7NzxCst8uCmuR+mBF/8YEvnsazGauTHUg
         waETftJEUk8j37dqhW//H5FRO/6EPxAjugJ0Xt8dA6E3eptOkt58/c7lM6dUKoI9jDrq
         oOezV0oj2E4VKjOhr2VyajXXmjh7b+QTrRFYQYp9/at1Z+19ei4Gx7VsEe90rb3xK9f4
         H8BltzEcTBBfoViuLK/am//c4djPNcVznBEgRxiRnJRH4QM5GL4LyGifiPIcInmUis3B
         KyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xlsTXlXgkqcwZmlKCHkSKeWcBmUe/4Yks4XD/IOGgJ8=;
        b=xm6WUzooPPAy6SFN2/uy/FUyCjDbE2xAAFzSkIXIIl9rUwhpSrw9YjpAXou4sIz+cB
         Hda06JfQIhW0rHCnhztEcltP2AN7AKZvl0ET1F6gEJIHfq4jKczp78KGFdojdqOihTXq
         GmhjYb2k5xyKTacobV5T9G0CEVUhS8slbguY6rTYNSHII2yR9D9XVcCtiQpCU7OwBNwB
         z3aQET/3qDUnq/JevK85/wqcIkYcjlWBI3ELX/fHxK4a68YwQSU8sgfw2sujPgkPYDPS
         MsCr1ZsFXeh4syGWbAnhhSW3D90lEMu+gwJqAJDCngiAUxM5VLNanuVEW42JJNmeUyci
         Zd9g==
X-Gm-Message-State: AJIora+aKnRGxT5thboHR/hWThWQkuKUfY3rFv4oJVpQ/YCcmCoRhr16
        tLc5bl5JK7EU4qsTFfgba9u9VA==
X-Google-Smtp-Source: AGRyM1u0OqFaN5bR5kLMvbIxDbCjNtYUTNT4RMDYwcRrouitJfNNXVr7HZIeA2S96pKZGVQg4EWvAA==
X-Received: by 2002:a63:1658:0:b0:41a:4118:f4b9 with SMTP id 24-20020a631658000000b0041a4118f4b9mr6025950pgw.153.1658250732654;
        Tue, 19 Jul 2022 10:12:12 -0700 (PDT)
Received: from [10.4.188.211] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id g3-20020a170902e38300b0015e8d4eb1c8sm11811311ple.18.2022.07.19.10.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 10:12:12 -0700 (PDT)
Message-ID: <17df93c3-5d12-aea9-95df-a46437ea798a@bytedance.com>
Date:   Wed, 20 Jul 2022 01:12:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [External] Re: [PATCH v3] block: don't allow the same type rq_qos
 add more than once
To:     Jens Axboe <axboe@kernel.dk>, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
        stable@vger.kernel.org
References: <20220719165313.51887-1-hanjinke.666@bytedance.com>
 <036e5ae0-4908-d4ab-c2e5-56e9ca85e26d@kernel.dk>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <036e5ae0-4908-d4ab-c2e5-56e9ca85e26d@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

okay, I will do it.

在 2022/7/20 上午12:56, Jens Axboe 写道:
> On 7/19/22 10:53 AM, Jinke Han wrote:
>> From: Jinke Han <hanjinke.666@bytedance.com>
>>
>> In our test of iocost, we encounttered some list add/del corrutions of
>> inner_walk list in ioc_timer_fn.
> 
> This still fails for 5.20 and you didn't correct any of the spelling
> mistakes I identified.
> 
> Please take your time to get this right rather than attempt to rush it
> and needing to send new versions all of the time.
> 
