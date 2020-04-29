Return-Path: <SRS0=GTSZ=6N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247FAC83000
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 14:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBC012082E
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 14:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="i0G80BZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgD2ODr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726885AbgD2ODr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 10:03:47 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7D6C03C1AE
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2020 07:03:46 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r26so2173894wmh.0
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2020 07:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/N1h32tUQUjUvbbVh9Sx0ldWuhfL7NViXIQbgOtPfHU=;
        b=i0G80BZPAm1av9kXUevS62676qW5KOO6kLiBwdV+1UWaQThQ90GQpKI0ph1mvO4BVu
         jiNxY/PNluCXb1YA19LsvSwYN4H84/FQa/FgQOHxB/zk/grBc4TOo+ct2ThdUv4lGOYC
         XYDvpJr4oy31138O+l6/L25Rw19V8HgwqzH/mruMC3gSnvsk/qJF2LRZGKYvw0oG3PCN
         jegxRxSVqRk6QlL117n9HGP86LqIyW5IpjmyrJaY7TFy74U8k8TWAmS4RaPSnNnVSX83
         +NTOdHFd1z9NEnkFMlOsPHjiXruY2OiiTaPurfWtDhy2E9NArtqZ6j3tCXsBfk/bQkE2
         v/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/N1h32tUQUjUvbbVh9Sx0ldWuhfL7NViXIQbgOtPfHU=;
        b=gFXBJuCdLGpm5f20fwHGuls7SYaZkQ1W3ZKNtjxLWiim+8qvwGlVyePPqn6pPDyE5t
         +An1kWztVMGdSwll1SKZJ8Va/sJ83eXz+3QsTVQF0+R6CMhtntQK48T0P358sPqrf/Zp
         uhrz/FXlsjowYQS+xdeOPfSWA6zgQeB6PAORyDObfsvM2GiKQqo5AQvbLX8XSypf1FgH
         p15bNLMKrz35m0vILP0Jvw6AmsFa81037cA9xt1glQZKVIzmssmfi+17Sx2uqQPe3JRH
         wYTHCwrv5hm6Gw0GxpStxZkWzZQyoQl31jP0XblElKHmg4P82KI704j8nSRujlnsQKDI
         5XjQ==
X-Gm-Message-State: AGi0PuaOgEH5tNYry6tKEvizZsTl9FQPHFKZSoDaRiaB/ZSSPht+i/8N
        QsxjmdnMjkgI9zcoH/5j9PGcSQ==
X-Google-Smtp-Source: APiQypKhVVvWGVwyHnc7ndDVd3MQfcksp1Ah1aPBYv179+YC7X76d3YUcZsmi83MJ3DjOOhWMmkMhg==
X-Received: by 2002:a1c:8084:: with SMTP id b126mr3345914wmd.135.1588169025309;
        Wed, 29 Apr 2020 07:03:45 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id d133sm8887008wmc.27.2020.04.29.07.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 07:03:44 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martijn Coenen <maco@android.com>
Subject: [PATCH v4 00/10] Add a new LOOP_CONFIGURE ioctl
Date:   Wed, 29 Apr 2020 16:03:31 +0200
Message-Id: <20200429140341.13294-1-maco@android.com>
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
would accept requests, which is generally not desirable. Similar issues
exist around setting the block size (LOOP_SET_BLOCK_SIZE) and requesting
direct I/O mode (LOOP_SET_DIRECT_IO).

There are also performance benefits with combining these ioctls into
one, which are described in more detail in the last change in the
series.

Note that this series depends on
"loop: Call loop_config_discard() only after new config is applied."
[0], which I sent as a separate patch as it fixes an unrelated bug.

[0]: https://lkml.org/lkml/2020/3/31/755

---
v4:
  - Addressed review comments from Christoph Hellwig:
    -- Minor code cleanups
    -- Clarified what lo_flags LOOP_SET_STATUS can set and clear, and
       made that more explicit in the code (see [9/10])
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

Martijn Coenen (10):
  loop: Factor out loop size validation
  loop: Factor out setting loop device size
  loop: Switch to set_capacity_revalidate_and_notify()
  loop: Refactor loop_set_status() size calculation
  loop: Remove figure_loop_size()
  loop: Factor out configuring loop from status
  loop: Move loop_set_status_from_info() and friends up
  loop: Rework lo_ioctl() __user argument casting
  loop: Clean up LOOP_SET_STATUS lo_flags handling.
  loop: Add LOOP_CONFIGURE ioctl

 drivers/block/loop.c      | 407 +++++++++++++++++++++++---------------
 include/uapi/linux/loop.h |  31 ++-
 2 files changed, 281 insertions(+), 157 deletions(-)

-- 
2.26.2.303.gf8c07b1a785-goog

