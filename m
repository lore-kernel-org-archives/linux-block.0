Return-Path: <SRS0=Z7Y6=B6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06EFC433E1
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 18:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9139020758
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 18:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJDY1t8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHTSD6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Aug 2020 14:03:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23242 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725819AbgHTSD5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Aug 2020 14:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597946635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=j+L0uMKvowpmAd1FTiQMgUmXYdMhyZm4XOAPKpC3am4=;
        b=GJDY1t8EtW5PTe83cInhlHdEwITZJgBZIK/X6ZIWPldyYbfPQNmsCzp1BkbCA0k8Ztjk8x
        LOjh2efB4xb3RpQf2uUotX8NoVz2lbrjL0CkkKtVOv2zO80ged/AF1Wg+3vwHDMifx2YyJ
        gvtD9EnPOCZTL89jArac7GS2uqkBqDM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-2lvvEJkpM9iACDsUOXo3kw-1; Thu, 20 Aug 2020 14:03:51 -0400
X-MC-Unique: 2lvvEJkpM9iACDsUOXo3kw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C11C01074649;
        Thu, 20 Aug 2020 18:03:49 +0000 (UTC)
Received: from localhost (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE13A7B8F4;
        Thu, 20 Aug 2020 18:03:44 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/5] blk-mq: fix use-after-free on stale request
Date:   Fri, 21 Aug 2020 02:03:30 +0800
Message-Id: <20200820180335.3109216-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

We can't run allocating driver tag and updating tags->rqs[tag] atomically,
so stale request may be retrieved from tags->rqs[tag]. More seriously, the
stale request may have been freed via updating nr_requests or switching
elevator or other use cases.

It is one long-term issue, and Jianchao previous worked towards using
static_rqs[] for iterating request, one problem is that it can be hard
to use when iterating over tagset.

This patchset takes another different approach for fixing the issue: cache
freed rqs pages and release them until all tags->rqs[] references on these
pages are gone.

Please review and comment.

[1] https://lore.kernel.org/linux-block/1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com/
[2] https://marc.info/?t=154526200600007&r=2&w=2


Ming Lei (5):
  blk-mq: define max_order for allocating rqs pages as macro
  blk-mq: add helper of blk_mq_get_hw_queue_node
  blk-mq: add helpers for allocating/freeing pages of request pool
  blk-mq: cache freed request pool pages
  blk-mq: check and shrink freed request pool page

 block/blk-mq.c         | 236 +++++++++++++++++++++++++++++++++--------
 include/linux/blk-mq.h |   4 +
 2 files changed, 198 insertions(+), 42 deletions(-)

Cc: Hannes Reinecke <hare@suse.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: John Garry <john.garry@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>
-- 
2.25.2

