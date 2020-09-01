Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B083C433E6
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 06:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 056E52098B
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 06:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gxGKjZnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgIAGg3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 02:36:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726078AbgIAGg2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Sep 2020 02:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598942186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zzfocKsKUr8XTH48A1kIwAVGfGSumHa2g6/MLyRv8QM=;
        b=gxGKjZnBODe4q032LlMiE2OwmOg1WZTWPm/+nsDcZ1pq7Ql03vsAiGCXqBCvpRb3Qr+y1E
        vdLiECefiqW1KMD0aJDsehjCSaKY3JUNnpTOYifVbMM4PsArIxt6eqpJ7Xmn4Yf7ZLpmbO
        GnfxPEEdXMIMgO3VH4WwJko+aH8Joic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-hUhgr82tMQWNAeAD3RWyKg-1; Tue, 01 Sep 2020 02:36:23 -0400
X-MC-Unique: hUhgr82tMQWNAeAD3RWyKg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B3A01074641;
        Tue,  1 Sep 2020 06:36:22 +0000 (UTC)
Received: from T590 (ovpn-12-80.pek2.redhat.com [10.72.12.80])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9744080E09;
        Tue,  1 Sep 2020 06:36:16 +0000 (UTC)
Date:   Tue, 1 Sep 2020 14:36:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-block <linux-block@vger.kernel.org>, kernel@collabora.com
Subject: Re: [PATCH] block: Fix inflight statistic for MQ submission with
 !elevator
Message-ID: <20200901063611.GC289251@T590>
References: <20200831153127.3561733-1-krisman@collabora.com>
 <CACVXFVM21GWTrWs=6w3OXm7vQ-gmR_3PGss+9TE=swVN-Uzn7Q@mail.gmail.com>
 <1b0ad48b-bc94-269f-1899-e49f3d1802e2@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b0ad48b-bc94-269f-1899-e49f3d1802e2@kernel.dk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

On Mon, Aug 31, 2020 at 09:42:05PM -0600, Jens Axboe wrote:
> On 8/31/20 7:18 PM, Ming Lei wrote:
> > On Mon, Aug 31, 2020 at 11:37 PM Gabriel Krisman Bertazi
> > <krisman@collabora.com> wrote:
> >>
> >> According to Documentation/block/stat.rst, inflight should not include
> >> I/O requests that are in the queue but not yet dispatched to the device,
> >> but blk-mq identifies as inflight any request that has a tag allocated,
> >> which, for queues without elevator, happens at request allocation time
> >> and before it is queued in the ctx (default case in blk_mq_submit_bio).
> >>
> >> A more precise approach would be to only consider requests with state
> >> MQ_RQ_IN_FLIGHT.
> >>
> >> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> >> ---
> >>  block/blk-mq.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/block/blk-mq.c b/block/blk-mq.c
> >> index 0015a1892153..997b3327eaa8 100644
> >> --- a/block/blk-mq.c
> >> +++ b/block/blk-mq.c
> >> @@ -105,7 +105,7 @@ static bool blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
> >>  {
> >>         struct mq_inflight *mi = priv;
> >>
> >> -       if (rq->part == mi->part)
> >> +       if (rq->part == mi->part && rq->state == MQ_RQ_IN_FLIGHT)
> >>                 mi->inflight[rq_data_dir(rq)]++;
> > 
> > The fix looks fine. However, we have helper of
> > blk_mq_request_started() for this purpose.
> 
> Why does it look fine? Did you see the older commit I referenced? I'm

Looks my gmail inbox has problem, and I didn't see your referenced commit.
but I can see your reply just now in my redhat email box, sorry for that.

BTW, commit 6131837b1de6 ("blk-mq: count allocated but not started requests
in iostats inflight") didn't does what it claimed. blk_mq_queue_tag_busy_iter()
iterates over driver tags, so for real io scheduler, blk_mq_check_inflight()
basically returns count of inflight request, instead of allocated request.

Even worse, since commit 6131837b1de6 blk_mq_in_flight() behaves inconsistently
between q->elevator and !q->elevator.

> not saying the change is wrong per se, just that this is the behavior
> we've always had, and making this change would deviate from that. As
> Gabriel states in the follow up, it's either changing the documentation
> or the patch.

Looks iostat doesn't use the 'inflight' count, so what is the userspace's
expectation on this counter?

If it counts allocated request, it is easy for userspace to observe different
statistics if someone updates nr_requests via sysfs.


Thanks,
Ming

