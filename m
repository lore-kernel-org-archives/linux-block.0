Return-Path: <SRS0=dDIv=CZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34DEC43461
	for <linux-block@archiver.kernel.org>; Wed, 16 Sep 2020 03:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AF4A221E5
	for <linux-block@archiver.kernel.org>; Wed, 16 Sep 2020 03:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600228453;
	bh=PKkhun1Ab1bd97yrqnw+orJD4zNwVLElsmLuC3Wa/qg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=neuzoU9mPRnuqGWQAzhFjkoMe4FclnIErM1jAUW6wycYlWwTntRRbeaxhoMQ7WkOf
	 IEPStfIRAF13699cz3jwp8TfI9mNQSl1lbuoB675BKyp6SUca+ZL9j8XpwijeWI4lS
	 weESl31QT9SQ6kXR36xOXfnxY73jQjwAjs+nd3U4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgIPDyN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Sep 2020 23:54:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbgIPDyG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Sep 2020 23:54:06 -0400
Received: from sol.attlocal.net (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 377B121655;
        Wed, 16 Sep 2020 03:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600228446;
        bh=PKkhun1Ab1bd97yrqnw+orJD4zNwVLElsmLuC3Wa/qg=;
        h=From:To:Cc:Subject:Date:From;
        b=RVeYLBfOsNDZG78H9uqUJioF/NPO0cSIeEdxX941InqiC6k564GTG+u9NRAOVhHiZ
         3MJQZCL/wuu8YlXHijm86K0EKqvxNi2tWx201jWFSnNJGmeCtkKHCcUeWtX3hUEjNj
         /1MEozj02WhQR4ZX/xI5GOIhBmhbZtOZ8HKhiNrI=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, Satya Tangirala <satyat@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: [PATCH v2 0/3] block: fix up bio_crypt_ctx allocation
Date:   Tue, 15 Sep 2020 20:53:12 -0700
Message-Id: <20200916035315.34046-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series makes allocation of encryption contexts either able to fail,
or explicitly require __GFP_DIRECT_RECLAIM (via WARN_ON_ONCE).

This applies to linux-block/for-next.

Changed since v1 (https://lkml.kernel.org/r/20200902051511.79821-1-ebiggers@kernel.org):
    - Added patches 2 and 3.
    - Added kerneldoc for bio_crypt_clone().
    - Adjusted commit message.

Eric Biggers (3):
  block: make bio_crypt_clone() able to fail
  block: make blk_crypto_rq_bio_prep() able to fail
  block: warn if !__GFP_DIRECT_RECLAIM in bio_crypt_set_ctx()

 block/bio.c                 | 20 +++++++++-----------
 block/blk-core.c            |  8 +++++---
 block/blk-crypto-internal.h | 21 ++++++++++++++++-----
 block/blk-crypto.c          | 33 ++++++++++++++++++++-------------
 block/blk-mq.c              |  7 ++++++-
 block/bounce.c              | 19 +++++++++----------
 drivers/md/dm.c             |  7 ++++---
 include/linux/blk-crypto.h  | 20 ++++++++++++++++----
 8 files changed, 85 insertions(+), 50 deletions(-)


base-commit: 99faa39ec56f33591ed3cc4d3ef62ac2878fad7e
-- 
2.28.0

