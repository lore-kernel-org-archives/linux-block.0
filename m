Return-Path: <SRS0=MdGt=N4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5F0C43441
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 23:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5224520825
	for <linux-block@archiver.kernel.org>; Sat, 17 Nov 2018 23:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="U6Z0rHEO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5224520825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeKRKLu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Nov 2018 05:11:50 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42361 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbeKRKLt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Nov 2018 05:11:49 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so8739407pga.9
        for <linux-block@vger.kernel.org>; Sat, 17 Nov 2018 15:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=vg0Te61FL5WUMDKITRC/hKkoXhThs6kltKkJ/TOFcHM=;
        b=U6Z0rHEO23HHr5X1a//WPtlEEURKPE4vSUTZvDSN3RJzlfnpn/skXij/Ig5AfZy6b7
         tvc5SVOdhX0Bpjiog1sLRSiFMnnWW38iD4b0P0xh+EMX/D2l7lvDSUspO2Xf5bjcXpz5
         C8GoXJCLNjVXtr5v3GUZCW7l4SYex8omIAH9RPzIEFKIf1SevIwyO3mGmaSUse8fu0S0
         PMxfU+8HwOqVsH7h0WypWFZFminupUTcoIGVJvI994htzBgA/nZOafbvjtf1Fa42duFl
         o3/wVo4GpDf2MgSH1eE7XjCqpeRurKezwhtBDj8lIXi/Awv/xx12o751aIp8U/Cj0Tdw
         vTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=vg0Te61FL5WUMDKITRC/hKkoXhThs6kltKkJ/TOFcHM=;
        b=LRETn7EsN0NP7b7ScC0TTndH/RS+mHDhDhCo2k2M98PjWSgHBcOq8V3+NjPX2razBI
         DkYDgkKz5N3jPv9pSeqi6bIoB4RY0/zPUpKdVD8CnzbcWgY7wh8c500FvyAxb1tRm3jf
         WmdqkEp1VsHLTRuEeQr80i3jN04W18hIULz1exbp+ecBv6g8hhmBAtIEdMfh30VAJX+z
         iGD0xi7HLx7ULVx/znRfrcahwG+R5MpVDemMHRFsseTNlQKEP9ggGvqDCSX3kZt7VpMs
         BBvr/y1SxWXHz9oUTeNgTM4pQCrPIm0vZvsotJI9SL7/TqXSEqRXN5JPXPwSlrotsOOA
         PNzw==
X-Gm-Message-State: AGRZ1gL8EHZn3StP95KJkh+0V51im2V48o5qPNDYDsCD0QFZ3YvYDHwb
        6J/IAsNbGPRp8y3VwO4VnbzxBRZsY4Y=
X-Google-Smtp-Source: AJdET5fwCjk6lLhJEe6NFnkRfOsGuNnxI2dj+E50IRgOI/5TBDIsbb7VTWti3YrjJwnMwBWWK8uuCA==
X-Received: by 2002:a62:a511:: with SMTP id v17-v6mr16994291pfm.18.1542498803504;
        Sat, 17 Nov 2018 15:53:23 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id m1sm15812345pgn.9.2018.11.17.15.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 15:53:21 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCHSET 0/5] Support for polled aio
Date:   Sat, 17 Nov 2018 16:53:12 -0700
Message-Id: <20181117235317.7366-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Up until now, IO polling has been exclusively available through preadv2
and pwrite2, both fully synchronous interfaces. This works fine for
completely synchronous use cases, but that's about it. If QD=1 wasn't
enough read the performance goals, the only alternative was to increase
the thread count. Unfortunately, that isn't very efficient, both in
terms of CPU utilization (each thread will use 100% of CPU time) and in
terms of achievable performance.

With all of the recent advances in polling (non-irq polling, efficiency
gains, multiple pollable queues, etc), it's now feasible to add polling
support to aio - this patchset just does that.

An iocb flag is added, IOCB_FLAG_HIPRI, similarly to how we have
RWF_HIPRI for preadv2/pwritev2. It's applicable to the commands that
read/write data, like IOCB_CMD_PREAD/IOCB_CMD_PWRITE and the vectored
variants.  Submission works the same as before.

The polling happens off io_getevents(), when the application is looking
for completions. That also works like before, with the only difference
being that events aren't waited for, they are actively found and polled
on the device side.

The only real difference in terms of completions is that polling does
NOT use the libaio user exposed ring. This is just not feasible, as the
application needs to be the one that actively polls for the events.
Because of this, that's not supported with polling, and the internals
completely ignore the ring.

Outside of that, it's illegal to mix polled with non-polled IO on the
same io_context. There's no way to setup an io_context with the
information that we will be polling on it (always add flags to new
syscalls...), hence we need to track this internally. For polled IO, we
can never wait for events, we have to actively find them. I didn't want
to add counters to the io_context to inc/dec for each IO, so I just made
this illegal. If an application attempts to submit both polled and
non-polled IO on the same io_context, it will get an -EINVAL return at
io_submit() time.

Performance results have been very promising. For an internal Facebook
flash storage device, we're getting 20% increase in performance, with an
identical reduction in latencies. Notably, this is testing a highly
tuned setup to just turning on polling. I'm sure there's still extra
room for performance there. Note that at these speeds and feeds, the
polling ends up NOT using more CPU time than we did without polling!

On that same box, I ran microbenchmarks, and was able to increase peak
performance 25%. The box was pegged at around 2.4M IOPS, with just
turning on polling, the bandwidth was maxed out at 12.5GB/sec doing 3.2M
IOPS. All of this with 2 millions LESS interrupts/seconds, and 2M+ less
context switches.

In terms of efficiency, a tester was able to get 800K+ IOPS out of a
_single_ thread at QD=16 on a device. These kinds of results are just
unheard of in terms of efficiency.

You can find this code in my aio-poll branch, and that branch (and
these patches) are on top of my mq-perf branch.

 fs/aio.c                     | 495 ++++++++++++++++++++++++++++++++---
 fs/block_dev.c               |   2 +
 fs/direct-io.c               |   4 +-
 fs/iomap.c                   |   7 +-
 include/linux/fs.h           |   1 +
 include/uapi/linux/aio_abi.h |   2 +
 6 files changed, 478 insertions(+), 33 deletions(-)

-- 
Jens Axboe


