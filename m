Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C594C433FE
	for <linux-block@archiver.kernel.org>; Mon, 28 Nov 2022 18:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiK1Szv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Nov 2022 13:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiK1Szt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2022 13:55:49 -0500
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3D920189
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2022 10:55:46 -0800 (PST)
Received: by mail-pl1-f176.google.com with SMTP id p24so7336151plw.1
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2022 10:55:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wgmDqGHS1sUrH9TJPKKrtDA3xkUztR3VQIqu5bLr+yc=;
        b=mXxLpIWXyJs75/IRt5Kir1+MW3gRldUamioBzCV3J/7HD5IzDK3HnNCMsq3VO/y8P0
         bMgybxaVsnnTgFpDPQ5aVwQCWiWyMiMRTyc8XFjNN9OYmT16oZjHbCHUJYHzkpsE6rp9
         47dYCRGk5W5EocLtjpfMgEBnBUvyWRuXFHp7rIcRbhgknTQ6wyljqg0xfVRyfAdT52+O
         C8r5ik17Tsh8PhVIJRbsTV6G2cky+sjV9ZWIjQwJUaMTXX9nliS9LZEhgjdf9UfqsPTq
         rEzvsLsVLh2EfUMDXb1qddLoVvH+897hfRnob2xPGzMoL1gu3IO3KBIPKajYP1faWJ5a
         AnUg==
X-Gm-Message-State: ANoB5pms0m+2AomocTTK4EnruLgkxcL00VWoFcviTlQYlCisqgSMob5m
        pmxDxjlR1PP7ps2FwG+UASUw9zGpk0p08A==
X-Google-Smtp-Source: AA0mqf6erjJso2S93OsTNsSnXNegEMoZ0l1bpNKqFiUksAORgvdTvh/SplacB+EKNEv0s8wixQuhxg==
X-Received: by 2002:a17:903:3241:b0:186:dcc3:5d1d with SMTP id ji1-20020a170903324100b00186dcc35d1dmr46252233plb.20.1669661746089;
        Mon, 28 Nov 2022 10:55:46 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:95f2:baa2:773c:2cfe? ([2620:15c:211:201:95f2:baa2:773c:2cfe])
        by smtp.gmail.com with ESMTPSA id l7-20020a170902f68700b0017f756563bcsm9290116plg.47.2022.11.28.10.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 10:55:45 -0800 (PST)
Message-ID: <8a3f3648-1bf9-68c1-36c0-c245f5bd7f8d@acm.org>
Date:   Mon, 28 Nov 2022 10:55:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [bisected]kernel BUG at lib/list_debug.c:30! (list_add
 corruption. prev->next should be nex)
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Waiman Long <longman@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        CKI Project <cki-project@redhat.com>,
        Bruno Goncalves <bgoncalv@redhat.com>
References: <CA+QYu4oxiRKC6hJ7F27whXy-PRBx=Tvb+-7TQTONN8qTtV3aDA@mail.gmail.com>
 <2e5f0ed1-4771-1b24-e6da-b63393506e47@kernel.dk>
 <CA+QYu4qDcYJf3WKAmuFcFGX273t4Yi0WG+eF6oQGiRyKeXejWw@mail.gmail.com>
 <CAHj4cs9uLczHhbO+SRmbBGPu3WZ_HntiCi4sxettXCnjuV8ZXQ@mail.gmail.com>
 <CAHj4cs-1mH-FKtU8_uq4H4o6K+JKVwgvN7Yk3e8LOc+-u=YhMw@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAHj4cs-1mH-FKtU8_uq4H4o6K+JKVwgvN7Yk3e8LOc+-u=YhMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/22 06:29, Yi Zhang wrote:
> Finally, I rebased the for-6.2/block branch on 6.1-rc6 and was able to
> bisect it：
> 
> 
> 951d1e94801f95a3fc1c75ff342431c9f519dd14 is the first bad commit
> commit 951d1e94801f95a3fc1c75ff342431c9f519dd14
> Author: Waiman Long <longman@redhat.com>
> Date:   Fri Nov 4 20:59:02 2022 -0400
> 
>      blk-cgroup: Flush stats at blkgs destruction path
> 
>      As noted by Michal, the blkg_iostat_set's in the lockless list
>      hold reference to blkg's to protect against their removal. Those
>      blkg's hold reference to blkcg. When a cgroup is being destroyed,
>      cgroup_rstat_flush() is only called at css_release_work_fn() which is
>      called when the blkcg reference count reaches 0. This circular dependency
>      will prevent blkcg from being freed until some other events cause
>      cgroup_rstat_flush() to be called to flush out the pending blkcg stats.
> 
>      To prevent this delayed blkcg removal, add a new cgroup_rstat_css_flush()
>      function to flush stats for a given css and cpu and call it at the blkgs
>      destruction path, blkcg_destroy_blkgs(), whenever there are still some
>      pending stats to be flushed. This will ensure that blkcg reference
>      count can reach 0 ASAP.
> 
>      Signed-off-by: Waiman Long <longman@redhat.com>
>      Acked-by: Tejun Heo <tj@kernel.org>
>      Link: https://lore.kernel.org/r/20221105005902.407297-4-longman@redhat.com
>      Signed-off-by: Jens Axboe <axboe@kernel.dk>

I can confirm this report. If I revert patch "blk-cgroup: Flush stats at 
blkgs destruction path" on top of the block/for-next branch from last 
Wednesday then test block/027 passes. Test block/027 fails 
systematically with an unmodified block/for-next branch.

Bart.
