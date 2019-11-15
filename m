Return-Path: <SRS0=zNjm=ZH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87D6C432C3
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 10:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88DC020748
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 10:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pc03j4uj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfKOKm7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:42:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55548 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727022AbfKOKm7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Nov 2019 05:42:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573814578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hZQNt4i5tbZeI/K7Y736TeIuVYSACoxkrpk+iD4NB2w=;
        b=Pc03j4uj55oMoxzkHTpm/8fIsunz2Qm5IUZ+25956hMxNauL9icrsHs4lN1XstPrldtb4M
        c4wcNo66uuWU7ssswsoRS0B+ASmzI3aoN1DFaj/bdN3BQSXj/ra2jHjbAV8pmGBvfmi7vz
        b0azeanEuPC8VdBH/eKqv92JxhBw/ec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-lLE-SJQMMZCtEb6c1YNvPw-1; Fri, 15 Nov 2019 05:42:56 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35EB2477;
        Fri, 15 Nov 2019 10:42:55 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02E7369183;
        Fri, 15 Nov 2019 10:42:51 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH RFC 0/3] blk-mq/nvme: use blk_mq_alloc_request() for NVMe's connect request
Date:   Fri, 15 Nov 2019 18:42:35 +0800
Message-Id: <20191115104238.15107-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: lLE-SJQMMZCtEb6c1YNvPw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Use blk_mq_alloc_request() for allocating NVMe loop, fc, rdma and tcp's
connect request, and selecting transport queue runtime for connect
request.

Then kill blk_mq_alloc_request_hctx().=20


Ming Lei (3):
  block: reuse one scheduler/flush field for private request's data
  nvme: don't use blk_mq_alloc_request_hctx() for allocating connect
    request
  blk-mq: kill blk_mq_alloc_request_hctx()

 block/blk-mq.c             | 46 --------------------------------------
 drivers/nvme/host/core.c   |  9 +++-----
 drivers/nvme/host/fc.c     | 10 +++++++++
 drivers/nvme/host/rdma.c   | 40 ++++++++++++++++++++++++++++++---
 drivers/nvme/host/tcp.c    | 41 ++++++++++++++++++++++++++++++---
 drivers/nvme/target/loop.c | 42 +++++++++++++++++++++++++++++++---
 include/linux/blk-mq.h     |  3 ---
 include/linux/blkdev.h     |  6 ++++-
 8 files changed, 132 insertions(+), 65 deletions(-)

Cc: James Smart <james.smart@broadcom.com>
Cc: Sagi Grimberg <sagi@grimberg.me>

--=20
2.20.1

