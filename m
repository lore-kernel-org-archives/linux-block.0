Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A576BC07E99
	for <linux-block@archiver.kernel.org>; Mon,  5 Jul 2021 10:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8935F6141C
	for <linux-block@archiver.kernel.org>; Mon,  5 Jul 2021 10:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhGEK3B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Jul 2021 06:29:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20222 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230355AbhGEK3A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Jul 2021 06:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625480783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UV2vKZC47DVUHQuShVn7WCs3qT/5nF1C0McQmnOw2YA=;
        b=R+HzoWabpKcf03WKOVgNUX1AD7yrabZH9hn+yRz9E3nhl3wLUxU788TznCyZR5HzR74ZWr
        PzjKITgB+q6cWzVq5J01jCN+NcJRSgm0FtbI8qYVVe8qsARbjE/drC4anhR0Zs/cmsFPIf
        iq/YcSa6aoToq3KDhFCop2ByB4F15oI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-DqLw9t61OfqUcH9QnPVqQQ-1; Mon, 05 Jul 2021 06:26:22 -0400
X-MC-Unique: DqLw9t61OfqUcH9QnPVqQQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E066800D62;
        Mon,  5 Jul 2021 10:26:21 +0000 (UTC)
Received: from localhost (ovpn-13-193.pek2.redhat.com [10.72.13.193])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5C5C60C0F;
        Mon,  5 Jul 2021 10:26:16 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: [PATCH 0/6] loop: cleanup charging io to mem/blkcg
Date:   Mon,  5 Jul 2021 18:26:01 +0800
Message-Id: <20210705102607.127810-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



Ming Lei (6):
  loop: clean up blkcg association
  loop: conver timer for monitoring idle worker into dwork
  loop: add __loop_free_idle_workers() for covering freeing workers in
    clearing FD
  loop: improve loop_process_work
  loop: use xarray to store workers
  loop: don't add worker into idle list

 drivers/block/loop.c | 284 +++++++++++++++++++++++--------------------
 drivers/block/loop.h |   7 +-
 2 files changed, 153 insertions(+), 138 deletions(-)

Cc: Michal Koutný <mkoutny@suse.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>


-- 
2.31.1

