Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1068C2B9F8
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 07:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7652A61419
	for <linux-block@archiver.kernel.org>; Tue, 25 May 2021 07:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhEYHku (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 May 2021 03:40:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39037 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231671AbhEYHkt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 03:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621928359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jeWJ7HGi3jq6uRXU1bbWV9h6gPERN4k8ZMEjEkjKNkc=;
        b=i+PODPJNdkRbppd/fRtTT4Grvms1TDF1uNz1C9VfW6Z50w9u/5DcBo+GUhVGRltiQoNG7j
        KRQJYiv4koxs1DE9bwswYGpDCQqD4kNt4QyXJzCjpYZ2H62hw/BDaHqX493Cypmn3sZI+q
        FXdnfJcDQw7FX9jumZEmK1Yq8irZfOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-S4dYbxgOOQe4yMwIJ2HYlw-1; Tue, 25 May 2021 03:39:15 -0400
X-MC-Unique: S4dYbxgOOQe4yMwIJ2HYlw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8684F1009465;
        Tue, 25 May 2021 07:39:14 +0000 (UTC)
Received: from T590 (ovpn-13-203.pek2.redhat.com [10.72.13.203])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C5E3A60BF1;
        Tue, 25 May 2021 07:38:47 +0000 (UTC)
Date:   Tue, 25 May 2021 15:38:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        slp@redhat.com, sgarzare@redhat.com,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/3] virtio_blk: implement blk_mq_ops->poll()
Message-ID: <YKypgi2qcYVTgYdv@T590>
References: <20210520141305.355961-1-stefanha@redhat.com>
 <20210520141305.355961-4-stefanha@redhat.com>
 <20210524145928.GA3873@lst.de>
 <7cc7f19b-34b3-1501-898d-3f41e047d766@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cc7f19b-34b3-1501-898d-3f41e047d766@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 25, 2021 at 09:22:48AM +0200, Paolo Bonzini wrote:
> On 24/05/21 16:59, Christoph Hellwig wrote:
> > On Thu, May 20, 2021 at 03:13:05PM +0100, Stefan Hajnoczi wrote:
> > > Possible drawbacks of this approach:
> > > 
> > > - Hardware virtio_blk implementations may find virtqueue_disable_cb()
> > >    expensive since it requires DMA. If such devices become popular then
> > >    the virtio_blk driver could use a similar approach to NVMe when
> > >    VIRTIO_F_ACCESS_PLATFORM is detected in the future.
> > > 
> > > - If a blk_poll() thread is descheduled it not only hurts polling
> > >    performance but also delays completion of non-REQ_HIPRI requests on
> > >    that virtqueue since vq notifications are disabled.
> > 
> > Yes, I think this is a dangerous configuration.  What argument exists
> > again just using dedicated poll queues?
> 
> There isn't an equivalent of the admin queue in virtio-blk, which would
> allow the guest to configure the desired number of poll queues.  The number
> of queues is fixed.

Dedicated vqs can be used for poll only, and I understand VM needn't to know
if the vq is polled or driven by IRQ in VM.

I tried that in v5.4, but not see obvious IOPS boost, so give up.

https://github.com/ming1/linux/commits/my_v5.4-virtio-irq-poll


Thanks,
Ming

