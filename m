Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7A8C4338F
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 08:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E97060F9D
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 08:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbhG1IQy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jul 2021 04:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32258 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234311AbhG1IQx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jul 2021 04:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627460212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=11KkgfjZAJz7gnbKE1E4S6iTwopp2sMFZgLDOO2RYF0=;
        b=OC04xr5cpSVy9wKZbeIBobCE7QdQUUJcOdILwXFXU5KuBl9TIRaCs/lOqdVN6ACoUl4yvX
        UsP5sPF2X7M5xSm7gI7iLpvW0reGTKlGbqgtP4vjdwz9kqtm86QDU8xvF4UqRoF64HiKVa
        GhWUHDuNeTfqO08uwljj2lf0Clxz2L0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-lsI691mRPdqlEDxrWG7Qsw-1; Wed, 28 Jul 2021 04:16:50 -0400
X-MC-Unique: lsI691mRPdqlEDxrWG7Qsw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44B611084F40;
        Wed, 28 Jul 2021 08:16:49 +0000 (UTC)
Received: from localhost (ovpn-13-99.pek2.redhat.com [10.72.13.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 785AA60C05;
        Wed, 28 Jul 2021 08:16:44 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/7] loop: cleanup charging io to mem/blkcg
Date:   Wed, 28 Jul 2021 16:16:31 +0800
Message-Id: <20210728081638.1500953-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Guys,

Cleanup charging io to mem/blkcg a bit:

- avoid to store blkcg_css/memcg_css in loop_cmd, and store blkcg_css in
loop_worker instead

- avoid to acquire ->lo_work_lock in IO path

- simplify blkcg_css query via xarray

- other misc cleanup

V2:
	- add helper of memcg_get_e_css
	- cleanup #ifdef
	- improve the last patch, as discussed with Dan Schatzberg


Ming Lei (7):
  mm: memcontrol: add helper of memcg_get_e_css
  loop: clean up blkcg association
  loop: conver timer for monitoring idle worker into dwork
  loop: add __loop_free_idle_workers() for covering freeing workers in
    clearing FD
  loop: improve loop_process_work
  loop: use xarray to store workers
  loop: don't add worker into idle list

 drivers/block/loop.c       | 320 ++++++++++++++++++++-----------------
 drivers/block/loop.h       |   7 +-
 include/linux/memcontrol.h |   8 +
 3 files changed, 188 insertions(+), 147 deletions(-)

-- 
2.31.1

