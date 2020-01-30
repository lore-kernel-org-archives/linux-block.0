Return-Path: <SRS0=k455=3T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63280C2D0DB
	for <linux-block@archiver.kernel.org>; Thu, 30 Jan 2020 19:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366272082E
	for <linux-block@archiver.kernel.org>; Thu, 30 Jan 2020 19:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l/XUfyOZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgA3Tem (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:34:42 -0500
Received: from mail-io1-f48.google.com ([209.85.166.48]:37255 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgA3Tel (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jan 2020 14:34:41 -0500
Received: by mail-io1-f48.google.com with SMTP id k24so5385148ioc.4
        for <linux-block@vger.kernel.org>; Thu, 30 Jan 2020 11:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Uqfd4nHPzlTao5D1BCx3Lm6HKEPbqy0Pm2K9v2dKhEc=;
        b=l/XUfyOZQcEys/3CmHKqR38z2/ZBH3253kzyOszVOzfvOxa1yHnN654HGX68pkzXLR
         wnuzMh358yIMK3o+4lSIT0VygAqyRmatDqENZSVDd6UnH3arZPm54UeegmrT1ukw2x5Z
         VCOhUHYkXHkMWnmfa/ZwZZFjpJK3BlhG7YdjmhtOR67YNDd4KkviRccgCKbtHmduZ5jx
         GoeBDB1XxsUsdTEOACS+CIJ3YLXtKnOY29zGaE3ucLey4WiaxfdMujfUoEfSjSGKxTTs
         FBsMSIto2UhIGf+yhBSBdEvut6figPgUtB3nL+JH8tp6rF625Y9G/jlpObmqDOkd342B
         x8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Uqfd4nHPzlTao5D1BCx3Lm6HKEPbqy0Pm2K9v2dKhEc=;
        b=lcCwUqd+uayzd5r3zJ1mYyy2+lBy0PNmMcyzmyz3ocBYerj+bpKTmLrI3FhHz5EBPb
         HRaUpY2JQmZKLBHq2LLzjpToeM2DNV7j6fewmz9ual7UNxJqjN5DTSW7bI+0JDTNDJnV
         vmOlKvGMfjtjk+4NdjoRvZA7umd7kDz1drCZZN08KJkgE//FGNir7WamedSDQscUTXC2
         eLcUYLz8z/KhE61kCobXteGn5BXMjNbvVZL56OGSRctiuulwXIphXKxpRRX9ID/JEPe9
         BQMriW2KmCym+6mrCEr4rYo0/vNZyq4uD+gnVfW0ERBZUnDbaYg23M8qR9FE4lg9JsUl
         IJnA==
X-Gm-Message-State: APjAAAUXeLVaK0vg0fCxlgKFqTKA8t/jU3fLNumDKnZGsBEfYcf91wOA
        Z1P5w88iuAsZYYB7Fj892EOS+MxPOQFDOfaTLrwpCA==
X-Google-Smtp-Source: APXvYqxzmQHoBuJf804yymWbET6TVNO0QQs/sw6vTG9Zhd91VfLEVDxNI0Y0iLieowscYVLAlh8CLoyKPzkYejAXXZs=
X-Received: by 2002:a5d:9285:: with SMTP id s5mr5475456iom.85.1580412880940;
 Thu, 30 Jan 2020 11:34:40 -0800 (PST)
MIME-Version: 1.0
From:   Salman Qazi <sqazi@google.com>
Date:   Thu, 30 Jan 2020 11:34:29 -0800
Message-ID: <CAKUOC8WM3XU5y9QKHrO8VBdC4Dghexqy+o9OGM1qUs4kGQxZdQ@mail.gmail.com>
Subject: Hung tasks with multiple partitions
To:     Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org
Cc:     Jesse Barnes <jsbarnes@google.com>,
        Gwendal Grignou <gwendal@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

I am writing on behalf of the Chromium OS team at Google.  We found
the root cause for some hung tasks we were experiencing and we would
like to get your opinion on potential solutions.  The bugs were
encountered on 4.19 kernel.
However my reading of the code suggests that the relevant portions of the
code have not changed since then.

We have an eMMC flash drive that has been carved into partitions on an
8 CPU system.  The repro case that we came up with, is to use 8
threaded fio write-mostly workload against one partition, let the
system use the other partition as the read-write filesystem (i.e. just
background activity) and then run the following loop:

while true; do sync; sleep 1 ; done

The hung task stack traces look like the following:

[  128.994891] jbd2/dm-1-8     D    0   367      2 0x00000028
last_sleep: 96340206998.  last_runnable: 96340140151
[  128.994898] Call trace:
[  128.994903]  __switch_to+0x120/0x13c
[  128.994909]  __schedule+0x60c/0x7dc
[  128.994914]  schedule+0x74/0x94
[  128.994919]  io_schedule+0x1c/0x40
[  128.994925]  bit_wait_io+0x18/0x58
[  128.994930]  __wait_on_bit+0x78/0xdc
[  128.994935]  out_of_line_wait_on_bit+0xa0/0xcc
[  128.994943]  __wait_on_buffer+0x48/0x54
[  128.994948]  jbd2_journal_commit_transaction+0x1198/0x1a4c
[  128.994956]  kjournald2+0x19c/0x268
[  128.994961]  kthread+0x120/0x130
[  128.994967]  ret_from_fork+0x10/0x18

I added some more information to trace points to understand what was
going on.  It turns out that blk_mq_sched_dispatch_requests had
checked hctx->dispatch, found it empty, and then began consuming
requests from the io scheduler (in blk_mq_do_dispatch_sched).
Unfortunately, the deluge from the I/O scheduler (BFQ in our case)
doesn't stop for 30 seconds and there is no mechanism present in
blk_mq_do_dispatch_sched to terminate early or reconsider
hctx->dispatch contents.  In the meantime, a flush command arrives in
hctx->dispatch (via insertion in  blk_mq_sched_bypass_insert) and
languishes there.  Eventually the thread waiting on the flush triggers
the hung task watchdog.

The solution that comes to mind is to periodically check
hctx->dispatch in blk_mq_do_dispatch_sched and exit early if it is
non-empty.  However, not being an expert in this subsystem, I am not
sure if there would be other consequences.

Any help is appreciated,

Salman
