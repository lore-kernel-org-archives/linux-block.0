Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91587C433DB
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 03:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41BB664E9D
	for <linux-block@archiver.kernel.org>; Tue,  9 Feb 2021 03:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhBIDOU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Feb 2021 22:14:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60239 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229693AbhBIDNP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Feb 2021 22:13:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612840304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HLiqMW2n7YYtMYQAHHLQv7F6f639zWMgh5L7ZVOjcXI=;
        b=LACwDmZB0N2Suicgn9TagTnVE5Zrv836YnTuH/VjijGp6nj0uK7zSQyf3nvfin0MllQqSO
        GZKGAKR/7JPi1/59nJ0xOWcPFzmJawtOknRhmIcrctvcCkg9EtDAWy9okA8Y4eenrSjJm4
        XKcPpLFOTmdir1LzMenD6wc+Z26UHfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-8_ei_ySOMzu40yLQ1nxtkQ-1; Mon, 08 Feb 2021 22:11:42 -0500
X-MC-Unique: 8_ei_ySOMzu40yLQ1nxtkQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DC1A107ACE4;
        Tue,  9 Feb 2021 03:11:40 +0000 (UTC)
Received: from T590 (ovpn-13-86.pek2.redhat.com [10.72.13.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 45B205D6A8;
        Tue,  9 Feb 2021 03:11:26 +0000 (UTC)
Date:   Tue, 9 Feb 2021 11:11:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     snitzer@redhat.com, axboe@kernel.dk, joseph.qi@linux.alibaba.com,
        caspar@linux.alibaba.com, hch@lst.de, linux-block@vger.kernel.org,
        dm-devel@redhat.com, io-uring@vger.kernel.org
Subject: Re: [PATCH v3 09/11] dm: support IO polling for bio-based dm device
Message-ID: <20210209031122.GA63798@T590>
References: <20210208085243.82367-1-jefflexu@linux.alibaba.com>
 <20210208085243.82367-10-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208085243.82367-10-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 08, 2021 at 04:52:41PM +0800, Jeffle Xu wrote:
> DM will iterate and poll all polling hardware queues of all target mq
> devices when polling IO for dm device. To mitigate the race introduced
> by iterating all target hw queues, a per-hw-queue flag is maintained

What is the per-hw-queue flag?

> to indicate whether this polling hw queue currently being polled on or
> not. Every polling hw queue is exclusive to one polling instance, i.e.,
> the polling instance will skip this polling hw queue if this hw queue
> currently is being polled by another polling instance, and start
> polling on the next hw queue.

Not see such skip in dm_poll_one_dev() in which
queue_for_each_poll_hw_ctx() is called directly for polling all POLL
hctxs of the request queue, so can you explain it a bit more about this
skip mechanism?

Even though such skipping is implemented, not sure if good performance
can be reached because hctx poll may be done in ping-pong style
among several CPUs. But blk-mq hctx is supposed to have its cpu affinities.

-- 
Ming

