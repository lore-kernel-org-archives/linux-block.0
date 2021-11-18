Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA45C433F5
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 02:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BE9160E8C
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 02:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241521AbhKRCSC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 21:18:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46157 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239811AbhKRCSB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 21:18:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637201701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jk7es7EBuR89ZVmscpFRRaESWUk8lcuAN/hpKsQZFFA=;
        b=SHPIDZpIcAWCaUTBU5VJo2IYOuGJramMR/cQpVRfXN3fKA07ifHrlxbkXrtuIwKlFumRHa
        +ZtdITlcMYB5xWuRm4wkz8fBWYhIX/vNB02GkCmRgMDN3frQQ7dv477Nq9/aQicgKfzmkz
        AXLadY3qqLtQiQFxD1Iv5EMf3Ddvmbo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-rhiWkNXsNbKx4y3FX_aI7A-1; Wed, 17 Nov 2021 21:14:59 -0500
X-MC-Unique: rhiWkNXsNbKx4y3FX_aI7A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48F9180197B;
        Thu, 18 Nov 2021 02:14:58 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 861F11037F39;
        Thu, 18 Nov 2021 02:14:42 +0000 (UTC)
Date:   Thu, 18 Nov 2021 10:14:37 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        hch@infradead.org, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/4] block: add mq_ops->queue_rqs hook
Message-ID: <YZW3DT0q4y3llSjc@T590>
References: <20211117033807.185715-1-axboe@kernel.dk>
 <20211117033807.185715-2-axboe@kernel.dk>
 <20211117204101.GA3295649@dhcp-10-100-145-180.wdc.com>
 <YZWb1TiNLBtdQrt6@T590>
 <YZW0M61sJNMQIRVZ@C02CK6ZVMD6M>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZW0M61sJNMQIRVZ@C02CK6ZVMD6M>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 17, 2021 at 07:02:27PM -0700, Keith Busch wrote:
> On Thu, Nov 18, 2021 at 08:18:29AM +0800, Ming Lei wrote:
> > On Wed, Nov 17, 2021 at 12:41:01PM -0800, Keith Busch wrote:
> > > On Tue, Nov 16, 2021 at 08:38:04PM -0700, Jens Axboe wrote:
> > > > If we have a list of requests in our plug list, send it to the driver in
> > > > one go, if possible. The driver must set mq_ops->queue_rqs() to support
> > > > this, if not the usual one-by-one path is used.
> > > 
> > > It looks like we still need to sync with the request_queue quiesce flag.
> > 
> > Basically it is same with my previous post[1], but the above patch doesn't
> > handle request queue allocation/freeing correctly in case of BLK_MQ_F_BLOCKING.
> 
> Thanks for the pointer. I also thought it may be just as well that blocking
> dispatchers don't get to use the optimized rqlist queueing,

Yeah, that is fine, but nvme-tcp may not benefit from the ->queue_rq() optimization.

> which would simplify quiesce to the normal rcu usage.

Normal dispatch code still need to check quiesced for blocking queue, so
srcu is still needed, not see easier way than srcu yet. Years ago, I
tried to replace the srcu with percpu-refcnt, which is still more
complicated than srcu, but srcu_index can be dropped.


Thanks,
Ming

