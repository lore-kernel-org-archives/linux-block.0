Return-Path: <SRS0=2FWQ=6L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675C6C7C7E0
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 07:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 473772192A
	for <linux-block@archiver.kernel.org>; Mon, 27 Apr 2020 07:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="NVGg/5Ip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgD0Hmi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Apr 2020 03:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgD0Hmg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 03:42:36 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0AAC061A0F
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2020 00:42:34 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j1so19298466wrt.1
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2020 00:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QtLRp+85jR+Nf/i2z1v6PWdUdTEfUVlr69TtjOuDJWU=;
        b=NVGg/5IpqqSuA3/KLPa6EraIviZXG/1nXUO03Xa+MNt9p/3k+8qY7/5r1QzcEXQlOa
         7IhRQbgS9KS540eO0D9w/u1YJUnj1MPnjCzaJVlVt8W9lp6paNgQgGROxmqdWTIF54T+
         QU1nSMXXIpoXoPV0CD6foZ9sDkgl8EN80/a7u1tMN3UX13wP5DdJ0VKQQMOnFChFspx2
         ZVmUs6txG+4E6dyf6hcG0GYPC/Uhf7u5RQW+inpQJym7IyEDquxq9v4D5EZE+2mpTA2+
         f9V4rsuNC8SXHXfNd55ceNl0xTwfVsHDBymrS6Vmv9Dn90ZOmddzryikHmjK3TL9YBBB
         D6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QtLRp+85jR+Nf/i2z1v6PWdUdTEfUVlr69TtjOuDJWU=;
        b=U1hxJTxgBbJ+evAiTjB45dujVpAVWyE85yxI2MPPEFWwoFGd4TkklahqMUV2G8k0Wr
         BX2I/MzAhZdOGQ0HtmjV0kQ0wFXLdJG+/k+dr8ari49d5vx9lnEr6NejxpYnrCo1uTHJ
         0QdQIJE/4T8iHUpEdn0kY6tJnKGMkyBk7pX3r+cGJR7oJfr8139xOgcEI5C831HzSVNx
         ZAR3WFZz1V4ZS/RyBA3v9kc+ENN1TxMgDlpt9NyEVfOoVdmp/NidfG6pUZTO3Npx1gSI
         Aa+if6YZwB8aj/GLhAhztHD5QbeogJFUJJYKCRLE2Kbin0shDQP2TJz8OnT+wgLTba45
         2rBQ==
X-Gm-Message-State: AGi0PuaYqytRWYNYMruz1bm9GJk9+GnyenPtfAkuus+LPh4s8HJ+jJPe
        MKEkqpIomqOBw4Ur4sJ+zDrBxA==
X-Google-Smtp-Source: APiQypJfbNuVlkn/65gvpBXpn90vfdq2r2PK0vtNZowSpjzmBU7pOrB82bLFg3r36ntfCnFmsBYjWw==
X-Received: by 2002:adf:a74b:: with SMTP id e11mr24056320wrd.99.1587973353543;
        Mon, 27 Apr 2020 00:42:33 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id x132sm15091658wmg.33.2020.04.27.00.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 00:42:32 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, Martijn Coenen <maco@android.com>
Subject: [PATCH v3 0/9] Add a new LOOP_SET_FD_AND_STATUS ioctl
Date:   Mon, 27 Apr 2020 09:42:13 +0200
Message-Id: <20200427074222.65369-1-maco@android.com>
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


Martijn Coenen (9):
  loop: Factor out loop size validation
  loop: Factor out setting loop device size
  loop: Switch to set_capacity_revalidate_and_notify()
  loop: Refactor loop_set_status() size calculation
  loop: Remove figure_loop_size()
  loop: Factor out configuring loop from status
  loop: Move loop_set_status_from_info() and friends up
  loop: Rework lo_ioctl() __user argument casting
  loop: Add LOOP_SET_FD_AND_STATUS ioctl

 drivers/block/loop.c      | 337 +++++++++++++++++++++++---------------
 include/uapi/linux/loop.h |   7 +
 2 files changed, 208 insertions(+), 136 deletions(-)

-- 
2.26.2.303.gf8c07b1a785-goog

