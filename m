Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA059C47096
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 01:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1DF3613E3
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 01:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhFDBYJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 21:24:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22671 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhFDBYJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Jun 2021 21:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622769744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aNgQp5Eo66crYUqMd0jTriz542Fx6DGFm1W5YzQhOxw=;
        b=fXqD/64DiQoldufL4kt7FqLFOxIneUeFafGuIfi6GaOfQdPgDjbm1m0ETvBnOY/MBIA1JU
        wz4t/m77twNM+/1j4fWt0f7kC2RgFZ11se63ndKSCz8+ieG8c3a4tj0hI2A0uLqmwlDgV5
        uiKsfqvSQ4mSTyvgXR0Jq601V9zM+jY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-ZQkmDysnNY60rlaXjm5d2Q-1; Thu, 03 Jun 2021 21:22:22 -0400
X-MC-Unique: ZQkmDysnNY60rlaXjm5d2Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1FF5425E9;
        Fri,  4 Jun 2021 01:22:21 +0000 (UTC)
Received: from T590 (ovpn-12-139.pek2.redhat.com [10.72.12.139])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B2AFF19C44;
        Fri,  4 Jun 2021 01:22:12 +0000 (UTC)
Date:   Fri, 4 Jun 2021 09:22:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH 2/4] block: move wbt allocation into blk_alloc_queue
Message-ID: <YLmAQIy7kkPqdTz1@T590>
References: <20210525080442.1896417-1-ming.lei@redhat.com>
 <20210525080442.1896417-3-ming.lei@redhat.com>
 <35a0f0b7-ad44-26cb-7fb7-d4f56241ff62@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35a0f0b7-ad44-26cb-7fb7-d4f56241ff62@acm.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 03, 2021 at 05:44:00PM -0700, Bart Van Assche wrote:
> On 5/25/21 1:04 AM, Ming Lei wrote:
> > wbt_init() calls wbt_alloc() which adds allocated wbt instance into
> > q->rq_qos. This way is very dangerous because q->rq_qos is accessed in
> > IO fast path.
> > 
> > So far wbt_init() is called in the two code paths:
> > 
> > 1) blk_register_queue(), when the block device has been exposed to
> > usespace, so IO may come when adding wbt into q->rq_qos
> > 
> > 2) sysfs attribute store, in which normal IO is definitely allowed
> > 
> > Move wbt allocation into blk_alloc_queue() for avoiding to add wbt
> > instance dynamically to q->rq_qos. And before calling wbt_init(), the
> > wbt is disabled, so functionally it works as expected.
> 
> I don't like this change since it is not generic - it only helps the WBT
> implementation.

OK, actually except for wbt, the only one left is iocost which adds
rq_qos via cgroup attribute. 

> 
> All rq-qos policies call rq_qos_add() and all these policies take effect
> before rq_qos_add() returns. Does the q->rq_qos list perhaps have to be
> protected with RCU? Would that be sufficient to fix the crashes reported
> in the cover letter?

Freezing queue should be easier for providing the protection, and I will try
that approach.


Thanks,
Ming

