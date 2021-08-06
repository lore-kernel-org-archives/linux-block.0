Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B2DC4320A
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 02:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2902E61186
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 02:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240924AbhHFCez (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Aug 2021 22:34:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34793 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239900AbhHFCex (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Aug 2021 22:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628217278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dqs4cK2GxE9mpkJgfNNpzt8FFXyNW2dDzyHOF1sRmFI=;
        b=TsqveMmWTLO4zgbz8rkvQi72wflhqnYxDEIrL4Z/jzKg7zxgxRuy4sMNo5vhw+dYMPNyeJ
        tq4kgyiBY5LLJ4IK3N9oQdOMmLFXz8LmSOim7eLoipN07ZzTBPSl2dRTLmZQFN7h7T56Qx
        KjDxaAuP7QJu6vj4hgbVxF+Z31aHb/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-EZHD7KwCOdGVWUjGGyXrMw-1; Thu, 05 Aug 2021 22:34:37 -0400
X-MC-Unique: EZHD7KwCOdGVWUjGGyXrMw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D535C107ACF5;
        Fri,  6 Aug 2021 02:34:35 +0000 (UTC)
Received: from localhost (ovpn-12-45.pek2.redhat.com [10.72.12.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DBE496A057;
        Fri,  6 Aug 2021 02:34:31 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 0/7] loop: cleanup charging io to mem/blkcg
Date:   Fri,  6 Aug 2021 10:34:16 +0800
Message-Id: <20210806023423.131060-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

V3:
	- one patch style change in 7/7
	- rebase patch 4/7 against for-5.15/block
	- add acked-by tag

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

