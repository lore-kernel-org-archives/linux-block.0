Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AE9C433EF
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 16:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C1B610E5
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 16:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhJFQhS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbhJFQhR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Oct 2021 12:37:17 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7F4C061746
        for <linux-block@vger.kernel.org>; Wed,  6 Oct 2021 09:35:25 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id d18so3468649iof.13
        for <linux-block@vger.kernel.org>; Wed, 06 Oct 2021 09:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=msVIeFs4KRx0G52I454LZ5OGlbz556v7g/KPwBP7mcE=;
        b=uzYb+05OhQyBZvdL77U0c1vlr92n7PMggZz9lsoj1vu5BsXBn3IkvDLKgFq1A+Z7vI
         JtMlHYiEXt3P1PlAdZReROxST11km0JI6GkXK34ivd2AiNgh0BcMeI6cC5ffIUyPkHrp
         rk3BhCFAumlJAnBYwTACvYrSg7M3e54kSwoiq5AkpjP6OyGnfZMaPC789j2carv66mGs
         EEcE7tCozd5atYI1KwDXcIk/1aXdb8u0UG2Nl4xqy2/PPHNk9S3Dk1mDVRUULXrkFuHd
         3bq2R0Aq43bWaE4xROV6oLrrGLlTSUfV82qIkCrCAqCwRwzQ6Bms4Ye9Nldggmainjd6
         mjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=msVIeFs4KRx0G52I454LZ5OGlbz556v7g/KPwBP7mcE=;
        b=OlYRHhT1yfBL5HEaSCBHx2zn+donCuX/ed90vVv+ZRFzfWoE8zibA6XdjXwCeopfzx
         OxLHBLOedywEAnD6G3g/BuPLCMsK/oR945WRd0zjk1a8rGQzZ205FHvMmspoPTiBh1hp
         ezHt/CqjLZ7zBVVO2U5adBjuIq/TkumNVvviwQH7j+FtknKKcZiJ46wQl1nMZ73ZeuDF
         w7+Ri5gqBPWscGU0RDqxrMWwUQrurjFOa3Y/Kl/wyN2lnqZ7aZ8KcpuW8lOoAt/pQTlj
         CPmWhHSNmx24BYZPqWJFzNff4bD6KVq0gucohivn9sUzzFFMWfyQ7uTMksSlrzip/tMa
         hUEw==
X-Gm-Message-State: AOAM533JlKdX28j6TiqOqoUPVvnaowFHqTesCQw818gT9GLBqYxcsMfd
        VUimrWxB7DCJ3yGvGxQesTuGErSMNPFX04dBFjM=
X-Google-Smtp-Source: ABdhPJyNCP+xWCaQbaHX+Sa1RR/ABICK4oa5t73WLG9cF+OpxXi/AnJ9sAhfJYbV56OLZFbYIL2m8A==
X-Received: by 2002:a05:6602:1486:: with SMTP id a6mr7305390iow.104.1633538124595;
        Wed, 06 Oct 2021 09:35:24 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id n17sm1911890ile.76.2021.10.06.09.35.24
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 09:35:24 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Subject: [PATCHSET RFC 0/3] Add plug based request allocation batching
Date:   Wed,  6 Oct 2021 10:35:19 -0600
Message-Id: <20211006163522.450882-1-axboe@kernel.dk>
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

sudo taskset -c 0,16  t/io_uring -b512 -d128 -s32 -c32 -p1 -F1 -B1 -n2 /dev/nvme1n1 /dev/nvme2n1
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

-- 
Jens Axboe


