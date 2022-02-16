Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F26C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 04:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243573AbiBPEpw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 23:45:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238888AbiBPEpv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 23:45:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B95D1F4639
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 20:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644986739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qnH5gSU/IZp37yAYOefSY0nFRN3vNL42at6rN5w0k3A=;
        b=gxArZ0L1HLl8/SeUryDQWnuSRioB/PW193J6Mgxt0Z+UGL2vlKJWKniMJn4VidRpXVI9o3
        rHzEZphAMMFjUsWH7LNahDN+RU2brnjNC6cJQJpgbP5lUtLq9QPWvbiO2MTKYQFZQK22S+
        /lfYvKIGZYnI5wUlnCmA+gDSm6K09gs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-2819V1xJPk2nlHQhjfpo3A-1; Tue, 15 Feb 2022 23:45:36 -0500
X-MC-Unique: 2819V1xJPk2nlHQhjfpo3A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7F7B1006AA3;
        Wed, 16 Feb 2022 04:45:35 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 819395DB95;
        Wed, 16 Feb 2022 04:45:21 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ning Li <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 0/8] block: improve iops limit throttle
Date:   Wed, 16 Feb 2022 12:45:06 +0800
Message-Id: <20220216044514.2903784-1-ming.lei@redhat.com>
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

The 1st three patches are cleanup.

The 4th patches add one new local helper of submit_bio_noacct_nocheck() for
blk_throtl_dispatch_work_fn(), so that bios won't be throttled any more
when blk-throttle code dispatches throttled bios.

The 5th patch merges merge submit_bio_checks() into submit_bio_noacct
as suggested by Christoph.

The 6th and 7th patch makes the real difference for throttling split bio wrt.
iops limit.

The last patch is to revert commit 4f1e9630afe6 ("blk-throtl: optimize IOPS
throttle for large IO scenarios").

Ning Li has verified that iops throttle is improved much on the posted
RFC V1 version.

V4:
	- remove wrapper in 4/8
	- early return in 5/8

V3:
	- add reviewed-by/acked-by tag
	- patch style change 2/8
	- mark submit_bio_checks as static 3/8
	- move ubmit_bio_checks() into submit_bio_noacct 5/8

V2:
	- remove RFC
	- don't add/export __submit_bio_noacct(), instead add one new local
	helper of submit_bio_noacct_nocheck() per Christoph's suggestion



Ming Lei (8):
  block: move submit_bio_checks() into submit_bio_noacct
  block: move blk_crypto_bio_prep() out of blk-mq.c
  block: don't declare submit_bio_checks in local header
  block: don't check bio in blk_throtl_dispatch_work_fn
  block: merge submit_bio_checks() into submit_bio_noacct
  block: throttle split bio in case of iops limit
  block: don't try to throttle split bio if iops limit isn't set
  block: revert 4f1e9630afe6 ("blk-throtl: optimize IOPS throttle for
    large IO scenarios")

 block/blk-core.c     | 248 +++++++++++++++++++++----------------------
 block/blk-merge.c    |   2 -
 block/blk-mq.c       |   3 -
 block/blk-throttle.c |  61 ++++-------
 block/blk-throttle.h |  16 +--
 block/blk.h          |   2 +-
 6 files changed, 153 insertions(+), 179 deletions(-)

-- 
2.31.1

