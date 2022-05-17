Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4FCC433EF
	for <linux-block@archiver.kernel.org>; Tue, 17 May 2022 01:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiEQBZN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 May 2022 21:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiEQBZN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 May 2022 21:25:13 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F161133890
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 18:25:11 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id a19so15461534pgw.6
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 18:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=D/4KPWa9dqKvg6Vz7IhEunGR8QPJbm8+0oOV8yg7pbM=;
        b=MpBV3cHVEjwoA/pxWhWl7pRygbKPRLBVKTCykZJlfL1BLWdwzxsxciclEElu/fnDYY
         XQgte8akdUdHG49wC/X1IB5FzH7K99fDlQBkxfnk/CqcC+RA2N3R1g/2YylKJkYJZTsv
         MorFAPC9v32AdRW6mGxRUKGilKBkDLSOzWwqR55ZqAOXMjDvOIkT3ZkBTB5IEY5kqYaI
         twW9Io0PbMSHH7+D+QpBrpfGhrXatFzNM85qD5hGhZexVMp5rG6Qz3AuL6/Kjnp5gNcr
         0bfywyJ1zRlyYKT2b+Ps8i7QSHm+GOP6yysPrPJ6SAtGDURgBpvZkcdnYqlQZ11aQKfm
         qp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D/4KPWa9dqKvg6Vz7IhEunGR8QPJbm8+0oOV8yg7pbM=;
        b=qCOiafajxsubnGG6OhzFuVPKfcACcf0Bh19Z1IYB3Cjh2VR1qNfN/a+YF9G+BR/Vx5
         /9180Rttt95xAcpVwjL0MontoAoi6MuW1zkCX3T7MxS97T410hmaMScoi2N6A+Tv3Qq4
         B0kx4FplicuyTV3qX0ZhTMBtyHp26L/bTzn91gIOL/yVJDTa1kByBp6wW7NY7qpfhL0M
         Ni1nI6ULuOaQe45Jf4pZLYuNCVIFKDDefWHHuwTrYq5Z3ljo0Wp06dI9XYmgGv2leZan
         gb630+S9vud/rynqQ1+A4W0F++Y2uO6gjJZYxBtGHNUEIVXG1Sj2wugo4qLKXAOYoDQv
         1a4A==
X-Gm-Message-State: AOAM531t+tv9eUE4mSpwKqZAZ7wGKVL+p8sexeZaoy5xWyTTQuMnu0j1
        4iAYj5W42WNUe6eOPoERwOUCpQ==
X-Google-Smtp-Source: ABdhPJydH5XqRCsDp8l+O36PRizIzhQMlvxBm2Gq9jrhOMBLIIFHQ1YMgTiMJrCKCKwE4I6JgS4xGA==
X-Received: by 2002:a05:6a00:24cc:b0:50d:58bf:5104 with SMTP id d12-20020a056a0024cc00b0050d58bf5104mr20097370pfv.36.1652750711513;
        Mon, 16 May 2022 18:25:11 -0700 (PDT)
Received: from [10.254.192.228] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id cp19-20020a17090afb9300b001df6f16be29sm314665pjb.32.2022.05.16.18.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 18:25:11 -0700 (PDT)
Message-ID: <d39d5f69-950b-17c4-f511-a3cbab55177f@bytedance.com>
Date:   Tue, 17 May 2022 09:23:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [Phishing Risk] Re: [Phishing Risk] [External] Re: [PATCH]
 blk-iocost: fix very large vtime when iocg activate
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com
References: <20220516084045.96004-1-zhouchengming@bytedance.com>
 <YoKb7wpkz3xoCS6s@slm.duckdns.org>
 <bcd0956a-9aa0-3211-801b-1f1eace6de79@bytedance.com>
 <YoL0RHmU4tbS2f/F@slm.duckdns.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YoL0RHmU4tbS2f/F@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/5/17 09:03, Tejun Heo wrote:
> On Tue, May 17, 2022 at 08:57:55AM +0800, Chengming Zhou wrote:
>> #define time_after64(a,b)	\
>> 	(typecheck(__u64, a) &&	\
>> 	 typecheck(__u64, b) && \
>> 	 ((__s64)((b) - (a)) < 0))
>> #define time_before64(a,b)	time_after64(b,a)
>>
>> I still don't get why my changes are wrong. :-)
> 
> It's a wrapping timestamp where a lower value doesn't necessarily mean
> earlier. The before/after relationship is defined only in relation to each
> other. Imagine a cirle representing the whole value range and picking two
> spots in the circle, if one is in the clockwise half from the other, the
> former is said to be earlier than the latter and vice-versa. vtime runs way
> faster than nanosecs and wraps regularly, so we can't use absolute values to
> compare before/after.

Yes, thanks for the explanation. But the problem is not comparing two timestamp,
since ioc->margins.target is not a timestamp. This patch just fix a corner case
when now->vnow < ioc->margins.target:

u64 vtarget;

vtarget = now->vnow - ioc->margins.target; --> vtarget should be a timestamp earlier than vnow.

But when now->vnow < ioc->margins.target, vtarget would be a timestamp after vnow.

Thanks.

> 
> Thanks.
> 
