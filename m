Return-Path: <SRS0=wI0I=WY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DF3C3A5A1
	for <linux-block@archiver.kernel.org>; Wed, 28 Aug 2019 03:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601E721883
	for <linux-block@archiver.kernel.org>; Wed, 28 Aug 2019 03:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TjQXccpZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfH1DzA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Aug 2019 23:55:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42045 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfH1DzA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Aug 2019 23:55:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id i30so758431pfk.9
        for <linux-block@vger.kernel.org>; Tue, 27 Aug 2019 20:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y9181Itz3jIauqOELXX6WInlwQHr+dm37ugRC+ucshM=;
        b=TjQXccpZVKZ1sffAXO/DsPyDsK+AdFu9vdXcGvo9YuHGjpeHZlNiTOqwGfSPmYezm8
         l9Ajufq1E8hHy8CbTnQ2anykStPYMn7aF2ga3wEwW/IN1412J6cvxPr1DCxzzre7bLtx
         yS+d1Zh8I5PLqcOSKW5u/cce0sblzCDq2saTXTtJySLWpDmPv4on2rEXv33NS+3gHECZ
         /SIke6FZhTib1ascyJl3ItKGFoiCXn+zjg79QsgbWTNJQuWIrANzjeE+aU6JHsMPNJ9y
         IyyyJ8KkIDEJn10TuxcBtjTkEygENGwIvTRAXT18w5KFl4l7fKuf377AwEnhJljA6BBF
         crrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y9181Itz3jIauqOELXX6WInlwQHr+dm37ugRC+ucshM=;
        b=jt6tKa58Jv3jMjwjoQTmxzySI8yQBwj0aBvoaTrbkrmq+BpYRXx9yHTRJ0I9fW0EvU
         4M+xtUuw5PCz4qATxaZEkVF8fVTpX3Om85jJG94okWB1q//5iD4miOEgCwFxuUpPZtn7
         0WpFkkmFggNvqVBRl38w1OhwaWj4+2CRSTp8U0JSLn0TTitRFSFzHI4dQtueQnYTjL4M
         vmCsNpfNNJutqi4uDyckHYldwm68bqv+WOOLc3aUOU7qvcmH6zZ+kHSMTs0uTg870oxO
         wQcwLuPdGPua4GelVP3OPkjDalq+qQWLbpCkQrEB2llc5LFWaKa3TahlE7Aj1/lWpAob
         F41g==
X-Gm-Message-State: APjAAAVMaPNBqHjT/82XVu/m6IhKMIjuSVgTqcgz33s/rB4Pa+3UPv4y
        hUJEzdYPGt55aNBeNVMvwUPDRA==
X-Google-Smtp-Source: APXvYqzmfJh9pWOwzVARAistAKFsjEbyiAppZPV4jIoYh1R0tTv5COwEsvxQ4IKTKUnzMpTTzS4AvQ==
X-Received: by 2002:a17:90a:ac02:: with SMTP id o2mr2160177pjq.134.1566964499671;
        Tue, 27 Aug 2019 20:54:59 -0700 (PDT)
Received: from localhost ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id y188sm891408pfb.115.2019.08.27.20.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 20:54:59 -0700 (PDT)
From:   Fam Zheng <zhengfeiran@bytedance.com>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, paolo.valente@linaro.org, fam@euphon.net,
        duanxiongchun@bytedance.com, cgroups@vger.kernel.org,
        zhangjiachen.jc@bytedance.com, tj@kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH v3 0/3] Implement BFQ per-device weight interface
Date:   Wed, 28 Aug 2019 11:54:50 +0800
Message-Id: <20190828035453.18129-1-zhengfeiran@bytedance.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

v3: Pick up rev-by and ack-by from Paolo and Tejun.
    Add commit message to patch 3.

(Revision starting from v2 since v1 was used off-list)

Hi Paolo and others,

This adds to BFQ the missing per-device weight interfaces:
blkio.bfq.weight_device on legacy and io.bfq.weight on unified. The
implementation pretty closely resembles what we had in CFQ and the parsing code
is basically reused.

Tests
=====

Using two cgroups and three block devices, having weights setup as:

Cgroup          test1           test2
============================================
default         100             500
sda             500             100
sdb             default         default
sdc             200             200

cgroup v1 runs
--------------

    sda.test1.out:   READ: bw=913MiB/s
    sda.test2.out:   READ: bw=183MiB/s

    sdb.test1.out:   READ: bw=213MiB/s
    sdb.test2.out:   READ: bw=1054MiB/s

    sdc.test1.out:   READ: bw=650MiB/s
    sdc.test2.out:   READ: bw=650MiB/s

cgroup v2 runs
--------------

    sda.test1.out:   READ: bw=915MiB/s
    sda.test2.out:   READ: bw=184MiB/s

    sdb.test1.out:   READ: bw=216MiB/s
    sdb.test2.out:   READ: bw=1069MiB/s

    sdc.test1.out:   READ: bw=621MiB/s
    sdc.test2.out:   READ: bw=622MiB/s

Fam Zheng (3):
  bfq: Fix the missing barrier in __bfq_entity_update_weight_prio
  bfq: Extract bfq_group_set_weight from bfq_io_set_weight_legacy
  bfq: Add per-device weight

 block/bfq-cgroup.c  | 151 +++++++++++++++++++++++++++++++++-----------
 block/bfq-iosched.h |   3 +
 block/bfq-wf2q.c    |   2 +
 3 files changed, 119 insertions(+), 37 deletions(-)

-- 
2.22.1

