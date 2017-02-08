Return-Path: <axboe@kernel.dk>
Subject: Boot regression (was "Re: [PATCH] genhd: Do not hold event lock when
 scheduling workqueue elements")
To: Dexuan Cui <decui@microsoft.com>,
 Bart Van Assche <Bart.VanAssche@sandisk.com>, "hare@suse.com"
 <hare@suse.com>, "hare@suse.de" <hare@suse.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1484732896-22941-1-git-send-email-hare@suse.de>
 <1485822639.2669.16.camel@sandisk.com>
 <532c55c4-15da-d2f9-401c-36bc4343756b@suse.com>
 <MWHPR03MB2669B8A45A07846AF0A06E46BF4F0@MWHPR03MB2669.namprd03.prod.outlook.com>
 <MWHPR03MB26699D4657FB67A535972208BF430@MWHPR03MB2669.namprd03.prod.outlook.com>
 <1486436195.2791.1.camel@sandisk.com>
 <MWHPR03MB26695ACBEBDB30E3E2E108FBBF430@MWHPR03MB2669.namprd03.prod.outlook.com>
 <MWHPR03MB2669125A47D3CB7EB530D084BF430@MWHPR03MB2669.namprd03.prod.outlook.com>
 <9199d528-f220-5b77-d657-c510ca210067@kernel.dk>
 <MWHPR03MB26697302F28F9C2C7D7390D4BF420@MWHPR03MB2669.namprd03.prod.outlook.com>
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "jth@kernel.org" <jth@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b21e5580-ed75-6150-3c83-43ecbb0292a5@kernel.dk>
Date: Wed, 8 Feb 2017 10:43:59 -0700
MIME-Version: 1.0
In-Reply-To: <MWHPR03MB26697302F28F9C2C7D7390D4BF420@MWHPR03MB2669.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 02/08/2017 03:48 AM, Dexuan Cui wrote:
>> From: Jens Axboe [mailto:axboe@kernel.dk]
>> Sent: Wednesday, February 8, 2017 00:09
>> To: Dexuan Cui <decui@microsoft.com>; Bart Van Assche
>> <Bart.VanAssche@sandisk.com>; hare@suse.com; hare@suse.de
>> Cc: hch@lst.de; linux-kernel@vger.kernel.org; linux-block@vger.kernel.org;
>> jth@kernel.org
>> Subject: Re: [PATCH] genhd: Do not hold event lock when scheduling workqueue
>> elements
>>
>> On 02/06/2017 11:29 PM, Dexuan Cui wrote:
>>>> From: linux-block-owner@vger.kernel.org [mailto:linux-block-
>>>> owner@vger.kernel.org] On Behalf Of Dexuan Cui
>>>> with the linux-next kernel.
>>>>
>>>> I can boot the guest with linux-next's next-20170130 without any issue,
>>>> but since next-20170131 I haven't succeeded in booting the guest.
>>>>
>>>> With next-20170203 (mentioned in my mail last Friday), I got the same
>>>> calltrace as Hannes.
>>>>
>>>> With today's linux-next (next-20170206), actually the calltrace changed to
>>>> the below.
>>>> [  122.023036]  ? remove_wait_queue+0x70/0x70
>>>> [  122.051383]  async_synchronize_full+0x17/0x20
>>>> [  122.076925]  do_init_module+0xc1/0x1f9
>>>> [  122.097530]  load_module+0x24bc/0x2980
>>>
>>> I don't know why it hangs here, but this is the same calltrace in my
>>> last-Friday mail, which contains 2 calltraces. It looks the other calltrace has
>>> been resolved by some changes between next-20170203 and today.
>>>
>>> Here the kernel is trying to load the Hyper-V storage driver (hv_storvsc), and
>>> the driver's __init and .probe have finished successfully and then the kernel
>>> hangs here.
>>>
>>> I believe something is broken recently, because I don't have any issue before
>>> Jan 31.
>>
>> Can you try and bisect it?
>>
>> Jens Axboe
> 
> I bisected it on the branch for-4.11/next of the linux-block repo and the log shows
> the first bad commit is 
> [e9c787e6] scsi: allocate scsi_cmnd structures as part of struct request
> 
> # git bisect log
> git bisect start
> # bad: [80c6b15732f0d8830032149cbcbc8d67e074b5e8] blk-mq-sched: (un)register elevator when (un)registering queue
> git bisect bad 80c6b15732f0d8830032149cbcbc8d67e074b5e8
> # good: [309bd96af9e26da3038661bf5cdad780eef49dd9] md: cleanup bio op / flags handling in raid1_write_request
> git bisect good 309bd96af9e26da3038661bf5cdad780eef49dd9
> # bad: [27410a8927fb89bd150de08d749a8ed7f67b7739] nbd: remove REQ_TYPE_DRV_PRIV leftovers
> git bisect bad 27410a8927fb89bd150de08d749a8ed7f67b7739
> # bad: [e9c787e65c0c36529745be47d490d998b4b6e589] scsi: allocate scsi_cmnd structures as part of struct request
> git bisect bad e9c787e65c0c36529745be47d490d998b4b6e589
> # good: [3278255741326b6d66d8ca7d1cb2c57633ee43d9] scsi_dh_rdac: switch to scsi_execute_req_flags()
> git bisect good 3278255741326b6d66d8ca7d1cb2c57633ee43d9
> # good: [0fbc3e0ff623f1012e7c2af96e781eeb26bcc0d7] scsi: remove gfp_flags member in scsi_host_cmd_pool
> git bisect good 0fbc3e0ff623f1012e7c2af96e781eeb26bcc0d7
> # good: [eeff68c5618c8d0920b14533c70b2df007bd94b4] scsi: remove scsi_cmd_dma_pool
> git bisect good eeff68c5618c8d0920b14533c70b2df007bd94b4
> # good: [d48777a633d6fa7ccde0f0e6509f0c01fbfc5299] scsi: remove __scsi_alloc_queue
> git bisect good d48777a633d6fa7ccde0f0e6509f0c01fbfc5299
> # first bad commit: [e9c787e65c0c36529745be47d490d998b4b6e589] scsi: allocate scsi_cmnd structures as part of struct request

Christoph?

I've changed the subject line, this issue has nothing to do with the
issue that Hannes was attempting to fix.

-- 
Jens Axboe
