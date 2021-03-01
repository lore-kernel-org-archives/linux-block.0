Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664D3C433DB
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 19:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2317160231
	for <linux-block@archiver.kernel.org>; Mon,  1 Mar 2021 19:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbhCATa0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Mar 2021 14:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241479AbhCATZj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Mar 2021 14:25:39 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D027C06178A
        for <linux-block@vger.kernel.org>; Mon,  1 Mar 2021 11:24:57 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id do6so30406219ejc.3
        for <linux-block@vger.kernel.org>; Mon, 01 Mar 2021 11:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5l1F+wGO5Nb1bwNWSiP0iexmLFzCMcNx6yWjh9GDkl8=;
        b=1CoUBdIYvIuaC0DQg7GZmUY56DBIHEmIF+T/PlfBojIM4jnZIo2xmPoKJewZcF9QaE
         GAO2tvPHeZ1PkZDK8l6PTi5+YtaNDVKj0eNZqzNw5aSP6di8DP6YYOsMb0pdvKJs//V9
         lTAmzvu8DUkYZckNQivK8yS99XxFIRt0fICKuurfH1UNLI0VTWABsBdtpEf8FJ+GFi1F
         RdTbjUscmxCDeRe+h1NR8s4hLuLGNt1wBNONM3Km77CpFNC+Ge8oj9jwAy7wJCvmNA0S
         Pni72/MHv/recoWifuObzqjCtzYIXy4NI4aeHfzQFMa0DRSuO7BFMSMxqgix8QTgSHjS
         Mkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5l1F+wGO5Nb1bwNWSiP0iexmLFzCMcNx6yWjh9GDkl8=;
        b=WJ+H0sAMjHjHnj/9DEP5jXuJIAGWMAIOYNoR+j7n0dBLcnJTWTaI8KKZ/Lwn5C1ZVF
         hkuYrP2y4+PSdyQCpgy1MT04CvAt+H7gQccY4wCRemFdLA7IGbNeKVqVJTSNhvQIMJto
         DQCzpUtui0a4ns/QXY1g+wxwUUrUkh5CBuyBld1bCefVThICXJfm1vpQ4hgThFCNyENl
         xY8Y/F6z/L0kycOEalJG1PxEsKgWWEe4lcMvwS62F3BgqRQvCAeWGOyYbaPW/UXIu0Hq
         MinJiHbl3bLlXtseqmvPnzDAJv1TdRgOyagM3paef0Top0dbAxY1qf8AgwBD2irx4/lr
         pbQA==
X-Gm-Message-State: AOAM530PGPLb0I5GjWJXxD4FmBhV22isJBUxkfNZIn55TjIXMefWc/ct
        A4ErdKJSQapVktz8rP8vXg9rGA==
X-Google-Smtp-Source: ABdhPJwYFsDUaeZgzUEyiNQ3NKvuH1vsSYZBWEEH8kFW6WSW79+Va11Wf2oNdKBtftXLumXMStVEcw==
X-Received: by 2002:a17:906:22d4:: with SMTP id q20mr751162eja.54.1614626696497;
        Mon, 01 Mar 2021 11:24:56 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id i4sm14107110eje.90.2021.03.01.11.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 11:24:56 -0800 (PST)
From:   javier@javigon.com
X-Google-Original-From: javier.gonz@samsung.com
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, minwoo.im.dev@gmail.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [PATCH V6 0/2] nvme: enable char device per namespace
Date:   Mon,  1 Mar 2021 20:24:50 +0100
Message-Id: <20210301192452.16770-1-javier.gonz@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Javier González <javier.gonz@samsung.com>

These two patches enable a char device per namespace, also through
multipath. It is possible to test this in QEMU using Keith's and Klaus'
tree in nvme-next

     http://git.infradead.org/qemu-nvme.git/shortlog/refs/heads/nvme-next


One question that came up while preparing V6 is what to do with the bdev
sysfs entries when the block device fails. On the one hand, these values
are useful for the char device, but on the other, they are in principle
only valid for the block device. We have 3 options: (i) clear sysfs when
bdev fails and require user-space to query the nvme device directly
through sysfs, (ii) maintain the bdev sysfs entries, and (iii) make char
device dedicated sysfs entries, which might be redundant when both the
char device and the block device are brought up. Thoughts?

Keith: Regarding nvme-cli support, once this is in place, we will send a
patch to nvme-cli so that this device is shown in verbose mode. Do you
have anu thoughts about this?

Changes since V5
  - Addressed style and naming comments from Christoph
  - Change the logic around nvme_update_ns_info() to (i) make the
    GENHD_FL_HIDDEN more explicit in the init logic, and (ii) to support
    an error path that also stops the char device from being created.
    This error path is not exercised currently.

Changes since V4
  - Added support for multipath (from Minwoo)
  - Fixed typo in commit message for sysfs naming
  - Rebase into nvme-5.12

Changes since V3
  - Use a dedicated ida for the generic handle
  - Do not abort namespace greation if the generic handle fails

Changes since V2:
  - Apply a number of naming and code structure improvements (from
    Christoph)
  - Use i_cdev to pull struct nvme_ns in the ioctl path instead of
    populating file->private_data (from Christoph)
  - Change char device and sysfs entries to /dev/nvme-generic-XcYnZ to
    follow the hidden device naming scheme (from Christoph and Keith)

Changes since V1:
  - Remove patches 1-3 which are already picked up by Christoph
  - Change the char device and sysfs entries to nvmeXnYc / c signals
    char device
  - Address Minwoo's comments on inline functions and style


Javier González (1):
  nvme: enable char device per namespace

Minwoo Im (1):
  nvme: allow open for nvme-generic char device

 drivers/nvme/host/core.c | 198 ++++++++++++++++++++++++++++++++++-----
 drivers/nvme/host/nvme.h |   5 +
 2 files changed, 182 insertions(+), 21 deletions(-)

-- 
2.17.1

