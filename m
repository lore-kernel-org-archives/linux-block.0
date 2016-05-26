Return-Path: <m@bjorling.me>
Return-Path: <m@bjorling.me>
Subject: Re: gendisk and lightnvm
To: Dan Williams <dan.j.williams@gmail.com>
References: <5742B023.2040503@bjorling.me>
 <CAA9_cmfVKoEw1XpJJ4j4+QHWB29-cRvdDp1hmtyegxSpBy0fNw@mail.gmail.com>
 <57473C2D.2060700@bjorling.me>
 <CAA9_cmeVeQzL7kJS1s--N9r-9Pap=KWz42Pmwd1r_4Bd03cL0g@mail.gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
 Keith Busch <keith.busch@intel.com>, Simon Lund <slund@cnexlabs.com>,
 linux-block@vger.kernel.org
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>
Message-ID: <57476FC1.6020702@bjorling.me>
Date: Thu, 26 May 2016 23:50:57 +0200
MIME-Version: 1.0
In-Reply-To: <CAA9_cmeVeQzL7kJS1s--N9r-9Pap=KWz42Pmwd1r_4Bd03cL0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 05/26/2016 09:05 PM, Dan Williams wrote:
> On Thu, May 26, 2016 at 11:10 AM, Matias Bjørling <m@bjorling.me> wrote:
>> On 05/26/2016 07:40 PM, Dan Williams wrote:
>>>
>>> On Mon, May 23, 2016 at 12:24 AM, Matias Bjørling <m@bjorling.me> wrote:
>>>>
>>>> Hi Jens, Christoph, and Keith,
>>>>
>>>> I have been pondering for a couple of weeks on how to integrate lightnvm
>>>> into the sysfs stack. Lightnvm does not currently expose a "physical"
>>>> device. During device registration, the block device name is simply
>>>> stored,
>>>> which the user may then use as an id later, and expose through a target
>>>> implementation.
>>>>
>>>> Until then, the device is left "dangling" in the kernel, without any good
>>>> way to reference it other than asking the lightnvm manager. This also
>>>> includes device driver specific configuration, such as power and mq sysfs
>>>> entries.
>>>>
>>>> It would be great to have a common way to expose the lightnvm subsystem
>>>> through the block storage stack.
>>>>
>>>> With block devices, the device driver centric information includes:
>>>>
>>>> /sys/block/*/
>>>>     inflight
>>>>     removable
>>>>     serial
>>>>     /mq
>>>>     /power
>>>
>>>
>>> Which of these attributes do you need to access before the device is live?
>>>
>>
>> Hi Dan,
>>
>> /mq would be great. That would make possible to know the status of the NVMe
>> queues when used by targets. With the current design, the NVMe driver /mq is
>> never exposed through sysfs, and the targets that exposes itself as a block
>> device initializes their private genhd.
>
> Hmm, the queue exists before the gendisk so it seems reasonable to
> register/publish mq/ sysfs before the gendisk arrives.  I.e. both the
> gendisk and the pre-gendisk lightnvm device end up referencing the
> same request_queue.
>

In that case, the holder kobject is maintained by the request queue. 
That moves the block device naming earlier in the initialization 
process, and the request queue would properly need to hold the (struct 
gendisk)->diskname. I wonder if there is a better way.
