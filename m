Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35433 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbeIQKzf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Sep 2018 06:55:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id 7-v6so7097042pgf.2
        for <linux-block@vger.kernel.org>; Sun, 16 Sep 2018 22:29:49 -0700 (PDT)
From: Heiner Litz <hlitz@ucsc.edu>
To: linux-block@vger.kernel.org
Cc: javier@cnexlabs.com, mb@lightnvm.io, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com
Subject: [RFC PATCH 0/6] lightnvm: pblk: Introduce RAIL to enforce low tail read latency
Date: Sun, 16 Sep 2018 22:29:33 -0700
Message-Id: <20180917052939.4776-1-hlitz@ucsc.edu>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi All,
this patchset introduces RAIL, a mechanism to enforce low tail read latency for
lightnvm OCSSD devices. RAIL leverages redundancy to guarantee that reads are
always served from LUNs that do not serve a high latency operation such as a
write or erase. This avoids that reads become serialized behind these operations
reducing tail latency by ~10x. In particular, in the absence of ECC read errors,
it provides 99.99 percentile read latencies of below 500us. RAIL introduces
capacity overheads (7%-25%) due to RAID-5 like striping (providing fault
tolerance) and reduces the maximum write bandwidth to 110K IOPS on CNEX SSD.

This patch is based on pblk/core and requires two additional patches from Javier
to be applicable (let me know if you want me to rebase):

The 1st patch exposes some existing APIs so they can be used by RAIL
The 2nd patch introduces a configurable sector mapping function
The 3rd patch refactors the write path so the end_io_fn can be specified when
setting up the request
The 4th patch adds a new submit io function that acquires the write semaphore
The 5th patch introduces the RAIL feature and its API
The 6th patch integrates RAIL into pblk's read and write path
