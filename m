Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF6AC433F5
	for <linux-block@archiver.kernel.org>; Tue, 17 May 2022 00:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiEQA7W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 May 2022 20:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240813AbiEQA7U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 May 2022 20:59:20 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3AF443C7
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 17:59:18 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 191so4453922pgf.4
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 17:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Rbi1cvE5ak+hokclc7/2ypGdn+hwauLG7pccARXZlxA=;
        b=L7/wFcUdrihAHg2tWxQZVZ5Ma8QOx+e3d/RecGna7IX0vFVaBzoBUEJkuTNpyd/j0c
         0Oo/Zd+HKFURzHqmVR/0k7INDLW3PyHQdpBAby5k/TGUJeixpsypg/t7oqC1gIveV6dT
         u3WOWOu2USXZ9vuv/0aGn3njErWsZiFp3jRnEBqcsgaxTrgZvKxFapKsLzYw8tp+6h6H
         pyl947i29Eh62sRHPDrjnX4ng5kLkhrf2BmS7gXtWkMIyB68JrqaWnSROPsB6AvBUqwz
         5sTOWvcKK++i+qGn66jOc0600o+NHYS8nSngeLjxUvToGDv3Xk1onjeaaWbr3K4ybWkw
         18ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Rbi1cvE5ak+hokclc7/2ypGdn+hwauLG7pccARXZlxA=;
        b=JEw+V6cCzC2sxFpoTwKCsMHBMqSbOwvn9mtgdSKnNeQ7wYEogfPcYZWRbZcxQcxm3e
         ek7eTtZCOt3eGxBKasLbjgNP6Abnefx/7wb7PF0ieCZWQ1C13zmaNUOw2NEMPWkZWKVN
         ReAHdEI4VeCuYoluh8P3ies3JuM6eT+aUXGwVtZhXav+6j7qd5f0Mu0h3B7nMWZ+RPvZ
         m605jELP5m/oVeRH1TII/j/RqS6wbMKW8iASdSCucR4XngqKMDMF904jmSa60IwX4o08
         aP/+bhcdy0s0zS0zYvx++RpWRveknkOf8ojtdjEJqLaAGiCPi93pvdLh/clBLqfy1xi/
         vrhQ==
X-Gm-Message-State: AOAM533G/mR1ix3v35XXVMMMPfkVb6oYRbdGazzdV6+V3PZMJOeM07Ty
        CbqDjutJZRWMiHBnAk6y1r7f5YVH2V+R5g==
X-Google-Smtp-Source: ABdhPJyDkWFZSIWGdJi2+hm9e5X8axcTewLtO8q0CfFLeV14161+OanEVvu8b1FeF9pghca3/OgklA==
X-Received: by 2002:a05:6a00:1d8f:b0:510:9430:8021 with SMTP id z15-20020a056a001d8f00b0051094308021mr20031512pfw.55.1652749158260;
        Mon, 16 May 2022 17:59:18 -0700 (PDT)
Received: from [10.254.192.228] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id a1-20020a170902900100b0015e8d4eb2dfsm7531269plp.297.2022.05.16.17.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 17:59:17 -0700 (PDT)
Message-ID: <bcd0956a-9aa0-3211-801b-1f1eace6de79@bytedance.com>
Date:   Tue, 17 May 2022 08:57:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [Phishing Risk] [External] Re: [PATCH] blk-iocost: fix very large
 vtime when iocg activate
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com
References: <20220516084045.96004-1-zhouchengming@bytedance.com>
 <YoKb7wpkz3xoCS6s@slm.duckdns.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YoKb7wpkz3xoCS6s@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/5/17 02:46, Tejun Heo wrote:
> On Mon, May 16, 2022 at 04:40:45PM +0800, Chengming Zhou wrote:
>> When the first iocg activate after blk_iocost_init(), now->vnow
>> maybe smaller than ioc->margins.target, cause very large vtarget
>> since it's u64.
>>
>> 	vtarget = now->vnow - ioc->margins.target;
>> 	atomic64_add(vtarget - vtime, &iocg->vtime);
>>
>> Then the iocg's vtime will be very large too, larger than now->vnow.
> 
> It's a wrapping counter. Please take a look at how time_before64() and
> friends work.

Hi Tejun, below is from the trace of test on original code:

iocost_iocg_activate: [vda:/user.slice] now=38343468:2171657838 vrate=137438 \
period=0->0 vtime=18446744007162209454 weight=6553600/6553600 hweight=65536/65536

The vtime value is very large, much larger than vnow. Maybe the commit message
is a little misleading?

And I take a look at how time_before64() work:

#define time_after64(a,b)	\
	(typecheck(__u64, a) &&	\
	 typecheck(__u64, b) && \
	 ((__s64)((b) - (a)) < 0))
#define time_before64(a,b)	time_after64(b,a)

I still don't get why my changes are wrong. :-)

> 
> Nacked-by: Tejun Heo <tj@kernel.org>
> 
> Again, please spend more effort understanding the code before sending these
> subtle patches.

Ok, will do. This problem is found from the trace of test, then verified fixed
using the trace of the same test with this patch.

Thanks.

> 
> Thanks.
> 
