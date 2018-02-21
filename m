Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:38753 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753851AbeBUQUH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Feb 2018 11:20:07 -0500
Received: by mail-wr0-f174.google.com with SMTP id n7so6098100wrn.5
        for <linux-block@vger.kernel.org>; Wed, 21 Feb 2018 08:20:07 -0800 (PST)
Subject: Re: [PATCH] Use bio_endio instead of bio_put in error path of
 blk_rq_append_bio
To: Jiri Palecek <jpalecek@web.de>, Ming Lei <ming.lei@redhat.com>
References: <20171218074044.1369-3-ming.lei@redhat.com>
 <87o9lcp1aq.fsf@debian.i-did-not-set--mail-host-address--so-tickle-me>
 <CACVXFVMoXR9pobeCK9j-8ZL0VJB6xC7J6EYCN5YZarcVccPuvQ@mail.gmail.com>
 <2c6a3916-57b8-20cb-f081-bb1b907a1a8a@web.de>
 <20180131052448.GB9985@ming.t460p>
 <87h8qbptzz.fsf@debian.i-did-not-set--mail-host-address--so-tickle-me>
Cc: Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>
From: Boaz Harrosh <ooo@electrozaur.com>
Message-ID: <8be6c1f5-0359-8de4-22b3-d5e779ae7c12@electrozaur.com>
Date: Wed, 21 Feb 2018 18:20:03 +0200
MIME-Version: 1.0
In-Reply-To: <87h8qbptzz.fsf@debian.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 20/02/18 17:21, Jiri Palecek wrote:
> Hello,
> 
> I had a look at the callers of blk_rq_append_bio and checked the
> callers. Some changes may need to be done there and I'd like the input
> of their maintainers as well before finalising the patch.
> 
> Ming Lei <ming.lei@redhat.com> writes:
> 
>> On Tue, Jan 30, 2018 at 04:24:14PM +0100, Jiri Palecek wrote:
>>>
>>> On 1/30/18 1:53 PM, Ming Lei wrote:
>>>> On Thu, Jan 25, 2018 at 9:58 PM, Jiří Paleček <jpalecek@web.de> wrote:
>>>>>   Avoids page leak from bounced requests
>>>>> ---
>>>>>   block/blk-map.c | 3 ++-
>>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/block/blk-map.c b/block/blk-map.c
>>>>> index d3a94719f03f..702d68166689 100644
>>>>> --- a/block/blk-map.c
>>>>> +++ b/block/blk-map.c
>>>>> @@ -26,7 +26,8 @@ int blk_rq_append_bio(struct request *rq, struct bio **bio)
>>>>>          } else {
>>>>>                  if (!ll_back_merge_fn(rq->q, rq, *bio)) {
>>>>>                          if (orig_bio != *bio) {
>>>>> -                               bio_put(*bio);
>>>>> +                               bio_inc_remaining(orig_bio);
>>>>> +                               bio_endio(*bio);
>>>> 'bio_inc_remaining(orig_bio);' shouldn't be needed since we don't chain bounced
>>>> bio, otherwise this patch is fine.
>>>
>>> I believe it is needed or at least desirable. The situation when the request
>>> bounced is like this
>>>
>>> bio (bounced) . bi_private ---> orig_bio
>>>
>>> and at the end of bounce_end_io, bio_endio(bio->bi_private) [which is
>>> bio_endio(orig_bio) in our case] is called. That doesn't have any effect on
>>> __blk_rq_map_user_iov; its bios have .bi_end_io==0, therefore one call more
>>> or less doesn't matter. However, for other callers, like osd_initiator.c,
>>> this is not the case. They pass bios which have bi_end_io, and might be
>>> surprised if this was called unexpectedly.
>>
>> OK, I think it is good to follow the rule of not calling .bi_end_io() in
>> the failure path, just like __blk_rq_map_user_iov()/blk_rq_map_kern().
>>
>> But seems pscsi_map_sg() depends on bio_endio(orig_bio) to free the 'orig_bio',
>> could you fix it in this patch too?
> 
> I've come up with the following patch. Some notes:
> 
> 1) First of all, I think your suggestion to call bio_endio of the
>    original bio in blk_rq_append_bio is right. It would make things a
>    bit easier for the callers and those who I suspected need to hold on
>    the bio are actually just ignorant about errors. However, it does
>    change the api. So if you agree and the other parts are OK too, I'd
>    make a patch without the bio_inc_remaining.
> 
> 2) The osd_initiator.c seems to be a bit oblivious about errors, leaking
>    not only the bios, but the request as well. I added some functions
>    for proper cleanup there, with considerations:
>    
>    - I think it's better to unhook the .bi_next link of the bio before
>      adding it to the request, because blk_rq_append_bio uses that for
>      its own purposes.
> 
>    - Once the bios from osd_request have been spent (added to a
>      blk_request), they can be NULL-ified.
> 

I have not followed closely the issue but ...

No! the osd_initiator.c is completely out of scope. And does not leak any bios
and need not to be fixed. let me explain.

These are BIDI commands that travel as a couple of chained requests. They are
sent as BLOCK_PC command and complete or fail as one hole unit. The system is not
allowed (And does not know how) to split them or complete them partially. This is
not an FS read or write request of data. But a unique OSD request that the system
knows nothing about. The all scsi-command is specially crafted by the caller.
It is all properly destroyed at osd_request end of life (sync or async)
(NOTE there is no bio-end function only req-end)

again not followed closely but if it is about the free of the bounce buffers
then I would just disable bouncing for osd all together. There are only a very
few (2) drivers that support bidi for osd. iscsi and iser so we know those are
totally cool and this is all not an existing problem.

Thanks
Boaz

>    I'd like hear if these are OK.
> 
> 3) PSCSI needs to free the bios in pscsi_map_sg, but also needs to clear
>    the bios from the request in pscsi_execute_cmd in case of partial
>    errors (ie. first sg segment makes it to the request, second
>    fails). To my understanding, blk_put_request is insufficient in that
>    case.
> 
> Regards
>     Jiri Palecek
> 
