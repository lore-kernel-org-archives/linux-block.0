Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2A1C77B7A
	for <linux-block@archiver.kernel.org>; Tue,  6 Jun 2023 11:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237031AbjFFLin (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Jun 2023 07:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237262AbjFFLid (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Jun 2023 07:38:33 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323FB1988
        for <linux-block@vger.kernel.org>; Tue,  6 Jun 2023 04:38:03 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f3bb395e69so7619267e87.2
        for <linux-block@vger.kernel.org>; Tue, 06 Jun 2023 04:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20221208.gappssmtp.com; s=20221208; t=1686051480; x=1688643480;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RuUYiShAVsr/HQXAy2EuULhAqBmB4VM4J4Wz4NRgzOM=;
        b=tVovYlEmhUSlLnvELQxcPikgppad4Fqf4CV8W8h2fBXiX6quQya3h23sutIIdD5SGj
         EHoe2l//8SYc8xJiSDL68Idy93xoV+SrWf0YNbOlLcPXX7A/Mbf1DGmeItbJLUYuWwha
         eGGY6NfRc+LPzNl1EMNOfmOjm91ZlC6CvhEsiopWay86S3/8urUXi8/c8tgsGhGkQyuQ
         I4NighavESAvG6kRh50B3ZeLCw//+SUINTlg5cxu8OLGGpAoE60DraoN29HVQMdE6jtT
         beMKhOV31SCYcdpobYxCrFWBmrBSZnNbWBIltALMkCm8c2bvZuqwm5zCPxAEPnyccSYn
         4glQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686051480; x=1688643480;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RuUYiShAVsr/HQXAy2EuULhAqBmB4VM4J4Wz4NRgzOM=;
        b=fjZZYLXpbXnzkEJG4b3hKpAaIhaNKxVemEfQscDSdWTaKb3vChTQ9IGLJQfTegdiKR
         PjaK9MbBn6c+yT8guysxiZRJCF+yqHGU+O8awZbH+ZJmxTlrwoBTYy3crpOPOMcgTOU3
         2EYKFaqHY1RjYuKmeRma3qciiLj7/cB4cpt5o3l17JMTVT8WVEqfGZNIy30C0seBALc7
         yqYoRWDsMO8HhnfCDRSxvm09JrWPap5IROr04TenO4z0u02PC6/+UPcGqc2Fz0RICGbz
         LPr1DcAwHrkXE8ttVpTSR1S/boWPvZM/bHSjabgN1xQX+I3ukWNM16PZ0NjTculfC06B
         EVhw==
X-Gm-Message-State: AC+VfDx6CEJUkVSL193xgYt2UVFOUQRNvab+LUg/s6XO0Yu47AsrazUQ
        IP9dxRKZu1u4QfWu4e/L6lq3aHoQTwDvAjxb69jIl/x4OaLaijsxAVY=
X-Google-Smtp-Source: ACHHUZ76cVTfSMlBx0hx0MOYrARUD2mxISMgc8umBYfkWedgvv1Y6VCqt0iL+k/KKBhCxboC0hkfux5h3gLP8Huz2S0=
X-Received: by 2002:a2e:9d97:0:b0:2b1:c1b2:e2ef with SMTP id
 c23-20020a2e9d97000000b002b1c1b2e2efmr1026938ljj.51.1686051480068; Tue, 06
 Jun 2023 04:38:00 -0700 (PDT)
MIME-Version: 1.0
From:   Andrew Murray <amurray@thegoodpenguin.co.uk>
Date:   Tue, 6 Jun 2023 12:37:49 +0100
Message-ID: <CALqELGxfvF-YuU_K7709nN=LPkr5AWQe9ypGH2JZkPosORg9rw@mail.gmail.com>
Subject: Slow random write access
To:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

I've been working with an embedded video recording device that writes
data to the exfat filesystem of an SD card. 4 files (streams of video)
are written simultaneously by processes usually running on different
cores.

If you assume a newly formatted SD card, then because exfat clusters
appear to be sequentially allocated as needed when data is written (in
userspace), then those clusters are interleaved across the 4 files.
When writeback occurs, you see a cluster of sequential writes for each
file but with gaps where clusters are used by other files (as if
writeback is happening per process at different times). This results
in a random access pattern. Ideally an IO scheduler would recognise
these are cooperating processes, merge these 4 clusters of activities
to result in a sequential write pattern and combine into fewer larger
writes.

This is important for SD cards, because their write throughput is very
dependent on access patterns and size of write request. For example my
current SD card and above access pattern (with writes averaging 60KB)
results in a write throughput for a fully utilised device of less than
a few MB/S. This may seem contrary to the performance claims of SD
card manufacturers, but those claims are typically made for sequential
access with 512KB writes. Further, the claims made for the UHS speed
grades, e.g. U3 and the video class grades, e.g. V90 also assume that
specific SD card commands are used to enter a specific speed grade
mode (which isn't supported in Linux it seems). In other words larger
write accesses and more sequential access patterns will increase the
available bandwidth. (The only exception appears to be for the
application classes of SD cards which are optimised for random access
at 4KB).

I've explored the various mq schedulers (i'm still learning) - though
I understand that to prevent software being a bottleneck for fast
devices each core (or is that process?) has its own queue. As a result
schedulers can't make decisions across those queues (as that defeats
the point of mq). Thus implying that in my use-case, where
"cooperating processes" are on separate cores, then there is no
capability for the scheduler to combine the interleaved writes (I
notice that bfq has logic to detect this, though not sure if it's for
reads or rotational devices).

I've seen that mq-deadline appears to sort it's dispatch queue (I
understand a single queue for the device - so this is where those
software queues join) by sector - combined with the write_expire and
fifo_depth tunables - then it appears that mq-deadline does a good job
of turning interleaved writes to sequential writes (even across
processes running on different cores). However it doesn't appear to
combine writes which would greatly help.

Many of the schedulers aim to achieve a maximum latency, but it feels
like for slow devices, then a minimum write latency and ability to
reorder and combine those writes across cores would be beneficial.

I'm keen to understand if there is anything I've missed? Perhaps there
are tuneables or a specific scheduler that fits this purpose? Are my
assumptions about the mq layer correct?

Does it make sense to add merging in the dispatch queue (within
mq-deadline), is this the right approach?

Thanks,

Andrew Murray
