Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCE0C433B4
	for <linux-block@archiver.kernel.org>; Tue, 18 May 2021 11:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F201F61001
	for <linux-block@archiver.kernel.org>; Tue, 18 May 2021 11:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348509AbhERLSC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 May 2021 07:18:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27724 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237443AbhERLSC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 May 2021 07:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621336604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g+0jWqzgLQaMSZZWPdiHn0oyuSGspxrWwS78wocPOfM=;
        b=D0cPZM9bSgdiDW6S+01NRZvfiZVlgE8QU8g/BzRHVZ9z0r56poTkAWKgOS0ormXvOxxitc
        sMNV3Utm8oW2+ocskYkpnvr+btA7bktQfImyFE2Uf8cjk3QPRRVngVkT1rLRz1JwZwkIGY
        ufC0LbAqj0CUIzhIQd062NaMTRKI1S0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-L0pQfUtFObGO7e3Sbva4YA-1; Tue, 18 May 2021 07:16:40 -0400
X-MC-Unique: L0pQfUtFObGO7e3Sbva4YA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 779401B2C980;
        Tue, 18 May 2021 11:16:39 +0000 (UTC)
Received: from T590 (ovpn-13-48.pek2.redhat.com [10.72.13.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ABF1219D9F;
        Tue, 18 May 2021 11:16:31 +0000 (UTC)
Date:   Tue, 18 May 2021 19:16:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Yanhui Ma <yama@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        kashyap.desai@broadcom.com, chenxiang <chenxiang66@hisilicon.com>
Subject: Re: [PATCH] blk-mq: plug request for shared sbitmap
Message-ID: <YKOiClSTyHl5lbXV@T590>
References: <20210514022052.1047665-1-ming.lei@redhat.com>
 <b38d671a-530b-244a-bc0f-0b926c796243@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b38d671a-530b-244a-bc0f-0b926c796243@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 18, 2021 at 10:44:43AM +0100, John Garry wrote:
> On 14/05/2021 03:20, Ming Lei wrote:
> > In case of shared sbitmap, request won't be held in plug list any more
> > sine commit 32bc15afed04 ("blk-mq: Facilitate a shared sbitmap per
> > tagset"), this way makes request merge from flush plug list & batching
> > submission not possible, so cause performance regression.
> > 
> > Yanhui reports performance regression when running sequential IO
> > test(libaio, 16 jobs, 8 depth for each job) in VM, and the VM disk
> > is emulated with image stored on xfs/megaraid_sas.
> > 
> > Fix the issue by recovering original behavior to allow to hold request
> > in plug list.
> 
> Hi Ming,
> 
> Since testing v5.13-rc2, I noticed that this patch made the hang I was
> seeing disappear:
> https://lore.kernel.org/linux-scsi/3d72d64d-314f-9d34-e039-7e508b2abe1b@huawei.com/
> 
> I don't think that problem is solved, though.

This kind of hang or lockup is usually related with cpu utilization, and
this patch may reduce cpu utilization in submission context.

> 
> So I wonder about throughput performance (I had hoped to test before it was
> merged). I only have 6x SAS SSDs at hand, but I see some significant changes
> (good and bad) for mq-deadline for hisi_sas:
> Before 620K (read), 300K IOPs (randread)
> After 430K (read), 460-490K IOPs (randread)

'Before 620K' could be caused by busy queue when batching submission isn't
applied, so merge chance is increased. This patch applies batching
submission, so queue becomes not busy enough.

BTW, what is the queue depth of sdev and can_queue of shost for your hisilision SAS?
 
> 
> none IO sched is always about 450K (read) and 500K (randread)
> 
> Do you guys have any figures? Are my results as expected?

In yanhui's virt workload(qemu, libaio, dio, high queue depth, single
job), the patch can improve throughput much(>50%) when running
sequential write(dio, libaio, 16 jobs) to XFS. And it is observed that
IO merge is recovered to level of disabling host tags.

Thanks,
Ming

