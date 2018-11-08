Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Clear kernel memory before copying to user
To: Ming Lei <tom.leiming@gmail.com>, Keith Busch <keith.busch@intel.com>
Cc: linux-block <linux-block@vger.kernel.org>
References: <20181107143745.11845-1-keith.busch@intel.com>
 <CACVXFVO8pcZpK0MBud8oebdZWhKB0Gzr14MPbzMtoHBUkN4Rbg@mail.gmail.com>
 <20181107151538.GA11941@localhost.localdomain>
 <CACVXFVNbzK-WjJDrFjvApHE7R9bG3MnbN6M507d43KnUh3Ujpw@mail.gmail.com>
 <20181107154412.GB11941@localhost.localdomain>
 <CACVXFVPUwc9jDirAk2a4w8WhF-EqLXRputTZ+iOp9=1qAsfoeA@mail.gmail.com>
 <20181107160909.GC11941@localhost.localdomain>
 <CACVXFVMcxNdbFnJd46fd05MJ63NT5VE-M+jrjSqxP0E9zaYcag@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <79dcc81b-640c-064c-f859-7557d96bf45d@kernel.dk>
Date: Wed, 7 Nov 2018 18:31:16 -0700
MIME-Version: 1.0
In-Reply-To: <CACVXFVMcxNdbFnJd46fd05MJ63NT5VE-M+jrjSqxP0E9zaYcag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/7/18 6:12 PM, Ming Lei wrote:
> On Thu, Nov 8, 2018 at 12:12 AM Keith Busch <keith.busch@intel.com> wrote:
>>
>> On Thu, Nov 08, 2018 at 12:03:41AM +0800, Ming Lei wrote:
>>> On Wed, Nov 7, 2018 at 11:47 PM Keith Busch <keith.busch@intel.com> wrote:
>>>>
>>>> On Wed, Nov 07, 2018 at 11:44:59PM +0800, Ming Lei wrote:
>>>>> blk_update_request() may tell us how much progress made, :-)
>>>>
>>>> Except when it doesn't, which is 100% of the time for many block
>>>> drivers, including nvme.
>>>
>>> Please look at blk_mq_end_request()(<- nvme_complete_rq()), which
>>> calls blk_update_request().
>>
>> Huh? That just says 100% of the request size was transerred no matter
>> what was actually transferred.
>>
>> The protocol doesn't have a way to express what transfer size occured
>> with a command's completion, and even it did, there's no way I'd trust
>> every firmware not to screw it.
> 
> That sounds something like below:
> 
> 1) userspace requires to read 8 sectors starting from sector 0
> 2) nvme tells hardware to do that, and hardware transfers only 4
> sectors(0~3) data
> to memory, but still tells driver we have done 8 sectors(0~7).
> 
> What if there are real data in sectors 4~7?
> 
> Is it NVMe specific issue or common problem in other storage hardware?  SCSI
> does call blk_update_request() and handles partial completion.

I would never believe any of that, it's much better to error on the side
of caution for things like this. blk-mq doesn't even support partial
completions, exactly because most hw doesn't even support it. But even
for the ones that do, I would not trust it a lot.

-- 
Jens Axboe
