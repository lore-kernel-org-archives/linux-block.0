Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E4BCDB474
	for <linux-block@archiver.kernel.org>; Sat, 21 Oct 2023 01:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjJUBcZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Oct 2023 21:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJUBcZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Oct 2023 21:32:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AB5D6A
        for <linux-block@vger.kernel.org>; Fri, 20 Oct 2023 18:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697851891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JLVu9mgjvRz557D9Uh4mFZu/4k8hdbSG3nb+8fCv+bI=;
        b=QSsiBcqWtGeSurXBSAYB4wjExv/QqbuEEKS+BlbwQDeb9mI4E/yrJj0CABMTU9Qh0GOMch
        3WP32uOLgxbmTctjcMDEffPeOEc4i44uDFNVrCy+0h2sdgoc5ps5kqTcHq3D0fmV/YC4KF
        2XqshQBky24ge4sPJPvFySkEgln3724=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-ZnaX_knBN0-nT7eoVKQHtQ-1; Fri, 20 Oct 2023 21:31:22 -0400
X-MC-Unique: ZnaX_knBN0-nT7eoVKQHtQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 397DB38116F5;
        Sat, 21 Oct 2023 01:31:22 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AC8FF40C6F7B;
        Sat, 21 Oct 2023 01:31:16 +0000 (UTC)
Date:   Sat, 21 Oct 2023 09:31:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Ed Tsai <ed.tsai@mediatek.com>
Subject: Re: [PATCH] block: Improve shared tag set performance
Message-ID: <ZTMp3zwaKKQPKmqS@fedora>
References: <20231018180056.2151711-1-bvanassche@acm.org>
 <20231020044159.GB11984@lst.de>
 <0d2dce2a-8e01-45d6-b61b-f76493d55863@acm.org>
 <ZTKqAzSPNcBp4db0@kbusch-mbp>
 <f2728de6-ff3c-4693-b51f-58c3d46d0fbf@acm.org>
 <ZTK0NcqB4lIQ_zHQ@kbusch-mbp>
 <dbdc6dbe-5e2a-4414-bea6-1d2160ffdfdd@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbdc6dbe-5e2a-4414-bea6-1d2160ffdfdd@acm.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 20, 2023 at 10:54:59AM -0700, Bart Van Assche wrote:
> 
> On 10/20/23 10:09, Keith Busch wrote:
> > On Fri, Oct 20, 2023 at 09:45:53AM -0700, Bart Van Assche wrote:
> > > 
> > > On 10/20/23 09:25, Keith Busch wrote:
> > > > The legacy block request layer didn't have a tag resource shared among
> > > > multiple request queues. Each queue had their own mempool for allocating
> > > > requests. The mempool, I think, would always guarantee everyone could
> > > > get at least one request.
> > > 
> > > I think that the above is irrelevant in this context. As an example, SCSI
> > > devices have always shared a pool of tags across multiple logical
> > > units. This behavior has not been changed by the conversion of the
> > > SCSI core from the legacy block layer to blk-mq.
> > > 
> > > For other (hardware) block devices it didn't matter either that there
> > > was no upper limit to the number of requests the legacy block layer
> > > could allocate. All hardware block devices I know support fixed size
> > > queues for queuing requests to the block device.
> > 
> > I am not sure I understand your point. Those lower layers always were
> > able to get at least one request per request_queue. They can do whatever
> > they want with it after that. This change removes that guarantee for
> > blk-mq in some cases, right? I just don't think you can readily conclude
> > that is "safe" by appealing to the legacy behavior, that's all.
> 
> Hi Keith,
> 
> How requests were allocated in the legacy block layer is irrelevant in
> this context. The patch I posted affects the tag allocation strategy.
> Tag allocation happened in the legacy block layer by calling
> blk_queue_start_tag(). From Linux kernel v4.20:
> 
> /**
>  * blk_queue_start_tag - find a free tag and assign it
>  * @q:  the request queue for the device
>  * @rq:  the block request that needs tagging
>  * [ ... ]
>  **/
> 
> That function supports sharing tags between request queues but did not
> attempt to be fair at all. This is how the SCSI core in Linux kernel v4.20
> sets up tag sharing between request queues (from drivers/scsi/scsi_scan.c):
> 
> 	if (!shost_use_blk_mq(sdev->host)) {
> 		blk_queue_init_tags(sdev->request_queue,
> 				    sdev->host->cmd_per_lun, shost->bqt,
> 				    shost->hostt->tag_alloc_policy);
> 	}
> 
> blk-mq has always had a fairness algorithm in case a tag set is shared
> across request queues. If a tag set is shared across request queues, the
> number of tags per request queue is restricted to the total number of
> tags divided by the number of users (ignoring rounding). From
> block/blk-mq.c in the latest kernel:
> 
> 	depth = max((bt->sb.depth + users - 1) / users, 4U);
> 
> What my patch does is to remove this fairness guarantee. There was no
> equivalent of this fairness guarantee in the legacy block layer.

If two LUNs are attached to same host, one is slow, and another is fast,
and the slow LUN can slow down the fast LUN easily without this fairness
algorithm.

Your motivation is that "One of these logical units (WLUN) is used
to submit control commands, e.g. START STOP UNIT. If any request is
submitted to the WLUN, the queue depth is reduced from 31 to 15 or
lower for data LUNs." I guess one simple fix is to not account queues
of this non-IO LUN as active queues?



Thanks, 
Ming

