Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068F9C67839
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 19:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2EEC20880
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 19:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="GVMdYczn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2EEC20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeLKTRC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:17:02 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:34149 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbeLKTRB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 14:17:01 -0500
Received: by mail-lj1-f178.google.com with SMTP id u6-v6so14044958ljd.1
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 11:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O7fFUM/mepqe/i69Sla4D4jNze3fp3adihc9Ic58eOA=;
        b=GVMdYcznBYlKwHrs356gHcEOIfsmsx5lPAhb8TO1oLbB61FlvuWNkBJbDYyStRXq/3
         bYFDpK19xBxdgpdiA/AeJbwuRYewaAqp3bn2rVf5vxehF5pwMGuBQaHXUTpPU5CfGlju
         CD2y74vRSpwqJDIi6CTobxG3klItOP9Cq1qSFkhWF5BvdB98avUkADApQW+6Nk276DJ9
         Ow4SIBV1+3rVfYNxqsj+YpByNnlqokCsALKWzPvagoOjnArxYc2g8kTXZ/SKo6+mKsKl
         WG9wdogzou19092v2aCfgkZCQ0EkQBHtfvi6RgFcL+qaer7BOiA8kXIYguMO6au+ujd0
         772Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O7fFUM/mepqe/i69Sla4D4jNze3fp3adihc9Ic58eOA=;
        b=VHPqbRcxnfc4h+qyCt4GRiFIoPRV/YfVlWHnvqUdBf0OgvIvBcBwnYEDq6/rjqUw86
         iroTzCkdDk0acsjLfnanIWZpHBCE9UQsjfmzhnUv83bugt3dwfW36NhKCWsKg5otJZUs
         5T6ZZSBiRZp/dzK9Z7KuyMFVgqjqReT3uPuslxl2IeFYidQ9BjvBDiGNRa7l9Guindpb
         3gogzXuK0g2zn5IaQNk30hv0r/2nLXGiaRmtcIbqHPXa98Qg4w3B6L/UO/8vJuqMAq6k
         gSYam5wn6CrZKLCX2M0wnjxVeIK22OZnyu44Kl8eAdxAQ63z9NBFkpTUCZiMvfOyONQY
         VLPw==
X-Gm-Message-State: AA+aEWbhaGOu00h92tVut+jH8TjsMXsGNmjOMtwKq1CvaCdihDyi4OTk
        PzFRCQt3EZ3cbNgp3ryd8T0V9k0M4f0=
X-Google-Smtp-Source: AFSGD/UOcBuxUW1xRyZpOcd3ar6Jna83QvZZGqIYibKxiqnOLfLeHH6dWeAnDSDA4UHzaSlpFD3aJw==
X-Received: by 2002:a2e:9783:: with SMTP id y3-v6mr10423226lji.167.1544555819041;
        Tue, 11 Dec 2018 11:16:59 -0800 (PST)
Received: from skyninja.webspeed.dk (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id v64sm2764583lfa.48.2018.12.11.11.16.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 11:16:58 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 00/21] lightnvm updates for 4.21
Date:   Tue, 11 Dec 2018 20:16:06 +0100
Message-Id: <20181211191627.15542-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Would you please pick up the following patches for 4.21?

Changelog:

 - Igor added packed metadata to pblk. Now drives without metadata
   per LBA can be used as well.
 - Fix from Geert on uninitialized value on chunk metadata reads.
 - Fixes from Hans and Javier to pblk recovery and write path.
 - Fix from Hua Su to fix a race condition in the pblk recovery code.
 - Scan optimization added to pblk recovery from Zhoujie.
 - Small geometry cleanup from me.

Thank you,
Matias

Geert Uytterhoeven (1):
  lightnvm: Fix uninitialized return value in nvm_get_chunk_meta()

Hans Holmberg (8):
  lightnvm: pblk: fix chunk close trace event check
  lightnvm: pblk: fix resubmission of overwritten write err lbas
  lightnvm: pblk: account for write error sectors in emeta
  lightnvm: pblk: stop writes gracefully when running out of lines
  lightnvm: pblk: set conservative threshold for user writes
  lightnvm: pblk: remove unused macro
  lightnvm: pblk: fix pblk_lines_init error handling path
  lightnvm: pblk: remove dead code in pblk_recov_l2p

Hua Su (2):
  lightnvm: pblk: fix spelling in comment
  lightnvm: pblk: add lock protection to list operations

Igor Konopko (6):
  lightnvm: pblk: move lba list to partial read context
  lightnvm: pblk: add helpers for OOB metadata
  lightnvm: dynamic DMA pool entry size
  lightnvm: disable interleaved metadata
  lightnvm: pblk: support packed metadata
  lightnvm: pblk: do not overwrite ppa list with meta list

Javier González (2):
  lightnvm: pblk: add comments wrt locking in recovery path
  lightnvm: pblk: avoid ref warning on cache creation

Matias Bjørling (1):
  lightnvm: simplify geometry enumeration

Zhoujie Wu (1):
  lightnvm: pblk: ignore the smeta oob area scan

 drivers/lightnvm/core.c          |  23 ++++---
 drivers/lightnvm/pblk-core.c     |  77 ++++++++++++++++++-----
 drivers/lightnvm/pblk-init.c     | 103 ++++++++++++++++++++++++-------
 drivers/lightnvm/pblk-map.c      |  63 ++++++++++++-------
 drivers/lightnvm/pblk-rb.c       |   5 +-
 drivers/lightnvm/pblk-read.c     |  66 +++++++++++---------
 drivers/lightnvm/pblk-recovery.c |  46 +++++++++-----
 drivers/lightnvm/pblk-rl.c       |   5 +-
 drivers/lightnvm/pblk-sysfs.c    |   7 +++
 drivers/lightnvm/pblk-write.c    |  64 +++++++++++++------
 drivers/lightnvm/pblk.h          |  43 +++++++++++--
 drivers/nvme/host/core.c         |  18 +++---
 drivers/nvme/host/lightnvm.c     |  27 ++++----
 drivers/nvme/host/nvme.h         |   2 -
 include/linux/lightnvm.h         |   3 +-
 15 files changed, 383 insertions(+), 169 deletions(-)

-- 
2.17.1

