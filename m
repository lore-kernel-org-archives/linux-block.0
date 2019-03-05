Return-Path: <SRS0=rLai=RI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3708C43381
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 17:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B6320848
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 17:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="tDJLPYS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfCER1m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Mar 2019 12:27:42 -0500
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:43405 "EHLO
        forwardcorp1o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728172AbfCER1m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Mar 2019 12:27:42 -0500
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1o.cmail.yandex.net (Yandex) with ESMTP id E744721672;
        Tue,  5 Mar 2019 20:27:38 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id OU0qeWHHGu-RchOasM2;
        Tue, 05 Mar 2019 20:27:38 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1551806858; bh=SHMSe0BDUm7rTH2OZfSxE/ZaTpJiliYBzSWNaqaUXTY=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=tDJLPYS1loEp0aC1r9BJoM6xeYPqeLJOrgmqsG8vRcRtgBk1E0k/nDjfoMJUlgLOq
         +0LV8oZVsopSRE51WPExwANwgaLbQKLsWD3ThUy8Z8xC/a6kXL3+QQztJXshP7T0L5
         gVKtaISq7uPC0Dk05k3RUthG1UckTGlmEaPA6ccw=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:f9d0:8381:2ca:ee7b])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id gGUl5T8ZmN-Rc2WQFak;
        Tue, 05 Mar 2019 20:27:38 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] blk-throttle: verify format of bandwidth limit and detect
 overflows
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
References: <155125474480.292717.11530762471075713387.stgit@buzz>
 <20190305155631.GC50184@devbig004.ftw2.facebook.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <8854733a-8724-d4d1-da37-48717b05a42a@yandex-team.ru>
Date:   Tue, 5 Mar 2019 20:27:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190305155631.GC50184@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05.03.2019 18:56, Tejun Heo wrote:
> Hello, Konstantin.
> 
> On Wed, Feb 27, 2019 at 11:05:44AM +0300, Konstantin Khlebnikov wrote:
>> Unlike to memory cgroup blkio throttler does not support value suffixes.
>>
>> It silently ignores everything after last digit. For example this command
>> will set rate limit 1 byte per second rather than 1 megabyte per second:
>>
>> # echo "7:0 1M" > blkio.throttle.read_bps_device
>> # cat blkio.throttle.read_bps_device
>> 7:0 1
>>
>> Cgroup2 interface has the same flaw:
>>
>> # echo "7:0 rbps=1M" > io.max
>> # cat io.max
>> 7:0 rbps=1 wbps=max riops=max wiops=max
>>
>> Also sscanf does not care much about overflows.
>>
>> This patch uses modern function kstrtou64 for parsing.
>> It rejects trailing garbage and detects integer overflows.
>>
>> Also this patch handles iops limit overflows for cgroup-v1 in the same as
>> cgroup-v2: limits >= UINT_MAX becomes unlimited.
>>
>> Fixes: 2ee867dcfa2e ("blkcg: implement interface for the unified hierarchy")
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> 
> So, I'd much rather keep the parsing implementations simple.  Unless
> there's a correctness problem (you mentioned overflowing, how would
> that happen?), the simpler the better.  I don't think the kernel needs
> to be in the business of strict input verification here.

This is inconsistency between controllers. IO controller should either
accept size suffixes or reject them. Ignoring garbage is not an option.
To be honest, I've successfully shot in the foot by bps limit "1M".

Integer overflows are happens when userspace software uses floats for data
representation and calculations. This way values bigger than 2^32-1 or
2^64-1 could appear easily in text representation.

Almost all integer knobs in sysctl and sysfs use modern kstrtoXX functions
with strict validation of format and overflows.

> 
> Thanks.
> 
