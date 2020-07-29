Return-Path: <SRS0=8JfY=BI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5798CC433DF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 10:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 355FD206D4
	for <linux-block@archiver.kernel.org>; Wed, 29 Jul 2020 10:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c0OaV45r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgG2K3M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jul 2020 06:29:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:40832 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726336AbgG2K3M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jul 2020 06:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596018550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DTN1gPMgXT8nr/fZROnfZjxJWLArqWdWGgPkYjBP6ew=;
        b=c0OaV45rNIchwYZ30d/GQDPhW5tESyIg9ag1Rwj3m0i4LziV6Zi6aGrTYpRhGuLkTJrJjN
        6dUn9ULWj2Q8An1VaNjXL4I8lYYQm6mYDjmeGIPXO/H7APyOe7xlXQbEryc6W36h7p6TcM
        xikFvADhOBTC36ez2tBq6uEYC3FgTx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-MKIWmZk4NXmOR8dhqeAJQg-1; Wed, 29 Jul 2020 06:29:08 -0400
X-MC-Unique: MKIWmZk4NXmOR8dhqeAJQg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 066328005B0;
        Wed, 29 Jul 2020 10:29:07 +0000 (UTC)
Received: from T590 (ovpn-12-176.pek2.redhat.com [10.72.12.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0955160CD1;
        Wed, 29 Jul 2020 10:28:59 +0000 (UTC)
Date:   Wed, 29 Jul 2020 18:28:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [RFC PATCH] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
Message-ID: <20200729102856.GA1563056@T590>
References: <20200728134938.1505467-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728134938.1505467-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 28, 2020 at 09:49:38PM +0800, Ming Lei wrote:
> In case of BLK_MQ_F_BLOCKING, blk-mq uses SRCU to mark read critical
> section during dispatching request, then request queue quiesce is based on
> SRCU. What we want to get is low cost added in fast path.
> 
> However, from srcu_read_lock/srcu_read_unlock implementation, not see
> it is quicker than percpu refcount, so use percpu_ref to implement
> queue quiesce. This usage is cleaner and simpler & enough for implementing
> queue quiesce. The main requirement is to make sure all read sections to observe
> QUEUE_FLAG_QUIESCED once blk_mq_quiesce_queue() returns.
> 
> Also it becomes much easier to add interface of async queue quiesce.

BTW, no obvious IOPS difference is observed with this patch applied when running
io on null_blk(blocking, submit_queues=32) in one dual-socket, 32cores system.


Thanks,
Ming

