Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:65335 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751980AbeAaWPv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jan 2018 17:15:51 -0500
Subject: Re: [PATCH] Use bio_endio instead of bio_put in error path of
 blk_rq_append_bio
To: Ming Lei <ming.lei@redhat.com>
Cc: Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20171218074044.1369-3-ming.lei@redhat.com>
 <87o9lcp1aq.fsf@debian.i-did-not-set--mail-host-address--so-tickle-me>
 <CACVXFVMoXR9pobeCK9j-8ZL0VJB6xC7J6EYCN5YZarcVccPuvQ@mail.gmail.com>
 <2c6a3916-57b8-20cb-f081-bb1b907a1a8a@web.de>
 <20180131052448.GB9985@ming.t460p>
From: Jiri Palecek <jpalecek@web.de>
Message-ID: <45e27f3b-a9b2-e196-619a-30ec2ef7a4c6@web.de>
Date: Wed, 31 Jan 2018 23:15:18 +0100
MIME-Version: 1.0
In-Reply-To: <20180131052448.GB9985@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


On 1/31/18 6:24 AM, Ming Lei wrote:
> On Tue, Jan 30, 2018 at 04:24:14PM +0100, Jiri Palecek wrote:
>> On 1/30/18 1:53 PM, Ming Lei wrote:
>>> On Thu, Jan 25, 2018 at 9:58 PM, Jiří Paleček <jpalecek@web.de> wrote:
>>>>    Avoids page leak from bounced requests
>>>> ---
>>>>    block/blk-map.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/block/blk-map.c b/block/blk-map.c
>>>> index d3a94719f03f..702d68166689 100644
>>>> --- a/block/blk-map.c
>>>> +++ b/block/blk-map.c
>>>> @@ -26,7 +26,8 @@ int blk_rq_append_bio(struct request *rq, struct bio **bio)
>>>>           } else {
>>>>                   if (!ll_back_merge_fn(rq->q, rq, *bio)) {
>>>>                           if (orig_bio != *bio) {
>>>> -                               bio_put(*bio);
>>>> +                               bio_inc_remaining(orig_bio);
>>>> +                               bio_endio(*bio);
>>> 'bio_inc_remaining(orig_bio);' shouldn't be needed since we don't chain bounced
>>> bio, otherwise this patch is fine.
>> I believe it is needed or at least desirable. The situation when the request
>> bounced is like this
>>
>> bio (bounced) . bi_private ---> orig_bio
>>
>> and at the end of bounce_end_io, bio_endio(bio->bi_private) [which is
>> bio_endio(orig_bio) in our case] is called. That doesn't have any effect on
>> __blk_rq_map_user_iov; its bios have .bi_end_io==0, therefore one call more
>> or less doesn't matter. However, for other callers, like osd_initiator.c,
>> this is not the case. They pass bios which have bi_end_io, and might be
>> surprised if this was called unexpectedly.
> OK, I think it is good to follow the rule of not calling .bi_end_io() in
> the failure path, just like __blk_rq_map_user_iov()/blk_rq_map_kern().
>
> But seems pscsi_map_sg() depends on bio_endio(orig_bio) to free the 'orig_bio',
> could you fix it in this patch too?
Yes, there seems to be leak in the error path of that code. However, 
that was there for more than a year so I didn't think that was urgent. 
I'll have a look at it, but I would prefer if someone familiar with 
pscsi had their say as well.
>
>> Before  caa4b02476e3, blk_rq_append_request wouldn't touch/delete the passed
>> bio at all under any circumstances. I believe it should stay that way and
>> incrementing the remaining counter, which effectively nullifies the extra
>> bio_endio call, does that pretty straightforwardly.
> Seems too tricky to use bio_inc_remaining() for avoiding bio_endio(orig_bio),
> if we have to do that, I suggest to add comment on that.

Okay. I thought that it didn't really reach the level of sophistication 
otherwise seen in block layer code :)

Regards

     Jiri Palecek
