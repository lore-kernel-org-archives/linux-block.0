Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14C8C433B4
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 15:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B70161492
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 15:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhEKPYp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 May 2021 11:24:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31398 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231793AbhEKPYo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 May 2021 11:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620746617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VoJ5+ox4eIRG3plXwjrIUU+GnCRQiuWnzu/8Z+52gBw=;
        b=XAVrpqDfx7vgmxs2oZsOLlCWM4mQgw6tGBMILZ0t8VPcShTNmex3Rn50HPaW76rERbMYna
        hY20v4jFyxHRHUAevJJMxqFUdCA6oySQDwk+hr58oWulJL4KKLMpfVSXjz0Ijo5vpDhZSa
        5cyJcANtAhjPNL2WMpSvCRkjC+371fs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-hzpTpgSLPNSMRFkVvGZVbA-1; Tue, 11 May 2021 11:22:50 -0400
X-MC-Unique: hzpTpgSLPNSMRFkVvGZVbA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 260C86D585;
        Tue, 11 May 2021 15:22:47 +0000 (UTC)
Received: from localhost (ovpn-12-205.pek2.redhat.com [10.72.12.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E85B648A0;
        Tue, 11 May 2021 15:22:42 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        Christoph Hellwig <hch@lst.de>,
        David Jeffery <djeffery@redhat.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V7 0/4] blk-mq: fix request UAF related with iterating over tagset requests
Date:   Tue, 11 May 2021 23:22:32 +0800
Message-Id: <20210511152236.763464-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

V7:
	- fix one null-ptr-deref during updating nr_hw_queues, because
	blk_mq_clear_flush_rq_mapping() may touch non-mapped hw queue's
	tags, only patch 4/4 is modified, reported and verified by
	Shinichiro Kawasaki
	- run blktests and not see regression

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
 block/blk-mq-tag.c | 49 ++++++++++++++++++------
 block/blk-mq-tag.h |  6 +++
 block/blk-mq.c     | 95 ++++++++++++++++++++++++++++++++++++++++------
 block/blk-mq.h     |  1 +
 5 files changed, 130 insertions(+), 24 deletions(-)

-- 
2.29.2

