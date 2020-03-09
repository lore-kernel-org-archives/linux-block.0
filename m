Return-Path: <SRS0=ZA/H=42=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB95C10F25
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 20:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4686B2464B
	for <linux-block@archiver.kernel.org>; Mon,  9 Mar 2020 20:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWioRsA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgCIU7i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:59:38 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40910 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgCIU7i (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Mar 2020 16:59:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id n5so4518700qtv.7
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2020 13:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OI1aCLQHnpmDoPTY4E08elp0EiuK+c3JSvvnkm9D62U=;
        b=BWioRsA3+coJZ9Y1oO7hAMc0F3R3ga9DtRizoP5zaS5Y42pugwQS7CTzgUMoqV+P7X
         hfXJU324wZCyySTF68eK3nb+aVfpSfKeZYIIcQxUbCvgrs3fAjmaSqblYAXMWhmSs13u
         pF5GXT0vjXG3SUl35KZsYxMkKkJk4gmjPBa7PfXgQ4E4LfPnhbxExiLLSZLwLku4o2sH
         upPqesN4ZarrVX9qgqRUgmfK+b4JoGB4ihckwi5k+5xIEnxT5JGy/XfkHPtBfReCxT9n
         hPFVcqibMTQ8Ep+mSLElH1HFDJrlsVWKUxr1YEYJc6jdT1ufWXBv41pdIxKV6yuRlfWB
         eZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OI1aCLQHnpmDoPTY4E08elp0EiuK+c3JSvvnkm9D62U=;
        b=CwiRDBDlJ1VaSwRt6w6zdmiGqxoBmQCkAkzSpqBGN98QbXXqa6W73pH7pslmSQU47+
         Ffz7rFv5R6qILKQsFLxAKbH3+ajelGNpwU/MJ2PhGjf3x7ckKNneqbMI5T2rwY7mb1bs
         SP5RSWBOnsk6UbUfwrIgeIMLqituwmpm/iVS532GhiJLg3mJVWc5sUAoppfLGezdKYVV
         S7qKkPEutNe/ZOyErd4Tnj8e5nDoQRwI+66XEoaMwA5gs5ZQ8KgJb87Y4luFWOkWjZck
         SSjR3yRbCFbJVxbHjmWualBd/UvzqR4tpVVHh8trsGFPVBrwj0dqOXDLHnCrP21HEtZg
         fe/Q==
X-Gm-Message-State: ANhLgQ0JRHMoLouKDgwSDlU5zawARM3K4Xuwj7+IzFpB7z4r7dnBnd4k
        rRlsGtdL011Na54Z69+g6rv/iijq0WI=
X-Google-Smtp-Source: ADFU+vuv55+AjSfd10alPadjnb6j6ujVdRllhWPoAQe36OPCHWZmmYuUzaPnp8kMoJmV/mij8OlBLg==
X-Received: by 2002:ac8:24db:: with SMTP id t27mr16415631qtt.49.1583787576957;
        Mon, 09 Mar 2020 13:59:36 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::4078])
        by smtp.gmail.com with ESMTPSA id e130sm23089764qkb.72.2020.03.09.13.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 13:59:36 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     kernel-team@fb.com, mmullins@fb.com, josef@toxicpanda.com,
        Jes Sorensen <jsorensen@fb.com>
Subject: [PATCH 0/7] blk-mq request and latency stats
Date:   Mon,  9 Mar 2020 16:59:24 -0400
Message-Id: <20200309205931.24256-1-Jes.Sorensen@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jes Sorensen <jsorensen@fb.com>

Hi,

This patchset introduces statistics collection of request sizes and
latencies for blk-mq using the blk-stat infrastructue.

This was designed to have minimal overhead when not in use. It relies on
blk_rq_stats_sectors() and introduces a sectors counter to struct
blk_rq_stat.

For request sizes it uses 8 buckets per operation type. Latencies are
tracked in us precision, and uses 32 buckets per operation type. To
not blow up the size of struct request_queue, I changed it to
dynamically allocate these data structures.

Usage, request stats are enabled like this:
 $ echo 1 > /sys/block/nvme0n1/queue/reqstat
with output reading like this:
 $ cat /sys/block/nvme0n1/queue/stat
 read: 0 0 0 8278016 14270464 29323264 120107008 2069282816
 read reqs: 0 0 0 2021 1531 1377 3229 3627
 write: 4096 0 3072 10903552 9244672 6258688 16584704 2228011008
 write reqs: 8 0 1 2662 898 311 375 4972
 discard: 0 0 0 5242880 5472256 3809280 136880128 830554112
 discard reqs: 0 0 0 1280 515 196 4150 3717

Latency stats are enabled like this:
 $ echo 1 > /sys/block/nvme0n1/queue/latstat
with output reading like this
 $  cat /sys/block/nvme0n1/queue/latency
 read: 0 0 0 0 4 101 677 5146 1162 2654 1933 832 657 52 8 0 3 2 3 2 0 0 0 0 0 0 0 0 0 0 0 0
 write: 0 0 0 79 2564 2641 8087 6226 1580 4052 498 332 385 365 382 279 323 166 109 119 188 267 0 0 0 0 0 0 0 0 0 0
 discard: 0 0 0 0 0 0 0 17709 698 15 0 1 0 0 3 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

Cheers,
Jes


Jes Sorensen (7):
  block: keep track of per-device io sizes in stats
  block: Use blk-stat infrastructure to collect per queue request stats
  Export block request stats to sysfs
  Expand block stats to export number of of requests per bucket
  blk-mq: Only allocate request stat data when it is enabled
  blk-stat: Make bucket function take latency as an additional argument
  block: Introduce blk-mq latency stats

 block/blk-iolatency.c     |   2 +-
 block/blk-mq.c            | 110 ++++++++++++++++++++-
 block/blk-stat.c          |  18 ++--
 block/blk-stat.h          |  12 ++-
 block/blk-sysfs.c         | 195 ++++++++++++++++++++++++++++++++++++++
 block/blk-wbt.c           |   2 +-
 include/linux/blk_types.h |   1 +
 include/linux/blkdev.h    |  13 +++
 8 files changed, 338 insertions(+), 15 deletions(-)

-- 
2.17.1

