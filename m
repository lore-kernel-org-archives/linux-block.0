Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40794C2B9F4
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 21:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B8D61209
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 21:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhFNV7Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jun 2021 17:59:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42367 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230113AbhFNV6m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jun 2021 17:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623707798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1i9G9aaOTXhmmdYhAqrQITiRmEjz9EDuDK7cCkO/Jp0=;
        b=YDRKfrqzk4H6/dt/s4YGXdv5Met/Y4++xfyX3ijZEXlKWOvbi5/3HPCTXwV56FAdY5VZpM
        HtvbkkqluT34lVQKi1scCgZbz+Lk1dVWbVP/jAMPrXa8su+lzKB+2QCB6z7HP2+ik3KP4h
        ei74TrnV/Rbpk9oso+S4byU54tl1MbI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-qHyAz7F4Of22FgrCf6sqfw-1; Mon, 14 Jun 2021 17:56:34 -0400
X-MC-Unique: qHyAz7F4Of22FgrCf6sqfw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E64AC1850606;
        Mon, 14 Jun 2021 21:56:33 +0000 (UTC)
Received: from T590 (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E3D110023B5;
        Mon, 14 Jun 2021 21:56:27 +0000 (UTC)
Date:   Tue, 15 Jun 2021 05:56:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH V2] blk-mq: update hctx->dispatch_busy in case of real
 scheduler
Message-ID: <YMfQh/eWzsbejQlL@T590>
References: <20210604000915.192286-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604000915.192286-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 04, 2021 at 08:09:15AM +0800, Ming Lei wrote:
> Commit 6e6fcbc27e77 ("blk-mq: support batching dispatch in case of io")
> starts to support io batching submission by using hctx->dispatch_busy.
> 
> However, blk_mq_update_dispatch_busy() isn't changed to update hctx->dispatch_busy
> in that commit, so fix the issue by updating hctx->dispatch_busy in case
> of real scheduler.
> 
> Reported-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Fixes: 6e6fcbc27e77 ("blk-mq: support batching dispatch in case of io")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Hello Jens,

Can you merge this patch if you are fine?

thanks,
Ming

