Return-Path: <SRS0=TQg9=4A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E416FC3B187
	for <linux-block@archiver.kernel.org>; Wed, 12 Feb 2020 22:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA79821569
	for <linux-block@archiver.kernel.org>; Wed, 12 Feb 2020 22:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iLXIzaiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgBLW1W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Feb 2020 17:27:22 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:33698 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728447AbgBLW1W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Feb 2020 17:27:22 -0500
Received: by mail-io1-f42.google.com with SMTP id z8so4198865ioh.0
        for <linux-block@vger.kernel.org>; Wed, 12 Feb 2020 14:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=edt2I3RTLN6ychJeRY9QbcR2ZMw2DB5I2yqN3iENPXM=;
        b=iLXIzaiyHsE/IhzFXtGEunG40WLt1XbwRtJtZ37nxisPw4UOfQhVHcR4pTNQvLr+j4
         WMBXN4RMIGdBHVXbxKBOk02OQDUFfxM/S8VAXHg2ZbDyz5uJnEQFQQ6y4kf53K9HGaze
         A1ajRqaNql2Os0POSjpqXo7TR19uMd2PD/A97TDhHEuCeAJVlkAW0M8EgINdTuLNA871
         Y9pZl5PWhUhuadzFu1vdM03l09q/qA1A8OeB9zTbonvJh0phbdmf9xKRcDpGmD99OwZj
         ZJ5ULRoemcknZc8UGFW6Z3PQcirSlmqQINH9ZZAsRZ79DlectxCB3GyFpVPVstTodPLk
         pIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=edt2I3RTLN6ychJeRY9QbcR2ZMw2DB5I2yqN3iENPXM=;
        b=RQXxDQPHDyAkV5y0RoV/4A+5dRPAiH9WKy8u3HQNWv1vZ7+gMf/Lu8wUf42wnmyFW0
         iiGbeXxmOs8/D4XZANKnY7knXOoAgxa/6qghWhVnrmwFYq2Jk3skG0xbRR9rVRS4KGmz
         1js+2ZVEh4WSnoXwFIigf0oO4mBc8y0agEI/VVy+pTxbA6r2/ZgjBc+p44hgqdB2oNKA
         S3UpR5cyrhkm8diShefY3/cN1ECute81XRzAUavSPFya7ufZuXllcCWm2RqQsR+frRtl
         aI0c7UznDaKN1W/u03hPn10yJ2znnew+bgXKA8d2OFL9jcSoXELiCuk360eqcy7ev+Bs
         AhHQ==
X-Gm-Message-State: APjAAAWL9qLamNcDsII3PTvq9Pbuhse5Tl8NbyuoteRxx18iT7mXjcdl
        gFuXByL6aYvplhgot8xrN5tJwXUee6WU4kSYwS0ITQ==
X-Google-Smtp-Source: APXvYqyP2m7YArG2eKQ+in1Y8KsWY16aMk3DQQbmrK5tyQty0ShKXrchBomO1gm/wBbaf2EjEMdWFY+JAfBUNwmQ4WY=
X-Received: by 2002:a5d:9157:: with SMTP id y23mr19527487ioq.199.1581546440844;
 Wed, 12 Feb 2020 14:27:20 -0800 (PST)
MIME-Version: 1.0
From:   Salman Qazi <sqazi@google.com>
Date:   Wed, 12 Feb 2020 14:27:09 -0800
Message-ID: <CAKUOC8VN5n+YnFLPbQWa1hKp+vOWH26FKS92R+h4EvS=e11jFA@mail.gmail.com>
Subject: BLKSECDISCARD ioctl and hung tasks
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

So, here's another issue that we are grappling with, where we have a
root-cause but don't currently have a good fix for.  BLKSECDISCARD is
an operation used for securely destroying a subset of the data on a
device.  Unfortunately, on SSDs, this is an operation with variable
performance.  It can be O(minutes) in the worst case.  The
pathological case is when many erase blocks on the flash contain a
small amount of data that is part of the discard and a large amount of
data that isn't.  In such cases, the erase blocks have to be copied
almost in entirety to fresh blocks, in order to erase the sectors to
be discarded. This can be thought of as a defragmentation operation on
the drive and can be expected to cost in the same ballpark as
rewriting most of the contents of the drive.

Therefore, it is possible for the thread waiting in the IOCTL in
submit_bio_wait call in blkdev_issue_discard to wait for several
minutes.  The hung task watchdog is usually configured for 2 minutes,
and this can expire before the operation finishes.

This operation is very important to the security model of Chrome OS
devices.  Therefore, we would like the kernel to survive this even if
it takes several minutes.

Three approaches come to mind:

One approach is to somehow avoid waiting for a single monolithic
operation and instead wait on bits and pieces of the operation.  These
can be sized to finish within a reasonable timeframe.  The exact size
is likely device-specific.  We already split these operations before
issuing to the device, but the IOCTL thread is waiting for the whole
rather than the parts. The hung task watchdog only sees the total
amount of time the thread slept and not the forward progress taking
place quietly.

Another approach might be to do something in the spirit of the write
system call: complete the partial operation (whatever the kernel
thinks is reasonable), adjust the IOCTL argument and have the
userspace reissue the syscall to continue the operation.  The second
option should probably be done with a different IOCTL name to avoid
breaking userspace.

A third approach, which is perhaps more adventurous, is to have a
notion of forward progress that a thread can export and the hung task
watchdog can evaluate.  This can take the form of a function pointer
and an argument.  The result of the function is a monotonically
decreasing unsigned value.  When this value stops changing, we can
conclude that the thread is hung.  This can be used in place of
context switch count for tasks where this function is available.  This
can potentially solve other similar issues, there is a way to tell if
there is forward progress, but it is not as straightforward as the
context switch count.

What are your thoughts?

Thanks in advance,

Salman
