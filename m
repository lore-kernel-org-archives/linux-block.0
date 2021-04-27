Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D905C433ED
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 15:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67AA9613E5
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 15:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbhD0PLr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Apr 2021 11:11:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25393 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235466AbhD0PLp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Apr 2021 11:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619536261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=h001Afg41x838JMLVP3PGKAhiYpbjWeOdD90pJNr9Sc=;
        b=i/M5yozoG9G2tMgFqYeGSx+shnvDOBAriULXW2csTfyssbTMRsSaaZp0mboJbNOGoapHjL
        yWKhh+IhmFsjq/LD6EJWhRJrBtcG1dJKFJPvrDwkQJJ+uN+6r9xz/1RpT9FyQIZyKQpu5x
        EG7PqzLR5yXEM4FIsP8TEGNQlCzk6vU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-sFAOSSQtMLuvS2iB4uAypg-1; Tue, 27 Apr 2021 11:10:59 -0400
X-MC-Unique: sFAOSSQtMLuvS2iB4uAypg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EEE7107ACCD;
        Tue, 27 Apr 2021 15:10:58 +0000 (UTC)
Received: from localhost (ovpn-12-67.pek2.redhat.com [10.72.12.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 39CD45D6D5;
        Tue, 27 Apr 2021 15:10:53 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 0/3] blk-mq: fix request UAF related with iterating over tagset requests
Date:   Tue, 27 Apr 2021 23:10:55 +0800
Message-Id: <20210427151058.2833168-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This patchset fixes the request UAF issue by one simple approach,
without clearing ->rqs[] in fast path.

1) grab request's ref before calling ->fn in blk_mq_tagset_busy_iter,
and release it after calling ->fn, so ->fn won't be called for one
request if its queue is frozen, done in 2st patch

2) clearing any stale request referred in ->rqs[] before freeing the
request pool, one per-tags spinlock is added for protecting
grabbing request ref vs. clearing ->rqs[tag], so UAF by refcount_inc_not_zero
in bt_tags_iter() is avoided, done in 3rd patch.

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


Ming Lei (3):
  block: avoid double io accounting for flush request
  blk-mq: grab rq->refcount before calling ->fn in
    blk_mq_tagset_busy_iter
  blk-mq: clear stale request in tags->rq[] before freeing one request
    pool

 block/blk-flush.c  |  3 +--
 block/blk-mq-tag.c | 29 +++++++++++++++++++------
 block/blk-mq-tag.h |  3 +++
 block/blk-mq.c     | 53 +++++++++++++++++++++++++++++++++++++---------
 block/blk-mq.h     |  1 +
 5 files changed, 71 insertions(+), 18 deletions(-)

-- 
2.29.2

