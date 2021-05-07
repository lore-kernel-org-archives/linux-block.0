Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1067FC433B4
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 14:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC61B61026
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 14:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbhEGOn0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 May 2021 10:43:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38054 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233545AbhEGOn0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 May 2021 10:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620398546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IGVQZsQ/uznJDxSv7/vseNJU1hvIQkaqJDtE/W6EOGo=;
        b=a4rUkFqk/EahU6EyfXgkrXsQSmrcvjWHhw71bO1/crMpkHeSSQlqN51WfGDnwlKaxVRiig
        LgLGJIpq9ALDJax5gVQ1ZB+ZgkjjreauDEre4fLbgA8E+IrWan5LfH32N4I3Ovi1JwukuM
        vl08uyfXRBtVetg4K08Lsp5xtNlxwrk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-bdvkWK1rMI2TTu3iXWkf7g-1; Fri, 07 May 2021 10:42:24 -0400
X-MC-Unique: bdvkWK1rMI2TTu3iXWkf7g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29DD8100A605;
        Fri,  7 May 2021 14:42:22 +0000 (UTC)
Received: from localhost (ovpn-12-110.pek2.redhat.com [10.72.12.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC4FA5D6A1;
        Fri,  7 May 2021 14:42:15 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        Christoph Hellwig <hch@lst.de>,
        David Jeffery <djeffery@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 0/4] blk-mq: fix request UAF related with iterating over tagset requests
Date:   Fri,  7 May 2021 22:42:04 +0800
Message-Id: <20210507144208.459139-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This patchset fixes the request UAF issue by one simple approach,
without clearing ->rqs[] in fast path, please consider it for 5.13.

1) grab request's ref before calling ->fn in blk_mq_tagset_busy_iter,
and release it after calling ->fn, so ->fn won't be called for one
request if its queue is frozen, done in 2st patch

2) clearing any stale request referred in ->rqs[] before freeing the
request pool, one per-tags spinlock is added for protecting
grabbing request ref vs. clearing ->rqs[tag], so UAF by refcount_inc_not_zero
in bt_tags_iter() is avoided, done in 3rd patch.

V6:
	- hold spin lock when reading rq via ->rq[tag_bit], the issue is
	  added in V5
	- make blk_mq_find_and_get_req() more clean, as suggested by Bart
	- not hold tags->lock when clearing ->rqs[] for avoiding to disable
	interrupt a bit long, as suggested by Bart
	- code style change, as suggested by Christoph

V5:
	- cover bt_iter() by same approach taken in bt_tags_iter(), and pass
	John's invasive test
	- add tested-by/reviewed-by tag

V4:
	- remove hctx->fq-flush_rq from tags->rqs[] before freeing hw queue,
	patch 4/4 is added, which is based on David's patch.

V3:
	- drop patches for completing requests started in iterator ->fn,
	  because blk-mq guarantees that valid request is passed to ->fn,
	  and it is driver's responsibility for avoiding double completion.
	  And drivers works well for not completing rq twice.
	- add one patch for avoiding double accounting of flush rq 

V2:
	- take Bart's suggestion to not add blk-mq helper for completing
	  requests when it is being iterated
	- don't grab rq->ref if the iterator is over static rqs because
	the use case do require to iterate over all requests no matter if
	the request is initialized or not

Ming Lei (4):
  block: avoid double io accounting for flush request
  blk-mq: grab rq->refcount before calling ->fn in
    blk_mq_tagset_busy_iter
  blk-mq: clear stale request in tags->rq[] before freeing one request
    pool
  blk-mq: clearing flush request reference in tags->rqs[]

 block/blk-flush.c  |  3 +-
 block/blk-mq-tag.c | 49 +++++++++++++++++++------
 block/blk-mq-tag.h |  6 +++
 block/blk-mq.c     | 91 ++++++++++++++++++++++++++++++++++++++++------
 block/blk-mq.h     |  1 +
 5 files changed, 126 insertions(+), 24 deletions(-)

-- 
2.29.2

