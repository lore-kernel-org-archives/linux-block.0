Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:36613 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752377AbeBTPWV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Feb 2018 10:22:21 -0500
From: Jiri Palecek <jpalecek@web.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jiri Palecek <jpalecek@web.de>, Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        Boaz Harrosh <ooo@electrozaur.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH] Use bio_endio instead of bio_put in error path of blk_rq_append_bio
In-Reply-To: <20180131052448.GB9985@ming.t460p> (Ming Lei's message of "Wed,
        31 Jan 2018 13:24:58 +0800")
References: <20171218074044.1369-3-ming.lei@redhat.com>
        <87o9lcp1aq.fsf@debian.i-did-not-set--mail-host-address--so-tickle-me>
        <CACVXFVMoXR9pobeCK9j-8ZL0VJB6xC7J6EYCN5YZarcVccPuvQ@mail.gmail.com>
        <2c6a3916-57b8-20cb-f081-bb1b907a1a8a@web.de>
        <20180131052448.GB9985@ming.t460p>
Date: Tue, 20 Feb 2018 16:21:04 +0100
Message-ID: <87h8qbptzz.fsf@debian.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable

Hello,

I had a look at the callers of blk_rq_append_bio and checked the
callers. Some changes may need to be done there and I'd like the input
of their maintainers as well before finalising the patch.

Ming Lei <ming.lei@redhat.com> writes:

> On Tue, Jan 30, 2018 at 04:24:14PM +0100, Jiri Palecek wrote:
>>=20
>> On 1/30/18 1:53 PM, Ming Lei wrote:
>> > On Thu, Jan 25, 2018 at 9:58 PM, Ji=F8=ED Pale=E8ek <jpalecek@web.de> =
wrote:
>> > >   Avoids page leak from bounced requests
>> > > ---
>> > >   block/blk-map.c | 3 ++-
>> > >   1 file changed, 2 insertions(+), 1 deletion(-)
>> > >=20
>> > > diff --git a/block/blk-map.c b/block/blk-map.c
>> > > index d3a94719f03f..702d68166689 100644
>> > > --- a/block/blk-map.c
>> > > +++ b/block/blk-map.c
>> > > @@ -26,7 +26,8 @@ int blk_rq_append_bio(struct request *rq, struct b=
io **bio)
>> > >          } else {
>> > >                  if (!ll_back_merge_fn(rq->q, rq, *bio)) {
>> > >                          if (orig_bio !=3D *bio) {
>> > > -                               bio_put(*bio);
>> > > +                               bio_inc_remaining(orig_bio);
>> > > +                               bio_endio(*bio);
>> > 'bio_inc_remaining(orig_bio);' shouldn't be needed since we don't chai=
n bounced
>> > bio, otherwise this patch is fine.
>>=20
>> I believe it is needed or at least desirable. The situation when the req=
uest
>> bounced is like this
>>=20
>> bio (bounced) . bi_private ---> orig_bio
>>=20
>> and at the end of bounce_end_io, bio_endio(bio->bi_private) [which is
>> bio_endio(orig_bio) in our case] is called. That doesn't have any effect=
 on
>> __blk_rq_map_user_iov; its bios have .bi_end_io=3D=3D0, therefore one ca=
ll more
>> or less doesn't matter. However, for other callers, like osd_initiator.c,
>> this is not the case. They pass bios which have bi_end_io, and might be
>> surprised if this was called unexpectedly.
>
> OK, I think it is good to follow the rule of not calling .bi_end_io() in
> the failure path, just like __blk_rq_map_user_iov()/blk_rq_map_kern().
>
> But seems pscsi_map_sg() depends on bio_endio(orig_bio) to free the 'orig=
_bio',
> could you fix it in this patch too?

I've come up with the following patch. Some notes:

1) First of all, I think your suggestion to call bio_endio of the
   original bio in blk_rq_append_bio is right. It would make things a
   bit easier for the callers and those who I suspected need to hold on
   the bio are actually just ignorant about errors. However, it does
   change the api. So if you agree and the other parts are OK too, I'd
   make a patch without the bio_inc_remaining.

2) The osd_initiator.c seems to be a bit oblivious about errors, leaking
   not only the bios, but the request as well. I added some functions
   for proper cleanup there, with considerations:
=20=20=20
   - I think it's better to unhook the .bi_next link of the bio before
     adding it to the request, because blk_rq_append_bio uses that for
     its own purposes.

   - Once the bios from osd_request have been spent (added to a
     blk_request), they can be NULL-ified.

   I'd like hear if these are OK.

3) PSCSI needs to free the bios in pscsi_map_sg, but also needs to clear
   the bios from the request in pscsi_execute_cmd in case of partial
   errors (ie. first sg segment makes it to the request, second
   fails). To my understanding, blk_put_request is insufficient in that
   case.

Regards
    Jiri Palecek


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=0002-Some-error-paths.patch

>From fca495c6bf41775be152e7f7f00be6f0dc746ac3 Mon Sep 17 00:00:00 2001
From: =?iso8859-2?q?Ji=F8=ED=20Pale=E8ek?= <jpalecek@web.de>
Date: Sun, 4 Feb 2018 21:55:56 +0100
Subject: [PATCH 2/2] Some error paths

---
 block/blk-map.c                    |  4 +++-
 drivers/scsi/osd/osd_initiator.c   | 29 +++++++++++++++++++++++++----
 drivers/target/target_core_pscsi.c |  4 +++-
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 702d68166689..8378f4ddd419 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -246,7 +246,7 @@ int blk_rq_map_kern(struct request_queue *q, struct request *rq, void *kbuf,
 	ret = blk_rq_append_bio(rq, &bio);
 	if (unlikely(ret)) {
 		/* request is too big */
-		bio_put(orig_bio);
+		bio_endio(orig_bio);
 		return ret;
 	}
 
diff --git a/drivers/scsi/osd/osd_initiator.c b/drivers/scsi/osd/osd_initiator.c
index e18877177f1b..f352fdda52b9 100644
--- a/drivers/scsi/osd/osd_initiator.c
+++ b/drivers/scsi/osd/osd_initiator.c
@@ -437,6 +437,16 @@ static void _osd_free_seg(struct osd_request *or __unused,
 	seg->alloc_size = 0;
 }
 
+static void _osd_end_bios(struct bio *bio)
+{
+	struct bio *nxt = NULL;
+	while (bio) {
+		nxt = bio->bi_next;
+		bio_endio(bio);
+		bio = nxt;
+	}
+}
+
 static void _put_request(struct request *rq)
 {
 	/*
@@ -469,6 +479,10 @@ void osd_end_request(struct osd_request *or)
 	_osd_free_seg(or, &or->set_attr);
 	_osd_free_seg(or, &or->cdb_cont);
 
+	/* Only in case of errors should these be non-NULL */
+	_osd_end_bios(or->in.bio);
+	_osd_end_bios(or->out.bio);
+
 	_osd_request_free(or);
 }
 EXPORT_SYMBOL(osd_end_request);
@@ -1575,13 +1589,20 @@ static struct request *_make_request(struct request_queue *q, bool has_write,
 	if (IS_ERR(req))
 		return req;
 
-	for_each_bio(bio) {
-		struct bio *bounce_bio = bio;
+	while(bio) {
+		struct bio *nxt = bio->bi_next;
+		bio->bi_next = NULL;
 
-		ret = blk_rq_append_bio(req, &bounce_bio);
-		if (ret)
+		ret = blk_rq_append_bio(req, &bio);
+		if (ret) {
+			_put_request(req);
+			bio_endio(bio);
+			oii->bio = nxt;
 			return ERR_PTR(ret);
+		}
+		bio = nxt;
 	}
+	oii->bio = NULL;
 
 	return req;
 }
diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index 0d99b242e82e..42c24356d683 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -922,6 +922,7 @@ pscsi_map_sg(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 
 				rc = blk_rq_append_bio(req, &bio);
 				if (rc) {
+					bio_put(bio);
 					pr_err("pSCSI: failed to append bio\n");
 					goto fail;
 				}
@@ -940,6 +941,7 @@ pscsi_map_sg(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 	if (bio) {
 		rc = blk_rq_append_bio(req, &bio);
 		if (rc) {
+			bio_put(bio);
 			pr_err("pSCSI: failed to append bio\n");
 			goto fail;
 		}
@@ -1016,7 +1018,7 @@ pscsi_execute_cmd(struct se_cmd *cmd)
 	return 0;
 
 fail_put_request:
-	blk_put_request(req);
+	blk_end_request_all(req, BLK_STS_IOERR);
 fail:
 	kfree(pt);
 	return ret;
-- 
2.15.1


--=-=-=--
