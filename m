Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3981EC4338F
	for <linux-block@archiver.kernel.org>; Sat, 14 Aug 2021 12:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1185060EFE
	for <linux-block@archiver.kernel.org>; Sat, 14 Aug 2021 12:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbhHNMgV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 14 Aug 2021 08:36:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35881 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229549AbhHNMgV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Aug 2021 08:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628944550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Zi9rp4A/ofXDkM+2FBhAwSRraea93QLDveGmuBcx8js=;
        b=R9JuWxmGhRqMwEn8i3vQgsGVObuc+q58M/CKhzeF0irdFnhO/HQRlV0gCn6dK6Dswaa6za
        72r/46I4fdT4pYg4HoUXN9xvNwQGQWNvQCeWXrO9JuSScKkH48nqx8x6CXJzhzOyz9i0Ag
        h6GR9dx4e0n3GDhYulAqO9BQN2scPtU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-a7BetHQTNHW64izu1qUtqg-1; Sat, 14 Aug 2021 08:35:46 -0400
X-MC-Unique: a7BetHQTNHW64izu1qUtqg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 916B894DE1;
        Sat, 14 Aug 2021 12:35:44 +0000 (UTC)
Received: from localhost (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC6B960C9F;
        Sat, 14 Aug 2021 12:35:38 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/7] genirq/affinity: abstract new API from managed irq affinity spread
Date:   Sat, 14 Aug 2021 20:35:25 +0800
Message-Id: <20210814123532.229494-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

 block/blk-mq-cpumap.c      |  64 ++----
 include/linux/group_cpus.h |  28 +++
 kernel/irq/affinity.c      | 404 +-----------------------------------
 lib/Makefile               |   2 +
 lib/group_cpus.c           | 413 +++++++++++++++++++++++++++++++++++++
 5 files changed, 465 insertions(+), 446 deletions(-)
 create mode 100644 include/linux/group_cpus.h
 create mode 100644 lib/group_cpus.c

-- 
2.31.1

