Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823CFC433FE
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 23:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5856C61077
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 23:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhJFXP2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Oct 2021 19:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhJFXP2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Oct 2021 19:15:28 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B2FC061755
        for <linux-block@vger.kernel.org>; Wed,  6 Oct 2021 16:13:34 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id j2so4473975ilo.10
        for <linux-block@vger.kernel.org>; Wed, 06 Oct 2021 16:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OCNBphKAfWXDaAht8UQdCK6F187ODvF0e1hM63EFZbQ=;
        b=SNaa2PaGR6lXvINONlsLnAvfuyezrW4U04/yAA3RiP4x5CfKVOfjio46zKjPpRVYC6
         miaidQHvu0m2lYgcWeerAz0vSjrJb9kfIXUr64BptFCUEPYk56YvJSqrOiTS4ZVq44K+
         pQaD3RafWL9TyEuSTQDCgFVMVHan0SoXox03xOCSlYxLsyhwDncyFz8IfHZJ6PiebFjT
         Y+AR+wEQneSLEKOZqaewNnJ+TEJ8RPaxnYtZAp2hBRtYJzDpF3ZxSuknFGzJ/OIFaUIB
         th5sfLRJTh5la1L+k+yrnXLgKw42Fni/zzx46fnIrH8UmVbxFAJNubUoSrtpYBNs2sIe
         plmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OCNBphKAfWXDaAht8UQdCK6F187ODvF0e1hM63EFZbQ=;
        b=rW08QDvakTsujAhfdjyUeyvmpfnU8JDDoE8i2CZXu9cRDmwQmkbMWVL/+bGH0sCUdt
         gy6kCB+e3oERfG2P5685xImyDKiTODggenQ0M0rMqwVbDNCjFC6IlYxIml1Ex0UjxDsf
         4dYCWPZK8j+NYTUpyaCR16qCDEp/XHmaZcN7YhQDc7JWseg6Ybrb30Ye6SAHAyrfGPX2
         DnpuX1cMF8V7ChGnF95XZVAixBS5E9mXrqbgjl4UejwKkFni/vYplA8+hFmt2gtn23jl
         tCr6ZpD5R3zdqrQLGPT2t2pKcRjPzszNOtU4wbCDIG+ypa6tJOr/n1XacmJLqlyqwUwr
         ZKrA==
X-Gm-Message-State: AOAM5339QvC/asRfbLFqIr0Z/ac3R1ORnc9VJ4BaPdRCjPTpMUHNAJMv
        9hJNS+FyJ55SQLFEGGnkqRMo0QoyPLoZbQ==
X-Google-Smtp-Source: ABdhPJxOLwHCmtGHmTd6CVRRlGIOnDGJq14EogDccq49S/kNEJcVF8+5nhem0NZjyDdLgNOqqC2dXQ==
X-Received: by 2002:a05:6e02:bc9:: with SMTP id c9mr640846ilu.309.1633562014171;
        Wed, 06 Oct 2021 16:13:34 -0700 (PDT)
Received: from p1.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id o1sm12955203ilj.41.2021.10.06.16.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 16:13:33 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     io-uring@vger.kernel.org
Subject: [PATCHSET v2 0/3] Add plug based request allocation batching
Date:   Wed,  6 Oct 2021 17:13:27 -0600
Message-Id: <20211006231330.20268-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Even if the caller knows that N requests will be submitted, we still
have to go all the way to tag allocation for each one. That's somewhat
inefficient, when we could just grab as many tags as we need initially
instead.

This small series allows request caching in the blk_plug. We add a new
helper for passing in how many requests we expect to submit,
blk_start_plug_nr_ios(), and then we can use that information to
populate the cache on the first request allocation. Subsequent queue
attempts can then just grab a pre-allocated request out of the cache
rather than go into the tag allocation again.

This brings single core performance on my setup from:

taskset -c 0,16  t/io_uring -b512 -d128 -s32 -c32 -p1 -F1 -B1 -n2 /dev/nvme1n1 /dev/nvme2n1
Added file /dev/nvme1n1 (submitter 0)
Added file /dev/nvme2n1 (submitter 1)
polled=1, fixedbufs=1, register_files=1, buffered=0, QD=128
Engine=io_uring, sq_ring=128, cq_ring=256
submitter=0, tid=1206
submitter=1, tid=1207
IOPS=5806400, BW=2835MiB/s, IOS/call=32/32, inflight=(77 32)
IOPS=5860352, BW=2861MiB/s, IOS/call=32/31, inflight=(102 128)
IOPS=5844800, BW=2853MiB/s, IOS/call=32/32, inflight=(102 32)

to:

taskset -c 0,16  t/io_uring -b512 -d128 -s32 -c32 -p1 -F1 -B1 -n2 /dev/nvme1n1 /dev/nvme2n1
Added file /dev/nvme1n1 (submitter 0)
Added file /dev/nvme2n1 (submitter 1)
polled=1, fixedbufs=1, register_files=1, buffered=0, QD=128
Engine=io_uring, sq_ring=128, cq_ring=256
submitter=0, tid=1220
submitter=1, tid=1221
IOPS=6061248, BW=2959MiB/s, IOS/call=32/31, inflight=(114 82)
IOPS=6100672, BW=2978MiB/s, IOS/call=32/31, inflight=(128 128)
IOPS=6082496, BW=2969MiB/s, IOS/call=32/32, inflight=(77 38)

which is about a 4-5% improvement in single core performance. Looking
at profiles, we're spending _less_ time in sbitmap even though we're
doing more work.

V2:
- Remove hunk from another patch in patch 2
- Make the plugging limits block layer private

-- 
Jens Axboe


