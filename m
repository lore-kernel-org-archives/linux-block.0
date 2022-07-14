Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCA5C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 13:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239293AbiGNNhb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 09:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbiGNNha (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 09:37:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2073F52882
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 06:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657805848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mok4BNH5oIuVwLnSTH9Oq+sxqjNhVUlcYIHZIcNcJOQ=;
        b=ev6IHZnf4GJg5HS1ttGa3sAPhJGBAUtTqEnUcC6P3zFjJHcZ89h8t5GnxhgeW8g4avPNyf
        +XWTwH+qBhcOxf0r+Qp4bk177GhSGayStw5wmBnXuYZ2bNuHw8K72k0lla76vr6K3/RYZd
        4TPRo9/gC39gRF9jiodX0QWc+N/uDnA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-0fC1df-kO-KqHn7VcRFSSw-1; Thu, 14 Jul 2022 09:37:19 -0400
X-MC-Unique: 0fC1df-kO-KqHn7VcRFSSw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF3C9804191;
        Thu, 14 Jul 2022 13:37:18 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E091F2026D64;
        Thu, 14 Jul 2022 13:37:15 +0000 (UTC)
Date:   Thu, 14 Jul 2022 21:37:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] ublk_drv: fix request queue leak
Message-ID: <YtAcBnGodvCUtaRP@T590>
References: <20220714103201.131648-1-ming.lei@redhat.com>
 <YtAWhRdXrumYEsU+@infradead.org>
 <YtAYGMvQ+N4RsJRG@T590>
 <YtAYwH45Ewy3+aLr@infradead.org>
 <YtAZgYh54V/CDNG+@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtAZgYh54V/CDNG+@T590>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 14, 2022 at 09:26:25PM +0800, Ming Lei wrote:
> On Thu, Jul 14, 2022 at 06:23:12AM -0700, Christoph Hellwig wrote:
> > On Thu, Jul 14, 2022 at 09:20:24PM +0800, Ming Lei wrote:
> > > The problem is that you moved part of blk_cleanup_queue() into
> > > del_gendisk().
> > > 
> > > Here, the issue Jens reproduced is that we don't add disk yet, so won't
> > > call del_gendisk(). The queue & disk is allocated & initialized correctly.
> > > 
> > > Then how to do the part done by original blk_cleanup_queue() without calling
> > > blk_mq_destroy_queue()?
> > 
> > What do you need to clean up?  put_disk is supposed to eventually
> > clean up everything allocated by blk_alloc_disk through disk_release.
> > If it fails to cleanup anything that is a bug we need to fix in the core
> > as it will affect all drivers.
> 
> The part to be cleaned up is nothing to do with disk:
> 
>                 if (queue_is_mq(q))
>                         blk_mq_exit_queue(q);
> 
> ->exit_hctx() is called in blk_mq_exit_queue().
> 
> Without calling blk_mq_destroy_queue, I don't see other way to address
> this issue, or suggestions?

It is actually one big problem of 6f8191fdf41d ("block: simplify disk shutdown")
since blk_put_queue() can't do what blk_cleanup_queue() did.

Anywhere using blk_put_queue() to release blk-mq queue before adding
disk has the same issue.


Thanks,
Ming

