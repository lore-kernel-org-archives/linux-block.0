Return-Path: <axboe@kernel.dk>
Subject: Re: fix loop discard regression
To: Christoph Hellwig <hch@lst.de>, Ross Zwisler <zwisler@gmail.com>
References: <1470319801-20594-1-git-send-email-hch@lst.de>
 <CAOxpaSXxmO8sB1D_03yu9H1CLeF+5iUWtRE7WLqddkqgSrCd_g@mail.gmail.com>
 <20160805073956.GA24229@lst.de>
Cc: ming.lei@canonical.com, Mike Christie <mchristi@redhat.com>,
 Dave Chinner <david@fromorbit.com>, linux-block@vger.kernel.org,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a8f487c5-e8c3-0288-0acc-1fc780061b43@kernel.dk>
Date: Fri, 5 Aug 2016 07:51:36 -0600
MIME-Version: 1.0
In-Reply-To: <20160805073956.GA24229@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 08/05/2016 01:39 AM, Christoph Hellwig wrote:
> On Thu, Aug 04, 2016 at 12:55:26PM -0600, Ross Zwisler wrote:
>> On Thu, Aug 4, 2016 at 8:09 AM, Christoph Hellwig <hch@lst.de> wrote:
>>> The first patch fixes a regression where discard request were accidentally
>>> marked as aio after the req_op conversion.  This would have been mostly
>>> harmless except for the god-awful parsing of request types later in the
>>> actual I/O handler which turns them into a write, so the second patch
>>> rewrites that handler using a proper switch statement as well.
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-block" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> Tested-by: Ross Zwisler <ross.zwisler@linux.intel.com>
>>
>> Also, your 2nd patch is missing a signed-off-by.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> in case that Jens wants to bother with force-updating the tree.

Not really, was hoping to flush it out today. Don't see it as a huge
problem...


-- 
Jens Axboe
