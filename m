Return-Path: <SRS0=1Rjj=CS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F34C43461
	for <linux-block@archiver.kernel.org>; Wed,  9 Sep 2020 01:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F18232177B
	for <linux-block@archiver.kernel.org>; Wed,  9 Sep 2020 01:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RVy/UXe2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgIIBQ6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Sep 2020 21:16:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29305 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726369AbgIIBQ6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Sep 2020 21:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599614216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i8mv0FVtNHbd9zXlKvA6wXb9TbJe9plomVS4MYmguXw=;
        b=RVy/UXe2pYU2s4SAn31uycS9U6xJziZYIdIIc6iFrOm81cd9oHQfDnk67HOpwJm5sPqo0u
        UPJLLE6ALRt74nUQPrfJZKb0lKA2jvxlI787HaQ6L1sP0sd/Sm8C4TIlg3HatXgb1vQrhQ
        ftAo18QIaojHNo0f7YKT0oARm+mtEWY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-UZ-XJF2-NnWRoDA0VNN-ug-1; Tue, 08 Sep 2020 21:16:54 -0400
X-MC-Unique: UZ-XJF2-NnWRoDA0VNN-ug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27300100558D;
        Wed,  9 Sep 2020 01:16:53 +0000 (UTC)
Received: from T590 (ovpn-12-76.pek2.redhat.com [10.72.12.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 122673A40;
        Wed,  9 Sep 2020 01:16:45 +0000 (UTC)
Date:   Wed, 9 Sep 2020 09:16:41 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH V3 1/4] blk-mq: serialize queue quiesce and unquiesce by
 mutex
Message-ID: <20200909011641.GA1465199@T590>
References: <20200908081538.1434936-1-ming.lei@redhat.com>
 <20200908081538.1434936-2-ming.lei@redhat.com>
 <8e040e37-d1df-ea5f-8a63-f4067d092b72@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e040e37-d1df-ea5f-8a63-f4067d092b72@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 08, 2020 at 10:54:14AM -0700, Bart Van Assche wrote:
> On 2020-09-08 01:15, Ming Lei wrote:
> >  void blk_mq_unquiesce_queue(struct request_queue *q)
> >  {
> > +	mutex_lock(&q->mq_quiesce_lock);
> > +
> >  	blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
> >  
> >  	/* dispatch requests which are inserted during quiescing */
> >  	blk_mq_run_hw_queues(q, true);
> > +
> > +	mutex_unlock(&q->mq_quiesce_lock);
> >  }
> Has the sunvdc driver been retested? It calls blk_mq_unquiesce_queue()
> with a spinlock held. As you know calling mutex_lock() while holding a
> spinlock is not allowed.

I am wondering if sunvdc is still being actively used, the similar lock issue
has been existed since 7996a8b5511a ("blk-mq: fix hang caused by
freeze/unfreeze sequence") which is committed in May 2019.

+       spin_lock_irq(&port->vio.lock);
+       port->drain = 0;
+       blk_mq_unquiesce_queue(q);
+       blk_mq_unfreeze_queue(q);

mutex_lock is added to blk_mq_unfreeze_queue(q) since commit 7996a8b5511a.

Not see such report actually.

> There may be other drivers than the sunvdc driver that do this.

Most calls of blk_mq_unquiesce_queue are easily to be audited because
blk_mq_quiesce_queue is used in same callsite.

I will take a close look at this thing before posting next version.

Thanks,
Ming

