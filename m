Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CDDC04FF3
	for <linux-block@archiver.kernel.org>; Mon, 24 May 2021 15:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D3F861209
	for <linux-block@archiver.kernel.org>; Mon, 24 May 2021 15:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbhEXPC7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 May 2021 11:02:59 -0400
Received: from verein.lst.de ([213.95.11.211]:54895 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233846AbhEXPA6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 May 2021 11:00:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5699267373; Mon, 24 May 2021 16:59:28 +0200 (CEST)
Date:   Mon, 24 May 2021 16:59:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, slp@redhat.com,
        sgarzare@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/3] virtio_blk: implement blk_mq_ops->poll()
Message-ID: <20210524145928.GA3873@lst.de>
References: <20210520141305.355961-1-stefanha@redhat.com> <20210520141305.355961-4-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520141305.355961-4-stefanha@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 20, 2021 at 03:13:05PM +0100, Stefan Hajnoczi wrote:
> Possible drawbacks of this approach:
> 
> - Hardware virtio_blk implementations may find virtqueue_disable_cb()
>   expensive since it requires DMA. If such devices become popular then
>   the virtio_blk driver could use a similar approach to NVMe when
>   VIRTIO_F_ACCESS_PLATFORM is detected in the future.
> 
> - If a blk_poll() thread is descheduled it not only hurts polling
>   performance but also delays completion of non-REQ_HIPRI requests on
>   that virtqueue since vq notifications are disabled.

Yes, I think this is a dangerous configuration.  What argument exists
again just using dedicated poll queues?
