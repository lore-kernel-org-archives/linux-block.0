Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:52066 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934005AbeB1Rii (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Feb 2018 12:38:38 -0500
Received: by mail-wm0-f53.google.com with SMTP id h21so6595054wmd.1
        for <linux-block@vger.kernel.org>; Wed, 28 Feb 2018 09:38:37 -0800 (PST)
Subject: Re: [PATCH] Use bio_endio instead of bio_put in error path of
 blk_rq_append_bio
To: Jiri Palecek <jpalecek@web.de>, Ming Lei <ming.lei@redhat.com>
References: <20171218074044.1369-3-ming.lei@redhat.com>
 <87o9lcp1aq.fsf@debian.i-did-not-set--mail-host-address--so-tickle-me>
 <CACVXFVMoXR9pobeCK9j-8ZL0VJB6xC7J6EYCN5YZarcVccPuvQ@mail.gmail.com>
 <2c6a3916-57b8-20cb-f081-bb1b907a1a8a@web.de>
 <20180131052448.GB9985@ming.t460p>
 <87h8qbptzz.fsf@debian.i-did-not-set--mail-host-address--so-tickle-me>
 <8be6c1f5-0359-8de4-22b3-d5e779ae7c12@electrozaur.com>
 <058e8999-3f89-ae20-ee38-229c78d6d1c8@web.de>
Cc: Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>
From: Boaz Harrosh <ooo@electrozaur.com>
Message-ID: <24729d65-c531-dcc5-3eca-900d65961092@electrozaur.com>
Date: Wed, 28 Feb 2018 19:38:34 +0200
MIME-Version: 1.0
In-Reply-To: <058e8999-3f89-ae20-ee38-229c78d6d1c8@web.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 27/02/18 16:44, Jiri Palecek wrote:
<>
>> These are BIDI commands that travel as a couple of chained requests. They are
>> sent as BLOCK_PC command and complete or fail as one hole unit. The system is not
>> allowed (And does not know how) to split them or complete them partially. This is
>> not an FS read or write request of data. But a unique OSD request that the system
>> knows nothing about. The all scsi-command is specially crafted by the caller.
>> It is all properly destroyed at osd_request end of life (sync or async)
>> (NOTE there is no bio-end function only req-end)
> 
> That's correct, however, the assumed leak would happen when the
> preparation of the request fails.
> 
> The whole issue started with possible bounce buffer leaks in
> blk_rq_append_request, which didn't happen before it started to
> handle bouncing. However, Ming Lei noticed it would be simpler and
> easier to also free the original bio, as opposed to just the bounce
> buffer, on error. Because that wasn't so previously, the question now
> stands, what do the callers likely expect?
> 

Sigh! That bouncing thing. It is so not relevant for osd. I wish we could
just drop the bouncing and return an error, if it was ever needed
(because it never is for osd)

> This leads us to osd_initiator.c, which IMHO doesn't expect anything
> and simply lacks any sane handling of such possibility. If you say
> there can't be any leaks, please explain to me this riddle. Given the
> code:
> 
> static struct request *_make_request(struct request_queue *q, bool has_write,
>                   struct _osd_io_info *oii, gfp_t flags)
> {
>     struct request *req;
>     struct bio *bio = oii->bio;
>     int ret;
> 
>     req = blk_get_request(q, has_write ? REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN,
>             flags); /** 1 **/
>     if (IS_ERR(req))
>         return req;
> 
>     for_each_bio(bio) {
>         struct bio *bounce_bio = bio;
> 
>         ret = blk_rq_append_bio(req, &bounce_bio);

[Sorry still did not see the all code]
What is the meaning of the pointer-to-pointer-to-bio here? it used to
be relevant to blk_queue_bounce, that I guess you internalized into
blk_rq_append_bio() but why do we need it outside the call now?

>         if (ret)
>             return ERR_PTR(ret); /** 2 **/
>     }
> 
>     return req;
> }
> 
> 1. If this function exits by line labeled "2", where is struct
>    request *req allocated on line 1 freed?

You are probably right, if you want to fix it? This used to never fail because
blk_queue_bounce() retuning void. And blk_rq_append_bio could only fail if
ll_back_merge_fn would fail, but for OSD supporting drivers this would never fail.
And also those checks were already preformed before (when more segments were added).

So in practice this could never fail and never showed in testing. But I agree
this is a layering violation and the code is wrong.

> 2. If this function exits by line 2, where are the bio(s) in oii->bio
>    freed? What if it fails on the second bio?
> 
> I assume osd_end_request would be called afterwards (as in exofs_read_kern).
> 

This code always scared me to bits because if you look closely it does nothing
It does not actually builds the chain it relays on bio->bi_next not being modified
and so we loop on doing nothing (resting the bio->bi_next to the same thing it was before)

So yes oii->bio(s) are freed in osd_end_request and/or by callers because the bios
might have one more ref on them, because they might be needed by caller
to finish up.

> Regards
>    Jiri Palecek
> 

Thank you for looking into this, sorry for the headache this code gives you.
If there was a way to just fail if bounce is needed that could be just fine
for osd. But else I guess that error exit needs fixing.

Based on v4.15 code feel free to add to your patchset
where needed

----
Don't leak the request if blk_rq_append_bio fails

Sign-of-by: Boaz Harrosh <ooo@electrozaur.com>
----
diff --git a/drivers/scsi/osd/osd_initiator.c b/drivers/scsi/osd/osd_initiator.c
index 2f2a991..3c97e0e 100644
--- a/drivers/scsi/osd/osd_initiator.c
+++ b/drivers/scsi/osd/osd_initiator.c
@@ -1572,8 +1572,10 @@ static struct request *_make_request(struct request_queue *q, bool has_write,
 
 		blk_queue_bounce(req->q, &bounce_bio);
 		ret = blk_rq_append_bio(req, bounce_bio);
-		if (ret)
+		if (ret) {
+			_put_request(req);
 			return ERR_PTR(ret);
+		}
 	}
 
 	return req;
