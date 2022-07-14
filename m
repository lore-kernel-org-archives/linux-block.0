Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034FFC43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 13:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237959AbiGNN0q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 09:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiGNN0p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 09:26:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D336715FDC
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 06:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657805204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pePP+kGXeCoH9lPj84kbBS7UkYDeKYSXW/oA7q+oVas=;
        b=TsV6Vlss61cEZ70NlgNPi7M+2eaJITlk5Zqu08WqhDRHxUYkhPHz2Z+RyW1btcN6wNyLsk
        GMqyII7VXy8V4coYLa9ksIjmJvM85Gs+p/xRaf6PFqszVlfjhcCkD1Wjkp/QYT+W+MrIol
        GH9bsnqPGRKGCraDQM6vrYe/c4N1ycM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-lWi7TjuRNmWsn0GHfngUqA-1; Thu, 14 Jul 2022 09:26:35 -0400
X-MC-Unique: lWi7TjuRNmWsn0GHfngUqA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADBFD380114C;
        Thu, 14 Jul 2022 13:26:34 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D0F040E80E2;
        Thu, 14 Jul 2022 13:26:30 +0000 (UTC)
Date:   Thu, 14 Jul 2022 21:26:25 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] ublk_drv: fix request queue leak
Message-ID: <YtAZgYh54V/CDNG+@T590>
References: <20220714103201.131648-1-ming.lei@redhat.com>
 <YtAWhRdXrumYEsU+@infradead.org>
 <YtAYGMvQ+N4RsJRG@T590>
 <YtAYwH45Ewy3+aLr@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtAYwH45Ewy3+aLr@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 14, 2022 at 06:23:12AM -0700, Christoph Hellwig wrote:
> On Thu, Jul 14, 2022 at 09:20:24PM +0800, Ming Lei wrote:
> > The problem is that you moved part of blk_cleanup_queue() into
> > del_gendisk().
> > 
> > Here, the issue Jens reproduced is that we don't add disk yet, so won't
> > call del_gendisk(). The queue & disk is allocated & initialized correctly.
> > 
> > Then how to do the part done by original blk_cleanup_queue() without calling
> > blk_mq_destroy_queue()?
> 
> What do you need to clean up?  put_disk is supposed to eventually
> clean up everything allocated by blk_alloc_disk through disk_release.
> If it fails to cleanup anything that is a bug we need to fix in the core
> as it will affect all drivers.

The part to be cleaned up is nothing to do with disk:

                if (queue_is_mq(q))
                        blk_mq_exit_queue(q);

->exit_hctx() is called in blk_mq_exit_queue().

Without calling blk_mq_destroy_queue, I don't see other way to address
this issue, or suggestions?

Thanks,
Ming

