Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79516C433EF
	for <linux-block@archiver.kernel.org>; Thu, 24 Feb 2022 09:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbiBXJiH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbiBXJiH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Feb 2022 04:38:07 -0500
Received: from out199-14.us.a.mail.aliyun.com (out199-14.us.a.mail.aliyun.com [47.90.199.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415B926F4FA
        for <linux-block@vger.kernel.org>; Thu, 24 Feb 2022 01:37:36 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V5NbNMq_1645695452;
Received: from 30.225.28.168(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0V5NbNMq_1645695452)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Feb 2022 17:37:33 +0800
Message-ID: <c11d76b7-869f-a82c-970c-971274a63723@linux.alibaba.com>
Date:   Thu, 24 Feb 2022 17:37:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Content-Language: en-US
To:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Hannes Reinecke <hare@suse.de>, lsf-pc@lists.linux-foundation.org,
        linux-block@vger.kernel.org
References: <87tucsf0sr.fsf@collabora.com>
 <986caf55-65d1-0755-383b-73834ec04967@suse.de>
 <b6bb4435-d83c-b129-c761-00a74e7e0739@grimberg.me>
 <87bkyyg4jc.fsf@collabora.com>
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
In-Reply-To: <87bkyyg4jc.fsf@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

hi,

> Sagi Grimberg <sagi@grimberg.me> writes:
>
>>> Actually, I'd rather have something like an 'inverse io_uring', where
>>> an application creates a memory region separated into several 'ring'
>>> for submission and completion.
>>> Then the kernel could write/map the incoming data onto the rings, and
>>> application can read from there.
>>> Maybe it'll be worthwhile to look at virtio here.
>> There is lio loopback backed by tcmu... I'm assuming that nvmet can
>> hook into the same/similar interface. nvmet is pretty lean, and we
>> can probably help tcmu/equivalent scale better if that is a concern...
> Sagi,
>
> I looked at tcmu prior to starting this work.  Other than the tcmu
> overhead, one concern was the complexity of a scsi device interface
> versus sending block requests to userspace.
Yeah, Some of our costumers have tried to use tcmu and found obvious 
overhead, which
impact io throughput tremendously, especially it lacks zero-copy and 
multi-queue support.
Previously I have sent a report to tcmu community:
     https://www.spinics.net/lists/target-devel/msg21121.html

And currently I have implemented a zero-copy prototype for tcmu(not sent 
out yet), which
increases user's io throughput from 3.6GB to 11.5GB/s, fio 4 jobs, 8 
iodepth, io size 256kb.
This prototype uses remap_pfn_range() to map io requests' sg pages to 
user space, but
remap_pfn_range() have obvious overhead while intel pat is enabled. I 
also sent a mail to
mm community:
https://lore.kernel.org/linux-mm/c5526629-5ce4-1f99-e9af-36da2876b258@linux.alibaba.com/T/#u
About how to map sg pages to use space correctly, but there's no 
response yet.
If anybody is familiar with my question, may kindly give help, thanks.

Regards,
Xiaoguang Wang
>
> What would be the advantage of doing it as a nvme target over delivering
> directly to userspace as a block driver?
>
> Also, when considering the case where userspace wants to just look at the IO
> descriptor, without actually sending data to userspace, I'm not sure
> that would be doable with tcmu?
>
> Another attempt to do the same thing here, now with device-mapper:
>
> https://patchwork.kernel.org/project/dm-devel/patch/20201203215859.2719888-4-palmer@dabbelt.com/
>

