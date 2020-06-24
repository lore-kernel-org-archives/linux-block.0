Return-Path: <SRS0=vHgh=AF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838EFC433DF
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 22:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BD7F2073E
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 22:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cbfi8SVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388104AbgFXW7O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jun 2020 18:59:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33723 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728383AbgFXW7O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 18:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593039551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xEPXGmRuXy84KM2mPCdo3BbJP27cNaBu5OvOVstsHYQ=;
        b=Cbfi8SVser10PUA2aEWjKG61pz1z8e3YWWxrP1ehbgFbRQvIntmWkC5suzT2Ear3LKpw74
        oiavk7MQW42daHkTab0McT5giEsjIVMxDWgvRhjE0847DRUa8HByeL1brpmHyw5hkGkJAJ
        5eDamgLKF0a+LFUeJY1jO5NLoHU9MAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-wp9i3H1IPP6lKFQh4t36gA-1; Wed, 24 Jun 2020 18:59:07 -0400
X-MC-Unique: wp9i3H1IPP6lKFQh4t36gA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBD65804001;
        Wed, 24 Jun 2020 22:59:05 +0000 (UTC)
Received: from T590 (ovpn-12-22.pek2.redhat.com [10.72.12.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E97CD82026;
        Wed, 24 Jun 2020 22:58:59 +0000 (UTC)
Date:   Thu, 25 Jun 2020 06:58:55 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V5 0/6] blk-mq: support batching dispatch from scheduler
Message-ID: <20200624225855.GA1045898@T590>
References: <20200603094337.2064181-1-ming.lei@redhat.com>
 <4c5d8c1b-2b5a-1bee-b5eb-5f4b7336b979@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c5d8c1b-2b5a-1bee-b5eb-5f4b7336b979@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 24, 2020 at 02:17:28PM -0700, Sagi Grimberg wrote:
> 
> > Hi Jens,
> > 
> > More and more drivers want to get batching requests queued from
> > block layer, such as mmc[1], and tcp based storage drivers[2]. Also
> > current in-tree users have virtio-scsi, virtio-blk and nvme.
> > 
> > For none, we already support batching dispatch.
> > 
> > But for io scheduler, every time we just take one request from scheduler
> > and pass the single request to blk_mq_dispatch_rq_list(). This way makes
> > batching dispatch not possible when io scheduler is applied. One reason
> > is that we don't want to hurt sequential IO performance, becasue IO
> > merge chance is reduced if more requests are dequeued from scheduler
> > queue.
> > 
> > Tries to start the support by dequeuing more requests from scheduler
> > if budget is enough and device isn't busy.
> > 
> > Simple fio test over virtio-scsi shows IO can get improved by 5~10%.
> > 
> > Baolin has tested previous versions and found performance on MMC can be improved.
> > 
> > Patch 1 ~ 4 are improvement and cleanup, which can't applied without
> > supporting batching dispatch.
> > 
> > Patch 5 ~ 6 starts to support batching dispatch from scheduler.
> > 
> > 
> > 
> > [1] https://lore.kernel.org/linux-block/20200512075501.GF1531898@T590/#r
> > [2] https://lore.kernel.org/linux-block/fe6bd8b9-6ed9-b225-f80c-314746133722@grimberg.me/
> > 
> > V5:
> > 	- code style changes suggested by Damien
> > 
> > V4:
> > 	- fix releasing budgets and avoids IO hang(5/6)
> > 	- dispatch more batches if the device can accept more(6/6)
> > 	- verified by running more tests
> > 
> > V3:
> > 	- add reviewed-by tag
> > 	- fix one typo
> > 	- fix one budget leak issue in case that .queue_rq returned *_RESOURCE in 5/6
> > 
> > V2:
> > 	- remove 'got_budget' from blk_mq_dispatch_rq_list
> > 	- drop patch for getting driver tag & handling partial dispatch
> 
> Hey Ming,
> 
> What ever happened to this one?

Hi Sagi,

Looks the 1st patch can't be applied cleanly against for-5.9/block, I will send
V6 later.

thanks,
Ming

