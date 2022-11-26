Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20015C4321E
	for <linux-block@archiver.kernel.org>; Sat, 26 Nov 2022 15:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiKZPxa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Nov 2022 10:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKZPx3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Nov 2022 10:53:29 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159E12FC
        for <linux-block@vger.kernel.org>; Sat, 26 Nov 2022 07:53:27 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id y4so6449738plb.2
        for <linux-block@vger.kernel.org>; Sat, 26 Nov 2022 07:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LHhIdusx+0OwmPO0x1Tzy0pNoBow2vIz6nGjo/ZLXIo=;
        b=vpbW6lvWlajxe5/wl+D/t6Cw9qrKR6GoJNQEGlnRgID+oztKZH6ScJww52X333YFCu
         S0zhqepB7zvyOsqTYEcM1v5SV1OqpZzLHZbSeHXkkIsGiilFwOifcauqSB+92lKsITkU
         7pLmSZ0xp5GWIfvwWoc6C8m99Rb48/uQiofIsOz/ccA4Iyv/jdeBulu1ZJPiAuAeOBry
         M7s2UulN9aTlk6gwPMMbduOyaiaCgoaHOUlf9+6xUYGo4+EZhRcWXVfiwveuKRenZlYw
         SVIgtAWT3wVsGE8ssD7cnww2FNmscqRY6IPnbX6qOGCKkHJ+IaXBPDllZSLLxfalzMth
         C6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LHhIdusx+0OwmPO0x1Tzy0pNoBow2vIz6nGjo/ZLXIo=;
        b=i1VZhpr28y7Ld5sTRKSDy+CBU+QKf7M1uz7kijxaDWeR9NHwH1DHqHxmxcbrIq1UJt
         vFt4RA3Aq3MtUxgxnGtDdpLlTSOORXp2Ei/3zw6QyQRg+p0CUhE7eiDVJRqA8n9bFsjo
         J3WJslRnzx9szSL5mmSJO/5QmNLbDYiMb1teAEAVoF8DtIMStECtiztIz9JplGyDlN3o
         2ClSQGb/Xa2saLvKQKyROvLE+GdKWNhe8E9EHfs4RLd0naQ92jaJGvRtJ0fm42YXLpLr
         oZ1BpZh0SWKagYuqVfkc9gbIKFNMDOQAIFXAsCYOFOh6X6dnx+FWAlJoG8d5x2ETfEUR
         9Axg==
X-Gm-Message-State: ANoB5pm43uZJFBqji6Uq/uQUHplOnnS/asc5QK6y9rJ2/gkFK5WUUg/6
        SoGBHVhs/o0SlCL89VwhCiOphA==
X-Google-Smtp-Source: AA0mqf6TjQ9+tT8VjZU0DcmkK1aU6qcSoYoP6P6MAv3nB2rkHSM3V9HSRc5uuqUoilKpC8FG5X1RLQ==
X-Received: by 2002:a17:902:e492:b0:17f:72c3:8922 with SMTP id i18-20020a170902e49200b0017f72c38922mr24778701ple.167.1669478006337;
        Sat, 26 Nov 2022 07:53:26 -0800 (PST)
Received: from [192.168.4.201] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id ij5-20020a170902ab4500b001885d15e3c1sm5541497plb.26.2022.11.26.07.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Nov 2022 07:53:25 -0800 (PST)
Message-ID: <3f346cf0-1a3a-b884-5a21-f0508d02981d@kernel.dk>
Date:   Sat, 26 Nov 2022 08:53:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [bisected]kernel BUG at lib/list_debug.c:30! (list_add
 corruption. prev->next should be nex)
To:     Yi Zhang <yi.zhang@redhat.com>, Waiman Long <longman@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        CKI Project <cki-project@redhat.com>,
        Bruno Goncalves <bgoncalv@redhat.com>
References: <CA+QYu4oxiRKC6hJ7F27whXy-PRBx=Tvb+-7TQTONN8qTtV3aDA@mail.gmail.com>
 <2e5f0ed1-4771-1b24-e6da-b63393506e47@kernel.dk>
 <CA+QYu4qDcYJf3WKAmuFcFGX273t4Yi0WG+eF6oQGiRyKeXejWw@mail.gmail.com>
 <CAHj4cs9uLczHhbO+SRmbBGPu3WZ_HntiCi4sxettXCnjuV8ZXQ@mail.gmail.com>
 <CAHj4cs-1mH-FKtU8_uq4H4o6K+JKVwgvN7Yk3e8LOc+-u=YhMw@mail.gmail.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHj4cs-1mH-FKtU8_uq4H4o6K+JKVwgvN7Yk3e8LOc+-u=YhMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/22 7:29 AM, Yi Zhang wrote:
> Hi Jens
> Sorry for the delay as I couldn't reproduce it with the original
> for-6.2/block branch.
> Finally, I rebased the for-6.2/block branch on 6.1-rc6 and was able to
> bisect it：
> 
> 
> 951d1e94801f95a3fc1c75ff342431c9f519dd14 is the first bad commit
> commit 951d1e94801f95a3fc1c75ff342431c9f519dd14
> Author: Waiman Long <longman@redhat.com>
> Date:   Fri Nov 4 20:59:02 2022 -0400
> 
>     blk-cgroup: Flush stats at blkgs destruction path
> 
>     As noted by Michal, the blkg_iostat_set's in the lockless list
>     hold reference to blkg's to protect against their removal. Those
>     blkg's hold reference to blkcg. When a cgroup is being destroyed,
>     cgroup_rstat_flush() is only called at css_release_work_fn() which is
>     called when the blkcg reference count reaches 0. This circular dependency
>     will prevent blkcg from being freed until some other events cause
>     cgroup_rstat_flush() to be called to flush out the pending blkcg stats.
> 
>     To prevent this delayed blkcg removal, add a new cgroup_rstat_css_flush()
>     function to flush stats for a given css and cpu and call it at the blkgs
>     destruction path, blkcg_destroy_blkgs(), whenever there are still some
>     pending stats to be flushed. This will ensure that blkcg reference
>     count can reach 0 ASAP.
> 
>     Signed-off-by: Waiman Long <longman@redhat.com>
>     Acked-by: Tejun Heo <tj@kernel.org>
>     Link: https://lore.kernel.org/r/20221105005902.407297-4-longman@redhat.com
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>

Waiman, let me know if you have an idea what is going on here and can
send in a fix, or if I need to revert this one. From looking at the
lists of commits after these reports came in, I did suspect this
commit. But I don't know enough about this area to render an opinion
on a fix without spending more time on it.

-- 
Jens Axboe


