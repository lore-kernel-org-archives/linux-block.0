Return-Path: <SRS0=tuS3=7S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80B9C433E0
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 11:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7425206E6
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 11:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivDzuGhC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgFELoc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Jun 2020 07:44:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43968 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726324AbgFELob (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Jun 2020 07:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591357470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VSRhHAT9oS3TRzMR3tbbPJqPVCtwY7MqNVoYVh2kBfM=;
        b=ivDzuGhC/8bjYNax1PGlJ9m6dz+dex9Fx8BS0DntcTf7PB9nOofckKvhuI8vJ02w7jURN6
        a5OJWnsWzK4zksm/VULrLOmw9VpJK/pUC3rrhyicnRwmXTFPjptGQPJ4RaTzpX1K6lCqq2
        jp1CNgkDIQJ5Q9rNq19rktu/0cvbwlU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-SBTEvpWrMCm3ROpZarcyew-1; Fri, 05 Jun 2020 07:44:29 -0400
X-MC-Unique: SBTEvpWrMCm3ROpZarcyew-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87201835B41;
        Fri,  5 Jun 2020 11:44:27 +0000 (UTC)
Received: from localhost (ovpn-12-29.pek2.redhat.com [10.72.12.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E533619C58;
        Fri,  5 Jun 2020 11:44:23 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Daniel Wagner <dwagner@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 0/2] blk-mq: fix handling cpu hotplug
Date:   Fri,  5 Jun 2020 19:44:08 +0800
Message-Id: <20200605114410.2416726-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

The 1st patch avoids to fail driver tag allocation because of inactive
hctx, so hang risk can be killed during cpu hotplug.

The 2nd patch fixes blk_mq_all_tag_iter so that we can drain all
requests before one hctx becomes inactive.

Both fixes bf0beec0607d ("blk-mq: drain I/O when all CPUs in a hctx are
offline").

John has verified that the two can fix his request timeout issue during
cpu hotplug.

Christoph Hellwig (1):
  blk-mq: split out a __blk_mq_get_driver_tag helper

Ming Lei (1):
  blk-mq: fix blk_mq_all_tag_iter

 block/blk-mq-tag.c | 39 ++++++++++++++++++++++++++++++++++++---
 block/blk-mq-tag.h |  8 ++++++++
 block/blk-mq.c     | 29 -----------------------------
 block/blk-mq.h     |  1 -
 4 files changed, 44 insertions(+), 33 deletions(-)

Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.garry@huawei.com>


-- 
2.25.2

