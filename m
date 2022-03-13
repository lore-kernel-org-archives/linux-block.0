Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9E7C433F5
	for <linux-block@archiver.kernel.org>; Sun, 13 Mar 2022 21:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbiCMVQV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Mar 2022 17:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiCMVQU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Mar 2022 17:16:20 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3DE32EC8
        for <linux-block@vger.kernel.org>; Sun, 13 Mar 2022 14:15:12 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id g3so17345664edu.1
        for <linux-block@vger.kernel.org>; Sun, 13 Mar 2022 14:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2IGzCcAoUKBG+McJjJnibBpWAWFZfZOGrCz/Dpq5wAI=;
        b=cQgc4jw1PXY8mQBzWZ/HRMvp3EqYYe3YZnqfdNKeeMlXrum6h1kZWJzXfif3XwkAln
         nJs7kjqK+52Z4EeSsfAnhshJqWzBvTkEOeVQ/PpqyLJ4EksJs+YtknLtWx8qVAPr1djR
         jEIhmcBhy1RJaA7EGgYXRW52CZmVL2ZT1p1EmkvgWP5wFsEccjll4MdPwZrdSA5anhBp
         bi8Y+NGhWA+t2oMlAMR8O+qHlQpuK2UWt/xMuxXaTvGW3QiCtl0ScXywCDYf3QPc9Nxr
         9bn/IetHlou4ESujRTGi75gpUxLRRrgT379vD605Db15qm3c/4FsERvtN9Q4iL/ARw/N
         GcRA==
X-Gm-Message-State: AOAM530kyWSREh8Wnc1AlJfET5Uj5HQdfrCbkdSoL8gKKZTbkJ7PO3hj
        Z532j6jk9wrFq/7LPBvYvwI=
X-Google-Smtp-Source: ABdhPJzVcX5Dr1wZpXgT9csylL88uBsId/HG3SwQyvYX2etGJ6tAhIDspNubCZ78MQd5TqPubfzRCA==
X-Received: by 2002:aa7:db94:0:b0:410:f0e8:c39e with SMTP id u20-20020aa7db94000000b00410f0e8c39emr17605239edt.14.1647206110765;
        Sun, 13 Mar 2022 14:15:10 -0700 (PDT)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il. [46.117.116.119])
        by smtp.gmail.com with ESMTPSA id g9-20020aa7c849000000b00412fc6bf26dsm6915332edt.80.2022.03.13.14.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Mar 2022 14:15:10 -0700 (PDT)
Message-ID: <6d831f69-06f4-fafe-ce17-13596e6f3f6d@grimberg.me>
Date:   Sun, 13 Mar 2022 23:15:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Content-Language: en-US
To:     Mike Christie <michael.christie@oracle.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Hannes Reinecke <hare@suse.de>, lsf-pc@lists.linux-foundation.org,
        linux-block@vger.kernel.org
References: <87tucsf0sr.fsf@collabora.com>
 <986caf55-65d1-0755-383b-73834ec04967@suse.de>
 <b6bb4435-d83c-b129-c761-00a74e7e0739@grimberg.me>
 <87bkyyg4jc.fsf@collabora.com>
 <e0a6ca51-8202-0b61-dd50-349e6f27761b@grimberg.me>
 <45caea9d-53d0-6f06-bb98-9174a08972d4@oracle.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <45caea9d-53d0-6f06-bb98-9174a08972d4@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>>> Actually, I'd rather have something like an 'inverse io_uring', where
>>>>> an application creates a memory region separated into several 'ring'
>>>>> for submission and completion.
>>>>> Then the kernel could write/map the incoming data onto the rings, and
>>>>> application can read from there.
>>>>> Maybe it'll be worthwhile to look at virtio here.
>>>>
>>>> There is lio loopback backed by tcmu... I'm assuming that nvmet can
>>>> hook into the same/similar interface. nvmet is pretty lean, and we
>>>> can probably help tcmu/equivalent scale better if that is a concern...
>>>
>>> Sagi,
>>>
>>> I looked at tcmu prior to starting this work.  Other than the tcmu
>>> overhead, one concern was the complexity of a scsi device interface
>>> versus sending block requests to userspace.
>>
>> The complexity is understandable, though it can be viewed as a
>> capability as well. Note I do not have any desire to promote tcmu here,
>> just trying to understand if we need a brand new interface rather than
>> making the existing one better.
> 
> Ccing tcmu maintainer Bodo.
> 
> We don't want to re-use tcmu's interface.
> 
> Bodo has been looking into on a new interface to avoid issues tcmu has
> and to improve performance. If it's allowed to add a tcmu like backend to
> nvmet then it would be great because lio was not really made with mq and
> perf in mind so it already starts with issues. I just started doing the
> basics like removing locks from the main lio IO path but it seems like
> there is just so much work.

Good to know...

So I hear there is a desire to do this. So I think we should list the
use-cases for this first because that would lead to different design
choices.. For example one use-case is just to send read/write/flush
to userspace, another may want to passthru nvme commands to userspace
and there may be others...

>>> What would be the advantage of doing it as a nvme target over delivering
>>> directly to userspace as a block driver?
>>
>> Well, for starters you gain the features and tools that are extensively
>> used with nvme. Plus you get the ecosystem support (development,
>> features, capabilities and testing). There are clear advantages of
>> plugging into an established ecosystem.
> 
> Yeah, tcmu has been really nice to export storage that people for whatever
> reason didn't want in the kernel. We got the benefits you described where
> distros have the required tools and their support teams have experience, etc.

No surprise here...
