Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E71AC433FE
	for <linux-block@archiver.kernel.org>; Wed, 16 Nov 2022 23:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiKPX6l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Nov 2022 18:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiKPX6j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 18:58:39 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3CB1037
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 15:58:37 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id b11so154831pjp.2
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 15:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kojRkknuzQaruikj1Bw1AgCPwluH/lc+Fu21L+WOJJc=;
        b=RwvO8tezPJW+rHCmdRbQ+mADp1YnOCxf4exyMImXeZ746yvzytYOZgond8mRARU4tL
         pQ0qeYVAciS4yBF7nk1nbOofVyL4B0d4vDYyWLrCKCqfEo7QbjYmVUIae6tmOGUCGZRX
         fBpiXhZ1Dwi9HbTy3EYf8cIC4PNO85VbxGM3vhCGU8/Ag91kGCbRgGflI5IITZxfo1/2
         ZJMk2wHlXJVUeD46A9eZFQaUKXVCSIiP4XB44lA7MDEobMur/ZeYiUenuLAulsMFYKz3
         RbUnHNs3xlJr6g0xMtTRbBgwgAl36Yar5dWjaYRwWoPQqagB5508qtDcaTqP1yrdGiQQ
         E9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kojRkknuzQaruikj1Bw1AgCPwluH/lc+Fu21L+WOJJc=;
        b=le2P83HF5SaerqQHDoLoN5MKt0KbcDIVexZNfdjYQ97uBQhYqNsoz7wcIFlFVSc9xA
         x3WkVe/tv/OspkqnkfDlmiRANDNWzLcByiahITqqZmVbqAbosm8ESE28KUQRspzGtZSm
         elaenyKE9wEuuuNfT6M7wUUBXInmIyJWAOBAOAd3r3uXN4NalrCdJNuJwrgn/vo/oj44
         Vya4e/nmjg9ZEsHdd4JBLDr5jO1o5exQkNwb5SLJ0r3PVpchHgVGnUXM5wKbUmju/NTL
         ViQAl2v2a963vOk6LMPeqScuz58PFKQnuBW9R2Oae4XZ9rj0XXWiDeOpRTs4AZTdQ8YD
         0dPQ==
X-Gm-Message-State: ANoB5pnLZ++y8MruI11kVSY4H9fdi/kGchlr0cccDeYsvUUeyn0169Ag
        AoPAhl+6CI5PTtJI0f3Mz2KnIA==
X-Google-Smtp-Source: AA0mqf6NGk2RuTo6aGaFr95auX8C3f+sgHmdR9BqJEXf7pgDbmWsgSj2ySTo9oGGDAcTDjfogAu8kQ==
X-Received: by 2002:a17:90b:d13:b0:217:ecbd:5ae with SMTP id n19-20020a17090b0d1300b00217ecbd05aemr5831869pjz.17.1668643116857;
        Wed, 16 Nov 2022 15:58:36 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id nh9-20020a17090b364900b00212d9a06edcsm2173613pjb.42.2022.11.16.15.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 15:58:36 -0800 (PST)
Message-ID: <5e885fce-a0b4-559f-5498-4402080f6a2e@kernel.dk>
Date:   Wed, 16 Nov 2022 16:58:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v10 0/3] blk-cgroup: Optimize blkcg_rstat_flush()
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>, Tejun Heo <tj@kernel.org>
References: <20221105005902.407297-1-longman@redhat.com>
 <4b5142be-6a47-9dfd-a238-5b9d29b296b8@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <4b5142be-6a47-9dfd-a238-5b9d29b296b8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/16/22 4:06 PM, Waiman Long wrote:
> On 11/4/22 20:58, Waiman Long wrote:
>> ? v10:
>> ?? - Update patch 3 to rename the rstat function to
>> ???? cgroup_rstat_css_cpu_flush().
>>
>> ? v9:
>> ?? - Remove patch "llist: Allow optional sentinel node terminated lockless
>> ???? list" for now. This will be done as a follow-up patch.
>> ?? - Add a new lqueued field to blkg_iostat_set to store the status of
>> ???? whether lnode is in a lockless list.
>> ?? - Add a new patch 3 to speed up the freeing of blkcg by flushing out
>> ???? the rstat lockless lists at blkcg offline time.
>>
>> ? v8:
>> ?? - Update the llist patch to make existing llist functions and macros
>> ???? work for both NULL and sentinel terminated lockless list as much
>> ???? as possible and leave only the initialization and removal functions
>> ???? to have a sentinel terminated llist variants.
>>
>> This patch series improves blkcg_rstat_flush() performance by eliminating
>> unnecessary blkg enumeration and flush operations for those blkg's and
>> blkg_iostat_set's that haven't been updated since the last flush.
>>
>> Waiman Long (3):
>> ?? blk-cgroup: Return -ENOMEM directly in blkcg_css_alloc() error path
>> ?? blk-cgroup: Optimize blkcg_rstat_flush()
>> ?? blk-cgroup: Flush stats at blkgs destruction path
>>
>> ? block/blk-cgroup.c???? | 103 +++++++++++++++++++++++++++++++++++------
>> ? block/blk-cgroup.h???? |? 10 ++++
>> ? include/linux/cgroup.h |?? 1 +
>> ? kernel/cgroup/rstat.c? |? 20 ++++++++
>> ? 4 files changed, 119 insertions(+), 15 deletions(-)
> 
> Jens, do you have any further comment on this patchset? Is it possible
> to queue it for the next Linux version?

Looks good to me, I'll queue it up.

-- 
Jens Axboe
