Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CF9C4361B
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 08:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3319423B99
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 08:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgLIIVf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Dec 2020 03:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgLIIVf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Dec 2020 03:21:35 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D4BC0613CF
        for <linux-block@vger.kernel.org>; Wed,  9 Dec 2020 00:20:54 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id g20so863908ejb.1
        for <linux-block@vger.kernel.org>; Wed, 09 Dec 2020 00:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UjGATTQ9Lr9mRaXTY4JfpSKxRrLubz3xzYpAsaHjJ4w=;
        b=Oo/+k9NArSKIDf+HvrumsXY0GBnwvwO4U099AOrfIaw76s0MeQxtL2wQ4yMoIau0TE
         HiB7MxGiHWfT155JhK+9dJ4c52MwVwSmKPf/c5UqhAHLhsgOodBRsnBBD5G/slgAGDa9
         fG+/1pBEM7qoHzmHFpHaUKrBxb7HS/3wx8n/7klShxyKe6BacjqHbCUQzqc1t5PHU69y
         Q3oZ6KDvnMMnxfYYd+DHcVRVolhx+BR55cZBqYHWDxIA2rrfS4TQDX0k3HHzjypMK0sc
         IJSHx9qfcnIPnEarnEAYPtV3UEjqXU2+GUgI/T18vrJmBRUcf5rsfuiy7ZLvcwRpvimt
         svcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UjGATTQ9Lr9mRaXTY4JfpSKxRrLubz3xzYpAsaHjJ4w=;
        b=OYi4M3lCnHXGaWaGFQ5aOYqb1WOnghRYRyGe/d6lr/ES2aChDwf6F99OeifbI1CTV4
         NL81KQBT/zIOawitJvkcmVfyTes33avPk67c+WAcrwFdn+Qr9R8HoCAX/ocENK3bdaSG
         2Otigm10ebHWlggsSIFsCvhGbe9n9DM4/q8ugClgSfXMPpc5PyqVAh2+ZYgyidHx3JuQ
         KyhtEqyBJaF2C9lEy1uZzzN3mFvRkD2KFh7StG2cDrnYizig1eEzeIaBa3cfV2jND2r4
         ZcIpWPj6OKPmZ6Rfkh80aRzwlN7SAsbA0ce6bg+VTbuPeRSlsbr4M+zcBnAfRt3O7yjX
         mxlg==
X-Gm-Message-State: AOAM531+1r7Itt5UVHsvAW3WIyNzuagxX3CYu1qbPsqc3VsHwkw50dTQ
        OrE/tUchIy5GHelYd6bx9esk1DD4wGCVUw==
X-Google-Smtp-Source: ABdhPJzqEZH8sJ/LkbMemVSn7DhV0m232TlWKj71css6SKRVWzbmU/DLwWpAahzRaT8aJdjrOsoREQ==
X-Received: by 2002:a17:906:a43:: with SMTP id x3mr1037348ejf.197.1607502053259;
        Wed, 09 Dec 2020 00:20:53 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49e0:2500:1d14:118d:b29c:98ec])
        by smtp.gmail.com with ESMTPSA id cf17sm823225edb.16.2020.12.09.00.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 00:20:52 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, danil.kipnis@cloud.ionos.com
Subject: [PATCH for-next 0/7] Misc update for rnbd
Date:   Wed,  9 Dec 2020 09:20:44 +0100
Message-Id: <20201209082051.12306-1-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This is the misc update for rnbd. It inlcudes:
- 2 follow-up fixes for commit 64e8a6ece1a5 ("block/rnbd-clt: Dynamically alloc buffer for pathname & blk_symlink_name")
  one warning, and one possible memleak.
- one fix for race with dev session sysfs removal.
- fix for write-back cache & FUA.
- reduce memory footprint by allocate sglist on demand and do not request pdu
  from rtrs-clt.
- Typo fix.

The patches are based on your block/for-next.

Gioh Kim (3):
  block/rnbd: Set write-back cache and fua same to the target device
  block/rnbd-clt: Dynamically allocate sglist for rnbd_iu
  block/rnbd-clt: Does not request pdu to rtrs-clt

Jack Wang (2):
  block/rnbd-clt: Fix possible memleak
  block/rnbd: Fix typos

Md Haris Iqbal (2):
  block/rnbd-clt: Get rid of warning regarding size argument in strlcpy
  block/rnbd-srv: Protect dev session sysfs removal

 drivers/block/rnbd/rnbd-clt-sysfs.c    |  5 +-
 drivers/block/rnbd/rnbd-clt.c          | 96 +++++++++++++++-----------
 drivers/block/rnbd/rnbd-clt.h          | 12 +++-
 drivers/block/rnbd/rnbd-proto.h        |  9 ++-
 drivers/block/rnbd/rnbd-srv.c          | 12 +++-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c |  6 --
 drivers/infiniband/ulp/rtrs/rtrs.h     |  7 --
 7 files changed, 88 insertions(+), 59 deletions(-)

-- 
2.25.1

