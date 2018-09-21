Return-Path: <axboe@kernel.dk>
Subject: Re: block: DMA alignment of IO buffer allocated from slab
To: Christoph Hellwig <hch@lst.de>, Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Ming Lei <tom.leiming@gmail.com>,
 linux-block <linux-block@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 "open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
 Dave Chinner <dchinner@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ming Lei <ming.lei@redhat.com>, Christoph Lameter <cl@linux.com>
References: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com>
 <20180920063129.GB12913@lst.de> <87h8ij0zot.fsf@vitty.brq.redhat.com>
 <20180921130504.GA22551@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <98996e39-7d29-354c-9009-d4b1a1bbdeb0@kernel.dk>
Date: Fri, 21 Sep 2018 09:00:31 -0600
MIME-Version: 1.0
In-Reply-To: <20180921130504.GA22551@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/21/18 7:05 AM, Christoph Hellwig wrote:
> On Fri, Sep 21, 2018 at 03:04:18PM +0200, Vitaly Kuznetsov wrote:
>> Christoph Hellwig <hch@lst.de> writes:
>>
>>> On Wed, Sep 19, 2018 at 05:15:43PM +0800, Ming Lei wrote:
>>>> 1) does kmalloc-N slab guarantee to return N-byte aligned buffer?  If
>>>> yes, is it a stable rule?
>>>
>>> This is the assumption in a lot of the kernel, so I think if somethings
>>> breaks this we are in a lot of pain.
>>
>> It seems that SLUB debug breaks this assumption. Kernel built with
>>
>> CONFIG_SLUB_DEBUG=y
>> CONFIG_SLUB=y
>> CONFIG_SLUB_DEBUG_ON=y
> 
> Looks like we should fix SLUB debug then..

Fully agree, it's such a fundamental property.

-- 
Jens Axboe
