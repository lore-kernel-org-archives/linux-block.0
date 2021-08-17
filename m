Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AFBC4338F
	for <linux-block@archiver.kernel.org>; Tue, 17 Aug 2021 00:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3312B60295
	for <linux-block@archiver.kernel.org>; Tue, 17 Aug 2021 00:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbhHQA7x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Aug 2021 20:59:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47687 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232771AbhHQA7w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 20:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629161959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VKXDnAdzRM3i95od7keaaRdwJayELZosTyR9D3D4I0E=;
        b=JJxH2kubQh8+P8+ywM8HqmLZWNHp1y/N6ZX3QPweIzY1QbmxFTQOqmA19KLHKHeNKOP/fq
        bLo5v6ZfJMeamUWzu8OR2a/2qci1b+TmfjHfxm2V+gkC4UIykG6MeV2ySdomPLYUXAbk4v
        Q8Ia8U7EXuO4QJxxpN1CLTJ4kPobSGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-qUmV0UKPN7mZV--mzOp3vQ-1; Mon, 16 Aug 2021 20:59:16 -0400
X-MC-Unique: qUmV0UKPN7mZV--mzOp3vQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B65CF801AEB;
        Tue, 17 Aug 2021 00:59:14 +0000 (UTC)
Received: from T590 (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CDD35D6A8;
        Tue, 17 Aug 2021 00:59:04 +0000 (UTC)
Date:   Tue, 17 Aug 2021 08:58:59 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>,
        "Blank-Burian, Markus, Dr." <blankburian@uni-muenster.de>
Subject: Re: [PATCH] blk-mq: fix kernel panic during iterating over flush
 request
Message-ID: <YRsJ00t5XDdlebcW@T590>
References: <20210811142624.618598-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811142624.618598-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 11, 2021 at 10:26:24PM +0800, Ming Lei wrote:
> For fixing use-after-free during iterating over requests, we grabbed
> request's refcount before calling ->fn in commit 2e315dc07df0 ("blk-mq:
> grab rq->refcount before calling ->fn in blk_mq_tagset_busy_iter").
> Turns out this way may cause kernel panic when iterating over one flush
> request:
> 
> 1) old flush request's tag is just released, and this tag is reused by
> one new request, but ->rqs[] isn't updated yet
> 
> 2) the flush request can be re-used for submitting one new flush command,
> so blk_rq_init() is called at the same time
> 
> 3) meantime blk_mq_queue_tag_busy_iter() is called, and old flush request
> is retrieved from ->rqs[tag]; when blk_mq_put_rq_ref() is called,
> flush_rq->end_io may not be updated yet, so NULL pointer dereference
> is triggered in blk_mq_put_rq_ref().
> 
> Fix the issue by calling refcount_set(&flush_rq->ref, 1) after
> flush_rq->end_io is set. So far the only other caller of blk_rq_init() is
> scsi_ioctl_reset() in which the request doesn't enter block IO stack and
> the request reference count isn't used, so the change is safe.
> 
> Fixes: 2e315dc07df0 ("blk-mq: grab rq->refcount before calling ->fn in
> blk_mq_tagset_busy_iter")
> Reported-by: "Blank-Burian, Markus, Dr." <blankburian@uni-muenster.de>
> Tested-by: "Blank-Burian, Markus, Dr." <blankburian@uni-muenster.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Hello Jens,

Ping...

Thanks,
Ming

