Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB72C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Jul 2022 15:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240110AbiGTPdp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jul 2022 11:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237384AbiGTPdo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jul 2022 11:33:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6602861B29
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 08:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658331222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nix0PQL9qtzLzsUTpE20kk7FKnhmpL1WAxaeHOQWKu8=;
        b=WOD9/1Ke32F+7+jEbTiTYkR1pHGdSaZq6q0tK5iA/K1CtfOusJc9sBmSEhs/nYq58+bINq
        PbayDcf95fQ58UrRK8NTgZU690hG+fG1U5T0yaZv5A1wXdbx8IY1ZxQv1zp3CjqQicykg8
        l77onTJXfBOKfTCmNW356ye2ftx1LBM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-S1sgl2rvN3KmbOVB4T5HNQ-1; Wed, 20 Jul 2022 11:33:33 -0400
X-MC-Unique: S1sgl2rvN3KmbOVB4T5HNQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32618803918;
        Wed, 20 Jul 2022 15:33:33 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CDB5A492C3B;
        Wed, 20 Jul 2022 15:33:29 +0000 (UTC)
Date:   Wed, 20 Jul 2022 23:33:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH 2/2] Revert "ublk_drv: fix request queue leak"
Message-ID: <YtggRH5AJpKYmmwt@T590>
References: <20220718062928.335399-1-hch@lst.de>
 <20220718062928.335399-2-hch@lst.de>
 <YtalgzqC/q3JpYCR@T590>
 <20220720060705.GB6734@lst.de>
 <YtezD/apQ1dM0n33@T590>
 <20220720090040.GA18210@lst.de>
 <YtfXmlbhN9WAPK71@T590>
 <20220720130845.GA11940@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720130845.GA11940@lst.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 20, 2022 at 03:08:45PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 20, 2022 at 06:23:22PM +0800, Ming Lei wrote:
> > Even though alloc_disk and add_disk is paired here, GD_OWNS_QUEUE still
> > can't be set because request queue has to be workable for the new alloc/
> > added disk, just like scsi.
> 
> How so?  dm has totally normall disk/request_queue lifetimes.  The only
> caveat is that the blk-mq bits of the queue are added after the initial
> non-mq disk allocation.  There is no newly added disk after the disk
> and queue are torn down.

I meant that request queue is supposed to be low level stuff for implementing
disk function, and request queue hasn't to be released and re-allocated
after each disk whole lifetime(alloc disk, add disk, del_gendisk, release disk).

IMO, the limit is just from GD_OWNS_QUEUE which moves releasing some queue
resource into del_gendisk or disk release(as the fixes you posted), and this
way is fragile, frankly speaking. In theory, allocating queue and releasing
queue should be completely symmetrical, but GD_OWNS_QUEUE does change this way.

And GD_OWNS_QUEUE can't be set for SCSI, so the two modes have to be
supported by block layer.

Thanks,
Ming

