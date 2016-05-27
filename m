Return-Path: <m@bjorling.me>
Return-Path: <m@bjorling.me>
Subject: Re: gendisk and lightnvm
To: Dan Williams <dan.j.williams@gmail.com>
References: <5742B023.2040503@bjorling.me>
 <CAA9_cmfVKoEw1XpJJ4j4+QHWB29-cRvdDp1hmtyegxSpBy0fNw@mail.gmail.com>
 <57473C2D.2060700@bjorling.me>
 <CAA9_cmeVeQzL7kJS1s--N9r-9Pap=KWz42Pmwd1r_4Bd03cL0g@mail.gmail.com>
 <57476FC1.6020702@bjorling.me>
 <CAA9_cmczkSBgLj5BwjVRVAq5b3SYGHbNSyu2qO1_TRguYRQ1pg@mail.gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
 Keith Busch <keith.busch@intel.com>, Simon Lund <slund@cnexlabs.com>,
 linux-block@vger.kernel.org
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>
Message-ID: <57488327.8080104@bjorling.me>
Date: Fri, 27 May 2016 19:25:59 +0200
MIME-Version: 1.0
In-Reply-To: <CAA9_cmczkSBgLj5BwjVRVAq5b3SYGHbNSyu2qO1_TRguYRQ1pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 05/27/2016 12:06 AM, Dan Williams wrote:
> On Thu, May 26, 2016 at 2:50 PM, Matias Bjørling <m@bjorling.me> wrote:
>> On 05/26/2016 09:05 PM, Dan Williams wrote:
> [..]
>> In that case, the holder kobject is maintained by the request queue. That
>> moves the block device naming earlier in the initialization process, and the
>> request queue would properly need to hold the (struct gendisk)->diskname. I
>> wonder if there is a better way.
>
> I don't see why it is necessary to move the block device naming
> earlier.  The block device kobject can link to the mq/ kobject created
> by lightnvm rather than include it as a child of the gendisk.
>

You're right. I'll cook up some RFC patches with the changes. Thanks.
