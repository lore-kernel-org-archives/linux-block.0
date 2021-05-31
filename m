Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAA5C47092
	for <linux-block@archiver.kernel.org>; Mon, 31 May 2021 01:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ED7B61220
	for <linux-block@archiver.kernel.org>; Mon, 31 May 2021 01:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhEaBjB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 May 2021 21:39:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41305 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229891AbhEaBi7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 May 2021 21:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622425040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p4jMBwiXr0kxR7AZUOhY+iK/CXw5hKwlo43jf2axMLY=;
        b=R1kiT83H6RSoek9EeDuL2A4oyqjNSLJ/Z0cSliLc2mo6TDPJt7tDnnlbL/F7F6dwFDnLDt
        bQJ5ltrX4mT5To89ARaL+ihL+DgSBNbg3SawlQsPCN+4AQuedTSlg46lBIJdXYv16RB7J8
        B25xwLtz4GOFudXXLD67PhhN+xGbvBI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-9WF8DQl1PGubXbI2Lh4xDw-1; Sun, 30 May 2021 21:37:16 -0400
X-MC-Unique: 9WF8DQl1PGubXbI2Lh4xDw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22C5F801817;
        Mon, 31 May 2021 01:37:15 +0000 (UTC)
Received: from T590 (ovpn-12-79.pek2.redhat.com [10.72.12.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FE9110023AF;
        Mon, 31 May 2021 01:37:05 +0000 (UTC)
Date:   Mon, 31 May 2021 09:37:01 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-mq: update hctx->dispatch_busy in case of real
 scheduler
Message-ID: <YLQ9vdTarVAA+y+Z@T590>
References: <20210528032055.2242080-1-ming.lei@redhat.com>
 <20210528122631.GA28653@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528122631.GA28653@quack2.suse.cz>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 28, 2021 at 02:26:31PM +0200, Jan Kara wrote:
> On Fri 28-05-21 11:20:55, Ming Lei wrote:
> > Commit 6e6fcbc27e77 ("blk-mq: support batching dispatch in case of io")
> > starts to support io batching submission by using hctx->dispatch_busy.
> > 
> > However, blk_mq_update_dispatch_busy() isn't changed to update hctx->dispatch_busy
> > in that commit, so fix the issue by updating hctx->dispatch_busy in case
> > of real scheduler.
> > 
> > Reported-by: Jan Kara <jack@suse.cz>
> > Fixes: 6e6fcbc27e77 ("blk-mq: support batching dispatch in case of io")
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq.c | 3 ---
> >  1 file changed, 3 deletions(-)
> 
> Looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> BTW: Do you plan to submit also your improvement to
> __blk_mq_do_dispatch_sched() to update dispatch_busy during the fetching
> requests from the scheduler to avoid draining all requests from the IO
> scheduler?

I understand that kind of change isn't needed. When more requests are
dequeued, hctx->dispatch_busy will be updated, then __blk_mq_do_dispatch_sched()
won't dequeue at batch any more if either .queue_rq() returns
STS_RESOURCE or running out of driver tag/budget.

Or do you still see related issues after this patch is applied?

Thanks,
Ming

