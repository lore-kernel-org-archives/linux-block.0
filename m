Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE6BC2D0F8
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 03:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98EB9206F5
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 03:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bmtyw3yb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgEMDsU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 May 2020 23:48:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55399 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727107AbgEMDsT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 May 2020 23:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589341697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=j/N7HqkwLtJEtdp6jLx4/8FtUp+Yyd3XBiUjbiAhixg=;
        b=bmtyw3yb1Q35m1wEm27CkaCQYww5BIUbszes9UdBiLazQ1cl9vIKh0Ie1IpkqfsScnIZnq
        P52tllpfETkizxrtWRP0QLqxkQ+4HOFqnLDDifKZ/D7q3tavlIvew8/+Cat6pjmdIYAgc+
        gIz4lcBAutm4Zub6c6HPcztmGcDjd10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-4e0M1slZNHO6ffG81ykAPA-1; Tue, 12 May 2020 23:48:14 -0400
X-MC-Unique: 4e0M1slZNHO6ffG81ykAPA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDFF8107ACCA;
        Wed, 13 May 2020 03:48:12 +0000 (UTC)
Received: from localhost (ovpn-12-166.pek2.redhat.com [10.72.12.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C75E1A925;
        Wed, 13 May 2020 03:48:08 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V11 00/12] blk-mq: improvement CPU hotplug
Date:   Wed, 13 May 2020 11:47:51 +0800
Message-Id: <20200513034803.1844579-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Thomas mentioned:
    "
     That was the constraint of managed interrupts from the very beginning:
    
      The driver/subsystem has to quiesce the interrupt line and the associated
      queue _before_ it gets shutdown in CPU unplug and not fiddle with it
      until it's restarted by the core when the CPU is plugged in again.
    "

But no drivers or blk-mq do that before one hctx becomes inactive(all
CPUs for one hctx are offline), and even it is worse, blk-mq stills tries
to run hw queue after hctx is dead, see blk_mq_hctx_notify_dead().

This patchset tries to address the issue by two stages:

1) add one new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE

- mark the hctx as internal stopped, and drain all in-flight requests
if the hctx is going to be dead.

2) re-submit IO in the state of CPUHP_BLK_MQ_DEAD after the hctx becomes dead

- steal bios from the request, and resubmit them via generic_make_request(),
then these IO will be mapped to other live hctx for dispatch

Thanks John Garry for running lots of tests on arm64 with this patchset
and co-working on investigating all kinds of issues.

Thanks Christoph's review on V7 & V8.

Please consider it for v5.8.

https://github.com/ming1/linux/commits/v5.7-rc-blk-mq-improve-cpu-hotplug

V11:
	- drop new callback from blk_mq_all_tag_busy_iter, add new helper
	of blk_mq_all_tag_iter (5/12), as suggested by Bart
	- fix request allocation hang in case of queue freeze(11/12), as
	reported by Bart

V10:
	- fix double bio complete in request resubmission(10/11)
	- add tested-by tag

V9:
	- add Reviewed-by tag
	- document more on memory barrier usage between getting driver tag
	and handling cpu offline(7/11)
	- small code cleanup as suggested by Chritoph(7/11)
	- rebase against for-5.8/block(1/11, 2/11)
V8:
	- add patches to share code with blk_rq_prep_clone
	- code re-organization as suggested by Christoph, most of them are
	in 04/11, 10/11
	- add reviewed-by tag

V7:
	- fix updating .nr_active in get_driver_tag
	- add hctx->cpumask check in cpuhp handler
	- only drain requests which tag is >= 0
	- pass more aggressive cpuhotplug&io test

V6:
	- simplify getting driver tag, so that we can drain in-flight
	  requests correctly without using synchronize_rcu()
	- handle re-submission of flush & passthrough request correctly

V5:
	- rename BLK_MQ_S_INTERNAL_STOPPED as BLK_MQ_S_INACTIVE
	- re-factor code for re-submit requests in cpu dead hotplug handler
	- address requeue corner case

V4:
	- resubmit IOs in dispatch list in case that this hctx is dead 

V3:
	- re-organize patch 2 & 3 a bit for addressing Hannes's comment
	- fix patch 4 for avoiding potential deadlock, as found by Hannes

V2:
	- patch4 & patch 5 in V1 have been merged to block tree, so remove
	  them
	- address comments from John Garry and Minwoo


*** BLURB HERE ***

Ming Lei (12):
  block: clone nr_integrity_segments and write_hint in blk_rq_prep_clone
  block: add helper for copying request
  blk-mq: mark blk_mq_get_driver_tag as static
  blk-mq: assign rq->tag in blk_mq_get_driver_tag
  blk-mq: add blk_mq_all_tag_iter
  blk-mq: prepare for draining IO when hctx's all CPUs are offline
  blk-mq: stop to handle IO and drain IO before hctx becomes inactive
  block: add blk_end_flush_machinery
  blk-mq: add blk_mq_hctx_handle_dead_cpu for handling cpu dead
  block: add request allocation flag of BLK_MQ_REQ_FORCE
  blk-mq: re-submit IO in case that hctx is inactive
  block: deactivate hctx when the hctx is actually inactive

 block/blk-core.c           |  32 +++-
 block/blk-flush.c          | 141 ++++++++++++---
 block/blk-mq-debugfs.c     |   2 +
 block/blk-mq-tag.c         |  33 +++-
 block/blk-mq-tag.h         |   2 +
 block/blk-mq.c             | 356 +++++++++++++++++++++++++++++--------
 block/blk-mq.h             |  22 ++-
 block/blk.h                |  11 +-
 drivers/block/loop.c       |   2 +-
 drivers/md/dm-rq.c         |   2 +-
 include/linux/blk-mq.h     |  14 ++
 include/linux/cpuhotplug.h |   1 +
 12 files changed, 494 insertions(+), 124 deletions(-)

-- 
2.25.2

