Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67F4C46467
	for <linux-block@archiver.kernel.org>; Tue, 27 Dec 2022 02:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiL0CaJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Dec 2022 21:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiL0CaH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Dec 2022 21:30:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD47F45
        for <linux-block@vger.kernel.org>; Mon, 26 Dec 2022 18:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672108170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jbAtScacCJJF14FDmrZt0VPAoTte0b/A2HYccNWz1a8=;
        b=QGo5oGe33+ITdaBotW+pGRDPYIgIv7nlA4LowbHzmSg49TiSysMWDQWTTWHay6Fvhffwxc
        bPvse44iAevcB/QNSplOKAwbZ5XJHro2caDw2VPiodRtg/62Ze+efnQj8/VRrdga2SVoyt
        kROwN1Jd1FBEN/eIUuBH7Yz8DM1rVkw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-88-dknrK1sCM8SaCT8kSUC8zQ-1; Mon, 26 Dec 2022 21:29:14 -0500
X-MC-Unique: dknrK1sCM8SaCT8kSUC8zQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C5669101A55E;
        Tue, 27 Dec 2022 02:29:13 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C43B52026D4B;
        Tue, 27 Dec 2022 02:29:12 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 0/6] genirq/affinity: Abstract APIs from managed irq affinity spread
Date:   Tue, 27 Dec 2022 10:28:59 +0800
Message-Id: <20221227022905.352674-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

blk-mq IO perf data is observed as more stable, meantime with big
improvement, see detailed data in the last patch.

Please consider it for v6.3!

V4:
	- address comments from John, not export the API, given so far no
	  module uses this symbol
	- add maintainer entry for new added lib/group_cpus.c
	- rebase on 6.2

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


Ming Lei (6):
  genirq/affinity: Remove the 'firstvec' parameter from
    irq_build_affinity_masks
  genirq/affinity: Pass affinity managed mask array to
    irq_build_affinity_masks
  genirq/affinity: Don't pass irq_affinity_desc array to
    irq_build_affinity_masks
  genirq/affinity: Rename irq_build_affinity_masks as group_cpus_evenly
  genirq/affinity: Move group_cpus_evenly() into lib/
  blk-mq: Build default queue map via group_cpus_evenly()

 MAINTAINERS                |   2 +
 block/blk-mq-cpumap.c      |  63 ++----
 include/linux/group_cpus.h |  14 ++
 kernel/irq/affinity.c      | 405 +----------------------------------
 lib/Makefile               |   2 +
 lib/group_cpus.c           | 427 +++++++++++++++++++++++++++++++++++++
 6 files changed, 467 insertions(+), 446 deletions(-)
 create mode 100644 include/linux/group_cpus.h
 create mode 100644 lib/group_cpus.c

-- 
2.31.1

