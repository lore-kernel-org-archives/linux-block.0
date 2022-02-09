Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BB2C43219
	for <linux-block@archiver.kernel.org>; Wed,  9 Feb 2022 09:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiBIJlm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Feb 2022 04:41:42 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbiBIJho (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Feb 2022 04:37:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B628EC1DC171
        for <linux-block@vger.kernel.org>; Wed,  9 Feb 2022 01:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644399429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RonBlka76a7wpJqVy2Yldi5/Ip4rcWNV9GLugcF6EX4=;
        b=h5hWJR9DSFcttSTnIkpyAdTWqmUkk9vz/UpZDZvEs9/ftqcqtBmZ86CgnYPCM4APln6HED
        N2YiW7y7DfEzHQJAxh7cbIFSw5rvbuwqmnWWkpm7fxK2d7wGyAIO0qHKmOjcLs9ukC3HVa
        LC1QfyM4otcYzdaUcL9OJUU6hQghHyE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-140-Z-Vr7HmdOwOciq5eJFIrKw-1; Wed, 09 Feb 2022 04:15:09 -0500
X-MC-Unique: Z-Vr7HmdOwOciq5eJFIrKw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C92E1091DA8;
        Wed,  9 Feb 2022 09:15:07 +0000 (UTC)
Received: from localhost (ovpn-8-35.pek2.redhat.com [10.72.8.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5911110589AF;
        Wed,  9 Feb 2022 09:14:36 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Li Ning <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/7] block: improve iops limit throttle
Date:   Wed,  9 Feb 2022 17:14:22 +0800
Message-Id: <20220209091429.1929728-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

The 1st three patches are cleanup.

The 4th patches add one new local helper of submit_bio_noacct_nocheck() for
blk_throtl_dispatch_work_fn(), so that bios won't be throttled any more
when blk-throttle code dispatches throttled bios.

The 5th and 6th patch makes the real difference for throttling split bio wrt.
iops limit.

The last patch is to revert commit 4f1e9630afe6 ("blk-throtl: optimize IOPS
throttle for large IO scenarios").

Lining has verified that iops throttle is improved much on the posted
RFC V1 version.

V2:
	- remove RFC
	- don't add/export __submit_bio_noacct(), instead add one new local
	helper of submit_bio_noacct_nocheck() per Christoph's suggestion

Ming Lei (7):
  block: move submit_bio_checks() into submit_bio_noacct
  block: move blk_crypto_bio_prep() out of blk-mq.c
  block: don't declare submit_bio_checks in local header
  block: don't check bio in blk_throtl_dispatch_work_fn
  block: throttle split bio in case of iops limit
  block: don't try to throttle split bio if iops limit isn't set
  block: revert 4f1e9630afe6 ("blk-throtl: optimize IOPS throttle for
    large IO scenarios")

 block/blk-core.c     | 53 ++++++++++++++++++++------------------
 block/blk-merge.c    |  2 --
 block/blk-mq.c       |  3 ---
 block/blk-throttle.c | 61 ++++++++++++++++----------------------------
 block/blk-throttle.h | 16 +++++++-----
 block/blk.h          |  2 +-
 6 files changed, 61 insertions(+), 76 deletions(-)

-- 
2.31.1

