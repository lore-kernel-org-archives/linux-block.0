Return-Path: <julien.grall@arm.com>
Subject: Re: [Xen-devel] [PATCH] drivers/block/xen-blkback/common.h: use
 DIV_ROUND_UP instead of reimplementing its function
To: =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc: Jan Beulich <JBeulich@suse.com>, Jens Axboe <axboe@kernel.dk>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 xen-devel <xen-devel@lists.xenproject.org>,
 zhong jiang <zhongjiang@huawei.com>
References: <1536731100-56054-1-git-send-email-zhongjiang@huawei.com>
 <5B98CAE202000078001E79CC@prv1-mh.provo.novell.com>
 <20180912091350.6wuvt2jkvzg6wruo@mac.bytemobile.com>
 <20180912091639.oynlvdo6pghnqfvt@mac.bytemobile.com>
 <364bad2c-708e-6406-7b52-7bfef9d5dbe1@arm.com>
 <20180912102908.4ls7vts55n2zfkdz@mac.bytemobile.com>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <58794c01-16f4-b124-46fe-cdcb386235de@arm.com>
Date: Mon, 24 Sep 2018 14:28:26 +0100
MIME-Version: 1.0
In-Reply-To: <20180912102908.4ls7vts55n2zfkdz@mac.bytemobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Hi Roger,

On 09/12/2018 11:29 AM, Roger Pau Monné wrote:
> On Wed, Sep 12, 2018 at 10:48:42AM +0100, Julien Grall wrote:
>> Hi,
>>
>> On 09/12/2018 10:16 AM, Roger Pau Monné wrote:
>>> On Wed, Sep 12, 2018 at 11:13:50AM +0200, Roger Pau Monné wrote:
>>>> Adding Julien how did the work to support XEN_PAGE_SIZE != PAGE_SIZE.
>>>>
>>>> On Wed, Sep 12, 2018 at 02:14:26AM -0600, Jan Beulich wrote:
>>>>>>>> On 12.09.18 at 07:45, <zhongjiang@huawei.com> wrote:
>>>>>> --- a/drivers/block/xen-blkback/common.h
>>>>>> +++ b/drivers/block/xen-blkback/common.h
>>>>>> @@ -65,7 +65,7 @@
>>>>>>    	(XEN_PAGES_PER_INDIRECT_FRAME / XEN_PAGES_PER_SEGMENT)
>>>>>>    #define MAX_INDIRECT_PAGES \
>>>>>> -	((MAX_INDIRECT_SEGMENTS + SEGS_PER_INDIRECT_FRAME - 1)/SEGS_PER_INDIRECT_FRAME)
>>>>>> +		DIV_ROUND_UP(MAX_INDIRECT_SEGMENTS, SEGS_PER_INDIRECT_FRAME)
>>>>>>    #define INDIRECT_PAGES(_segs) DIV_ROUND_UP(_segs, XEN_PAGES_PER_INDIRECT_FRAME)
>>>>>
>>>>> My first reaction was to suggest
>>>>>
>>>>> #define MAX_INDIRECT_PAGES INDIRECT_PAGES(MAX_INDIRECT_SEGMENTS)
>>>>>
>>>>> but that wouldn't match what's there currently (note the two different
>>>>> divisors). I can't really decide whether that's just unfortunate naming
>>>>> of the two macros, or an actual bug.
>>>>
>>>> I think there's indeed a bug here.
>>>>
>>>> AFAICT, MAX_INDIRECT_PAGES should use XEN_PAGES_PER_INDIRECT_FRAME and
>>>> then it could be changed as Jan suggested.
>>
>> The problem is SEGS_PER_INDIRECT_FRAME has been miscalculated. So I think it
>> would be fine to use XEN_PAGES_PER_INDIRECT_FRAME in MAX_INDIRECT_PAGES.
>>
>> However the naming for XEN_PAGES_PER_INDIRECT_FRAME is misnamed. We return
>> number of a for segments per indirect frame. So I would rename to
>> SEGS_PER_INDIRECT_FRAME.
> 
> I don't think I agree with this last part, SEGS_PER_INDIRECT_FRAME
> would have to take into account XEN_PAGES_PER_SEGMENT, and
> XEN_PAGES_PER_INDIRECT_FRAME doesn't.
> 
> XEN_PAGES_PER_INDIRECT_FRAME currently returns the number of grant
> references per indirect page, but as I understand it a segment can use
> more than one grant reference, if for example the guest page size is
> 64KB.

I am a bit confused. By segment, do you refer to the backend or frontend 
segment?

In any case, it would be possible to remove SEGS_PER_INDIRECT_FRAME if 
we rework MAX_INDIRECT_PAGES(...). This should improve the readability 
as well.

Cheers,

-- 
Julien Grall
