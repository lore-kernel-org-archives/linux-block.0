Return-Path: <SRS0=H7KM=7Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAB3C433DF
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 21:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD9D22074B
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 21:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kpOTxNC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgFKVbb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jun 2020 17:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgFKVba (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 17:31:30 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E07FC08C5C1
        for <linux-block@vger.kernel.org>; Thu, 11 Jun 2020 14:31:29 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id m1so3098120pgk.1
        for <linux-block@vger.kernel.org>; Thu, 11 Jun 2020 14:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=NWre+WVyBKtupFvAI0z0ibFYw6Kk11D+JRzt+2oIybs=;
        b=kpOTxNC1B1KAE1u2IVJo3IiWWqxZvuYuc56o0u/38g7CcYPUlFJlyOJodw7RMcjERZ
         79lRdM9J87DGknmah6Fqdzfe/HjoHrEokR0W3Ic10FnCiQECVzXsD6bekb6Np9zgktxn
         12gXx4tZHHQVkv0oZ8XdMmvfutX9hZOmdckeNMes8v6yFro0+PSB5LNxflOAEk2EUp2x
         69P2TtNNMx1BRe310jtA3+Jx1cGOD8Lt77n8v0broUZuNalsZRMnOK3gYnZxf54eVcYy
         txLk2jGTH7017qKp2Y5efw+ju7RKOL5aSjFCaS2IxR8psJdPhSFOVYqRNuTfgesISmUa
         nsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=NWre+WVyBKtupFvAI0z0ibFYw6Kk11D+JRzt+2oIybs=;
        b=oCeiVwIKPDwdAhEP0657XEIS+926HDruGkKKLR4iUAPjGWx04vQpmm/qcxWOjwQT7Q
         d+1YzpSfK+/+Q+UOB6KfLEc/lIBqxHJFyyaqUG1FkTyyXsBAhx2bJBlYhU+PedO6xYHm
         pAikF0DMR0g+THZ+8EPgtWfsN2B8kPQFvokIFLrKTP+a/5TnVjxpUM29Vly1pUR9uDyg
         0npViZDcgrRdjYWf+QcClo/iaJ186+dyDBPRh9rsLr6NSo8/vEXVJ0zc9NU3Td6aRwoP
         cK8KZmpvA7sr29PiPgrXKiAVKLSGsmOxCGqycMn8pi7QhGS7PBB2bBoUcK353q/gfxMK
         IO7A==
X-Gm-Message-State: AOAM5307v3mQHRS0SOSYqGQGq+aZW/sAC2zfXcsG2jfTb4EG0y9L/zRe
        ItLVqk2KT6xujmPMPWvMyekTqKP5VV3CMA==
X-Google-Smtp-Source: ABdhPJxe4U56pSJgLHbJeCaoh3ZhAdZ9RTZfdFxqZ1y3UoM4WcxzSYYWf5vY8mAxu12hA6vmfr3xJg==
X-Received: by 2002:a63:1617:: with SMTP id w23mr8532040pgl.248.1591911088117;
        Thu, 11 Jun 2020 14:31:28 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id o1sm3422466pjp.37.2020.06.11.14.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 14:31:27 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.8-rc1
Message-ID: <fc27bd22-3954-5733-c503-bd45d51754e0@kernel.dk>
Date:   Thu, 11 Jun 2020 15:31:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Some followup fixes for this merge window. In particular:

- Seqcount write missing preemption disable for stats (Ahmed)

- blktrace fixes (Chaitanya)

- Redundant initializations (Colin)

- Various small NVMe fixes (Chaitanya, Christoph, Daniel, Max, Niklas,
  Rikard)

- loop flag bug regression fix (Martijn)

- blk-mq tagging fixes (Christoph, Ming)

Please pull!

The following changes since commit 1ee08de1e234d95b5b4f866878b72fceb5372904:

  Merge tag 'for-5.8/io_uring-2020-06-01' of git://git.kernel.dk/linux-block (2020-06-02 15:42:50 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.8-2020-06-11

for you to fetch changes up to 9a6a5738abf82d6f467a31f1f6779e495462f7af:

  umem: remove redundant initialization of variable ret (2020-06-11 09:16:17 -0600)

----------------------------------------------------------------
block-5.8-2020-06-11

----------------------------------------------------------------
Ahmed S. Darwish (1):
      block: nr_sects_write(): Disable preemption on seqcount write

Chaitanya Kulkarni (4):
      blktrace: use errno instead of bi_status
      blktrace: fix endianness in get_pdu_int()
      blktrace: fix endianness for blk_log_remap()
      nvmet: fail outstanding host posted AEN req

Christoph Hellwig (3):
      block: remove the error argument to the block_bio_complete tracepoint
      blk-mq: split out a __blk_mq_get_driver_tag helper
      nvme-pci: use simple suspend when a HMB is enabled

Colin Ian King (2):
      pktcdvd: remove redundant initialization of variable ret
      umem: remove redundant initialization of variable ret

Daniel Wagner (1):
      nvme-fc: don't call nvme_cleanup_cmd() for AENs

Martijn Coenen (1):
      loop: Fix wrong masking of status flags

Max Gurtovoy (1):
      nvmet-tcp: constify nvmet_tcp_ops

Ming Lei (1):
      blk-mq: fix blk_mq_all_tag_iter

Niklas Cassel (1):
      nvme: do not call del_gendisk() on a disk that was never added

Rikard Falkeborn (1):
      nvme-tcp: constify nvme_tcp_mq_ops and nvme_tcp_admin_mq_ops

yu kuai (1):
      block/bio-integrity: don't free 'buf' if bio_integrity_add_page() failed

 block/bio-integrity.c        |  1 -
 block/bio.c                  |  3 +--
 block/blk-mq-tag.c           | 39 ++++++++++++++++++++++++++++++++++++---
 block/blk-mq-tag.h           |  8 ++++++++
 block/blk-mq.c               | 29 -----------------------------
 block/blk-mq.h               |  1 -
 block/blk.h                  |  2 ++
 drivers/block/loop.c         |  2 +-
 drivers/block/pktcdvd.c      |  2 +-
 drivers/block/umem.c         |  2 +-
 drivers/nvme/host/core.c     |  4 +---
 drivers/nvme/host/fc.c       |  5 +++--
 drivers/nvme/host/nvme.h     |  3 +--
 drivers/nvme/host/pci.c      |  6 ++++++
 drivers/nvme/host/tcp.c      |  8 ++++----
 drivers/nvme/target/core.c   | 27 ++++++++++++++++++++-------
 drivers/nvme/target/tcp.c    |  4 ++--
 include/trace/events/block.h |  6 +++---
 kernel/trace/blktrace.c      | 36 ++++++++++++++----------------------
 19 files changed, 104 insertions(+), 84 deletions(-)

-- 
Jens Axboe

