Return-Path: <SRS0=ocaT=2I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC6AC2D0C3
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 07:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC5B206B7
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 07:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StBvN2/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfLRHUF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Dec 2019 02:20:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51091 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725882AbfLRHUF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Dec 2019 02:20:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576653603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fYeOh3Byq//a4cdBHK5jgsQ7V90xFPhkylt6ogpeL8Q=;
        b=StBvN2/sbC4Npg4JEYnz88Me8FNkwetdZ4EQFMcFSW2PJQ5qqpLGuC0ieU11tYSClp1f2/
        dt7R3SRMh8ZWHQSSXWQoc8ip6kHO5SnnbO1KP0jUVn35RQD0NjS8tIcRR1RH8tkVI7uZqg
        IOt4J8ys1vaNCjsqhRn67kRBUp3d0Xs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-OObexW6QMtSMIR0UsAJLTA-1; Wed, 18 Dec 2019 02:19:59 -0500
X-MC-Unique: OObexW6QMtSMIR0UsAJLTA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E18C21083E51;
        Wed, 18 Dec 2019 07:19:56 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B35B7D8FC;
        Wed, 18 Dec 2019 07:19:52 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Long Li <longli@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>
Subject: [RFC PATCH 0/3] softirq/blk-mq: implement interrupt flood detection for avoiding cpu lockup
Date:   Wed, 18 Dec 2019 15:19:39 +0800
Message-Id: <20191218071942.22336-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Guys,

For minimizing IO latency, blk-mq often completes IO in the hardware
interrupt context. However, in case of multiple HBAs, or multiple
storage devices attached to same HBA, if one CPU core has to handle
interrupts of IOs submitted from multile CPU , there is risk to lock
up CPUs[1][2].

Follows the idea when there is mutliple IO submitter and single
CPU for completing these IOs:

1) in case of multiple storages attached to one single HBA, these
storages may handle IO more quickly than single CPU core

2) in case of multiple HBAs in one system, one single effective CPU
can be selected for handling interrupts from several queues, then
multiple storages still may handle IO more quickly than single CPU
core.

When handling IO completion in interrupt context, IO latency is good,
but there is risk to lock up CPU. When moving IO completion to process
context via NAPI or threaded interrupt handler, CPU lockup can be
avoided. So people try to move part of IO completion into process
context for avoiding CPU lockup, meantime trying to not hurt IO
performance, such as Keith's work[3].

However, it is hard to partition IO completion in the two contexts, if
less work is moved to process context, risk of locking up CPU can't be
eliminated; if more work is moved to process context, extra IO latency is
introduced, then IO performance is hurt.

Interrupt flood information can be one useful hint for partitioning IO
completion work into the two contexts effectively.

The 1st two patches implement interrpupt flood detection, and the 3rd
patch applies the hint to complet IO in process context when interrupt
flood happens. This way avoids CPU lockup, meantime IO performance isn't
hurt obviously.

[1] https://lore.kernel.org/lkml/1566281669-48212-1-git-send-email-longli=
@linuxonhyperv.com/
[2] https://lore.kernel.org/lkml/a7ef3810-31af-013a-6d18-ceb6154aa2ef@hua=
wei.com/
[3] https://lore.kernel.org/linux-nvme/20191209175622.1964-1-kbusch@kerne=
l.org/T/#t

Ming Lei (3):
  sched/core: add API for exporting runqueue clock
  softirq: implement interrupt flood detection
  blk-mq: complete request in rescuer process context in case of irq
    flood

 block/blk-mq.c          |  68 ++++++++++++++++-
 drivers/base/cpu.c      |  23 ++++++
 include/linux/hardirq.h |   2 +
 include/linux/sched.h   |   2 +
 kernel/sched/core.c     |   5 ++
 kernel/softirq.c        | 161 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 260 insertions(+), 1 deletion(-)

Cc: Long Li <longli@microsoft.com>
Cc: Ingo Molnar <mingo@redhat.com>,
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: John Garry <john.garry@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Hannes Reinecke <hare@suse.com>
--=20
2.20.1

