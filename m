Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64494C433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Mar 2022 08:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345631AbiCOIFH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 04:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiCOIFH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 04:05:07 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6F236153
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 01:03:54 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id e24so27606612wrc.10
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 01:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lPaiPZxGEpEpkm8pNrCymMDcaFj4w7Q4PkUpBC9Mq5o=;
        b=WkebNT3wFl41dC6Szby+oyEiDCWb9po6HyvW3MsVUlQiragkM6SproqsqhwfpnnUti
         3tkFIXwLJNLjDyGKa3Pjw+Amr/GICzpasmp4LoeK4FZXnVy1y1jrQpwNcjMt3NLC4IiV
         FXKKxMNSRLkSkrPoyiOi3fqXQ46DYJBb+Z/OdaM/O8YDSWbXJXEDdDRRN1QhhyUlpsm5
         S7UdvdbWGfAoUtE1zvVK9S1MX9XMr1oHRNvJxeVF+sfBOUCcl9X9JGW7rZceHCKPDNQv
         ONvpjf2yWPlZVgSgSBZMXKrdB6rO6wcMxSlXSWoj2nZlH8vX0eEuVsva0TYoAo2DQG4Y
         kKQA==
X-Gm-Message-State: AOAM532cmAmlBVBMgNmL5qG9knE5CGpnvJHe17W6PFpHyzB63YKLU0WO
        gmW5NqXrMy+/t/rVn4aqBGrstt46V3E=
X-Google-Smtp-Source: ABdhPJyCneij0ZT/mDNBoHprDyYDtZfqJL9KNv4hlWlKP/8kzM/POm8f+KvQq3mCharhtBzNuJXZuQ==
X-Received: by 2002:adf:910a:0:b0:1ed:c3fc:2dcf with SMTP id j10-20020adf910a000000b001edc3fc2dcfmr19534449wrj.430.1647331432738;
        Tue, 15 Mar 2022 01:03:52 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j34-20020a05600c1c2200b0038995cb915fsm2733866wms.9.2022.03.15.01.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 01:03:52 -0700 (PDT)
Message-ID: <9749b5c1-e990-a08c-5be5-5df19a3ebc7d@grimberg.me>
Date:   Tue, 15 Mar 2022 10:03:50 +0200
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
 <6d831f69-06f4-fafe-ce17-13596e6f3f6d@grimberg.me>
 <50379fbf-0344-7471-365e-76bab8dc949e@oracle.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <50379fbf-0344-7471-365e-76bab8dc949e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/14/22 19:12, Mike Christie wrote:
> On 3/13/22 4:15 PM, Sagi Grimberg wrote:
>>
>>>>>>> Actually, I'd rather have something like an 'inverse io_uring', where
>>>>>>> an application creates a memory region separated into several 'ring'
>>>>>>> for submission and completion.
>>>>>>> Then the kernel could write/map the incoming data onto the rings, and
>>>>>>> application can read from there.
>>>>>>> Maybe it'll be worthwhile to look at virtio here.
>>>>>>
>>>>>> There is lio loopback backed by tcmu... I'm assuming that nvmet can
>>>>>> hook into the same/similar interface. nvmet is pretty lean, and we
>>>>>> can probably help tcmu/equivalent scale better if that is a concern...
>>>>>
>>>>> Sagi,
>>>>>
>>>>> I looked at tcmu prior to starting this work.  Other than the tcmu
>>>>> overhead, one concern was the complexity of a scsi device interface
>>>>> versus sending block requests to userspace.
>>>>
>>>> The complexity is understandable, though it can be viewed as a
>>>> capability as well. Note I do not have any desire to promote tcmu here,
>>>> just trying to understand if we need a brand new interface rather than
>>>> making the existing one better.
>>>
>>> Ccing tcmu maintainer Bodo.
>>>
>>> We don't want to re-use tcmu's interface.
>>>
>>> Bodo has been looking into on a new interface to avoid issues tcmu has
>>> and to improve performance. If it's allowed to add a tcmu like backend to
>>> nvmet then it would be great because lio was not really made with mq and
>>> perf in mind so it already starts with issues. I just started doing the
>>> basics like removing locks from the main lio IO path but it seems like
>>> there is just so much work.
>>
>> Good to know...
>>
>> So I hear there is a desire to do this. So I think we should list the
>> use-cases for this first because that would lead to different design
>> choices.. For example one use-case is just to send read/write/flush
>> to userspace, another may want to passthru nvme commands to userspace
>> and there may be others...
> 
> We might want to discuss at OLS or start a new thread.
> 
> Based on work we did for tcmu and local nbd, the issue is how complex
> can handling nvme commands in the kernel get? If you want to run nvmet
> on a single node then you can pass just read/write/flush to userspace
> and it's not really an issue.

As I said, I can see other use-cases that may want raw nvme commands
in a backend userspace driver...

> 
> For tcmu/nbd the issue we are hitting is how to handle SCSI PGRs when
> you are running lio on multiple nodes and the nodes export the same
> LU to the same initiators. You can do it all in kernel like Bart did
> for SCST and DLM
> (https://blog.linuxplumbersconf.org/2015/ocw/sessions/2691.html).
> However, for lio and tcmu some users didn't want pacemaker/corosync and
> instead wanted to use their project's clustering or message passing
> So pushing to user space is nice for these commands.

For this use-case we'd probably want to scan the config knobs to see
that we have what's needed (I think we should have enough to enable this
use-case).

> 
> There are/were also issues with things like ALUA commands and handling
> failover across nodes but I think nvme ANA avoids them. Like there
> is nothing in nvme ANA like the SET_TARGET_PORT_GROUPS command which can
> set the state of what would be remote ports right?

Right.
