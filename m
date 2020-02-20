Return-Path: <SRS0=lp7R=4I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CABAC7619D
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 01:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0466521D56
	for <linux-block@archiver.kernel.org>; Thu, 20 Feb 2020 01:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbQ8v2zI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgBTBpu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 20:45:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24806 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727211AbgBTBpu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 20:45:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582163148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pc+yQXiGzW41GPI5r+LEEGq8tps3Gd34A89mKbuYOIo=;
        b=IbQ8v2zI3iCIo1W0UL5u3Nv57TdaVe4ToN0Xjz3Wv5JOXGYGHLNrykGmpHWWIODUJOhXj0
        zgQDU378nE1I886rFmLosSjVqD+myT8wOKEslz2+Di2jFpCFx9XT5op4JI0xQNnd3sRECx
        xk82x8Wq9iGU/ZtVNexsz2v3/5Y4+Fs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-8pXUa1T4N8OjMqGaSWROOw-1; Wed, 19 Feb 2020 20:45:44 -0500
X-MC-Unique: 8pXUa1T4N8OjMqGaSWROOw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8237E800D48;
        Thu, 20 Feb 2020 01:45:43 +0000 (UTC)
Received: from ming.t460p (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DB7C9051B;
        Thu, 20 Feb 2020 01:45:33 +0000 (UTC)
Date:   Thu, 20 Feb 2020 09:45:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     dongli.zhang@oracle.com
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Ewan D. Milne" <emilne@redhat.com>
Subject: Re: [PATCH] blk-mq: insert passthrough request into hctx->dispatch
 directly
Message-ID: <20200220014526.GA1469@ming.t460p>
References: <20200215032140.4093-1-ming.lei@redhat.com>
 <20200219163615.GE18377@infradead.org>
 <20200219221036.GA24522@ming.t460p>
 <0e1d5b99-28f3-79b3-d5b4-25f6b4f95955@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e1d5b99-28f3-79b3-d5b4-25f6b4f95955@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 19, 2020 at 03:47:50PM -0800, dongli.zhang@oracle.com wrote:
> 
> 
> On 2/19/20 2:10 PM, Ming Lei wrote:
> > On Wed, Feb 19, 2020 at 08:36:15AM -0800, Christoph Hellwig wrote:
> >> On Sat, Feb 15, 2020 at 11:21:40AM +0800, Ming Lei wrote:
> >>> For some reason, device may be in one situation which can't handle
> >>> FS request, so STS_RESOURCE is always returned and the FS request
> >>> will be added to hctx->dispatch. However passthrough request may
> >>> be required at that time for fixing the problem. If passthrough
> >>> request is added to scheduler queue, there isn't any chance for
> >>> blk-mq to dispatch it given we prioritize requests in hctx->dispatch.
> >>> Then the FS IO request may never be completed, and IO hang is caused.
> >>>
> >>> So passthrough request has to be added to hctx->dispatch directly.
> >>>
> >>> Fix this issue by inserting passthrough request into hctx->dispatch
> >>> directly. Then it becomes consistent with original legacy IO request
> >>> path, in which passthrough request is always added to q->queue_head.
> >>
> >> Do you have a description of an actual problem this fixes?  Maybe even
> >> a reproducer for blktests?
> >>
> > 
> > It is reported by one RH customer in the following test case:
> > 
> > 	1) Start IO on Emulex FC host
> > 	2) Fail one controller, wait 5 minutes
> > 	3) Bring controller back online
> > 
> > When we trace the problem, it is found that FS request started in device_add_disk()
> > from scsi disk probe context stuck because scsi_queue_rq() always return
> > STS_BUSY via scsi_setup_fs_cmnd() -> alua_prep_fn().
> > 
> > The kernel ALUA state is TRANSITIONING at that time, so it is reasonable to see
> > BLK_TYPE_FS requests won't go anywhere because of the check in alua_prep_fn().
> > 
> > However, the passthrough request(TEST UNIT READY) is submitted from alua_rtpg_work
> > when the FS request can't be dispatched to LLD. And SCSI stack should
> > have been allowed to handle this passthrough rquest. But it can't reach SCSI stack
> > via .queue_rq() because blk-mq won't dispatch it until hctx->dispatch is
> > empty.
> > 
> > The legacy IO request code always added passthrough request into head of q->queue_head
> > directly instead of scheduler queue or sw queue, so no such issue.
> > 
> > So far not figured out one blktests test case, but the problem is real.
> > 
> > BTW, I just found we need the extra following change:
> > 
> > @@ -1301,7 +1301,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
> >                         q->mq_ops->commit_rqs(hctx);
> > 
> >                 spin_lock(&hctx->lock);
> > -               list_splice_init(list, &hctx->dispatch);
> > +               list_splice_tail_init(list, &hctx->dispatch);
> >                 spin_unlock(&hctx->lock);
> > 
> 
> Is it fine to add to tail as the requests on dispatch would be reordered?

Wrt. FS request:

Firstly we never guarantee that the request is dispatched in order.

Secondly and more importantly, request can be added into hctx->dispatch
in any order. One usual case is that request is added to hctx->dispatch
concurrently when .queue_rq() fails. On the other side, in case of not
concurrent adding to hctx->dispatch, after one request is added to
hctx->dispatch, we always dispatch request from hctx->dispatch first,
instead of dequeuing request from scheduler queue and adding them to
hctx->dispatch again after .queue_rq() fails.

> 
> A, B, C and D are on the list. Suppose A is failed and the new list would become
> B, C D, A?

Right, I don't see there is any issue in this way, do you see issues?



Thanks,
Ming

