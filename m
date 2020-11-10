Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0106EC2D0A3
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 02:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D450206F1
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 02:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="pRRITVYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgKJCYJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Nov 2020 21:24:09 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31560 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKJCYJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Nov 2020 21:24:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604975734; x=1636511734;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PuBaw3stJbTbaX8/cdgDgYBitU4HyXXto5yoOVDwa2Y=;
  b=pRRITVYJ0cED8lT1rs/itmd7WassjkGg5v+PjAIbFDb0Luq46BHy0tQy
   6yHK42iALoktP+80vuHdupMGICm4FZOckBxeC0SImjaAN/f82x7GpKUzt
   3P88ZFy63M9kXeVqKblj3HS45xjeRr3yOwyvurH2VrA1jCLpQAfLup/8a
   xFYEge6dQ3ZrHznVjc53ukEAB2asazDNIO5RYan9exWd9250e/fhDD+gW
   ZZ0PT/TuqWTzp6339zgj3A8wSNSTNd1RYh+HbVKKYOCWRkzUPhKwqvPrN
   8m2l8ELEpmTeFANPENOLxkT2a43uhJG5Hrs3PWFAQ132uW4kWLHY5W4EE
   w==;
IronPort-SDR: rPyC1I2clfRCnoYe2Gn/AzHzAFMpSIYu5D1n5m/CVHN0veQBBlSgtmBtUQh0AUAJY6csvza8mX
 2YPafM2yefjW90U8xV+a5uZS3M+5BJXmiHzd0+dAB4P8/MVwJN4QNwiojevtNUwvYqjaE29f+q
 88PYofX1Y8QxW3bincUASier4rb8/YguogzFZhRplszCSjk991aW2SxH0gIrOVM35jHclcqFm/
 tk9Y+L1/e+Amu6XsjITp7xuJvyXhfXionM88+yCZzadjh6azR0AE3wakr6brqOH+i3r4q1LIPt
 yOM=
X-IronPort-AV: E=Sophos;i="5.77,465,1596470400"; 
   d="scan'208";a="255796312"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 10:35:34 +0800
IronPort-SDR: z5oZ2Ai4qmKsSdbdnlV/gSxj5pTW/wBhJa7UPrpC5BHLmXqkgMXtEEpA4TjNZ7rj3sYHMwq0ct
 Z7TG9P9myos4A/ZMcpCAhxl8Z9d7TGmIXa50DkcpsQ3XWZ9zY2xP9SfrKp5wKWy7kivwSl7vWr
 ZcRVz4xkwFh4d2CiWxtANvDlPUZI2lWUQMQ2kZcWRRXDiSM3mk+pWmA4/RSgn8tfyFXvw4J9ns
 az8Bz+HkxgrHNQXhMp3LDayCYl7/fe2AyPLnlujuqx2RUnHiFhcQuoWIG1Ah6OXkIJtkCiAFqc
 uctYf1kr5WSmJHjUEFuSeLkQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 18:08:56 -0800
IronPort-SDR: OTIAnybxKDXy8FotM1TblXxalRopqTyeYcyk6tX3Hh7gWaPbnaZ/5TfPey4u+M4szFtWxCUuYs
 j/7yI+wp4O6gUuccMRiSjUxWXZDrnFuG6iQdW4vMAN3s5y/3Fkwy6C/LKdc8xvJ6KZgNZk6tSM
 kvvqWVvDplZffNJHoElb3YwlRRBt1r3FRYa4veYWLtZGNMUXmJUi6Nitkw2ljiGE6pRiDLWMQ/
 GZYU37abmDd3TOyb2cyBRETeuq+mnnsdutSA1zM2Qc2FKmqzsyAZFQ/5FhbzbEvkdkg9fXrFJO
 JPI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Nov 2020 18:24:08 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V4 0/6] nvmet: passthru improvements
Date:   Mon,  9 Nov 2020 18:23:59 -0800
Message-Id: <20201110022405.6707-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This patch series has several small trivial cleanups and few code
optimizations.

Due to conflicting nature of patches I've generated this series on the
top of timeout [1].

Regards,
Chaitanya

[1] http://lists.infradead.org/pipermail/linux-nvme/2020-November/020797.html

Changes from V3:-

1. Simplify nvme_alloc_request() and nvme_alloc_request_qid().
2. Add helpers which are used by request alloc functions.
3. Rebase and retest the code.
4. Only init bio_end_io for bio_alloc() case in passthru.
5. Add reviewed-by tags.

Changes from V2:-

1. Remove "nvme-core: annotate nvme_alloc_request()" patch and
   split the nvme_alloc_request() into nvme_alloc_request_qid_any()
   and nvme_alloc_request_qid() with addition of the prep patch for
   the same.
2. Remove the cleanup patches and trim down the series.
3. Remove the code for setting up the op_flags for passthru.  
4. Rebase and retest on the nvme-5.10.

Changes from V1:-

1. Remove the sg_cnt check and nvmet_passthru_sg_map() annotation.
2. Add annotations and performance numbers for newly added patch #1.
3. Move ctrl refcount and module refcount into nvme_dev_open() and
   nvme_dev_release(). Add prepration patch for the same.
4. Add reviewed-by tags.

Chaitanya Kulkarni (6):
  nvme-core: add req init helpers
  nvme-core: split nvme_alloc_request()
  nvmet: remove op_flags for passthru commands
  block: move blk_rq_bio_prep() to linux/blk-mq.h
  nvmet: use minimized version of blk_rq_append_bio
  nvmet: use inline bio for passthru fast path

 block/blk.h                    | 12 ------
 drivers/nvme/host/core.c       | 67 ++++++++++++++++++++++++----------
 drivers/nvme/host/lightnvm.c   |  5 +--
 drivers/nvme/host/nvme.h       |  2 +
 drivers/nvme/host/pci.c        |  4 +-
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/passthru.c | 30 +++++++--------
 include/linux/blk-mq.h         | 12 ++++++
 8 files changed, 79 insertions(+), 54 deletions(-)

-- 
2.22.1

