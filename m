Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF62C2D0FA
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 13:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59A25223D6
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 13:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="MgDrbim7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387534AbgEMNiv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 09:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387466AbgEMNiv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 09:38:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3E3C061A0E
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 06:38:51 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id n5so13638631wmd.0
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 06:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rXE9rpaAYNGyo7kteRNEK9nsX6cJ1gYcNqMSG8WX6wk=;
        b=MgDrbim7CM6R4xeK9W2/yzVHdlKQ7By1fayAYg4Tjplyzij/l1w8ycXfzuD4XMQoof
         HrSYwZuMYFJKYqwyyicQ4PAf6cBCnjAhxsZnmdRF5Hs5oJrbjQAk7zFWpQh0PdOmP1D9
         EpOo9dVIxxwsH7HHdQZzPBdM/UY7bsdp/4olyHwKRLvaqclpB/nECbIU2mjGLk6E9M9R
         mRDTVWlbIvbA5F/4rYksuGF9E2xdO1ro+PlRmYxqI4RS1G0lIZNXueTpIOf1bVA+qeLG
         hugL5nFaWk8Ru09h22hDnfKoJ8L3tHKIh3QmH4Ssp8vS33HXgemEp2Mi3DT7KR9yNDI5
         q7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rXE9rpaAYNGyo7kteRNEK9nsX6cJ1gYcNqMSG8WX6wk=;
        b=NpQ4oMYHkVNUNiXBgenmeyt170zfBLy8fhNmuUH9zrUs54C81G3Bfdrk2fC1sb3vvi
         kohV2ykN25Ar9ldl8hQ/d3BUKCFeZ+SQGWpHcK2Ug5gmrryt/v9X0mVvADJkSTwj6BAh
         9HHmDSZ4Q8Qvhsnj10jkSXnP4SQW4F7djVS2ng95b1I8OeF/7BAAv6TsmQyWtCxULFPD
         KopKQBp7wuLCpC/DaVEKveXZ2IOsrLGTnmPvE3gF3t5wmm/IDy2GuIVnahoSuo9kyRg+
         Dlckaf32WoEbuIbG6kDB3mhuEK7abKlVb6wGcXeAkV+7bGibqTSo/6hX27pCUbhd0NJv
         Tgmw==
X-Gm-Message-State: AGi0PuYRSJfQms0hCc6miwI83kzoDCvecpaFZiYqH/Rhx5pYrRgT3fyk
        dfOAuZtsAavgYd0kDTE4tUEyAA==
X-Google-Smtp-Source: APiQypIbO66csc21lLUPivkOBEyTcbRhAnbBF6C69jLHsEKF5KxepmAyLp8gysIsaU4ePUQVLJ1JDg==
X-Received: by 2002:a7b:cb53:: with SMTP id v19mr41936201wmj.166.1589377129846;
        Wed, 13 May 2020 06:38:49 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id m6sm26202653wrq.5.2020.05.13.06.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 06:38:49 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, maco@google.com,
        kernel-team@android.com, bvanassche@acm.org,
        Chaitanya.Kulkarni@wdc.com, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>
Subject: [PATCH v5 00/11] Add a new LOOP_CONFIGURE ioctl
Date:   Wed, 13 May 2020 15:38:34 +0200
Message-Id: <20200513133845.244903-1-maco@android.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series introduces a new ioctl that makes it possible to atomically
configure a loop device. Previously, if you wanted to set parameters
such as the offset on a loop device, this required calling LOOP_SET_FD
to set the backing file, and then LOOP_SET_STATUS to set the offset.
However, in between these two calls, the loop device is available and
would accept requests, which is generally not desirable. Similar issues
exist around setting the block size (LOOP_SET_BLOCK_SIZE) and requesting
direct I/O mode (LOOP_SET_DIRECT_IO).

There are also performance benefits with combining these ioctls into
one, which are described in more detail in the last change in the
series.

---
v5:
  - Added "loop: Call loop_config_discard() ..." as a first patch to
    this series, as the rest of the refactoring done depends on it.
  - Removed sector_t truncation checks, as suggested by Ming Lei.

v4:
  - Addressed review comments from Christoph Hellwig:
    -- Minor code cleanups
    -- Clarified what lo_flags LOOP_SET_STATUS can set and clear, and
       made that more explicit in the code (see [10/11])
    -- LOOP_CONFIGURE can now also be used to configure the block size
       and to explicitly request Direct I/O and read-only mode.
    -- Explicitly reject lo_flags we don't know about in LOOP_CONFIGURE
    -- Renamed LOOP_SET_FD_AND_STATUS to LOOP_CONFIGURE, since the ioctl
       can now do things LOOP_SET_STATUS couldn't do.
v3:
  - Addressed review comments from Christoph Hellwig:
    -- Factored out loop_validate_size()
    -- Split up the largish first patch in a few smaller ones
    -- Use set_capacity_revalidate_and_notify()
  - Fixed a variable wrongly using size_t instead of loff_t
v2:
  - Addressed review comments from Bart van Assche:
    -- Use SECTOR_SHIFT constant
    -- Renamed loop_set_from_status() to loop_set_status_from_info()
    -- Added kerneldoc for loop_set_status_from_info()
    -- Removed dots in patch subject lines
  - Addressed review comments from Christoph Hellwig:
    -- Added missing padding in struct loop_fd_and_status
    -- Cleaned up some __user pointer handling in lo_ioctl
    -- Pass in a stack-initialized loop_info64 for the legacy
       LOOP_SET_FD case

Martijn Coenen (11):
  loop: Call loop_config_discard() only after new config is applied
  loop: Remove sector_t truncation checks
  loop: Factor out setting loop device size
  loop: Switch to set_capacity_revalidate_and_notify()
  loop: Refactor loop_set_status() size calculation
  loop: Remove figure_loop_size()
  loop: Factor out configuring loop from status
  loop: Move loop_set_status_from_info() and friends up
  loop: Rework lo_ioctl() __user argument casting
  loop: Clean up LOOP_SET_STATUS lo_flags handling
  loop: Add LOOP_CONFIGURE ioctl

 drivers/block/loop.c      | 381 ++++++++++++++++++++++----------------
 include/uapi/linux/loop.h |  31 +++-
 2 files changed, 255 insertions(+), 157 deletions(-)

-- 
2.26.2.645.ge9eca65c58-goog

