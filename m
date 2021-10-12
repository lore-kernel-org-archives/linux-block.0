Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C621C433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 15:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40D066052B
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 15:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbhJLPJK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 11:09:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28493 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237062AbhJLPJJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 11:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634051227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jXSeKkVlYOYMFbXldE+ZY1oBqyx/jHfPT9bwC8eSB9I=;
        b=GnkxLJCLlKkFPd4hnCTJzmYQrQ0Mlimn71OFaj0+vDL+k9txag/Io7+7MhMooJTnSqdmxw
        /L0rbtcn3cXV4mdigx3RGkv8aG+SrZFNPvlzZpr/FL3WzOekm8/oFvt88H9gCIhkNEob5G
        du5oDRCFv/2Pck3d8pPz4Y0znNCgrmc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-SY_I9Pu1M9WRGHWECdziKg-1; Tue, 12 Oct 2021 11:07:02 -0400
X-MC-Unique: SY_I9Pu1M9WRGHWECdziKg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C29BA19067E4;
        Tue, 12 Oct 2021 15:07:00 +0000 (UTC)
Received: from T590 (ovpn-8-34.pek2.redhat.com [10.72.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4248F5D6A8;
        Tue, 12 Oct 2021 15:06:55 +0000 (UTC)
Date:   Tue, 12 Oct 2021 23:06:51 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V3 6/6] blk-mq: support concurrent queue quiesce/unquiesce
Message-ID: <YWWki6An1sOpx3rV@T590>
References: <20211009034713.1489183-1-ming.lei@redhat.com>
 <20211009034713.1489183-7-ming.lei@redhat.com>
 <20211012103010.GA29640@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012103010.GA29640@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 12, 2021 at 12:30:10PM +0200, Christoph Hellwig wrote:
> On Sat, Oct 09, 2021 at 11:47:13AM +0800, Ming Lei wrote:
> > +	spin_lock_irqsave(&q->queue_lock, flags);
> > +	if (!q->quiesce_depth++)
> > +		blk_queue_flag_set(QUEUE_FLAG_QUIESCED, q);
> 
> We can get rid of the QUEUE_FLAG_QUIESCED flag now and just look
> at ->quiesce_depth directly.

I'd rather not to do that given we need to check QUEUE_FLAG_QUIESCED in fast
path.

> 
> > +	spin_lock_irqsave(&q->queue_lock, flags);
> > +	WARN_ON_ONCE(q->quiesce_depth <= 0);
> > +	if (q->quiesce_depth > 0 && !--q->quiesce_depth) {
> 
> 	if (WARN_ON_ONCE(q->quiesce_depth <= 0))
> 		; /* oops */
> 	else if (!--q->quiesce_depth)
> 		run_queue = true;

OK.


Thanks,
Ming

