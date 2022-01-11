Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C933C433EF
	for <linux-block@archiver.kernel.org>; Tue, 11 Jan 2022 11:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238642AbiAKLzz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jan 2022 06:55:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44432 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238628AbiAKLzx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jan 2022 06:55:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641902152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LYXCmB1Y9bdQXDKoC8M63UVyVJ0Av2LUNOdpH170N7M=;
        b=THM8gmjVJ2BzyhLydkUiUG8Wj02gIWBVIIsxUpMukf3N3cHDLsYMgpSSQ/ibeDiDI4Y+ae
        87m4+GVa7LKagO5DFlL+vQB4wE0s+hBDcyZge1mPzbMZW8ihvzrHrv7cqpbowIUOMfSTI7
        QJxtcXqmSQXXvPDKQNImQXUPw5P06j4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-2I4Uhsg7NW2QOOEkKmjYdA-1; Tue, 11 Jan 2022 06:55:51 -0500
X-MC-Unique: 2I4Uhsg7NW2QOOEkKmjYdA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7345C36393;
        Tue, 11 Jan 2022 11:55:49 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 321FA70D5F;
        Tue, 11 Jan 2022 11:55:38 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Li Ning <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH 0/7] block: improve iops limit throttle
Date:   Tue, 11 Jan 2022 19:55:25 +0800
Message-Id: <20220111115532.497117-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Guys,

Lining reported that iops limit throttle doesn't work on dm-thin, also
iops limit throttle works bad on plain disk in case of excessive split.

Commit 4f1e9630afe6 ("blk-throtl: optimize IOPS throttle for large IO scenarios")
was for addressing this issue, but the taken approach is just to run
post-accounting, then current split bios won't be throttled actually,
so actual iops throttle result isn't good in case of excessive bio
splitting.

The 1st two patches are cleanup.

The 3rd and 4th patches add one new helper of __submit_bio_noacct() for
blk_throtl_dispatch_work_fn(), so that bios won't be throttled any more
when blk-throttle code dispatches throttled bios.

The 5th and 6th patch makes the real difference for throttling split bio wrt.
iops limit.

The last patch is to revert commit 4f1e9630afe6 ("blk-throtl: optimize IOPS
throttle for large IO scenarios").

Lining, you should get exact IOPS throttling in your dm-thin test with
this patchset, please test and feedback.


Ming Lei (7):
  block: move submit_bio_checks() into submit_bio_noacct
  block: move blk_crypto_bio_prep() out of blk-mq.c
  block: allow to bypass bio check before submitting bio
  block: don't check bio in blk_throtl_dispatch_work_fn
  block: throttle split bio in case of iops limit
  block: don't try to throttle split bio if iops limit isn't set
  block: revert 4f1e9630afe6 ("blk-throtl: optimize IOPS throttle for
    large IO scenarios")

 block/blk-core.c       | 32 +++++++++-------------
 block/blk-merge.c      |  2 --
 block/blk-mq.c         |  3 ---
 block/blk-throttle.c   | 61 +++++++++++++++---------------------------
 block/blk-throttle.h   | 16 ++++++-----
 include/linux/blkdev.h |  7 ++++-
 6 files changed, 51 insertions(+), 70 deletions(-)

-- 
2.31.1

