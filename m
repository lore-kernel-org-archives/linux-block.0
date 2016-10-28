Subject: Re: Block layer state diagrams
To: Bart Van Assche <Bart.VanAssche@sandisk.com>, "hare@suse.de"
 <hare@suse.de>
References: <0213e715-5d87-1110-45d5-ed48f8837842@sandisk.com>
 <865bd65b-b26e-d8e0-1b0e-ad715ea4d8d2@suse.de>
 <702a719e-d979-8a38-c434-55f607c21f40@sandisk.com>
 <aa53ddef-e359-e085-79a1-cce9ef74994a@fb.com>
 <1477670813.4062.1.camel@sandisk.com>
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <f0f84ad7-f863-a274-b2af-1307ad776b00@fb.com>
Date: Fri, 28 Oct 2016 10:24:42 -0600
MIME-Version: 1.0
In-Reply-To: <1477670813.4062.1.camel@sandisk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/28/2016 10:06 AM, Bart Van Assche wrote:
> On Fri, 2016-10-28 at 09:45 -0600, Jens Axboe wrote:
>> On 10/27/2016 04:37 PM, Bart Van Assche wrote:
>>> On 10/26/2016 10:45 PM, Hannes Reinecke wrote:
>>>> On 10/26/2016 10:21 PM, Bart Van Assche wrote:
>>>>> Some time ago I created the attached state diagrams for myself
>>>>> to avoid
>>>>> that I would have to reread the entire block layer core source
>>>>> code if
>>>>> it has been a while since I had a look at it. Do you think it
>>>>> would be
>>>>> useful to add these diagrams somewhere in the Documentation
>>>>> directory?
>>>>>
>>>>
>>>> Can you add a step for the mapping between software and
>>>> hardware queues?
>>>> Also the actual submission to the LLDD (in step 'executing')
>>>> could do
>>>> with a bit more emphasis.
>>>> And maybe the fontsize could be a tad smaller; currently it's
>>>> hard to
>>>> figure out which label goes where, expecially in the bottom half.
>>>
>>> Thanks Hannes for the review. How about the attached second version
>>> of
>>> these diagrams?
>>
>> I think they are a little confusing. Some of it is specific to non-fs
>> requests, yet you have the plugging path in there as well. Was the
>> intent to just show the PC path?
>
> Hello Jens,
>
> As far as I know there is no documentation yet in the kernel tree
> (other than the block layer source code) of how the different block
> layer functions affect the request state. Several kernel developers
> seem not to be aware of when it is allowed to call which block layer
> function. See e.g. "Re: [PATCH v2 1/2] scsi: Handle Unit Attention when
> issuing SCSI command" (http://www.spinics.net/lists/linux-scsi/msg10073
> 7.html) for an example. These diagrams make e.g. clear when it is
> allowed to call blk_start_request() and when that it is not allowed.

Don't get me wrong, I think it would be great to have some graphic
documentation of the flow. But I think it should be clear about what it
is showing, not just some of it. Otherwise it'll just cause people to
get confused.

-- 
Jens Axboe
