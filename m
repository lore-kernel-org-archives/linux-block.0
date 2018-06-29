Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Make __bio_clone_fast() copy bi_vcnt
To: Kent Overstreet <kent.overstreet@gmail.com>,
 Ming Lei <tom.leiming@gmail.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>, Ming Lei <ming.lei@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
 Hannes Reinecke <hare@suse.com>, Johannes Thumshirn <jthumshirn@suse.de>
References: <20180627201231.15641-1-bart.vanassche@wdc.com>
 <20180627235005.GE7583@ming.t460p>
 <4995fc0c-e9d7-d747-7331-67396827a596@wdc.com>
 <20180628003007.GG7583@ming.t460p>
 <5e78949d-6169-5a5a-869b-731a3468e2de@wdc.com>
 <CACVXFVNzb9j_KwJLor4O=T_fgRRR12KOkZ2DXtniYp=u3Ru3bg@mail.gmail.com>
 <20180628231616.GA31305@kmo-pixel>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0bcf8a32-6c10-9b9e-a1de-738f49b4de4d@kernel.dk>
Date: Thu, 28 Jun 2018 20:18:27 -0600
MIME-Version: 1.0
In-Reply-To: <20180628231616.GA31305@kmo-pixel>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/28/18 5:16 PM, Kent Overstreet wrote:
> On Fri, Jun 29, 2018 at 07:10:47AM +0800, Ming Lei wrote:
>> On Thu, Jun 28, 2018 at 11:21 PM, Bart Van Assche
>> <bart.vanassche@wdc.com> wrote:
>>> On 06/27/18 17:30, Ming Lei wrote:
>>>>
>>>> One core idea of immutable bvec is to use bio->bi_iter and the original
>>>> bvec table to iterate over anywhere in the bio. That is why .bi_io_vec
>>>> needs to copy, but not see any reason why .bi_vcnt needs to do.
>>>>
>>>> Do you have use cases on .bi_vcnt for cloned bio?
>>>
>>>
>>> So far this is only a theoretical concern. There are many functions in the
>>> block layer that use .bi_vcnt, and it is a lot of work to figure out all the
>>> callers of all these functions.
> 
> Back when I implemented immutable biovecs I thoroughly audited all the bi_vcnt
> uses and removed all of them that weren't by the code that owns/submits the bio.
> 
> Grepping around I see one or two suspicious uses.. blk-merge.c in particular
> 
>> No, any functions using .bi_vcnt on a cloned-bio may be a bug, and we should
>> take a close look.
> 
> not just cloned bios, any code using bi_vcnt on a bio it didn't create is wrong.
> 
> so big nack to this patch (I wasn't ccd on it though and it doesn't seem to have
> hit lkml, so I can't find the original patch...)

Yeah, you are both right, I was smoking crack.

-- 
Jens Axboe
