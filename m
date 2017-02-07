Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] genhd: Do not hold event lock when scheduling workqueue
 elements
To: Dexuan Cui <decui@microsoft.com>,
 Bart Van Assche <Bart.VanAssche@sandisk.com>, "hare@suse.com"
 <hare@suse.com>, "hare@suse.de" <hare@suse.de>
References: <1484732896-22941-1-git-send-email-hare@suse.de>
 <1485822639.2669.16.camel@sandisk.com>
 <532c55c4-15da-d2f9-401c-36bc4343756b@suse.com>
 <MWHPR03MB2669B8A45A07846AF0A06E46BF4F0@MWHPR03MB2669.namprd03.prod.outlook.com>
 <MWHPR03MB26699D4657FB67A535972208BF430@MWHPR03MB2669.namprd03.prod.outlook.com>
 <1486436195.2791.1.camel@sandisk.com>
 <MWHPR03MB26695ACBEBDB30E3E2E108FBBF430@MWHPR03MB2669.namprd03.prod.outlook.com>
 <MWHPR03MB2669125A47D3CB7EB530D084BF430@MWHPR03MB2669.namprd03.prod.outlook.com>
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "jth@kernel.org" <jth@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9199d528-f220-5b77-d657-c510ca210067@kernel.dk>
Date: Tue, 7 Feb 2017 09:09:16 -0700
MIME-Version: 1.0
In-Reply-To: <MWHPR03MB2669125A47D3CB7EB530D084BF430@MWHPR03MB2669.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 02/06/2017 11:29 PM, Dexuan Cui wrote:
>> From: linux-block-owner@vger.kernel.org [mailto:linux-block-
>> owner@vger.kernel.org] On Behalf Of Dexuan Cui
>> with the linux-next kernel.
>>
>> I can boot the guest with linux-next's next-20170130 without any issue,
>> but since next-20170131 I haven't succeeded in booting the guest.
>>
>> With next-20170203 (mentioned in my mail last Friday), I got the same
>> calltrace as Hannes.
>>
>> With today's linux-next (next-20170206), actually the calltrace changed to
>> the below.
>> [  122.023036]  ? remove_wait_queue+0x70/0x70
>> [  122.051383]  async_synchronize_full+0x17/0x20
>> [  122.076925]  do_init_module+0xc1/0x1f9
>> [  122.097530]  load_module+0x24bc/0x2980
>  
> I don't know why it hangs here, but this is the same calltrace in my
> last-Friday mail, which contains 2 calltraces. It looks the other calltrace has
> been resolved by some changes between next-20170203 and today.
> 
> Here the kernel is trying to load the Hyper-V storage driver (hv_storvsc), and
> the driver's __init and .probe have finished successfully and then the kernel
> hangs here.
> 
> I believe something is broken recently, because I don't have any issue before
> Jan 31. 

Can you try and bisect it?

-- 
Jens Axboe
