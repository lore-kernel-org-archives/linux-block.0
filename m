Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC55C71145
	for <linux-block@archiver.kernel.org>; Thu, 24 Aug 2023 07:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240335AbjHXH3g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Aug 2023 03:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240384AbjHXH3V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2023 03:29:21 -0400
Received: from uriel.iewc.co.za (uriel.iewc.co.za [IPv6:2c0f:f720:0:3::9a49:2248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF7D10C8
        for <linux-block@vger.kernel.org>; Thu, 24 Aug 2023 00:29:18 -0700 (PDT)
Received: from [154.73.32.4] (helo=tauri.local.uls.co.za)
        by uriel.iewc.co.za with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <jaco@uls.co.za>)
        id 1qZ4mF-0006SD-2t;
        Thu, 24 Aug 2023 09:29:11 +0200
Received: from [192.168.42.21]
        by tauri.local.uls.co.za with esmtp (Exim 4.96)
        (envelope-from <jaco@uls.co.za>)
        id 1qZ4mF-0001oJ-1R;
        Thu, 24 Aug 2023 09:29:11 +0200
Message-ID: <d4b1c5d7-020b-7ef9-ee43-e78891649a3c@uls.co.za>
Date:   Thu, 24 Aug 2023 09:29:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Jaco Kroon <jaco@uls.co.za>
Subject: Re: LVM kernel lockup scenario during lvcreate
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <549daeae-1180-c0d4-915c-f18bcd1c68c3@uls.co.za>
 <58b1c8ae-dd2d-3eeb-f707-3f20513ab9e3@acm.org>
 <102b1994-74ff-c099-292c-f5429ce768c3@uls.co.za>
 <6b066ab5-7806-5a23-72a5-073153259116@acm.org>
 <544f4434-a32a-1824-b57a-9f7ff12dbb4f@uls.co.za>
 <a6d73e89-7a0c-3173-5f70-cd12cc7ef158@acm.org>
 <18d1c5a6-acd3-88cf-f997-80d97f43ab5c@uls.co.za>
 <0beea79c-af29-9f8f-e1f4-c8deba5a65c8@uls.co.za>
 <07d8b189-9379-560b-3291-3feb66d98e5c@acm.org>
 <ea29d76f-99c0-fcf2-09a3-4cc2e18f87da@uls.co.za>
 <1cf96e3b-e5e0-bcdb-df2b-ef9cbe51f9ca@acm.org>
 <ef2812b4-7853-9dda-85dd-210636840a59@uls.co.za>
Content-Language: en-GB
Organization: Ultimate Linux Solutions (Pty) Ltd
In-Reply-To: <ef2812b4-7853-9dda-85dd-210636840a59@uls.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart,


Just a follow up on this.


It seems even with the "none" scheduler we had an occurrence of this 
now.  Unfortunately I could not get to the host quickly enough in order 
to confirm ongoing IO, although based on the activity LEDs there were 
disks with IO.  I believe the disk controller controls these LEDs, but 
I'm not sure the pattern used to switch them on/off and this could vary 
from controller to controller (ie, do they go off only once the host has 
confirmed receipt of data, or once the data has been sent to the host?). 
This does seem to support your theory of a controller firmware issue.


It definitely happens more often with mq-deadline compared to none.


We're definitely seeing the same thing on another host using an ahci 
controller.  This seems to hint that it's not a firmware issue, as does 
the fact that this happens much less frequently with the none scheduler.


I will make a plan to action the firmware updates on the raid controller 
over the weekend regardless, just in order to eliminate that.  I will 
then revert to mq-deadline.  Assuming this does NOT fix it, how would I 
go about assessing if this is a controller firmware issue or a Linux 
kernel issue?


Come to think of it, it may be related or not, we've long since switched 
off dmeventd as running dmeventd causes this to happen on all hosts the 
moments any form of snapshots are involved.  With dmeventd combined with 
"heavy" use of the lv commands we could pretty much guarantee some level 
of lockup within a couple of days.


Kind regards,
Jaco


On 2023/07/13 17:07, Jaco Kroon wrote:
>
> Hi Bart,
>
>
> Not familiar at all with fio, so hoping this was OK.
>
>
> On 2023/07/12 15:43, Bart Van Assche wrote:
>> On 7/12/23 03:12, Jaco Kroon wrote:
>>> Ideas/Suggestions?
>>
>> How about manually increasing the workload, e.g. by using fio to 
>> randomly read 4 KiB fragments with a high queue depth?
>>
>> Bart.
>
>
> [global]
> kb_base=1024
> unit_base=8
> loops=10000
> runtime=7200
> time_based=1
> directory=/home/fio
> nrfiles=1
> size=4194304
> iodepth=256
> ioengine=io_uring
> numjobs=512
> create_fsync=1
>
> [reader]
>
>
>
> crowsnest [17:01:35] ~ # fio --alloc-size=$(( 32 * 1024 )) fio.ini
>
> Load averag went up to 1200+, IO was consistently 1GB/s read 
> throughput, and IOPs anywhere between 100k and 500k, mostly around the 
> 150k region.
>
>
> Guessing the next step would be to restore mq-deadline as scheduler 
> and re-do?
>
>
> I've neglected to capture the output unfortunately, will do next run 
> with --output if needed.  Can definitely initiate another run around 
> 6:00am GMT in the morning.
>
>
> Kind Regards,
> Jaco
>
