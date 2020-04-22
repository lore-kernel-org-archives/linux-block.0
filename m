Return-Path: <SRS0=ObBg=6G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126FAC55189
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 10:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5C422076E
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 10:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="MXmMZ3qY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgDVKGp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgDVKGo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 06:06:44 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9024C03C1A9
        for <linux-block@vger.kernel.org>; Wed, 22 Apr 2020 03:06:43 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j1so1690332wrt.1
        for <linux-block@vger.kernel.org>; Wed, 22 Apr 2020 03:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c4k706ZSVjtoFxzG3fOOAAjo3JI2263vlECa+mTD4TY=;
        b=MXmMZ3qYQcjhRwZSh9ypCfMLC6JfaTsD5/nBe5OW1Vr5WYTfMinHw2aUfRS75LfBgH
         5Pbq5J3Nl8rLj6dbCYDINGCd5X8wkaKA4/0fTS+dGXVRj+WRzIzy8lYJcMtDkMwBRcMB
         EBrG1ZZt77yrGYxcHv/RDxI7n4UBxGFvVChsLtpvgZMpxrKsAwYRUh7abVvVgdSqa6ph
         e2a7pzdZB0P1Yp5EfM6stlnyuCLydEP32jGPOCvUb7T57K2KLf23I/UsjRJdZdTN+Vtk
         g6ZRkvRDntzRiHXizBxEwWjdPY5k9yX4C5rBT7VaaCEl1RQTavKQZSI8EkuLyItUvZEk
         UCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c4k706ZSVjtoFxzG3fOOAAjo3JI2263vlECa+mTD4TY=;
        b=Xuuhe0IJ9rcdgA4h/6WCnWdfrMwho9o3vpsdogXZyUG1f7Lmy62pzpOnielbTc8G+I
         CGsPmrEJVkQxbkYESwB79hegDEFoFjCDMf42tc9VlpP7ll/a1zz/VtWTBqeLADaB7bei
         jza1Ai7PAu4zcfOCsPac/XvmzoKiI2vuckpkoha1QO89Sl9QUYrIYlvGQCMtP27303BW
         P2+U0vj5+ROh4GjZtEWgv70oDC/IAzSj+N4HIvw2wRjjGkfGXWCUtghvjUIg/iQpt2XC
         lykWXSvHOoXCwdmNmBzLXzsANF31gnCcslUwXDgFatA7m2ZHE0xLLWQxmHstWUm2cPEC
         qoLA==
X-Gm-Message-State: AGi0PuZFNB3W5Ekx9XXMb58BD3d0cFqx5QBboDUzArw/AiCTC/yLy5x+
        39uuttO5yxAWOLAH9lphmDzVdqMh4DN5fw==
X-Google-Smtp-Source: APiQypL2VyjVsQy2Trl1lObhl7WPbH2lgKTZGpODlZtiJj3Mf8TLFeihbDDyDR50ofmLLPXgOPlVzQ==
X-Received: by 2002:a5d:658e:: with SMTP id q14mr30016060wru.92.1587550002459;
        Wed, 22 Apr 2020 03:06:42 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id j13sm7812462wrq.24.2020.04.22.03.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 03:06:41 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, Martijn Coenen <maco@android.com>
Subject: [PATCH v2 0/5] Add a new LOOPSET_FD_AND_STATUS ioctl
Date:   Wed, 22 Apr 2020 12:06:31 +0200
Message-Id: <20200422100636.46357-1-maco@android.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
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
would accept requests, which is generally not desirable.

There are also performance benefits with combining these two ioctls into
one, which are described in more detail in the last change in the
series.

Note that this series depends on
"loop: Call loop_config_discard() only after new config is applied."
[0], which I sent as a separate patch as it fixes an unrelated bug.

[0]: https://lkml.org/lkml/2020/3/31/755

---
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

Martijn Coenen (5):
  loop: Refactor size calculation
  loop: Factor out configuring loop from status
  loop: Move loop_set_status_from_info() and friends up
  loop: rework lo_ioctl() __user argument casting
  loop: Add LOOP_SET_FD_AND_STATUS ioctl

 drivers/block/loop.c      | 327 ++++++++++++++++++++++----------------
 include/uapi/linux/loop.h |   7 +
 2 files changed, 201 insertions(+), 133 deletions(-)

-- 
2.26.2.303.gf8c07b1a785-goog

