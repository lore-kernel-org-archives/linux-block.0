Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC357C433F5
	for <linux-block@archiver.kernel.org>; Wed,  6 Apr 2022 20:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiDFUqV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Apr 2022 16:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbiDFUpX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Apr 2022 16:45:23 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4760415878E
        for <linux-block@vger.kernel.org>; Wed,  6 Apr 2022 12:02:28 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id k2so3756177edj.9
        for <linux-block@vger.kernel.org>; Wed, 06 Apr 2022 12:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OfpP3FToADthuOwAPWrJH6xPsGNzfbxsbWzPcz+HJUU=;
        b=ICjsAPBiFJ2aL61uaN9fStECKZ8tlA38m/QJg1Y3rfrqAdyBH9toCNpHcn4GvBoRt0
         aCEiEB3mqz7RbUdfXPekJPPvOjHJpqP1ZoxAXv2nvoNuvV/l8QQwls+n50n4O9EE/cGz
         0WCVvkLVU7rVlY0FtKdjG8WUEFYwthIM+Fk4Ze2e9yIwamhGfjcsXgFaY0OlH5s3hQLP
         ZejvNw9JkDZ+AwslyuLl2bTzgpBApAIwr9qaxbQB/bRnS9WGIMUZqWls1gvSkQKWdj6e
         sHMTPw2wxuYxNsbE4PMJx46binGBIcDMXbO9Tp/lYqGSFO/VUI6U6Brx2EJPcv+FO1Cr
         UrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OfpP3FToADthuOwAPWrJH6xPsGNzfbxsbWzPcz+HJUU=;
        b=vVotMXDSag3XoUUeNTgDZU9Lz7jmELQeJFFk/gvnvFSRB0xVveIDmRM2w8mazRTCT4
         5qt5mgvWxaj5datEEqIHXJ17oN7oohpceTz6b6pvbDaN1sfD4w2XVT5cR70cOQAevFdF
         ATgdCknhc6DgHfDPoXhgY3N/EomSRyKq0Gl9YSHLYwYidtnbbnALXzDkguSVB5t4DXaR
         N/ZtrTFmgSyeJBo9Vls+Pk5zly0dRFDlbKRy3xZIuWoizQ2AQfhG/PJayL96IdehNko4
         d5OZ3FHr0i7Ip4GRzWlOEBB7Fzgt6W72SUfEa5XO6BHMyOi3Kq05nsFLi9dqhfUPy60r
         0zuQ==
X-Gm-Message-State: AOAM530Q/+xrDWMLl+aQnsDr21e9MePuG6sY1IITB7+1C9jnCiZqXN8R
        iFEqNhW2sSJ8k+/OaLp2vQsGNQ==
X-Google-Smtp-Source: ABdhPJykGzEf/jskQs85g2EoyTbW6l43YOfNjRSLzsCjQGo1VYBj01LuJ/RmY17iS4PrdK0lmqa8wg==
X-Received: by 2002:a05:6402:f1c:b0:41b:54d2:ef1b with SMTP id i28-20020a0564020f1c00b0041b54d2ef1bmr10247933eda.185.1649271746623;
        Wed, 06 Apr 2022 12:02:26 -0700 (PDT)
Received: from [192.168.178.55] (85-127-190-169.dsl.dynamic.surfer.at. [85.127.190.169])
        by smtp.gmail.com with ESMTPSA id jv20-20020a170907769400b006e7f859e683sm3256460ejc.19.2022.04.06.12.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 12:02:26 -0700 (PDT)
Message-ID: <2563ca26-cda7-11c7-286a-35d6383f9d00@linbit.com>
Date:   Wed, 6 Apr 2022 21:02:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [GIT PULL] DRBD fixes for Linux 5.18
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>
References: <60bf3e8f-9cfb-00d1-5fea-71a72ba93258@linbit.com>
 <e2035fff-01e2-0df7-2508-82b741615519@kernel.dk>
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
In-Reply-To: <e2035fff-01e2-0df7-2508-82b741615519@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am 06.04.22 um 14:35 schrieb Jens Axboe:
> On 4/6/22 2:06 AM, Christoph B?hmwalder wrote:
>> Hi Jens,
>>
>> this is the first batch of DRBD updates, catching up from the last few
>> years. These fixes are a bit more substantial, so it would be great if
>> they could still go into 5.18.
> 
> Thanks for sending these, but you based the repo on my 5.19 branch,
> which won't work as pulling your tree will then result in me getting
> your 5.18 changes with my 5.19 as well.
> 
> As it happens, this is also a problem for your 5.19 based changes. My
> for-next branch is not stable, just like linux-next isn't stable. In
> terms of shas, not how it runs...
> 
> In general, for the block tree, here's what you want to base the changes
> on, using 5.18/5.19 as examples as current/next tree.
> 
> - If they are bound for 5.18, base them on block-5.18. That branch may
>   not exist if nothing is queued up yet, in which case just base them on
>   the last -rc1 tag for that series. That'd be 5.18-rc1 in this case.
> 
> - If they are bound for 5.19, usually I will have a 5.19 driver and core
>   block branch. Base them against for-5.19/drivers. If it doesn't exist,
>   previous -rc is a good choice again.
> 
> Usually post -rc2 all of the above branches will exist, during merge
> window and right after things are a bit more influx and haven't really
> settled down yet.
> 
> Now, there's also the fact that you're using a non kernel.org git tree.
> That's fine, but ideally we'd like you to use signed tags in that case.
> But not sure your key has been signed by anyone in the korg ring of
> trust? Since I've already seen these patches this isn't a huge concern
> for now, but something to get sorted out going forward.
> 
> Can you rebase your two pull requests and send them in again? Either
> that, or just git send-email the two series, that'll work too. I'm fine
> applying series from maintainers like that, it doesn't have to be a git
> pull request.
> 

Good to know, thanks for the pointers and sorry for the mess. I'll
resend based on block-5.18 and 5.18-rc1 respectively.
