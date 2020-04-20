Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7068C3815B
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 08:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A10A021927
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 08:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="jcFahNVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgDTIEq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgDTIEo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 04:04:44 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84290C061A0C
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 01:04:44 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g12so10226405wmh.3
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 01:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fv2Oi9ufX0LkGa3j+9DwW6rcNLKbTdnyozIfpaN2Whs=;
        b=jcFahNVCM1FBuXtg3EweZLC281pBCbnwwWQTVjrnL/WcgQZhHqVBIjCzie6c2d8nyb
         vNgcVmnhtHIAgNL64bNehP28fil40pHJ2BsfMiHRGbzUMLfUckJTpIHI4NmQPFOX0KsJ
         4WAnubBP4jvYNcJK43JeJLC+iDj9pMHl4iZ51OmpcVcQEk5BBdKHa8p+2eLMbMGOjC2N
         1Jz3LuDQCwWxj1CXv/MWN79JSY6enw5AeRPLmc14IXq9VFYWdFQXcJ/c8N6tiQYXjoeR
         8qEBixXQQLjX9IvILjpvb85YZePx9lzxQWjBqiu+AjxHqMXU+j9UtmYFlRYsfB/xNXQP
         WpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fv2Oi9ufX0LkGa3j+9DwW6rcNLKbTdnyozIfpaN2Whs=;
        b=abpyDtzSq5VHInm7tb7His4NgfSs/7SCR0LvnQQR4pGMJFM+GASOaaOBWF3bAD6Cg9
         MOdKGDskvB107ZscG+tAo8WV92IJEtKMktWpnzeSM/6cg89xv5LA4EdyH4kBvYFEwOfs
         B0py6u9+eC/Cctunbqgyyb4gMJgqPNWkxqC2HEsABNA4eY02OKKhMsfMfFHZ59kLhz0N
         VaAv2bBsS/QD0Uv8qD5X6Ith+HKgKXL5igWLvKiEHwLgmia/By72UvY8vM2nq43xuqcp
         AaO67ENwMMydzEyIMK+Dj+VV2unUvRYE5EekYY9/h+v7R1LapTSAKYlaT1Bak17GaOmQ
         VwBA==
X-Gm-Message-State: AGi0PuadAM37y3YurKwXPoR5KNsuPM1JpbtDpuIkX3BumLVWWLv/THBa
        1OMkq/IxO4tqikb4XGhP5Whnvw==
X-Google-Smtp-Source: APiQypJjiSUFYYQJVEwwmdO78/PS77Qb2pg5Locx//XIF9CmAuSIYC86/h+9eaBWFWJIxbf1MCg9mw==
X-Received: by 2002:a7b:ce88:: with SMTP id q8mr17515560wmj.161.1587369883251;
        Mon, 20 Apr 2020 01:04:43 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id a67sm335827wmc.30.2020.04.20.01.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 01:04:42 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        Martijn Coenen <maco@android.com>
Subject: [PATCH 0/4] Add a new LOOP_SET_FD_AND_STATUS ioctl.
Date:   Mon, 20 Apr 2020 10:04:05 +0200
Message-Id: <20200420080409.111693-1-maco@android.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
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
one, which is described in more detail in the last change in the series.

Note that this series depends on
"loop: Call loop_config_discard() only after new config is applied."
[0], which I sent as a separate patch as it fixes an unrelated bug.

[0]: https://lkml.org/lkml/2020/3/31/755

Martijn Coenen (4):
  loop: Refactor size calculation.
  loop: Factor out configuring loop from status.
  loop: Move loop_set_from_status() and friends up.
  loop: Add LOOP_SET_FD_AND_STATUS ioctl.

 drivers/block/loop.c      | 309 ++++++++++++++++++++++----------------
 include/uapi/linux/loop.h |   6 +
 2 files changed, 189 insertions(+), 126 deletions(-)

-- 
2.26.1.301.g55bc3eb7cb9-goog

