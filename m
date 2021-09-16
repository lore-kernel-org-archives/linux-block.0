Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F31C433EF
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 08:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1B3D6112E
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 08:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbhIPIPT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Sep 2021 04:15:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33775 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229908AbhIPIPT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Sep 2021 04:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631780038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jWAGeFMeG8RZcwmN+OXyIB4rSDeyQegD+pOOQmQG+54=;
        b=UBx74VIso2+ly/JeVjh01Xcevryin8e1ENTBPS6SbwUiTzZUqITBwXVDPoVxqap5ZMe5lr
        CMsGMy+Om0TWyYphy6ZMkLffwpF0tDuNVDu8fOeft9I22vizSXgunbXtcOIZBj6B6ztCjx
        yjZ+Rw45yLn3vkoHakD6HQdjPVSWHiA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-nQWDSTN5O3GdHvuBNqdZmw-1; Thu, 16 Sep 2021 04:13:55 -0400
X-MC-Unique: nQWDSTN5O3GdHvuBNqdZmw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BEBDA40C0;
        Thu, 16 Sep 2021 08:13:53 +0000 (UTC)
Received: from T590 (ovpn-12-89.pek2.redhat.com [10.72.12.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F162B5FC13;
        Thu, 16 Sep 2021 08:13:43 +0000 (UTC)
Date:   Thu, 16 Sep 2021 16:13:55 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Wen Xiong <wenxiong@us.ibm.com>,
        James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH V7 3/3] blk-mq: don't deactivate hctx if managed irq
 isn't used
Message-ID: <YUL8wz6CM4jrUeeN@T590>
References: <20210818144428.896216-1-ming.lei@redhat.com>
 <20210818144428.896216-4-ming.lei@redhat.com>
 <20210915161459.ks3pbqceuj5x3ugu@carbon.lan>
 <YUKpLmOPM1BNN5lF@T590>
 <20210916074229.7ntbn7prnv3fmmm2@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916074229.7ntbn7prnv3fmmm2@carbon.lan>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 16, 2021 at 09:42:29AM +0200, Daniel Wagner wrote:
> On Thu, Sep 16, 2021 at 10:17:18AM +0800, Ming Lei wrote:
> > Firstly, even with patches of 'qla2xxx - add nvme map_queues support',
> > the knowledge if managed irq is used in nvmef LLD is still missed, so
> > blk_mq_hctx_use_managed_irq() may always return false, but that
> > shouldn't be hard to solve.
> 
> Yes, that's pretty simple:
> 
> --- a/drivers/scsi/qla2xxx/qla_os.c
> +++ b/drivers/scsi/qla2xxx/qla_os.c
> @@ -7914,6 +7914,9 @@ static int qla2xxx_map_queues(struct Scsi_Host *shost)
>                 rc = blk_mq_map_queues(qmap);
>         else
>                 rc = blk_mq_pci_map_queues(qmap, vha->hw->pdev, vha->irq_offset);
> +
> +       qmap->use_managed_irq = true;
> +
>         return rc;
>  }

blk_mq_alloc_request_hctx() won't be called into qla2xxx queue, what we
need is to mark the nvmef queue as .use_managed_irq if the LLD uses
managed irq.

> 
> > The problem is that we still should make connect io queue completed
> > when all CPUs of this hctx is offline in case of managed irq.
> 
> I agree, though if I understand this right, the scenario where all CPUs
> are offline in a hctx and we want to use this htcx is only happening
> after an initial setup and then reconnect attempt happens. That is
> during the first connect attempt only online CPUs are assigned to the
> hctx. When the CPUs are taken offline the block layer makes sure not to
> use those queues anymore (no problem for the hctx so far). Then for some
> reason the nmve-fc layer decides to reconnect and we end up in the
> situation where we don't have any online CPU in given hctx.

It is simply that blk_mq_alloc_request_hctx() allocates request from one
specified hctx, and the specified hctx can be offline any time.

> 
> > One solution might be to use io polling for connecting io queue, but nvme fc
> > doesn't support polling, all the other nvme hosts do support it.
> 
> No idea, something to explore for sure :)

It is totally a raw idea, something like: start each queue in poll mode,
and run connect IO queue command via polling. Once the connect io queue command
is done, switch the queue into normal mode. Then
blk_mq_alloc_request_hctx() is guaranteed to be successful.

> 
> My point is that your series is fixing existing bugs and doesn't
> introduce a new one. qla2xxx is already depending on managed IRQs. I
> would like to see your series accepted with my hack as stop gap solution
> until we have a proper fix.

I am fine to work this way first if no one objects.


Thanks, 
Ming

