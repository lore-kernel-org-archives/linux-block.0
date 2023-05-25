Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E145DC77B7C
	for <linux-block@archiver.kernel.org>; Thu, 25 May 2023 00:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjEYAyQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 20:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjEYAyQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 20:54:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE81E7
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 17:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684976015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N+TgKLqKBzzmyE0p+0gIfrJPNMFF4ejADp8uDcLQDQY=;
        b=Y7Q3OOZd28WDzmak46h4dKqD+QUGgPnmQZl0YFmPkrTKI5N0Fznyzj18TmBHK93hgpgDk3
        QCs4oyGEQCt+ZILh/xUOWWdqRLQjGdrUG0ArDD/V4fe2AFybmQ8CykswaPa9aeYxWcYqk/
        HxtfByIxT+1G5axIVT8tHWiyBo8Xx1k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-257-1PaAP8vJNt2QcjB3Ykgtfw-1; Wed, 24 May 2023 20:53:33 -0400
X-MC-Unique: 1PaAP8vJNt2QcjB3Ykgtfw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01137185A78E;
        Thu, 25 May 2023 00:53:33 +0000 (UTC)
Received: from ovpn-8-21.pek2.redhat.com (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ED7C4492B0A;
        Thu, 25 May 2023 00:53:27 +0000 (UTC)
Date:   Thu, 25 May 2023 08:53:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jianchao Wang <jianchao.w.wang@oracle.com>, ming.lei@redhat.com
Subject: Re: [PATCH v3 2/7] block: Send requeued requests to the I/O scheduler
Message-ID: <ZG6xgnNdSi+HAS6J@ovpn-8-21.pek2.redhat.com>
References: <20230522183845.354920-1-bvanassche@acm.org>
 <20230522183845.354920-3-bvanassche@acm.org>
 <ZGyBV5W1WxVEzAED@ovpn-8-32.pek2.redhat.com>
 <1d2fc2c5-18fc-a937-7944-7d7808c00a0b@acm.org>
 <ZG1a610jtBDPDPip@ovpn-8-17.pek2.redhat.com>
 <a40b10d9-4e30-438f-2509-28bb0df4a161@acm.org>
 <bf32b0f9-d85b-367f-e6f4-83d58c418d7a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf32b0f9-d85b-367f-e6f4-83d58c418d7a@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 25, 2023 at 08:06:31AM +0900, Damien Le Moal wrote:
> On 5/25/23 02:56, Bart Van Assche wrote:
> > On 5/23/23 17:31, Ming Lei wrote:
> >> On Tue, May 23, 2023 at 10:19:34AM -0700, Bart Van Assche wrote:
> >>> The mq-deadline scheduler restricts the queue depth to one per zone for zoned
> >>> storage so at any time there is at most one write command (REQ_OP_WRITE) in
> >>> flight per zone.
> >>
> >> But if the write queue depth is 1 per zone, the requeued request won't
> >> be re-ordered at all given no other write request can be issued from
> >> scheduler in this zone before this requeued request is completed.
> >>
> >> So why bother to requeue the BLK_STS_RESOURCE request via scheduler?
> > 
> > Hi Ming,
> > 
> > It seems like my previous email was not clear enough. The mq-deadline 
> > scheduler restricts the queue depth per zone for commands passed to the 
> > SCSI core. It does not restrict how many requests a filesystem can 
> > submit per zone to the block layer. Without this patch there is a risk 
> > of reordering if a request is requeued, e.g. by the SCSI core, and other 
> > requests are pending for the same zone.
> 
> Yes there is, but the contract we established for zoned devices in the block
> layer, from the start of the support, is that users *must* write sequentially.
> The block layer does not attempt, generally speaking, to reorder requests.
> 
> When mq-deadline is used, the scheduler lba reordering *may* reorder writes,
> thus hiding potential bugs in the user write sequence for a zone. That is fine.
> However, once a write request is dispatched, we should keep the assumption that
> it is a well formed one, namely directed at the zone write pointer. So any
> consideration of requeue solving write ordering issues is moot to me.
> 
> Furthermore, when the requeue happens, the target zone is still locked and the
> only write request that can be in flight for that target zones is that one being
> requeued. Add to that the above assumption that the request is the one we must
> dispatch first, there are absolutely zero chances of seeing a reordering happen
> for writes to a particular zone. I really do not see the point of requeuing that
> request through the IO scheduler at all.

Totally agree, that is exactly what I meant.

> 
> In general, even for reads, requeuing through the scheduler is I think a really
> bad idea as that can potentially significantly increase the request latency
> (time to completion), with the user seeing long tail latencies. E.g. if the
> request has high priority or a short CDL time limit, requeuing through the
> scheduler will go against the user indicated urgency for that request and
> degrade the effectivness of latency control easures such as IO priority and CDL.
> 
> Requeues should be at the head of the dispatch queue, not through the scheduler.

It is pretty easy to run into STS_RESOURCE for some scsi devices,
requeuing via schedule does add more overhead for these devices.

> 
> As long as we keep zone write locking for zoned devices, requeue to the head of
> the dispatch queue is fine. But maybe this work is preparatory to removing zone
> write locking ? If that is the case, I would like to see that as well to get the
> big picture. Otherwise, the latency concerns I raised above are in my opinion, a
> blocker for this change.

Yeah, looks Bart needs to add more words about requirement & motivation
of this patchset.


Thanks,
Ming

