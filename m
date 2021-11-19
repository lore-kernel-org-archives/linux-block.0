Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A32C433EF
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 08:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19C0161AA3
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 08:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhKSINa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Nov 2021 03:13:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54831 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230477AbhKSIN3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Nov 2021 03:13:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637309428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gET37+W1NLj9OEtiOS1TDk9Pd6SGaFZ7d16hynuXJnI=;
        b=Nj50AR6k823Ko3si6sV9QcTSnJcF8v/+eum/6v++/z1VWg8pVB1Q7F5zOkQi6KYYrc55/G
        keXKSHJVWqz0vSbkOuqxxYp2orjtvCGQd1VYllybhGC6Y2X8sLRcih/mKPSKzCQeGARlvg
        8wLJn4VPskJufd++Dd7WURQ9lam5VWA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-r6sukmb6Mx6PP1eWQM-AnA-1; Fri, 19 Nov 2021 03:10:26 -0500
X-MC-Unique: r6sukmb6Mx6PP1eWQM-AnA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D5B718125C1;
        Fri, 19 Nov 2021 08:10:25 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8644860854;
        Fri, 19 Nov 2021 08:10:08 +0000 (UTC)
Date:   Fri, 19 Nov 2021 16:10:03 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/5] blk-mq: move srcu from blk_mq_hw_ctx to request_queue
Message-ID: <YZdb2/XoJVJOa1r+@T590>
References: <20211119021849.2259254-1-ming.lei@redhat.com>
 <20211119021849.2259254-2-ming.lei@redhat.com>
 <a3192b20-fa76-0b64-a2a9-c0c337741156@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3192b20-fa76-0b64-a2a9-c0c337741156@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 18, 2021 at 08:30:49PM -0800, Bart Van Assche wrote:
> On 11/18/21 18:18, Ming Lei wrote:
> > +	bool			alloc_srcu;
> 
> I found the following statement multiple times in this patch:
> 
> WARN_ON_ONCE(q->alloc_srcu != !!(q->tag_set->flags & BLK_MQ_F_BLOCKING));
> 
> Does this mean that the new q->alloc_srcu member variable can be left out
> and that it can be replaced with the following test?
> 
> q->tag_set->flags & BLK_MQ_F_BLOCKING

q->tag_set can't be used anymore after blk_cleanup_queue() returns,
and we need the flag for freeing request_queue instance.

> 
> Please note that I'm not concerned about the memory occupied by this
> variable but only about avoiding redundancy.
> 
> If this variable is retained it probably should be renamed, e.g. "has_srcu"
> instead of "alloc_srcu".

Fine.


Thanks,
Ming

