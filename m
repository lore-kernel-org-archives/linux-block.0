Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1ABC2B9F4
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 22:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9EE1611AB
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 22:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhFNWC1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jun 2021 18:02:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53635 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230230AbhFNWC1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jun 2021 18:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623708023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ddD+oy1LjkaHMo9790Zfl1R4v4szraFoIOIFpJzJ3FQ=;
        b=LpOJ2dCRiLrKbmoFLQkiTGgjWb8RWMFhcXLBI19Ltw9LB/TVI+v+YC8seSrRNNNh4h5bPU
        qIZplwvCg1Grq/H/s+0BGIcBp73GhF/baLE27wVCY+Gb1oekQTMsH1IoK3He0bc3kRBYdr
        X86PJj7kXQ/QW65CX4r4nG4ZdLMjrnw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-F_szTMZiMLGnKpb7JtakuA-1; Mon, 14 Jun 2021 18:00:22 -0400
X-MC-Unique: F_szTMZiMLGnKpb7JtakuA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D23891850609;
        Mon, 14 Jun 2021 22:00:20 +0000 (UTC)
Received: from T590 (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F27F95D6A8;
        Mon, 14 Jun 2021 22:00:14 +0000 (UTC)
Date:   Tue, 15 Jun 2021 06:00:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org,
        Wang Shanker <shankerwangmiao@gmail.com>
Subject: Re: [PATCH 0/2] block: discard merge fix & improvement
Message-ID: <YMfRax3F8NQL4E9V@T590>
References: <20210609004556.46928-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609004556.46928-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 09, 2021 at 08:45:54AM +0800, Ming Lei wrote:
> Hello Guys,
> 
> The 1st patch fixes request merge for single-range discard request.
> 
> The 2nd one improves request merge for multi-range discard request,
> so that any continuous bios can be merged to one range.
> 
> 
> Ming Lei (2):
>   block: fix discard request merge
>   block: support bio merge for multi-range discard
> 
>  block/blk-merge.c          | 20 +++++++++------
>  drivers/block/virtio_blk.c |  9 ++++---
>  drivers/nvme/host/core.c   |  8 +++---
>  include/linux/blkdev.h     | 51 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 72 insertions(+), 16 deletions(-)
> 
> Cc: Wang Shanker <shankerwangmiao@gmail.com>

Hello Guys,

Ping...


Thanks,
Ming

