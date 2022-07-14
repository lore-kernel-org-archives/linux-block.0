Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA6BC43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 13:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238671AbiGNNUj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 09:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239633AbiGNNUh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 09:20:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4B2E5D0C6
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 06:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657804836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DviWdqb+C+RnzDO6G89zVi77bcLfAP41WMfjkVBLzDI=;
        b=d+HEYTvEC1Ezz+3qJPx2CDMbxHru7a0TLLnEH/Gw1W/6FRybm/Qa2LAclria6g2YRRbqB6
        IrJWY/eQsqWRRzjm9/irCPA+Z2oKaiGb23lRdVqJbP0VNKDHYIDPSGwz91VShTUkWWr7NW
        2dxhTYce98xsQGvFrIuIZ0/5/r3eDEQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-J-Y5v1bPNsmKxKeB5aVUoA-1; Thu, 14 Jul 2022 09:20:32 -0400
X-MC-Unique: J-Y5v1bPNsmKxKeB5aVUoA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6564D3C23DA0;
        Thu, 14 Jul 2022 13:20:32 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD1D1141511F;
        Thu, 14 Jul 2022 13:20:29 +0000 (UTC)
Date:   Thu, 14 Jul 2022 21:20:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] ublk_drv: fix request queue leak
Message-ID: <YtAYGMvQ+N4RsJRG@T590>
References: <20220714103201.131648-1-ming.lei@redhat.com>
 <YtAWhRdXrumYEsU+@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtAWhRdXrumYEsU+@infradead.org>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 14, 2022 at 06:13:41AM -0700, Christoph Hellwig wrote:
> On Thu, Jul 14, 2022 at 06:32:01PM +0800, Ming Lei wrote:
> > However, ublk may not add disk in case of starting device failure, then
> > del_gendisk() won't be called when removing ublk device, so blk_mq_exit_queue
> > will not be callsed, and it can be bit hard to deal with this kind of
> > merge conflict.
> 
> So base it on a tree that has everything you need.
> 
> > Turns out ublk's queue/disk use model is very similar with scsi, so switch
> > to scsi's model by allocating disk and queue independently, then it can be
> > quite easy to handle v5.20 merge conflict by replacing blk_cleanup_queue
> > with blk_mq_destroy_queue.
> 
> Don't do that.  That thing really is a workaround for the lack of admin
> queues in scsi.  Nothing newly designed should use it.  It will not
> allow to optimize things and cause maintainaince burden down the road.

The problem is that you moved part of blk_cleanup_queue() into
del_gendisk().

Here, the issue Jens reproduced is that we don't add disk yet, so won't
call del_gendisk(). The queue & disk is allocated & initialized correctly.

Then how to do the part done by original blk_cleanup_queue() without calling
blk_mq_destroy_queue()?


Thanks,
Ming

