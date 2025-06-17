Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800422E401
	for <linux-block@vger.kernel.org>; Tue, 17 Jun 2025 02:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750127784; cv=none; b=eQ7/1D3kgdot56d9jFS59ywZ4GiCp9HQ1/L1fPbempitC6rtAiN0TcFvB1bV3ocvhLB+sS5+RaenTShrczQCNmslSAg0XZjgjx8ObMJnuNkn48F2Httv5bVCOtBHgiu5Nct7AamgEqlOmVi2bWKeLia//9aBFrurLQdSb8ucIgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750127784; c=relaxed/simple;
	bh=si9Vc/ED/gnk5wLr6a+jKzxYL2X9lI+9iImlLqFG6vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZYpkIdxMAoqXYAQn8Qw6bnWSLAvEq2Zms4QSLMIMMXGKXF/C4g1Gg1lW6ya7rWVZAUI81wqnmxHGAZmyNGh0TniIMh3cjxhxJe3ZPDJcCfqwogok+V6UKfFeWx1FPLTbAK6Vu6BWY0vDGL37auHAV3Jm5HhCHesQDBTRh+OmcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D7z1UjbB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D7z1UjbB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750127781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MChskAuooCjVIp4ptwMeYVTS0UApMt/GSUT63QzXYsk=;
	b=D7z1UjbBXNyR0wcIhukPxli9fF9ONm3A5lAIVrTG477plA/h/57BJbKbjreiuT4w2AremV
	63NS55tsJrx90fVrtn9XYxRefFsGv1KhHYDv2OL2MwBpotY284utVtdFWbgfAZO/Yx0vY2
	AABAXbeKOLIGzKcP2FsaF4wKLXlUMLo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-NZ9hyOX3MBO6BI-KprvgOQ-1; Mon,
 16 Jun 2025 22:36:17 -0400
X-MC-Unique: NZ9hyOX3MBO6BI-KprvgOQ-1
X-Mimecast-MFC-AGG-ID: NZ9hyOX3MBO6BI-KprvgOQ_1750127776
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C590218089B8;
	Tue, 17 Jun 2025 02:36:15 +0000 (UTC)
Received: from fedora (unknown [10.72.116.143])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA27819560A3;
	Tue, 17 Jun 2025 02:36:11 +0000 (UTC)
Date: Tue, 17 Jun 2025 10:36:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	"Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: use plug request list tail for one-shot backmerge
 attempt
Message-ID: <aFDUlnKVHLJC6VuE@fedora>
References: <82020a7f-adbc-4b3e-8edd-99aba5172510@amazon.com>
 <f4ed489d-af31-4ca0-bfc1-a340034c61f5@kernel.dk>
 <aEpkIxvuTWgY5BnO@infradead.org>
 <045d300e-9b52-4ead-8664-2cea6354f5bf@kernel.dk>
 <aErAYSg6f10p_WJK@infradead.org>
 <505e4900-b814-47cd-9572-c0172fa0d01e@kernel.dk>
 <aErGpBWAMPyT2un9@infradead.org>
 <2de604b5-0f57-4f41-84a1-aa6f3130d7c8@kernel.dk>
 <aFAYDPrW4THB0ga7@infradead.org>
 <CADUfDZqie84nJeBVJn94UvYqNhY73n41L+tbXOnXdMBqesLDWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqie84nJeBVJn94UvYqNhY73n41L+tbXOnXdMBqesLDWA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Jun 16, 2025 at 09:01:54AM -0700, Caleb Sander Mateos wrote:
> On Mon, Jun 16, 2025 at 6:11 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Thu, Jun 12, 2025 at 06:28:47AM -0600, Jens Axboe wrote:
> > > But ideally we'd have that, and just a plain doubly linked list on the
> > > queue/dispatch side. Which makes the list handling there much easier to
> > > follow, as per your patch.
> >
> > Quick hack from the weekend.  This also never deletes the requests from
> > the submission list for the queue_rqs case, so depending on the workload
> > it should touch either the same amount of less cache lines as the
> > existing version.  Only very lightly tested, and ublk is broken and
> > doesn't even compile as it's running out space in the io_uring pdu.
> > I'll need help from someone who knows ublk for that.
> >
> > ---
> > From 07e283303c63fcb694e828380a24ad51f225a228 Mon Sep 17 00:00:00 2001
> > From: Christoph Hellwig <hch@lst.de>
> > Date: Fri, 13 Jun 2025 09:48:40 +0200
> > Subject: block: always use a list_head for requests
> >
> > Use standard double linked lists for the remaining lists of queued up
> > requests. This removes a lot of hairy list manipulation code and allows
> > east reverse walking of the lists, which is used in
> > blk_attempt_plug_merge to improve the merging, and in blk_add_rq_to_plug
> > to look at the correct request.
> >
> > XXX: ublk is broken right now, because there is no space in the io_uring
> > pdu for the list backpointer.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  block/blk-core.c              |  2 +-
> >  block/blk-merge.c             | 11 +---
> >  block/blk-mq.c                | 97 ++++++++++++++---------------------
> >  drivers/block/null_blk/main.c | 16 +++---
> >  drivers/block/ublk_drv.c      | 43 +++++++---------
> >  drivers/block/virtio_blk.c    | 31 +++++------
> >  drivers/nvme/host/pci.c       | 32 ++++++------
> >  include/linux/blk-mq.h        |  2 +-
> >  include/linux/blkdev.h        |  2 +-
> >  9 files changed, 103 insertions(+), 133 deletions(-)
> >
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index b862c66018f2..29aad939a1e3 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -1127,7 +1127,7 @@ void blk_start_plug_nr_ios(struct blk_plug *plug, unsigned short nr_ios)
> >                 return;
> >
> >         plug->cur_ktime = 0;
> > -       rq_list_init(&plug->mq_list);
> > +       INIT_LIST_HEAD(&plug->mq_list);
> >         rq_list_init(&plug->cached_rqs);
> >         plug->nr_ios = min_t(unsigned short, nr_ios, BLK_MAX_REQUEST_COUNT);
> >         plug->rq_count = 0;
> > diff --git a/block/blk-merge.c b/block/blk-merge.c
> > index 70d704615be5..223941e9ec08 100644
> > --- a/block/blk-merge.c
> > +++ b/block/blk-merge.c
> > @@ -995,17 +995,10 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
> >         struct blk_plug *plug = current->plug;
> >         struct request *rq;
> >
> > -       if (!plug || rq_list_empty(&plug->mq_list))
> > +       if (!plug)
> >                 return false;
> >
> > -       rq = plug->mq_list.tail;
> > -       if (rq->q == q)
> > -               return blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
> > -                       BIO_MERGE_OK;
> > -       else if (!plug->multiple_queues)
> > -               return false;
> > -
> > -       rq_list_for_each(&plug->mq_list, rq) {
> > +       list_for_each_entry_reverse(rq, &plug->mq_list, queuelist) {
> >                 if (rq->q != q)
> >                         continue;
> >                 if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 4806b867e37d..6d56471d4346 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -1378,7 +1378,8 @@ static inline unsigned short blk_plug_max_rq_count(struct blk_plug *plug)
> >
> >  static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
> >  {
> > -       struct request *last = rq_list_peek(&plug->mq_list);
> > +       struct request *last =
> > +               list_last_entry(&plug->mq_list, struct request, queuelist);
> >
> >         if (!plug->rq_count) {
> >                 trace_block_plug(rq->q);
> > @@ -1398,7 +1399,7 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
> >          */
> >         if (!plug->has_elevator && (rq->rq_flags & RQF_SCHED_TAGS))
> >                 plug->has_elevator = true;
> > -       rq_list_add_tail(&plug->mq_list, rq);
> > +       list_add_tail(&rq->queuelist, &plug->mq_list);
> >         plug->rq_count++;
> >  }
> >
> > @@ -2780,15 +2781,15 @@ static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
> >         return __blk_mq_issue_directly(hctx, rq, last);
> >  }
> >
> > -static void blk_mq_issue_direct(struct rq_list *rqs)
> > +static void blk_mq_issue_direct(struct list_head *rqs)
> >  {
> >         struct blk_mq_hw_ctx *hctx = NULL;
> > -       struct request *rq;
> > +       struct request *rq, *n;
> >         int queued = 0;
> >         blk_status_t ret = BLK_STS_OK;
> >
> > -       while ((rq = rq_list_pop(rqs))) {
> > -               bool last = rq_list_empty(rqs);
> > +       list_for_each_entry_safe(rq, n, rqs, queuelist) {
> > +               list_del_init(&rq->queuelist);
> >
> >                 if (hctx != rq->mq_hctx) {
> >                         if (hctx) {
> > @@ -2798,7 +2799,7 @@ static void blk_mq_issue_direct(struct rq_list *rqs)
> >                         hctx = rq->mq_hctx;
> >                 }
> >
> > -               ret = blk_mq_request_issue_directly(rq, last);
> > +               ret = blk_mq_request_issue_directly(rq, list_empty(rqs));
> >                 switch (ret) {
> >                 case BLK_STS_OK:
> >                         queued++;
> > @@ -2819,45 +2820,18 @@ static void blk_mq_issue_direct(struct rq_list *rqs)
> >                 blk_mq_commit_rqs(hctx, queued, false);
> >  }
> >
> > -static void __blk_mq_flush_list(struct request_queue *q, struct rq_list *rqs)
> > +static void __blk_mq_flush_list(struct request_queue *q, struct list_head *rqs)
> >  {
> >         if (blk_queue_quiesced(q))
> >                 return;
> >         q->mq_ops->queue_rqs(rqs);
> >  }
> >
> > -static unsigned blk_mq_extract_queue_requests(struct rq_list *rqs,
> > -                                             struct rq_list *queue_rqs)
> > -{
> > -       struct request *rq = rq_list_pop(rqs);
> > -       struct request_queue *this_q = rq->q;
> > -       struct request **prev = &rqs->head;
> > -       struct rq_list matched_rqs = {};
> > -       struct request *last = NULL;
> > -       unsigned depth = 1;
> > -
> > -       rq_list_add_tail(&matched_rqs, rq);
> > -       while ((rq = *prev)) {
> > -               if (rq->q == this_q) {
> > -                       /* move rq from rqs to matched_rqs */
> > -                       *prev = rq->rq_next;
> > -                       rq_list_add_tail(&matched_rqs, rq);
> > -                       depth++;
> > -               } else {
> > -                       /* leave rq in rqs */
> > -                       prev = &rq->rq_next;
> > -                       last = rq;
> > -               }
> > -       }
> > -
> > -       rqs->tail = last;
> > -       *queue_rqs = matched_rqs;
> > -       return depth;
> > -}
> > -
> > -static void blk_mq_dispatch_queue_requests(struct rq_list *rqs, unsigned depth)
> > +static void blk_mq_dispatch_queue_requests(struct list_head *rqs,
> > +                                          unsigned depth)
> >  {
> > -       struct request_queue *q = rq_list_peek(rqs)->q;
> > +       struct request *rq = list_first_entry(rqs, struct request, queuelist);
> > +       struct request_queue *q = rq->q;
> >
> >         trace_block_unplug(q, depth, true);
> >
> > @@ -2869,39 +2843,35 @@ static void blk_mq_dispatch_queue_requests(struct rq_list *rqs, unsigned depth)
> >          */
> >         if (q->mq_ops->queue_rqs) {
> >                 blk_mq_run_dispatch_ops(q, __blk_mq_flush_list(q, rqs));
> > -               if (rq_list_empty(rqs))
> > +               if (list_empty(rqs))
> >                         return;
> >         }
> >
> >         blk_mq_run_dispatch_ops(q, blk_mq_issue_direct(rqs));
> >  }
> >
> > -static void blk_mq_dispatch_list(struct rq_list *rqs, bool from_sched)
> > +static void blk_mq_dispatch_list(struct list_head *rqs, bool from_sched)
> >  {
> >         struct blk_mq_hw_ctx *this_hctx = NULL;
> >         struct blk_mq_ctx *this_ctx = NULL;
> > -       struct rq_list requeue_list = {};
> > +       LIST_HEAD(list);
> > +       struct request *rq, *n;
> >         unsigned int depth = 0;
> >         bool is_passthrough = false;
> > -       LIST_HEAD(list);
> > -
> > -       do {
> > -               struct request *rq = rq_list_pop(rqs);
> >
> > +       list_for_each_entry_safe(rq, n, rqs, queuelist) {
> >                 if (!this_hctx) {
> >                         this_hctx = rq->mq_hctx;
> >                         this_ctx = rq->mq_ctx;
> >                         is_passthrough = blk_rq_is_passthrough(rq);
> >                 } else if (this_hctx != rq->mq_hctx || this_ctx != rq->mq_ctx ||
> >                            is_passthrough != blk_rq_is_passthrough(rq)) {
> > -                       rq_list_add_tail(&requeue_list, rq);
> >                         continue;
> >                 }
> > -               list_add_tail(&rq->queuelist, &list);
> > +               list_move_tail(&rq->queuelist, &list);
> >                 depth++;
> > -       } while (!rq_list_empty(rqs));
> > +       }
> >
> > -       *rqs = requeue_list;
> >         trace_block_unplug(this_hctx->queue, depth, !from_sched);
> >
> >         percpu_ref_get(&this_hctx->queue->q_usage_counter);
> > @@ -2921,17 +2891,27 @@ static void blk_mq_dispatch_list(struct rq_list *rqs, bool from_sched)
> >         percpu_ref_put(&this_hctx->queue->q_usage_counter);
> >  }
> >
> > -static void blk_mq_dispatch_multiple_queue_requests(struct rq_list *rqs)
> > +static void blk_mq_dispatch_multiple_queue_requests(struct list_head *rqs)
> >  {
> >         do {
> > -               struct rq_list queue_rqs;
> > -               unsigned depth;
> > +               struct request_queue *this_q = NULL;
> > +               struct request *rq, *n;
> > +               LIST_HEAD(queue_rqs);
> > +               unsigned depth = 0;
> > +
> > +               list_for_each_entry_safe(rq, n, rqs, queuelist) {
> > +                       if (!this_q)
> > +                               this_q = rq->q;
> > +                       if (this_q == rq->q) {
> > +                               list_move_tail(&rq->queuelist, &queue_rqs);
> > +                               depth++;
> > +                       }
> > +               }
> >
> > -               depth = blk_mq_extract_queue_requests(rqs, &queue_rqs);
> >                 blk_mq_dispatch_queue_requests(&queue_rqs, depth);
> > -               while (!rq_list_empty(&queue_rqs))
> > +               while (!list_empty(&queue_rqs))
> >                         blk_mq_dispatch_list(&queue_rqs, false);
> > -       } while (!rq_list_empty(rqs));
> > +       } while (!list_empty(rqs));
> >  }
> >
> >  void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
> > @@ -2955,15 +2935,14 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
> >                         blk_mq_dispatch_multiple_queue_requests(&plug->mq_list);
> >                         return;
> >                 }
> > -
> >                 blk_mq_dispatch_queue_requests(&plug->mq_list, depth);
> > -               if (rq_list_empty(&plug->mq_list))
> > +               if (list_empty(&plug->mq_list))
> >                         return;
> >         }
> >
> >         do {
> >                 blk_mq_dispatch_list(&plug->mq_list, from_schedule);
> > -       } while (!rq_list_empty(&plug->mq_list));
> > +       } while (!list_empty(&plug->mq_list));
> >  }
> >
> >  static void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
> > diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> > index aa163ae9b2aa..ce3ac928122f 100644
> > --- a/drivers/block/null_blk/main.c
> > +++ b/drivers/block/null_blk/main.c
> > @@ -1694,22 +1694,22 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
> >         return BLK_STS_OK;
> >  }
> >
> > -static void null_queue_rqs(struct rq_list *rqlist)
> > +static void null_queue_rqs(struct list_head *rqlist)
> >  {
> > -       struct rq_list requeue_list = {};
> >         struct blk_mq_queue_data bd = { };
> > +       LIST_HEAD(requeue_list);
> > +       struct request *rq, *n;
> >         blk_status_t ret;
> >
> > -       do {
> > -               struct request *rq = rq_list_pop(rqlist);
> > -
> > +       list_for_each_entry_safe(rq, n, rqlist, queuelist) {
> >                 bd.rq = rq;
> >                 ret = null_queue_rq(rq->mq_hctx, &bd);
> >                 if (ret != BLK_STS_OK)
> > -                       rq_list_add_tail(&requeue_list, rq);
> > -       } while (!rq_list_empty(rqlist));
> > +                       list_move_tail(&rq->queuelist, &requeue_list);
> > +       }
> >
> > -       *rqlist = requeue_list;
> > +       INIT_LIST_HEAD(rqlist);
> > +       list_splice(&requeue_list, rqlist);
> >  }
> >
> >  static void null_init_queue(struct nullb *nullb, struct nullb_queue *nq)
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index c637ea010d34..4d5b88ca7b1b 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -101,7 +101,7 @@ struct ublk_uring_cmd_pdu {
> >          */
> >         union {
> >                 struct request *req;
> > -               struct request *req_list;
> > +               struct list_head req_list;
> >         };
> >
> >         /*
> > @@ -1325,24 +1325,18 @@ static void ublk_cmd_list_tw_cb(struct io_uring_cmd *cmd,
> >                 unsigned int issue_flags)
> >  {
> >         struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> > -       struct request *rq = pdu->req_list;
> > -       struct request *next;
> > +       struct request *rq, *n;
> >
> > -       do {
> > -               next = rq->rq_next;
> > -               rq->rq_next = NULL;
> > +       list_for_each_entry_safe(rq, n, &pdu->req_list, queuelist)
> >                 ublk_dispatch_req(rq->mq_hctx->driver_data, rq, issue_flags);
> > -               rq = next;
> > -       } while (rq);
> >  }
> >
> > -static void ublk_queue_cmd_list(struct ublk_io *io, struct rq_list *l)
> > +static void ublk_queue_cmd_list(struct ublk_io *io, struct list_head *rqlist)
> >  {
> >         struct io_uring_cmd *cmd = io->cmd;
> >         struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> >
> > -       pdu->req_list = rq_list_peek(l);
> > -       rq_list_init(l);
> > +       list_splice(&pdu->req_list, rqlist);
> >         io_uring_cmd_complete_in_task(cmd, ublk_cmd_list_tw_cb);
> 
> ublk_cmd_list_tw_cb() doesn't need a doubly-linked list. It should be
> fine to continue storing just the first struct request * of the list
> in struct ublk_uring_cmd_pdu. That would avoid growing
> ublk_uring_cmd_pdu past the 32-byte limit.

Agree.

ublk needn't re-order, and doubly-linked list is useless here.


Thanks,
Ming

