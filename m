Return-Path: <SRS0=ya0H=4H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB139C5ACC4
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 22:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD089206EF
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 22:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fco2beCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgBSWLB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 17:11:01 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33808 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727232AbgBSWLB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 17:11:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582150259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WJXeiw8Pc47ziMf9sllqy/XIXqOZqMkjIL0kGh5O1UI=;
        b=fco2beCWpB15bSNVugH0zzS4nU5Ijwu1rWMGEJlS2mtvQCRgqu47HL/vUfehpDtxg/hSGq
        bC31AXBxVTB3F9oo4aFy5rYVfZKbkyELXW7+Dvx463ru7vmKrno8DINGEDZs68Sg2EUkkP
        FibnzbIJmCXl94mWEZ5GR99bYxEcIAk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-mzc_OQdGOmijSxTCyt1lLQ-1; Wed, 19 Feb 2020 17:10:55 -0500
X-MC-Unique: mzc_OQdGOmijSxTCyt1lLQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 936F713E2;
        Wed, 19 Feb 2020 22:10:54 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EC7619C4F;
        Wed, 19 Feb 2020 22:10:44 +0000 (UTC)
Date:   Thu, 20 Feb 2020 06:10:36 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Ewan D. Milne" <emilne@redhat.com>
Subject: Re: [PATCH] blk-mq: insert passthrough request into hctx->dispatch
 directly
Message-ID: <20200219221036.GA24522@ming.t460p>
References: <20200215032140.4093-1-ming.lei@redhat.com>
 <20200219163615.GE18377@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219163615.GE18377@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 19, 2020 at 08:36:15AM -0800, Christoph Hellwig wrote:
> On Sat, Feb 15, 2020 at 11:21:40AM +0800, Ming Lei wrote:
> > For some reason, device may be in one situation which can't handle
> > FS request, so STS_RESOURCE is always returned and the FS request
> > will be added to hctx->dispatch. However passthrough request may
> > be required at that time for fixing the problem. If passthrough
> > request is added to scheduler queue, there isn't any chance for
> > blk-mq to dispatch it given we prioritize requests in hctx->dispatch.
> > Then the FS IO request may never be completed, and IO hang is caused.
> > 
> > So passthrough request has to be added to hctx->dispatch directly.
> > 
> > Fix this issue by inserting passthrough request into hctx->dispatch
> > directly. Then it becomes consistent with original legacy IO request
> > path, in which passthrough request is always added to q->queue_head.
> 
> Do you have a description of an actual problem this fixes?  Maybe even
> a reproducer for blktests?
> 

It is reported by one RH customer in the following test case:

	1) Start IO on Emulex FC host
	2) Fail one controller, wait 5 minutes
	3) Bring controller back online

When we trace the problem, it is found that FS request started in device_add_disk()
from scsi disk probe context stuck because scsi_queue_rq() always return
STS_BUSY via scsi_setup_fs_cmnd() -> alua_prep_fn().

The kernel ALUA state is TRANSITIONING at that time, so it is reasonable to see
BLK_TYPE_FS requests won't go anywhere because of the check in alua_prep_fn().

However, the passthrough request(TEST UNIT READY) is submitted from alua_rtpg_work
when the FS request can't be dispatched to LLD. And SCSI stack should
have been allowed to handle this passthrough rquest. But it can't reach SCSI stack
via .queue_rq() because blk-mq won't dispatch it until hctx->dispatch is
empty.

The legacy IO request code always added passthrough request into head of q->queue_head
directly instead of scheduler queue or sw queue, so no such issue.

So far not figured out one blktests test case, but the problem is real.

BTW, I just found we need the extra following change:

@@ -1301,7 +1301,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
                        q->mq_ops->commit_rqs(hctx);

                spin_lock(&hctx->lock);
-               list_splice_init(list, &hctx->dispatch);
+               list_splice_tail_init(list, &hctx->dispatch);
                spin_unlock(&hctx->lock);

Will post V2.


Thanks,
Ming

