Return-Path: <SRS0=jKGj=DT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00813C433DF
	for <linux-block@archiver.kernel.org>; Mon, 12 Oct 2020 08:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99B982087D
	for <linux-block@archiver.kernel.org>; Mon, 12 Oct 2020 08:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H99Jz3UE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgJLINb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Oct 2020 04:13:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35838 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728956AbgJLIN2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Oct 2020 04:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602490406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cem/gNp247LYga6BNkaCK5NWZZonWFz2KLOKkw9NSWo=;
        b=H99Jz3UEz5Kp6cxaspdWzKR2W9GlwUYUaZJUnKe3p8WyVKtfoCjWE3M7hX7YWQKOEd/YMS
        jvvLZ1L3QWSzqRmEwSeqBpfNEMb6wss+5ppRhmRo+c09XAGIqNNcDBFZwAEzYogmplhK/+
        r+xTYTKyznpJrlZBKAXYNaXmlQbBkBM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-rGX0XLj5PQOQbez47LxsFw-1; Mon, 12 Oct 2020 04:13:24 -0400
X-MC-Unique: rGX0XLj5PQOQbez47LxsFw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6480718BE161;
        Mon, 12 Oct 2020 08:13:22 +0000 (UTC)
Received: from T590 (ovpn-13-62.pek2.redhat.com [10.72.13.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 80117614F5;
        Mon, 12 Oct 2020 08:13:11 +0000 (UTC)
Date:   Mon, 12 Oct 2020 16:13:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Chao Leng <lengchao@huawei.com>
Cc:     Yi Zhang <yi.zhang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: re-introduce blk_mq_complete_request_sync
Message-ID: <20201012081306.GB556731@T590>
References: <20201008213750.899462-1-sagi@grimberg.me>
 <20201009043938.GC27356@T590>
 <1711488120.3435389.1602219830518.JavaMail.zimbra@redhat.com>
 <e39b711e-ebbd-8955-ca19-07c1dad26fa2@grimberg.me>
 <23f19725-f46b-7de7-915d-b97fd6d69cdc@redhat.com>
 <ced685bf-ad48-ac41-8089-8c5ba09abfcb@grimberg.me>
 <7a7aca6e-30f5-0754-fb7f-599699b97108@redhat.com>
 <6f2a5ae2-2e6a-0386-691c-baefeecb5478@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f2a5ae2-2e6a-0386-691c-baefeecb5478@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 12, 2020 at 11:59:21AM +0800, Chao Leng wrote:
> 
> 
> On 2020/10/10 14:08, Yi Zhang wrote:
> > 
> > 
> > On 10/10/20 2:29 AM, Sagi Grimberg wrote:
> > > 
> > > 
> > > On 10/9/20 6:55 AM, Yi Zhang wrote:
> > > > Hi Sagi
> > > > 
> > > > On 10/9/20 4:09 PM, Sagi Grimberg wrote:
> > > > > > Hi Sagi
> > > > > > 
> > > > > > I applied this patch on block origin/for-next and still can reproduce it.
> > > > > 
> > > > > That's unexpected, can you try this patch?
> > > > > -- 
> > > > > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > > > > index 629b025685d1..46428ff0b0fc 100644
> > > > > --- a/drivers/nvme/host/tcp.c
> > > > > +++ b/drivers/nvme/host/tcp.c
> > > > > @@ -2175,7 +2175,7 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
> > > > >         /* fence other contexts that may complete the command */
> > > > >         mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
> > > > >         nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
> > > > > -       if (!blk_mq_request_completed(rq)) {
> > > > > +       if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq)) {
> > > > >                 nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
> > > > >                 blk_mq_complete_request_sync(rq);
> > > > >         }
> This may just reduce the probability. The concurrency of timeout and teardown will cause the same request
> be treated repeatly, this is not we expected.

That is right, not like SCSI, NVME doesn't apply atomic request completion, so
request may be completed/freed from both timeout & nvme_cancel_request().

.teardown_lock still may cover the race with Sagi's patch because teardown
actually cancels requests in sync style.

> In the teardown process, after quiesced queues delete the timer and cancel the timeout work maybe a better option.

Seems better solution, given it is aligned with NVME PCI's reset
handling. nvme_sync_queues() may be called in nvme_tcp_teardown_io_queues() to
avoid this race.


Thanks, 
Ming

