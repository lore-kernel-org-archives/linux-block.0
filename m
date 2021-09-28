Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21FAC433FE
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 00:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABB7A611C7
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 00:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238409AbhI1A56 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 20:57:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25362 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229942AbhI1A56 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 20:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632790579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AANd6N4xNjGR3ACjc8AW/NhjbHUtU/WY0SOE/ToowiQ=;
        b=AYDl1B63Jinb/kaJHRxLmbvEZR0OOYIex5Dgfb2cGB3T3vx+IEZvfC6C0pfqHTivAPdIbD
        zyHbgKZXI35O7vknYJAdZk6l4xx1dLK21qZ+9MwYAEdKzFPlpU/QVUzRG/MzDlp3GOwqJ1
        e4MBe0ZjUciUIsIRFElS4ODHFewqpww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-XXGwvUhANqOSM8601SwMwA-1; Mon, 27 Sep 2021 20:56:17 -0400
X-MC-Unique: XXGwvUhANqOSM8601SwMwA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4638E1006AA6;
        Tue, 28 Sep 2021 00:56:16 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3349D1F463;
        Tue, 28 Sep 2021 00:56:02 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 0/7] genirq/affinity: abstract new API from managed irq affinity spread
Date:   Tue, 28 Sep 2021 08:55:51 +0800
Message-Id: <20210928005558.243352-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

irq_build_affinity_masks() actually grouping CPUs evenly into each managed
irq vector according to NUMA and CPU locality, and it is reasonable to abstract
one generic API for grouping CPUs evenly, the idea is suggested by Thomas
Gleixner.

group_cpus_evenly() is abstracted and put into lib/, so blk-mq can re-use
it to build default queue mapping.

Please comments!

V3:
	- fix build failure in case of !CONFIG_SMP, only 6/7 is changed

V2:
	- fix build failure in case of !CONFIG_SMP
	- fix commit log typo
	- fix memory leak in last patch
	- add reviewed-by

Since RFC:
	- remove RFC
	- rebase on -next tree


Ming Lei (7):
  genirq/affinity: remove the 'firstvec' parameter from
    irq_build_affinity_masks
  genirq/affinity: pass affinity managed mask array to
    irq_build_affinity_masks
  genirq/affinity: don't pass irq_affinity_desc array to
    irq_build_affinity_masks
  genirq/affinity: rename irq_build_affinity_masks as group_cpus_evenly
  genirq/affinity: move group_cpus_evenly() into lib/
  lib/group_cpus: allow to group cpus in case of !CONFIG_SMP
  blk-mq: build default queue map via group_cpus_evenly()

 block/blk-mq-cpumap.c      |  65 ++----
 include/linux/group_cpus.h |  14 ++
 kernel/irq/affinity.c      | 404 +---------------------------------
 lib/Makefile               |   2 +
 lib/group_cpus.c           | 428 +++++++++++++++++++++++++++++++++++++
 5 files changed, 467 insertions(+), 446 deletions(-)
 create mode 100644 include/linux/group_cpus.h
 create mode 100644 lib/group_cpus.c

-- 
2.31.1

