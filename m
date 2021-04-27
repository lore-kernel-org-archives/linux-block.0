Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1F7C433B4
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 01:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87C396127A
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 01:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhD0BrG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 21:47:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40569 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232295AbhD0BrG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 21:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619487983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QsveBYzJsfmgWSnd0BcWbmWkWY9QcKoN/Dis9wkhIOQ=;
        b=Pq6B/it+HoaESDb3rAGW60r2/h7byDxFaxgc37dVMC9fEOmt4wrK7b3/Yu03519KmBcx73
        MPAvxibuMKBe+Z3ZSIxjc31zBLOIYBxSDdFwX/VdE2lo2nbZGXrmtDgvqfMaZ2kytyTMda
        ofK8lnlNwqu/dJNaA75YS9Fv2P0lnCU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-pJFC5dHoPdumJBvZtjWt_g-1; Mon, 26 Apr 2021 21:46:20 -0400
X-MC-Unique: pJFC5dHoPdumJBvZtjWt_g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19E2A10A8078;
        Tue, 27 Apr 2021 01:45:58 +0000 (UTC)
Received: from localhost (ovpn-12-63.pek2.redhat.com [10.72.12.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82E921045D02;
        Tue, 27 Apr 2021 01:45:52 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/3] blk-mq: fix request UAF related with iterating over tagset requests
Date:   Tue, 27 Apr 2021 09:45:37 +0800
Message-Id: <20210427014540.2747282-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Guys,

This patchset fixes the request UAF issue by one simple approach,
without clearing ->rqs[] in fast path.

1) grab request's ref before calling ->fn in blk_mq_tagset_busy_iter,
and release it after calling ->fn, so ->fn won't be called for one
request if its queue is frozen, done in 1st patch

2) always complete request synchronously when the completing is run
via blk_mq_tagset_busy_iter(), done in 2nd patch

3) clearing any stale request referred in ->rqs[] before freeing the
request pool, one per-tags spinlock is added for protecting
grabbing request ref vs. clearing ->rqs[tag], so UAF by refcount_inc_not_zero
in bt_tags_iter() is avoided, done in 3rd patch.


V2:
	- take Bart's suggestion to not add blk-mq helper for completing
	  requests when it is being iterated
	- don't grab rq->ref if the iterator is over static rqs because
	the use case do require to iterate over all requests no matter if
	the request is initialized or not

Ming Lei (3):
  blk-mq: grab rq->refcount before calling ->fn in
    blk_mq_tagset_busy_iter
  blk-mq: complete request locally if the completion is from tagset
    iterator
  blk-mq: clear stale request in tags->rq[] before freeing one request
    pool

 block/blk-mq-tag.c     | 33 ++++++++++++++++++-----
 block/blk-mq-tag.h     |  3 +++
 block/blk-mq.c         | 61 +++++++++++++++++++++++++++++++++++-------
 block/blk-mq.h         |  1 +
 include/linux/blkdev.h |  2 ++
 5 files changed, 84 insertions(+), 16 deletions(-)

-- 
2.29.2

