Return-Path: <SRS0=fNpn=NX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ADFC43441
	for <linux-block@archiver.kernel.org>; Mon, 12 Nov 2018 15:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D7322503
	for <linux-block@archiver.kernel.org>; Mon, 12 Nov 2018 15:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ms+kDUGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D7322503
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbeKMB3b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:29:31 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34725 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbeKMB3b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Nov 2018 20:29:31 -0500
Received: by mail-pf1-f193.google.com with SMTP id y18-v6so4506372pfn.1
        for <linux-block@vger.kernel.org>; Mon, 12 Nov 2018 07:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O+b4t6r9qmJGsq2dmTqykhhcuM72lEukenRsWFmslq4=;
        b=ms+kDUGo2aL/vY/7KLAwgIskWefGD9CpmVVhiWkWTflBy/hxWPnFcDaVKTgqtPkNqy
         AKoBSI/WVBK6BUUsCSbTRMJpRqwmAJG2utG/tfxNQY1JVCK6rc0M02Yymn+tMEXPteeD
         H9OPEViS3HQQy6/VkCpoZPY7Tn/Uazk/O2ixtEDJgeFGziRE5J7X8xFdMuEcXyJq0fDi
         LRZ6eWSlzLpgraJwVceXdiP7i0tc+cJ3uQIoxMP94YxHaSvyhTHpuy93Op//2asdjhg5
         +7S1/5ck2H99iz6I7cKUNyNQMEO+dJiaeHwI1+NR+8yazGIGPeLGVoYUI+qyklNIdGVv
         +qZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O+b4t6r9qmJGsq2dmTqykhhcuM72lEukenRsWFmslq4=;
        b=ss8rDIyb20DsB3U0rjUzoUZZCsHtJg/ZBO/9KGGqL1BjvphWxQV7YNGXlTCMc3ILxB
         mUxyQxxb7BKs+q0ThAbOWbL63VL029X7N09gv70xzSbV9jqUCAVXwjvK4YSGKuzcYZ+O
         JQ70whih8WVDfAeRvtgv0dWeu9k21FVY232wJhxP8yVG7J3gi4rHNRoMHa9ryADdOUgT
         XjMqRX8lgpn9i0O+g4wOcn2VGLJzft/kiB30jw3GobKTKgkoEc/r5MdHdCUb6vx5Kzw8
         FS0nIlaOBSJDf3s6NvmfyUCzZVGaaZhNNevZII3L8FR9LggG97HmwA+gIIaS3cFP5g8h
         c9cA==
X-Gm-Message-State: AGRZ1gKQWAX4Flh9J+v2zNS8MXfMI2do7RhOD3BxqDxF+bFO3HdqB4uA
        Yx7N2Pp51mPMSfRzfQhhgYMG/Q==
X-Google-Smtp-Source: AJdET5fZkRf4NVwbFFXSFovhPZwwjPZyAH3drmVx+Rpu3aH8JS6rwN0D5Z3T6j5S0mQ99VqObf24OQ==
X-Received: by 2002:a63:81c7:: with SMTP id t190mr1219199pgd.393.1542036945602;
        Mon, 12 Nov 2018 07:35:45 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id k38sm41336182pgb.33.2018.11.12.07.35.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 07:35:44 -0800 (PST)
Subject: Re: [PATCH 00/12] unify the interface of the proportional-share
 policy in blkio/io
To:     Paolo Valente <paolo.valente@linaro.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        'Paolo Valente' via bfq-iosched 
        <bfq-iosched@googlegroups.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        lennart@poettering.net
References: <20181112095632.69114-1-paolo.valente@linaro.org>
 <9e8adb3271680165d85994a225713391@natalenko.name>
 <E8A20452-A73C-4A31-B5EC-48EFB9937832@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e85cfae0-7743-8c51-c2c9-0855c26f868e@kernel.dk>
Date:   Mon, 12 Nov 2018 08:35:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <E8A20452-A73C-4A31-B5EC-48EFB9937832@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/12/18 3:17 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 12 nov 2018, alle ore 11:00, Oleksandr Natalenko <oleksandr@natalenko.name> ha scritto:
>>
>> On 12.11.2018 10:56, Paolo Valente wrote:
>>> Hi Jens, Tejun, all,
>>> about nine months ago, we agreed on a solution for unifying the
>>> interface of the proportional-share policy in blkio/io [1].  Angelo
>>> and I finally completed it.  Let me briefly recall the problem and the
>>> solution.
>>> The current implementation of cgroups doesn't allow two or more
>>> entities, e.g., I/O schedulers, to share the same files.  So, if CFQ
>>> creates its files for the proportional-share policy, such as, e.g,
>>> weight files for blkio/io groups, BFQ cannot attach somehow to them.
>>> Thus, to enable people to set group weights with BFQ, I resorted to
>>> making BFQ create its own version of these common files, by prepending
>>> a bfq prefix.
>>> Actually, no legacy code uses these different names, or is likely to
>>> do so.  Having these two sets of names is simply a source of
>>> confusion, as pointed out also, e.g., by Lennart Poettering (CCed
>>> here), and acknowledged by Tejun [2].
>>> In [1] we agreed on a solution that solves this problem, by actually
>>> making it possible to share cgroups files.  Both writing to and
>>> reading from a shared file trigger the appropriate operation for each
>>> of the entities that share the file.  In particular, in case of
>>> reading,
>>> - if all entities produce the same output, the this common output is
>>>  shown only once;
>>> - if the outputs differ, then every per-entity output is shown,
>>>  preceded by the name of the entity that produced that output.
>>> With this solution, legacy code that, e.g., sets group weights, just
>>> works, regardless of the I/O scheduler actually implementing
>>> proportional share.
>>> But note that this extension is not restricted to only blkio/io.  The
>>> general group interface now enables files to be shared among multiple
>>> entities of any kind.
>>> (I have also added a patch to fix some clerical errors in bfq doc,
>>> which I found while making the latter consistent with the new
>>> interface.)
>>> Thanks,
>>> Paolo
>>> [1] https://lkml.org/lkml/2018/1/4/667
>>> [2] https://github.com/systemd/systemd/issues/7057
>>> Angelo Ruocco (7):
>>>  kernfs: add function to find kernfs_node without increasing ref
>>>    counter
>>>  cgroup: link cftypes of the same subsystem with the same name
>>>  cgroup: add owner name to cftypes
>>>  block, bfq: align min and default weights with cfq
>>>  cgroup: make all functions of all cftypes be invoked
>>>  block, cfq: allow cgroup files to be shared
>>>  block, throttle: allow sharing cgroup statistic files
>>> Paolo Valente (5):
>>>  cgroup: add hook seq_show_cft with also the owning cftype as parameter
>>>  block, cgroup: pass cftype to functions that need to use it
>>>  block, bfq: use standard file names for the proportional-share policy
>>>  doc, bfq-iosched: fix a few clerical errors
>>>  doc, bfq-iosched: make it consistent with the new cgroup interface
>>> Documentation/block/bfq-iosched.txt |  31 +++--
>>> block/bfq-cgroup.c                  | 148 +++++++++++++-------
>>> block/bfq-iosched.h                 |   4 +-
>>> block/blk-cgroup.c                  |  22 +--
>>> block/blk-throttle.c                |  24 ++--
>>> block/cfq-iosched.c                 | 105 +++++++++++----
>>> fs/kernfs/dir.c                     |  13 ++
>>> include/linux/blk-cgroup.h          |  10 +-
>>> include/linux/cgroup-defs.h         |  14 +-
>>> include/linux/cgroup.h              |  13 ++
>>> include/linux/kernfs.h              |   7 +
>>> kernel/cgroup/cgroup.c              | 262 +++++++++++++++++++++++++++++-------
>>> 12 files changed, 483 insertions(+), 170 deletions(-)
>>> --
>>> 2.16.1
>>
>> I thought all the legacy stuff including CFS et al. is going to be removed in v4.21 completely…
>>
> 
> Thanks for pointing this out.
> 
> People with a lower kernel version than the future 4.21 just cannot
> and will not be able to use the proportional share policy on blk-mq
> (with legacy code), because of the name issue highlighted in this
> email.  If this patch series gets accepted, a backport will solve the
> problem.  In this respect, such a backport might even happen
> 'automatically', as most bfq commit seem to get backported to older,
> stable kernels.
> 
> In addition, this extension
> - extends the whole cgroups interface, in a seamless and
>   backward-compatible way, to prevent future issues like these;
> - solves a similar issue with throttle (which AFAIK won't go away
>   with 4.21).

There's no way this series can get accepted, since you've made the
mistake of basing it on something that won't apply to the block
tree for 4.21. I've outlined these rules before, but here they are
again:

1) Patches destined for the CURRENT kernel version should be
   against my for-linus branch. That means that right now, any
   patches that should to into 4.20 should be against that.

2) Patches destined for the NEXT kernel version should be against
   my for-x.y/block branch, where x.y is the next version. As of
   right now, patches for 4.21 should be against my for-4.21/bloc
   branch.

I'd encourage you to respin against that, particularly in this case
since we've both got a lot of churn, and also removal of various
items that you are patching here.

-- 
Jens Axboe

