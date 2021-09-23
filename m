Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E147FC433F5
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 06:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC0A96109E
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 06:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239329AbhIWGmE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Sep 2021 02:42:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23199 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237097AbhIWGmE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Sep 2021 02:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632379232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zrr7V6mPZZA/VKw5kQJ98ZtWmHqjzxTny3rVI8cigZk=;
        b=CD/RpK8/KulUYqxiSx1ivtQq4AcyXamWt07EsxKYIKfQU5shiCLE6dGwHqkm9iBptECO/o
        QxeCPdfUt2uTaO3lon5/opk5BEZ+BZLh6bgeqtaBJuAVh2q7itrVnvZMXg1Rl8WTOBzoWD
        EzAFLbyS4/ZUk3BAVCY94MpksGOzguw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-D5h3Pv2AMLCntrGEo3P34A-1; Thu, 23 Sep 2021 02:40:29 -0400
X-MC-Unique: D5h3Pv2AMLCntrGEo3P34A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC734A40C2;
        Thu, 23 Sep 2021 06:40:28 +0000 (UTC)
Received: from T590 (ovpn-8-34.pek2.redhat.com [10.72.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F1D5219724;
        Thu, 23 Sep 2021 06:39:47 +0000 (UTC)
Date:   Thu, 23 Sep 2021 14:39:59 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 3/4] block: drain file system I/O on del_gendisk
Message-ID: <YUwhPy1J8lzHQF77@T590>
References: <20210922172222.2453343-1-hch@lst.de>
 <20210922172222.2453343-4-hch@lst.de>
 <YUvZi2a0KjxEkiHo@T590>
 <20210923052705.GA5314@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923052705.GA5314@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 23, 2021 at 07:27:05AM +0200, Christoph Hellwig wrote:
> On Thu, Sep 23, 2021 at 09:34:03AM +0800, Ming Lei wrote:
> > > +	set_bit(GD_DEAD, &disk->state);
> > >  	set_capacity(disk, 0);
> > >  
> > > +	/*
> > > +	 * Prevent new I/O from crossing bio_queue_enter().
> > > +	 */
> > > +	blk_queue_start_drain(q);
> > > +	blk_mq_freeze_queue_wait(q);
> > > +
> > > +	rq_qos_exit(q);
> > > +	blk_sync_queue(q);
> > > +	blk_flush_integrity();
> > > +	/*
> > > +	 * Allow using passthrough request again after the queue is torn down.
> > > +	 */
> > > +	blk_mq_unfreeze_queue(q);
> > 
> > After blk_mq_unfreeze_queue() returns, blk_try_enter_queue() will return
> > true, so new FS I/O from opened bdev still won't be blocked, right?
> 
> It won't be blocked by blk_mq_unfreeze_queue, but because the capacity
> is set to 0 it still won't make it to the driver.

One bio could be made & checked before set_capacity(0), then is
submitted after blk_mq_unfreeze_queue() returns.

blk_mq_freeze_queue_wait() doesn't always imply RCU grace period, for
example, the .q_usage_counter may have been in atomic mode before
calling blk_queue_start_drain() & blk_mq_freeze_queue_wait().


Thanks,
Ming

