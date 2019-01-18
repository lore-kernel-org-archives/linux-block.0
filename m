Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85813C07EBF
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 19:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2952086D
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 19:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CUzp3n4T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbfART7L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:59:11 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37604 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729300AbfART7L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 14:59:11 -0500
Received: by mail-pg1-f193.google.com with SMTP id c25so6544130pgb.4
        for <linux-block@vger.kernel.org>; Fri, 18 Jan 2019 11:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=kbe/WePJ3ZTCBX+8yNCmGRXuwSPGnFTYXe33dKkBmYg=;
        b=CUzp3n4Taw0Yj91CW3zp4oZbWQVsWzrrBV7wDOGC7ZFm6di63+YTtx3EvMcN+hJpEZ
         jl0xOf7vXWlH9PPraOSM+8Q1DLjr3KNuEvE6xMJIoI6wtLvDwxIhXpmkxX1DtAT6pa3z
         PBDe4J8/QuEkgU0rDQvMKPUp44PYoaaIkgWBwxUx4yuvt6nmSsNOB/6EvDC6uolocE0Z
         636r9XJnYTXFILNA+I9P4V80oiVm92M22yM5SfrXNmUkTJAA67YmdsdKNohUAbZPI2ZS
         +lpPLnRFipYiK2CYAoLGq4ZBdSElSesrtq1zGc0MfEx5W0a8u63yTiD1/d4SCCnYJ1Qh
         Wh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=kbe/WePJ3ZTCBX+8yNCmGRXuwSPGnFTYXe33dKkBmYg=;
        b=MDpbEAxJkrVzDWMuRuNUpDzUTKiWGLyhSLd7F3NvBulD1vxf7WnrFuwFe9dzuDySdU
         10UMWJw67gdcETTkNNwdnuB6FRS4h5HOo4/G7fdI8sMCYnoCxEuXXgFgRMLbyEX3phfV
         c6bLmmExthGeBx7PbdcmPCfFAyvSfNNzBTxjAvXkDXjW1sTAFmfSX0H1JFdO+SA11vH8
         XPeK9XH+CLUloGfyYA0iPcCyD+JR+rZdfvKH63pVwRa6lwmPixr/TgDvdYcgiZHkp0ZU
         mcZN9DE24uklHng16s74gBdDGs301cfWF2M0KCwSqx0Q4MRAu2bciHo4cTNlAqzAJ5Fh
         o0/Q==
X-Gm-Message-State: AJcUukdj0JGhkFJVR7pZuMkQO1CQb2TGYOfHQ2z7G9zMi2F/FtydlhKV
        u/ENEgaYlwe0KwWGaMVycp915MWVtGXoSQ==
X-Google-Smtp-Source: ALg8bN4mlq0YkuB4YE9VJdXq/jurju/2MB4XXPeh8gf44e2mobuYQbP5ouNUILdwj/5Kun4etv8+CA==
X-Received: by 2002:a63:86c1:: with SMTP id x184mr18824973pgd.305.1547841549987;
        Fri, 18 Jan 2019 11:59:09 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v184sm7566634pfb.182.2019.01.18.11.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 11:59:09 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.0-rc3
Message-ID: <c2a330c3-0acb-6f39-8cf2-e1659fe39440@kernel.dk>
Date:   Fri, 18 Jan 2019 12:59:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Small collection of fixes for this release. This pull request contains:

- block size setting fixes for loop/nbd (Jan Kara)

- md bio_alloc_mddev() cleanup (Marcos)

- Ensure we don't lose the REQ_INTEGRITY flag (Ming)

- Two NVMe fixes by way of Christoph:

	- Fix NVMe IRQ calculation (Ming)
	- Uninitialized variable in nvmet-tcp (Sagi)

- BFQ comment fix (Paolo)

- License cleanup for recently added blk-mq-debugfs-zoned (Thomas)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20190118


----------------------------------------------------------------
Jan Kara (2):
      nbd: Use set_blocksize() to set device blocksize
      blockdev: Fix livelocks on loop device

Marcos Paulo de Souza (1):
      md: Make bio_alloc_mddev use bio_alloc_bioset

Ming Lei (2):
      block: don't lose track of REQ_INTEGRITY flag
      nvme-pci: fix nvme_setup_irqs()

Paolo Valente (1):
      block, bfq: fix comments on __bfq_deactivate_entity

Sagi Grimberg (1):
      nvmet-tcp: fix uninitialized variable access

Thomas Gleixner (1):
      block: Cleanup license notice

 block/bfq-wf2q.c             | 11 +++++------
 block/blk-mq-debugfs-zoned.c |  2 --
 block/blk-mq.c               |  3 ++-
 drivers/block/nbd.c          |  5 +++--
 drivers/md/md.c              |  7 +------
 drivers/nvme/host/pci.c      | 21 +++++++++++++--------
 drivers/nvme/target/tcp.c    |  2 +-
 fs/block_dev.c               | 28 ++++++++++++++++++----------
 8 files changed, 43 insertions(+), 36 deletions(-)

-- 
Jens Axboe

