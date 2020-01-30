Return-Path: <SRS0=k455=3T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA73CC2D0DB
	for <linux-block@archiver.kernel.org>; Thu, 30 Jan 2020 21:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F2F2082E
	for <linux-block@archiver.kernel.org>; Thu, 30 Jan 2020 21:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZvKodAa6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgA3VDH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jan 2020 16:03:07 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:40332 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgA3VDH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jan 2020 16:03:07 -0500
Received: by mail-il1-f193.google.com with SMTP id i7so4312622ilr.7
        for <linux-block@vger.kernel.org>; Thu, 30 Jan 2020 13:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sAMdh1b8NESkD+VXMD9Cy1k3kQ4bBkxFJ6eHKFRQAzo=;
        b=ZvKodAa6XfO/GxKVRlhTWY1MXqXlmaSRa25RLrAv905fQ8ce+SsrCEQr1PKhL/zy9s
         5hKWCmZeOHBTyn6+8Io+niptiTF9M4z7SmVzp+S1kN/ooGPrQqiQCwnKjm+5u/toBe1m
         gIAbasAWsQS2Xb0o3YVSj1O9XHCWY4nU9KpHKQDVCP4mt/T+U3YK4MXVJRt7Wy2shohC
         3WN2+O6t4IFSjIZlY+TnjgiYDstaqK03rnA3YVNs0SdAFei86ievLI6XGIoxDHVNmskJ
         cgvdSqZcaff16YqqMbfFRhDbe1GTdjZ8GYeojSnucRh4/HUZTYoe+QhXcnZCL1RUhY67
         zsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sAMdh1b8NESkD+VXMD9Cy1k3kQ4bBkxFJ6eHKFRQAzo=;
        b=qbf7uC1DQkWB0EzeXTYm19wQk9obud5+Zt7LPoy35+FwE5T61pGiC89KaCcG5JASbZ
         fSUVfkVmGuiIIemnh02f5Zr9wtNhZb6DDcBDn5D8BsRSKsDKzYrY5cCV3oQVtrnArP3r
         4UM4VEh9V5Qxt784WlcDYtBaLHXQik6UZWboTcgMR9mQcUz41XNy9ft4ox1R3dTfl6lh
         mI0dfYmmfY6zt+Oac2/DyM/VGdFNrHmM0l/vbgWtqBXwMS8PpaWyWnZv/mZ6lMnn/3mz
         fEV/j53rspKZMavLJsv+qjXfrJpYgO9uEGt735s+PNeW8Lq+vI9pxvRPrOPwk+1sh6ka
         UPlg==
X-Gm-Message-State: APjAAAWAEyePiw5T+2Fl51M+avlUVgzULq7sF2Ll7aTsPqjRDYqA3B5p
        DTCapzHDBB4lHzs/7Z/zogRA3sAeJNvfN24rg8V0Yw==
X-Google-Smtp-Source: APXvYqxAGTmMcBJRevv6WsO98ReDaHMPPG2/6AsN9texoUaaiFE9aNHh0UWNLucoYDknZMz7cjLrqL20aT5I/0akT50=
X-Received: by 2002:a92:9184:: with SMTP id e4mr6501313ill.70.1580418186010;
 Thu, 30 Jan 2020 13:03:06 -0800 (PST)
MIME-Version: 1.0
References: <CAKUOC8WM3XU5y9QKHrO8VBdC4Dghexqy+o9OGM1qUs4kGQxZdQ@mail.gmail.com>
 <55c0fe61-a091-b351-11b4-fa7f668e49d7@acm.org>
In-Reply-To: <55c0fe61-a091-b351-11b4-fa7f668e49d7@acm.org>
From:   Salman Qazi <sqazi@google.com>
Date:   Thu, 30 Jan 2020 13:02:54 -0800
Message-ID: <CAKUOC8U03G27b6E7Z6mBo6RB=D7bKS_MQPwexEZiA7SOt_Lyvw@mail.gmail.com>
Subject: Re: Hung tasks with multiple partitions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Jesse Barnes <jsbarnes@google.com>,
        Gwendal Grignou <gwendal@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 30, 2020 at 12:49 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 1/30/20 11:34 AM, Salman Qazi wrote:
> > I am writing on behalf of the Chromium OS team at Google.  We found
> > the root cause for some hung tasks we were experiencing and we would
> > like to get your opinion on potential solutions.  The bugs were
> > encountered on 4.19 kernel.
> > However my reading of the code suggests that the relevant portions of the
> > code have not changed since then.
> >
> > We have an eMMC flash drive that has been carved into partitions on an
> > 8 CPU system.  The repro case that we came up with, is to use 8
> > threaded fio write-mostly workload against one partition, let the
> > system use the other partition as the read-write filesystem (i.e. just
> > background activity) and then run the following loop:
> >
> > while true; do sync; sleep 1 ; done
> >
> > The hung task stack traces look like the following:
> >
> > [  128.994891] jbd2/dm-1-8     D    0   367      2 0x00000028
> > last_sleep: 96340206998.  last_runnable: 96340140151
> > [  128.994898] Call trace:
> > [  128.994903]  __switch_to+0x120/0x13c
> > [  128.994909]  __schedule+0x60c/0x7dc
> > [  128.994914]  schedule+0x74/0x94
> > [  128.994919]  io_schedule+0x1c/0x40
> > [  128.994925]  bit_wait_io+0x18/0x58
> > [  128.994930]  __wait_on_bit+0x78/0xdc
> > [  128.994935]  out_of_line_wait_on_bit+0xa0/0xcc
> > [  128.994943]  __wait_on_buffer+0x48/0x54
> > [  128.994948]  jbd2_journal_commit_transaction+0x1198/0x1a4c
> > [  128.994956]  kjournald2+0x19c/0x268
> > [  128.994961]  kthread+0x120/0x130
> > [  128.994967]  ret_from_fork+0x10/0x18
> >
> > I added some more information to trace points to understand what was
> > going on.  It turns out that blk_mq_sched_dispatch_requests had
> > checked hctx->dispatch, found it empty, and then began consuming
> > requests from the io scheduler (in blk_mq_do_dispatch_sched).
> > Unfortunately, the deluge from the I/O scheduler (BFQ in our case)
> > doesn't stop for 30 seconds and there is no mechanism present in
> > blk_mq_do_dispatch_sched to terminate early or reconsider
> > hctx->dispatch contents.  In the meantime, a flush command arrives in
> > hctx->dispatch (via insertion in  blk_mq_sched_bypass_insert) and
> > languishes there.  Eventually the thread waiting on the flush triggers
> > the hung task watchdog.
> >
> > The solution that comes to mind is to periodically check
> > hctx->dispatch in blk_mq_do_dispatch_sched and exit early if it is
> > non-empty.  However, not being an expert in this subsystem, I am not
> > sure if there would be other consequences.
>
> The call stack shown in your e-mail usually means that an I/O request
> got stuck. How about determining first whether this is caused by the BFQ
> scheduler or by the eMMC driver? I think the developers of these
> software components need that information anyway before they can step in.

As I mentioned in my previous email, I did use trace points to arrive
at my conclusion.  I added trace points in
blk_mq_sched_dispatch_requests to
detect both the start and the end of that function, as well as where
the dispatched commands were picked from.  I also traced
blk_mq_sched_bypass_insert and saw a flush enter hctx->dispatch after
blk_mq_sched_dispatch_requests had started but before it
finished.  After reaching my conclusion, I also tried a simple fix by
introducing an exit path in blk_mq_do_dispatch_sched, if
we detect that hctx->dispatch has become non-empty.   This made the
problem go away.

>
> The attached script may help to identify which requests got stuck.
>
> Bart.
