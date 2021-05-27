Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1A6C4708A
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 02:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEC51613D4
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 02:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbhE0Cq4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 22:46:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32663 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229500AbhE0Cqz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 22:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622083523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EWkYWiPlwYnDMl1EMPoJ122fbcn5PIsDKJeTg6UCCSE=;
        b=Jqk1f/entw0HMlsyq/fp1lNOKn+wrRPsa+MZkktEoohN06hLpJp+SfynKdFXdaXo+aw6FT
        vkc0NYu7mjzQUYmdAgX0SzQ9MnzvAN7UtS+adXMoFVivlEVJ2d4N5MIauLqH2Aa0L2fWIN
        r+ej0ETCoeFtBa80Srb04rmeRg35rvQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-4SezU8kSNVmSpV2_om6GiQ-1; Wed, 26 May 2021 22:45:19 -0400
X-MC-Unique: 4SezU8kSNVmSpV2_om6GiQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4455C1883528;
        Thu, 27 May 2021 02:45:18 +0000 (UTC)
Received: from T590 (ovpn-12-72.pek2.redhat.com [10.72.12.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 712615C27C;
        Thu, 27 May 2021 02:44:55 +0000 (UTC)
Date:   Thu, 27 May 2021 10:44:51 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, slp@redhat.com,
        sgarzare@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/3] virtio_blk: implement blk_mq_ops->poll()
Message-ID: <YK8Ho3mC117M8GXS@T590>
References: <20210520141305.355961-1-stefanha@redhat.com>
 <20210520141305.355961-4-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520141305.355961-4-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 20, 2021 at 03:13:05PM +0100, Stefan Hajnoczi wrote:
> Request completion latency can be reduced by using polling instead of
> irqs. Even Posted Interrupts or similar hardware support doesn't beat
> polling. The reason is that disabling virtqueue notifications saves
> critical-path CPU cycles on the host by skipping irq injection and in
> the guest by skipping the irq handler. So let's add blk_mq_ops->poll()
> support to virtio_blk.
> 
> The approach taken by this patch differs from the NVMe driver's
> approach. NVMe dedicates hardware queues to polling and submits
> REQ_HIPRI requests only on those queues. This patch does not require
> exclusive polling queues for virtio_blk. Instead, it switches between
> irqs and polling when one or more REQ_HIPRI requests are in flight on a
> virtqueue.
> 
> This is possible because toggling virtqueue notifications is cheap even
> while the virtqueue is running. NVMe cqs can't do this because irqs are
> only enabled/disabled at queue creation time.
> 
> This toggling approach requires no configuration. There is no need to
> dedicate queues ahead of time or to teach users and orchestration tools
> how to set up polling queues.

This approach looks good, and very neat thanks per-vq lock.

BTW, is there any virt-exit saved by disabling vq interrupt? I understand
there isn't since virt-exit may only be involved in remote completion
via sending IPI.

> 
> Possible drawbacks of this approach:
> 
> - Hardware virtio_blk implementations may find virtqueue_disable_cb()
>   expensive since it requires DMA. If such devices become popular then

You mean the hardware need to consider order between DMA completion and
interrupt notify? But it is disabling notify, guest just calls
virtqueue_get_buf() to see if there is buffer available, if not, it will be
polled again.

>   the virtio_blk driver could use a similar approach to NVMe when
>   VIRTIO_F_ACCESS_PLATFORM is detected in the future.
> 
> - If a blk_poll() thread is descheduled it not only hurts polling
>   performance but also delays completion of non-REQ_HIPRI requests on
>   that virtqueue since vq notifications are disabled.
> 
> Performance:
> 
> - Benchmark: fio ioengine=pvsync2 numjobs=4 direct=1
> - Guest: 4 vCPUs with one virtio-blk device (4 virtqueues)

4 jobs can consume up all 4 vCPUs. Just run a quick fio test with
'ioengine=io_uring --numjobs=1' on single vq, and IOPS can be improved
by ~20%(hipri=1 vs hipri=0) with the 3 patches, and the virtio-blk is
still backed on NVMe SSD.


Thanks, 
Ming

