Return-Path: <SRS0=7YUI=UX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67994C43613
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 06:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A8520663
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 06:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tZdi++Yz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfFXGMs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jun 2019 02:12:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34672 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfFXGMs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jun 2019 02:12:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3BXejbyxfLyaPfZFX/QsY2c/SVlvLdpSJA5DOMZDjkQ=; b=tZdi++YzXBw9RC3MIw316JIlD6
        pPTbXf+r9Uqc0Pv2BLiuVlEEbV0N/V8/0xWBqmCLNA3mjJUQB30yKA0kAO05UtkW79TI3PTWcuVG1
        +kB/Vv1XkfZ8KxLhe6ryB1kmq3M2WAZe93q7JmCuIIXy+rhy0DaWjpkjWjVdd81sQ+KRsvxNVyET4
        8zZ/jwLH9U96goqpFuyexE91tRkJ8TYJlYYT1UKYO3X1T4oc5FSLHbFB/qEZaT2XWOx2Jfh22AoGg
        cOl1DSroOieI6GHOmdoeKr2piEI3DOsL5szHZQJ0YwgvgZrV8sblmmMGlFV7gxYEqa+NFbYUUL2hP
        CYRAC5/A==;
Received: from 213-225-6-159.nat.highway.a1.net ([213.225.6.159] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfIDb-000712-ML; Mon, 24 Jun 2019 06:12:44 +0000
Date:   Mon, 24 Jun 2019 08:12:41 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [GIT PULL] nvme updates for 5.3
Message-ID: <20190624061241.GA31634@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A large chunk of NVMe updates for 5.3.  Highlights:

 - improved PCIe suspent support (Keith Busch)
 - error injection support for the admin queue (Akinobu Mita)
 - Fibre Channel discovery improvements (James Smart)
 - tracing improvements including nvmetc tracing support (Minwoo Im)
 - misc fixes and cleanups (Anton Eidelman, Minwoo Im, Chaitanya Kulkarni)


The following changes since commit 474a280036e8d319ef852f1dec59bedf4eda0107:

  cgroup: export css_next_descendant_pre for bfq (2019-06-21 02:48:34 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.3

for you to fetch changes up to 7e31d8215fd8cb1c13b47e23f1136545010e00de:

  Documentation: nvme: add an example for nvme fault injection (2019-06-21 11:15:50 +0200)

----------------------------------------------------------------
Akinobu Mita (3):
      nvme: prepare for fault injection into admin commands
      nvme: enable to inject errors into admin commands
      Documentation: nvme: add an example for nvme fault injection

Anton Eidelman (1):
      nvme: fix possible io failures when removing multipathed ns

Chaitanya Kulkarni (2):
      nvme-pci: set the errno on ctrl state change error
      nvme-pci: clean up nvme_remove_dead_ctrl a bit

James Smart (8):
      nvmet: add transport discovery change op
      nvmet-fc: add transport discovery change event callback support
      nvme-fcloop: add support for nvmet discovery_event op
      lpfc: add support to generate RSCN events for nport
      lpfc: add nvmet discovery_event op support
      lpfc: add support for translating an RSCN rcv into a discovery rescan
      lpfc: add sysfs interface to post NVME RSCN
      nvme-fc: add message when creating new association

Keith Busch (2):
      nvme: export get and set features
      nvme-pci: use host managed power state for suspend

Minwoo Im (10):
      nvme: introduce nvme_is_fabrics to check fabrics cmd
      nvme-pci: remove unnecessary zero for static var
      nvme-pci: remove queue_count_ops for write_queues and poll_queues
      nvme-pci: adjust irq max_vector using num_possible_cpus()
      nvme-pci: properly report state change failure in nvme_reset_work
      nvme-trace: do not export nvme_trace_disk_name
      nvme-trace: move opcode symbol print to nvme.h
      nvme-trace: support for fabrics commands in host-side
      nvme-trace: print result and status in hex format
      nvmet: introduce target-side trace

 .../fault-injection/nvme-fault-injection.txt       |  56 ++++++
 drivers/nvme/host/core.c                           |  45 +++--
 drivers/nvme/host/fabrics.c                        |   2 +-
 drivers/nvme/host/fault_inject.c                   |  41 +++--
 drivers/nvme/host/fc.c                             |   6 +
 drivers/nvme/host/nvme.h                           |  42 +++--
 drivers/nvme/host/pci.c                            | 143 +++++++++++----
 drivers/nvme/host/trace.c                          |  64 ++++++-
 drivers/nvme/host/trace.h                          |  66 ++-----
 drivers/nvme/target/Makefile                       |   3 +
 drivers/nvme/target/core.c                         |  12 +-
 drivers/nvme/target/discovery.c                    |   4 +
 drivers/nvme/target/fabrics-cmd.c                  |   2 +-
 drivers/nvme/target/fc.c                           |  13 +-
 drivers/nvme/target/fcloop.c                       |  37 ++++
 drivers/nvme/target/nvmet.h                        |   2 +
 drivers/nvme/target/trace.c                        | 201 +++++++++++++++++++++
 drivers/nvme/target/trace.h                        | 141 +++++++++++++++
 drivers/scsi/lpfc/lpfc.h                           |   2 +
 drivers/scsi/lpfc/lpfc_attr.c                      |  60 ++++++
 drivers/scsi/lpfc/lpfc_crtn.h                      |   4 +
 drivers/scsi/lpfc/lpfc_els.c                       | 127 +++++++++++++
 drivers/scsi/lpfc/lpfc_hbadisc.c                   |  35 ++++
 drivers/scsi/lpfc/lpfc_hw.h                        |   2 +
 drivers/scsi/lpfc/lpfc_nvme.c                      |  44 +++++
 drivers/scsi/lpfc/lpfc_nvmet.c                     |  17 ++
 drivers/scsi/lpfc/lpfc_sli.c                       |   1 +
 include/linux/nvme-fc-driver.h                     |   6 +
 include/linux/nvme.h                               |  66 ++++++-
 29 files changed, 1110 insertions(+), 134 deletions(-)
 create mode 100644 drivers/nvme/target/trace.c
 create mode 100644 drivers/nvme/target/trace.h
