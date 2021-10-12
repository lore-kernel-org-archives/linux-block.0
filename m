Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218B0C433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 15:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0438E61076
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 15:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhJLPEh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 11:04:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29384 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237338AbhJLPEg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 11:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634050954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H5n0vZXzpKUr4bdvWBgiF2GxyHPbprOqb+7u3O+dEug=;
        b=OZXaj8MdraQzsfikS35WDWRJLzHZNmv7WK/bVKyH6/cUTxz4CnP+963Bx85R8bjPLg3jfO
        YeF7EPP7XfFddM3DxtqEp2ZfHtv1Y6XwHoau7AHYjqDtiN3P32Ct6F7YTDC1wndbGD5hjC
        o3t9LrLH9OCbKMBPalTkcFXFRIOKj7E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-jiS4h6U3MFWVJ22ABzKX0Q-1; Tue, 12 Oct 2021 11:02:31 -0400
X-MC-Unique: jiS4h6U3MFWVJ22ABzKX0Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 856CF80158D;
        Tue, 12 Oct 2021 15:02:29 +0000 (UTC)
Received: from T590 (ovpn-8-34.pek2.redhat.com [10.72.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CCE82B060;
        Tue, 12 Oct 2021 15:02:24 +0000 (UTC)
Date:   Tue, 12 Oct 2021 23:01:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V3 4/6] nvme: paring quiesce/unquiesce
Message-ID: <YWWjXN3GEzypVFZ/@T590>
References: <20211009034713.1489183-1-ming.lei@redhat.com>
 <20211009034713.1489183-5-ming.lei@redhat.com>
 <20211012103620.GB29640@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012103620.GB29640@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 12, 2021 at 12:36:20PM +0200, Christoph Hellwig wrote:
> On Sat, Oct 09, 2021 at 11:47:11AM +0800, Ming Lei wrote:
> > The current blk_mq_quiesce_queue() and blk_mq_unquiesce_queue() always
> > stops and starts the queue unconditionally. And there can be concurrent
> > quiesce/unquiesce coming from different unrelated code paths, so
> > unquiesce may come unexpectedly and start queue too early.
> > 
> > Prepare for supporting concurrent quiesce/unquiesce from multiple
> > contexts, so that we can address the above issue.
> > 
> > NVMe has very complicated quiesce/unquiesce use pattern, add one atomic
> > bit for makeiing sure that blk-mq quiece/unquiesce is always called in
> > pair.
> 
> Can you explain the need for these bits a little more?  If they are
> unbalanced we should probably fix the root cause.
> 
> What issues did you see?

There are lots of unbalanced usage in nvme, such as

1) nvme pci:

- nvme_dev_disable() can be called more than one times before starting
reset, so multiple nvme_stop_queues() vs. single nvme_start_queues().

2) Forcibly unquiesce queues in nvme_kill_queues() even though queues
are never quiesced, and similar usage can be seen in tcp/fc/rdma too

Once the quiesce and unquiesce are run from difference context, it becomes
not easy to audit if the two is done in pair.



Thanks,
Ming

