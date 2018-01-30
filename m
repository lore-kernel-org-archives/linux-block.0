Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:53059 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752388AbeA3PYn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jan 2018 10:24:43 -0500
Subject: Re: [PATCH] Use bio_endio instead of bio_put in error path of
 blk_rq_append_bio
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20171218074044.1369-3-ming.lei@redhat.com>
 <87o9lcp1aq.fsf@debian.i-did-not-set--mail-host-address--so-tickle-me>
 <CACVXFVMoXR9pobeCK9j-8ZL0VJB6xC7J6EYCN5YZarcVccPuvQ@mail.gmail.com>
From: Jiri Palecek <jpalecek@web.de>
Message-ID: <2c6a3916-57b8-20cb-f081-bb1b907a1a8a@web.de>
Date: Tue, 30 Jan 2018 16:24:14 +0100
MIME-Version: 1.0
In-Reply-To: <CACVXFVMoXR9pobeCK9j-8ZL0VJB6xC7J6EYCN5YZarcVccPuvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


On 1/30/18 1:53 PM, Ming Lei wrote:
> On Thu, Jan 25, 2018 at 9:58 PM, Jiří Paleček <jpalecek@web.de> wrote:
>>   Avoids page leak from bounced requests
>> ---
>>   block/blk-map.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/blk-map.c b/block/blk-map.c
>> index d3a94719f03f..702d68166689 100644
>> --- a/block/blk-map.c
>> +++ b/block/blk-map.c
>> @@ -26,7 +26,8 @@ int blk_rq_append_bio(struct request *rq, struct bio **bio)
>>          } else {
>>                  if (!ll_back_merge_fn(rq->q, rq, *bio)) {
>>                          if (orig_bio != *bio) {
>> -                               bio_put(*bio);
>> +                               bio_inc_remaining(orig_bio);
>> +                               bio_endio(*bio);
> 'bio_inc_remaining(orig_bio);' shouldn't be needed since we don't chain bounced
> bio, otherwise this patch is fine.

I believe it is needed or at least desirable. The situation when the 
request bounced is like this

bio (bounced) . bi_private ---> orig_bio

and at the end of bounce_end_io, bio_endio(bio->bi_private) [which is 
bio_endio(orig_bio) in our case] is called. That doesn't have any effect 
on __blk_rq_map_user_iov; its bios have .bi_end_io==0, therefore one 
call more or less doesn't matter. However, for other callers, like 
osd_initiator.c, this is not the case. They pass bios which have 
bi_end_io, and might be surprised if this was called unexpectedly.

Before  caa4b02476e3, blk_rq_append_request wouldn't touch/delete the 
passed bio at all under any circumstances. I believe it should stay that 
way and incrementing the remaining counter, which effectively nullifies 
the extra bio_endio call, does that pretty straightforwardly.

Regards

     Jiri Palecek
