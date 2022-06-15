Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31B0C43334
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 02:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiFOChc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 22:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiFOCh3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 22:37:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B44F186F0
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 19:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655260648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=W1tF2akYObCvGp8f1j9n4dxSv870u5JmLGN6lYNKsNs=;
        b=JTdP6dBYDKSvpoXArwJP4A4kSrI2PPXAz0g0KhEnR7NP/9Qvsg+Pz7KiwefCfsVYf0HxJN
        wiqEsJbwaCzT7Cgup3Ii5YZDEg5TxcIVcN+9F9J31vksVb3T2GkfGCYNniBKITrKTbgBGZ
        2BB40SExWc4ZFyqynA5HOqEQVO0sIcw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-GcqROvLcOMy1a-hA3YBqGA-1; Tue, 14 Jun 2022 22:37:19 -0400
X-MC-Unique: GcqROvLcOMy1a-hA3YBqGA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B1DA800124;
        Wed, 15 Jun 2022 02:37:19 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 473F510725;
        Wed, 15 Jun 2022 02:37:17 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/3] blk-mq: three misc patches
Date:   Wed, 15 Jun 2022 10:37:09 +0800
Message-Id: <20220615023712.750122-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Guys,

The 1st two patches make referring to q->elevator more reliable, and
avoid potential use-after-free on q->elevator in two code paths.

The 3rd patch improves boot time for scsi host with lots of hw queues.


Ming Lei (3):
  blk-mq: protect q->elevator by ->sysfs_lock
  blk-mq: avoid to touch q->elevator without any protection
  blk-mq: don't clear flush_rq from tags->rqs[]

 block/blk-mq.c         | 27 ++++++++-------------------
 block/elevator.c       | 10 ++++++++++
 include/linux/blkdev.h |  2 ++
 3 files changed, 20 insertions(+), 19 deletions(-)

-- 
2.31.1

