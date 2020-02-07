Return-Path: <SRS0=URwg=33=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AC8C352A2
	for <linux-block@archiver.kernel.org>; Fri,  7 Feb 2020 10:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5C920838
	for <linux-block@archiver.kernel.org>; Fri,  7 Feb 2020 10:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgBGK4u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Feb 2020 05:56:50 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2391 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726798AbgBGK4u (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Feb 2020 05:56:50 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 905B9DC9F0E6E485ABF9;
        Fri,  7 Feb 2020 10:56:46 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 7 Feb 2020 10:56:46 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 7 Feb 2020
 10:56:45 +0000
Subject: Re: [PATCH V5 0/6] blk-mq: improvement CPU hotplug
To:     Ming Lei <tom.leiming@gmail.com>
CC:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Hannes Reinecke" <hare@suse.com>, Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>
References: <20200115114409.28895-1-ming.lei@redhat.com>
 <929dbfac-de46-a947-6a2c-f4d8d504c631@huawei.com>
 <6dbe8c9f-af4e-3157-b6e9-6bbf43efb1e1@huawei.com>
 <CACVXFVN8io2Pj1HZWLy=z1dbDrE3h9Q6B0DA4gdGOdK3+bRRPg@mail.gmail.com>
 <b1f67efb-585d-e0c1-460f-52be0041b37a@huawei.com>
 <CACVXFVOk3cnRqyngYjHPPtLM1Wn8p3=hP8C3tBns9nDQAnoCyQ@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <0ba80182-01f0-4118-a70c-9faba96d3a3d@huawei.com>
Date:   Fri, 7 Feb 2020 10:56:44 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CACVXFVOk3cnRqyngYjHPPtLM1Wn8p3=hP8C3tBns9nDQAnoCyQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 31/01/2020 10:58, Ming Lei wrote:
> On Fri, Jan 31, 2020 at 6:24 PM John Garry<john.garry@huawei.com>  wrote:
>>>> [  141.976109] Call trace:
>>>> [  141.978550]  __switch_to+0xbc/0x218
>>>> [  141.982029]  blk_mq_run_work_fn+0x1c/0x28
>>>> [  141.986027]  process_one_work+0x1e0/0x358
>>>> [  141.990025]  worker_thread+0x40/0x488
>>>> [  141.993678]  kthread+0x118/0x120
>>>> [  141.996897]  ret_from_fork+0x10/0x18
>>> Hi John,
>>>
>>> Thanks for your test!
>>>
>> Hi Ming,
>>
>>> Could you test the following patchset and only the last one is changed?
>>>
>>> https://github.com/ming1/linux/commits/my_for_5.6_block
>> For SCSI testing, I will ask my colleague Xiang Chen to test when he
>> returns to work. So I did not see this issue for my SCSI testing for
>> your original v5, but I was only using 1x as opposed to maybe 20x SAS disks.
>>
>> BTW, did you test NVMe? For some reason I could not trigger a scenario
>> where we're draining the outstanding requests for a queue which is being
>> deactivated - I mean, the queues were always already quiesced.
> I run cpu hotplug test on both NVMe and SCSI in KVM, and fio just runs
> as expected.
> 
> NVMe is often 1:1 mapping, so it might be a bit difficult to trigger
> draining in-flight IOs.
> 

Hi Ming,

We got around to testing your my_for_5.6_block branch (Xiang Chen 
actually took the v5 series and applied the following on top only:
block: deactivate hctx when running queue in wrong CPU core
Revert "block: deactivate hctx when all its CPUs are offline when run…)

and we get this:

] IRQ 598: no longer affine to CPU4
[ 1077.396063] CPU4: shutdown
[ 1077.398769] psci: CPU4 killed (polled 0 ms)
[ 1077.457777] CPU3: shutdown
[ 1077.460495] psci: CPU3 killed (polled 0 ms)
[ 1077.499650] CPU2: shutdown
[ 1077.502357] psci: CPU2 killed (polled 0 ms)
[ 1077.546976] CPU1: shutdown
[ 1077.549690] psci: CPU1 killed (polled 0 ms)
it's running b  0
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [38.9% done] 
[1201MB/0KB/0KB /s] [307K/0/0 iops] [eta 00m:22s]
it's running b  1
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [41.7% done] 
[625.2MB/0KB/0KB /s] [160K/0/0 iops] [eta 00m:21s]
it's running b  2
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [44.4% done] 
[637.1MB/0KB/0KB /s] [163K/0/0 iops] [eta 00m:20s]
it's running b  3
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [47.2% done] 
[648.6MB/0KB/0KB /s] [166K/0/0 iops] [eta 00m:19s]
it's running b  4
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [50.0% done] 
[672.8MB/0KB/0KB /s] [172K/0/0 iops] [eta 00m:18s]
it's running b  5
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [52.8% done] 
[680.2MB/0KB/0KB /s] [174K/0/0 iops] [eta 00m:17s]
it's running b  6
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [55.6% done] 
[674.7MB/0KB/0KB /s] [173K/0/0 iops] [eta 00m:16s]
it's running b  7
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [58.3% done] 
[666.2MB/0KB/0KB /s] [171K/0/0 iops] [eta 00m:15s]
it's running b  8
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [61.1% done] 
[668.7MB/0KB/0KB /s] [171K/0/0 iops] [eta 00m:14s]
it's running b  9
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [63.9% done] 
[657.9MB/0KB/0KB /s] [168K/0/0 iops] [eta 00m:13s]
it's running b  10
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [66.7% done] 
[659.6MB/0KB/0KB /s] [169K/0/0 iops] [eta 00m:12s]
it's running b  11
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [69.4% done] 
[662.8MB/0KB/0KB /s] [170K/0/0 iops] [eta 00m:11s]
it's running b  12
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [72.2% done] 
[669.8MB/0KB/0KB /s] [171K/0/0 iops] [eta 00m:10s]
it's running b  13
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [75.0% done] 
[673.2MB/0KB/0KB /s] [172K/0/0 iops] [eta 00m:09s]
it's running b  14
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [77.8% done] 
[650.5MB/0KB/0KB /s] [167K/0/0 iops] [eta 00m:08s]
it's running b  15
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [80.6% done] 
[658.9MB/0KB/0KB /s] [169K/0/0 iops] [eta 00m:07s]
it's running b  16
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [83.3% done] 
[670.3MB/0KB/0KB /s] [172K/0/0 iops] [eta 00m:06s]
it's running b  17
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [86.1% done] 
[663.7MB/0KB/0KB /s] [170K/0/0 iops] [eta 00m:05s]
it's running b  18
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [88.9% done] 
[657.9MB/0KB/0KB /s] [168K/0/0 iops] [eta 00m:04s]
it's running b  19
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [91.7% done] 
[650.9MB/0KB/0KB /s] [167K/0/0 iops] [eta 00m:03s]
it's running b  20
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [94.4% done] 
[646.1MB/0KB/0KB /s] [166K/0/0 iops] [eta 00m:02s]
it's running b  21
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [97.2% done] 
[658.4MB/0KB/0KB /s] [169K/0/0 iops] [eta 00m:01s]
it's running b  22
Jobs: 40 (f=40): [RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR] [100.0% 
done] [649.4MB/0KB/0KB /s] [166K/0/0 iops] [eta 00m:00s]
it's running b  23
Jobs: 1 (f=1): [______________________R_________________] [2.6% done] 
[402.5MB/0KB/0KB /s] [103K/0/0 iops] [eta 22m:44s]
it's running b  24
Jobs: 1 (f=1): [______________________R_________________] [2.7% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 22m:43s]
it's running b  25
Jobs: 1 (f=1): [______________________R_________________] [2.8% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 22m:42s]
it's running b  26
Jobs: 1 (f=1): [______________________R_________________] [2.9% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 22m:41s]
it's running b  27
Jobs: 1 (f=1): [______________________R_________________] [2.9% done] 
[0KB/0KB/0KB /s] [0/0/0 iops] [eta 22m:40s]
[ 1105.419335] sas: Enter sas_scsi_recover_host busy: 1 failed: 1
[ 1105.425185] sas: trying to find task 0x00000000f1b865f3
[ 1105.430409] sas: sas_scsi_find_task: aborting task 0x00000000f1b865f3
not running b  28
#

Looks like the queues are not properly drained as we're getting a single 
IO timeout. I'll have a look when I get a chance.

Cheers,
John
