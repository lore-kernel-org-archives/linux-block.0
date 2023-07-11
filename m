Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DCEEB64DC
	for <linux-block@archiver.kernel.org>; Tue, 11 Jul 2023 13:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjGKNWs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jul 2023 09:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjGKNWr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2023 09:22:47 -0400
Received: from bagheera.iewc.co.za (unknown [IPv6:2c0f:f720:0:3::9a49:2249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5698B18D
        for <linux-block@vger.kernel.org>; Tue, 11 Jul 2023 06:22:43 -0700 (PDT)
Received: from [154.73.32.4] (helo=tauri.local.uls.co.za)
        by bagheera.iewc.co.za with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jaco@uls.co.za>)
        id 1qJDJp-0006tp-UJ; Tue, 11 Jul 2023 15:22:17 +0200
Received: from [192.168.42.102]
        by tauri.local.uls.co.za with esmtp (Exim 4.94.2)
        (envelope-from <jaco@uls.co.za>)
        id 1qJDJp-0003XN-FQ; Tue, 11 Jul 2023 15:22:17 +0200
Message-ID: <0beea79c-af29-9f8f-e1f4-c8deba5a65c8@uls.co.za>
Date:   Tue, 11 Jul 2023 15:22:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: LVM kernel lockup scenario during lvcreate
Content-Language: en-GB
From:   Jaco Kroon <jaco@uls.co.za>
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <549daeae-1180-c0d4-915c-f18bcd1c68c3@uls.co.za>
 <58b1c8ae-dd2d-3eeb-f707-3f20513ab9e3@acm.org>
 <102b1994-74ff-c099-292c-f5429ce768c3@uls.co.za>
 <6b066ab5-7806-5a23-72a5-073153259116@acm.org>
 <544f4434-a32a-1824-b57a-9f7ff12dbb4f@uls.co.za>
 <a6d73e89-7a0c-3173-5f70-cd12cc7ef158@acm.org>
 <18d1c5a6-acd3-88cf-f997-80d97f43ab5c@uls.co.za>
Organization: Ultimate Linux Solutions (Pty) Ltd
In-Reply-To: <18d1c5a6-acd3-88cf-f997-80d97f43ab5c@uls.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart,

On 2023/06/27 01:29, Jaco Kroon wrote:
> Hi Bart,
>
> On 2023/06/26 18:42, Bart Van Assche wrote:
>> On 6/26/23 01:30, Jaco Kroon wrote:
>>> Please find attached updated ps and dmesg too, diskinfo wasn't 
>>> regenerated but this doesn't generally change.
>>>
>>> Not sure how this all works, according to what I can see the only 
>>> disk with pending activity (queued) is sdw?  Yet, a large number of 
>>> processes is blocking on IO, and yet again the stack traces in dmesg 
>>> points at __schedule.  For a change we do not have lvcreate in the 
>>> process list! This time that particular script's got a fsck in 
>>> uninterruptable wait ...
>>
>> Hi Jaco,
>>
>> I see pending commands for five different SCSI disks:
>>
>> $ zgrep /busy: block.gz
>> ./sdh/hctx0/busy:00000000affe2ba0 {.op=WRITE, .cmd_flags=SYNC|FUA, 
>> .rq_flags=FLUSH_SEQ|MQ_INFLIGHT|DONTPREP|IO_STAT|ELV, 
>> .state=in_flight, .tag=2055, .internal_tag=214, .cmd=Write(16) 8a 08 
>> 00 00 00 01 d1 c0 b7 88 00 00 00 08 00 00, .retries=0, .result = 0x0, 
>> .flags=TAGGED|INITIALIZED|LAST, .timeout=180.000, allocated 0.000 s ago}
>> ./sda/hctx0/busy:00000000987bb7c7 {.op=WRITE, .cmd_flags=SYNC|FUA, 
>> .rq_flags=FLUSH_SEQ|MQ_INFLIGHT|DONTPREP|IO_STAT|ELV, 
>> .state=in_flight, .tag=2050, .internal_tag=167, .cmd=Write(16) 8a 08 
>> 00 00 00 01 d1 c0 b7 88 00 00 00 08 00 00, .retries=0, .result = 0x0, 
>> .flags=TAGGED|INITIALIZED|LAST, .timeout=180.000, allocated 0.010 s ago}
>> ./sdw/hctx0/busy:00000000aec61b17 {.op=READ, .cmd_flags=META|PRIO, 
>> .rq_flags=STARTED|MQ_INFLIGHT|DONTPREP|ELVPRIV|IO_STAT|ELV, 
>> .state=in_flight, .tag=2056, .internal_tag=8, .cmd=Read(16) 88 00 00 
>> 00 00 00 00 1c 01 a8 00 00 00 08 00 00, .retries=0, .result = 0x0, 
>> .flags=TAGGED|INITIALIZED|LAST, .timeout=180.000, allocated 0.000 s ago}
>> ./sdw/hctx0/busy:0000000087e9a58e {.op=WRITE, .cmd_flags=SYNC|FUA, 
>> .rq_flags=FLUSH_SEQ|MQ_INFLIGHT|DONTPREP|IO_STAT|ELV, 
>> .state=in_flight, .tag=2058, .internal_tag=102, .cmd=Write(16) 8a 08 
>> 00 00 00 01 d1 c0 b7 88 00 00 00 08 00 00, .retries=0, .result = 0x0, 
>> .flags=TAGGED|INITIALIZED|LAST, .timeout=180.000, allocated 0.000 s ago}
>> ./sdaf/hctx0/busy:00000000d8751601 {.op=WRITE, .cmd_flags=SYNC|FUA, 
>> .rq_flags=FLUSH_SEQ|MQ_INFLIGHT|DONTPREP|IO_STAT|ELV, 
>> .state=in_flight, .tag=2057, .internal_tag=51, .cmd=Write(16) 8a 08 
>> 00 00 00 01 d1 c0 b7 88 00 00 00 08 00 00, .retries=0, .result = 0x0, 
>> .flags=TAGGED|INITIALIZED|LAST, .timeout=180.000, allocated 0.010 s ago}
>>
>> All requests have the flag "ELV". So my follow-up questions are:
>> * Which I/O scheduler has been configured? If it is BFQ, please try 
>> whether
>>   mq-deadline or "none" work better.
>
> crowsnest [00:34:58] /sys/class/block/sda/device/block/sda/queue # cat 
> scheduler
> none [mq-deadline] kyber bfq
>
> crowsnest [00:35:31] /sys/class/block # for i in 
> */device/block/sd*/queue/scheduler; do echo none > $i; done
> crowsnest [00:35:45] /sys/class/block #
>
> So let's see if that perhaps relates.  Neither CFQ nor BFQ has ever 
> given me anywhere near the performance of deadline, so that's our 
> default goto.

crowsnest [15:03:34] ~ # uptime
  15:07:52 up 15 days,  4:47,  3 users,  load average: 10.26, 9.88, 9.68

"how long is a piece of string?" comes to mind whether looking to decide 
if that's sufficiently long to call it success?  Normally died after 
about 7 days.

So *suspected* mq-deadline bug?

> And various hints that newer firmware exists ... but broadcom is not 
> making it easy to find the download nor is supermicro's website of 
> much help ... will try again during more sane hours.
>
> https://www.broadcom.com/support/download-search?pg=Storage+Adapters,+Controllers,+and+ICs&pf=Storage+Adapters,+Controllers,+and+ICs&pn=SAS3008+I/O+Controller&pa=Firmware&po=&dk=&pl=&l=false 
>

Supermicro has responded with appropriate upgrade options which we've 
not executed yet, but I'll make time for that over the coming weekend, 
or perhaps I should wait a bit longer to give more time for a similar 
lockup with the none scheduler?

Kind Regards,
Jaco

