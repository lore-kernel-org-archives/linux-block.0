Return-Path: <SRS0=VeZL=7M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D255C433E0
	for <linux-block@archiver.kernel.org>; Sat, 30 May 2020 13:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB48120715
	for <linux-block@archiver.kernel.org>; Sat, 30 May 2020 13:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZnqmBVN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgE3Nwf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 May 2020 09:52:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25564 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727851AbgE3Nwe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 May 2020 09:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590846753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zn+ZCmkiSQyh+6MepyeRumq85N/8Bs9+8iJFh1+7h3E=;
        b=ZnqmBVN05FKLKMG4pWuGGoWrkgQZjSjkLkHM33I+0ZuRiv5bdPGfyqZw7sCuk61GpEm3Lw
        nZBIZBlkecvy+SVUicFwQJ0kwBDKGnLnrIPIXE2ZwzOT+kJ4DvZ1XeGvqylYwRhlec01Rs
        uwN1Sl6i+HLQqf9FMirAztDBJe4bZ6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-mnJDak-NP720cnQB0rYLGA-1; Sat, 30 May 2020 09:52:31 -0400
X-MC-Unique: mnJDak-NP720cnQB0rYLGA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D172107ACCA;
        Sat, 30 May 2020 13:52:30 +0000 (UTC)
Received: from localhost (ovpn-12-60.pek2.redhat.com [10.72.12.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D70B67055D;
        Sat, 30 May 2020 13:52:26 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Cc:     Alan Adamson <alan.adamson@oracle.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH V2 0/3] blk-mq/nvme: improve nvme-pci reset handler
Date:   Sat, 30 May 2020 21:52:18 +0800
Message-Id: <20200530135221.1152749-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

For nvme-pci, after controller is recovered, in-flight IOs are waited
before updating nr hw queues. If new controller error happens during
this period, nvme-pci driver deletes the controller and fails in-flight
IO. This way is too violent, and not friendly from user viewpoint.

Add APIs for checking if queue is frozen, and replace nvme_wait_freeze
in nvme-pci reset handler with checking if all ns queues are frozen &
controller disabled. Then a fresh new reset can be scheduled for
handling new controller error during waiting for in-flight IO completion.

So deleting controller & failing IOs can be avoided in this situation.

Without this patches, when fail io timeout injection is run, the
controller can be removed very quickly. With this patch, no controller
removing can be observed, and controller can recover to normal state
after stopping to inject io timeout failure.

V2:
	- give up after retrying enough times
	- add comment on breaking because of shutdown

Ming Lei (3):
  blk-mq: add API of blk_mq_queue_frozen
  nvme: add nvme_frozen
  nvme-pci: make nvme reset more reliable

 block/blk-mq.c           |  6 +++++
 drivers/nvme/host/core.c | 17 +++++++++++++-
 drivers/nvme/host/nvme.h |  3 +++
 drivers/nvme/host/pci.c  | 50 +++++++++++++++++++++++++++++++++-------
 include/linux/blk-mq.h   |  1 +
 5 files changed, 68 insertions(+), 9 deletions(-)

Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Max Gurtovoy <maxg@mellanox.com>


-- 
2.25.2

