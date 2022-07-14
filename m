Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86253C43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 14:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbiGNOEV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 10:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240210AbiGNODw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 10:03:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1279C68722
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 07:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657807349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6QYZlWgKvOmDYqDcaHeClyQ51SBKpweqKujva4DH75s=;
        b=bbw36vwya3Ejdbcq28xV3RW33EhIujTaGI5HFW+Kf/9d/P7V8O2PlkAcAtDAGj13Jm1WmZ
        6w9YiNQRU3k9OcPKfIbW4KapPnNZ+Hd9mbff7LLCzKApSaSUu812MbQ9L6zgaQmAcJxbkF
        AyOAH+DmFeOufV0t4Rn2+SrqjUJoQMg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-xRxGwtnOOgyvo7bWGDIpuA-1; Thu, 14 Jul 2022 10:02:28 -0400
X-MC-Unique: xRxGwtnOOgyvo7bWGDIpuA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0869885A588;
        Thu, 14 Jul 2022 14:02:28 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C44D3492CA2;
        Thu, 14 Jul 2022 14:02:24 +0000 (UTC)
Date:   Thu, 14 Jul 2022 22:02:19 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: [PATCH] ublk_drv: fix request queue leak
Message-ID: <YtAh65vJeVZ9l3mD@T590>
References: <20220714103201.131648-1-ming.lei@redhat.com>
 <YtAWhRdXrumYEsU+@infradead.org>
 <YtAYGMvQ+N4RsJRG@T590>
 <YtAYwH45Ewy3+aLr@infradead.org>
 <YtAZgYh54V/CDNG+@T590>
 <YtAcBnGodvCUtaRP@T590>
 <YtAgUFZgEONO3P3s@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtAgUFZgEONO3P3s@infradead.org>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 14, 2022 at 06:55:28AM -0700, Christoph Hellwig wrote:
> On Thu, Jul 14, 2022 at 09:37:10PM +0800, Ming Lei wrote:
> > It is actually one big problem of 6f8191fdf41d ("block: simplify disk shutdown")
> > since blk_put_queue() can't do what blk_cleanup_queue() did.
> > 
> > Anywhere using blk_put_queue() to release blk-mq queue before adding
> > disk has the same issue.
> 
> And the reason why blk_put_queue can't do is seems to be mostly because
> queues don't hold a reference on the tag set (and tag_sets don't have

Exactly.

> a reference at all).  Which has caused us a bunch of issues before, so
> let me see if I can fix that properly.

I guess it is hard to fix, not get any idea yet. Originally we stop to
referring tagset after blk_cleanup_queue(), but now you are trying to
kill blk_cleanup_queue()...


thanks,
Ming

