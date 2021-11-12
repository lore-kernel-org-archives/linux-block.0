Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0452CC433EF
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 00:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7CF461284
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 00:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbhKLAr3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Nov 2021 19:47:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20418 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234575AbhKLAr2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Nov 2021 19:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636677878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sxoMk6uMkIWUKv0yby6wly/EbtvehH4fxSdzk4yEfBU=;
        b=LWylCy2xmkuFa159vAt0f1rdla6kIw5QQXuBK9P4D1KgMVNRm2XvE+jAqQOXw0XBaI4lLP
        X0BaeX0jPxIKsk9OoL6QM62wmKfvOm8skBO8KpJj3vFsySGo5vO+Y0FBod7oyzIA5IKZ9R
        ZUdE+hZoHI+H//BdMT26UAH7uBYObIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-mZ6QIG5OPfOY1VBtXqRpjg-1; Thu, 11 Nov 2021 19:44:35 -0500
X-MC-Unique: mZ6QIG5OPfOY1VBtXqRpjg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 496FA875047;
        Fri, 12 Nov 2021 00:44:34 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BD155DA60;
        Fri, 12 Nov 2021 00:44:30 +0000 (UTC)
Date:   Fri, 12 Nov 2021 08:44:25 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] block: move queue enter logic into
 blk_mq_submit_bio()
Message-ID: <YY246bCP+wKw0Z2c@T590>
References: <461c4758-2675-1d11-ac8a-6f25ef01d781@kernel.dk>
 <YYQr3jl3avsuOUAJ@infradead.org>
 <3d29a5ce-aace-6198-3ea9-e6f603e74aa1@kernel.dk>
 <YYQuyt2/y1MgzRi0@infradead.org>
 <87ee0091-9c2f-50e8-c8f2-dcebebb9de48@kernel.dk>
 <alpine.DEB.2.22.394.2111111350150.2780761@ramsan.of.borg>
 <YY0eVnbjmHmPZ3M4@T590>
 <CAMuHMdWTiF3MpcwHc=jCGLoBtTngzXTLHsYSYKPyfLBFBn8B2g@mail.gmail.com>
 <YY01hzAuvmeMxO+0@T590>
 <17ce59ff-bc8c-e8c8-22e1-96605440629a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17ce59ff-bc8c-e8c8-22e1-96605440629a@kernel.dk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 11, 2021 at 03:17:27PM -0700, Jens Axboe wrote:
> On 11/11/21 8:23 AM, Ming Lei wrote:
> > Hi Geert,
> > 
> > On Thu, Nov 11, 2021 at 03:51:28PM +0100, Geert Uytterhoeven wrote:
> >> Hi Ming,
> >>
> >> On Thu, Nov 11, 2021 at 2:45 PM Ming Lei <ming.lei@redhat.com> wrote:
> >>> On Thu, Nov 11, 2021 at 01:58:38PM +0100, Geert Uytterhoeven wrote:
> >>>> On Thu, 4 Nov 2021, Jens Axboe wrote:
> >>>>> On 11/4/21 1:04 PM, Christoph Hellwig wrote:
> >>>>>> On Thu, Nov 04, 2021 at 01:02:54PM -0600, Jens Axboe wrote:
> >>>>>>> On 11/4/21 12:52 PM, Christoph Hellwig wrote:
> >>>>>>>> Looks good:
> >>>>>>>>
> >>>>>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
> >>>>>>>
> >>>>>>> So these two are now:
> >>>>>>>
> >>>>>>> https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.16/block&id=c98cb5bbdab10d187aff9b4e386210eb2332af96
> >>>>>>>
> >>>>>>> which is the one I sent here, and then the next one gets cleaned up to
> >>>>>>> remove that queue enter helper:
> >>>>>>>
> >>>>>>> https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.16/block&id=7f930eb31eeb07f1b606b3316d8ad3ab6a92905b
> >>>>>>>
> >>>>>>> Can I add your reviewed-by to this last one as well? Only change is the
> >>>>>>> removal of blk_mq_enter_queue() and the weird construct there, it's just
> >>>>>>> bio_queue_enter() now.
> >>>>>>
> >>>>>> Sure.
> >>>>>
> >>>>> Thanks, prematurely already done, as you could tell :-)
> >>>>
> >>>> The updated version is now commit 900e080752025f00 ("block: move queue
> >>>> enter logic into blk_mq_submit_bio()") in Linus' tree.
> >>>>
> >>>> I have bisected failures on m68k/atari (on ARAnyM, using nfhd as the
> >>>> root device) to this commit, e.g.:
> >>>>
> >>>>     sd 0:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
> >>>>     sd 0:0:0:0: [sda] tag#0 Sense Key : Illegal Request [current]
> >>>>     sd 0:0:0:0: [sda] tag#0 Add. Sense: Invalid field in cdb
> >>>>     sd 0:0:0:0: [sda] tag#0 CDB: Write(10) 2a 08 00 00 00 01 00 00 08 00
> >>>>     critical target error, dev sda, sector 1 op 0x1:(WRITE) flags 0x20800 phys_seg 1 prio class 0
> >>>>     Buffer I/O error on dev sda1, logical block 0, lost sync page write
> >>>>
> >>>>     EXT4-fs (sda1): I/O error while writing superblock
> >>>>     sd 0:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
> >>>>     sd 0:0:0:0: [sda] tag#0 Sense Key : Illegal Request [current]
> >>>>     sd 0:0:0:0: [sda] tag#0 Add. Sense: Invalid field in cdb
> >>>>     sd 0:0:0:0: [sda] tag#0 CDB: Write(10) 2a 08 00 00 00 01 00 00 08 00
> >>>>     critical target error, dev sda, sector 1 op 0x1:(WRITE) flags 0x20800 phys_seg 1 prio class 0
> >>>>     Buffer I/O error on dev sda1, logical block 0, lost sync page write
> >>>>     EXT4-fs (sda1): I/O error while writing superblock
> >>>>
> >>>> This may happen either when mounting the root file system (leading to an
> >>>> unable to mount root fs panic), or later (leading to a read-only
> >>>> rootfs).
> >>>
> >>> BTW, today I just found that hang in blk_mq_freeze_queue_wait() is
> >>> caused by commit 900e080752025f00, and the following patch can fix it:
> >>>
> >>> - blk-mq: don't grab ->q_usage_counter in blk_mq_sched_bio_merge
> >>>
> >>> https://lore.kernel.org/linux-block/20211111085650.GA476@lst.de/T/#m759b88fda094a65ebf29bc81b780967cdaf9cf28
> >>>
> >>> Maybe you can try the above patch.
> >>
> >> Thanks! I have applied both patches, but it doesn't make a difference.
> > 
> > Thanks for your test!
> > 
> > Can you try the following patch?
> > 
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index f511db395c7f..a5ab2f2e9f67 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2517,7 +2517,6 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
> >  	struct blk_mq_alloc_data data = {
> >  		.q		= q,
> >  		.nr_tags	= 1,
> > -		.cmd_flags	= bio->bi_opf,
> >  	};
> >  	struct request *rq;
> >  
> > @@ -2525,6 +2524,7 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
> >  		return NULL;
> >  	if (unlikely(!submit_bio_checks(bio)))
> >  		goto put_exit;
> > +	data.cmd_flags	= bio->bi_opf;
> >  	if (blk_mq_attempt_bio_merge(q, bio, nsegs, same_queue_rq))
> >  		goto put_exit;
> 
> That's definitely a real fix, akin to the other pre-enter variants, this
> one just post checks. Geert, can you give this a whirl?
> 
> Ming, would you mind sending this as a real patch?

Hi Jens,

The above patch may not be enough, since submit_bio_checks() is done in
case of using cached request, so how about the following patch(un-tested)?


diff --git a/block/blk-mq.c b/block/blk-mq.c
index f511db395c7f..f84044c8de3f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2517,7 +2517,6 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 	struct blk_mq_alloc_data data = {
 		.q		= q,
 		.nr_tags	= 1,
-		.cmd_flags	= bio->bi_opf,
 	};
 	struct request *rq;
 
@@ -2525,6 +2524,7 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 		return NULL;
 	if (unlikely(!submit_bio_checks(bio)))
 		goto put_exit;
+	data.cmd_flags	= bio->bi_opf;
 	if (blk_mq_attempt_bio_merge(q, bio, nsegs, same_queue_rq))
 		goto put_exit;
 
@@ -2564,13 +2564,15 @@ static inline struct request *blk_mq_get_request(struct request_queue *q,
 			if (blk_mq_attempt_bio_merge(q, bio, nsegs,
 						same_queue_rq))
 				return NULL;
+			if (bio->bi_opf != rq->cmd_flags)
+				goto fallback;
 			plug->cached_rq = rq_list_next(rq);
 			INIT_LIST_HEAD(&rq->queuelist);
 			rq_qos_throttle(q, bio);
 			return rq;
 		}
 	}
-
+fallback:
 	return blk_mq_get_new_requests(q, plug, bio, nsegs, same_queue_rq);
 }
 

-- 
Ming

