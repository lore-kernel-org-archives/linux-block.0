Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:36947 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbdH1PJ0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Aug 2017 11:09:26 -0400
Received: by mail-pg0-f42.google.com with SMTP id 83so2217684pgb.4
        for <linux-block@vger.kernel.org>; Mon, 28 Aug 2017 08:09:26 -0700 (PDT)
MIME-Version: 1.0
From: John Groves <John@groves.net>
Date: Mon, 28 Aug 2017 10:09:04 -0500
Message-ID: <CALz7SpXrV2KLNJ+jOvuYkx7HDDxGt19g4ByTyZn_f1UAqmAhsQ@mail.gmail.com>
Subject: FUA, PREFLUSH, VWC redux
To: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

I'm hoping somebody can clarify the correct PREFLUSH and FUA behavior from a
block stack client.  I'm starting to suspect that some of my devices are
failing to inform the block stack correctly of their capabilities - leading
to expensive and unnecessary flushes.

My understanding is this:

* If I require confirmation that a single write is durable upon
completion, attach REQ_FUA to the bio.
* If I require that the current write plus all previously completed
writes be durable as of completion of the current write, attach
REQ_FUA and REQ_PREFLUSH to the bio.
* Both REQ_FUA and REQ_PREFLUSH should be NOPs on a device with with a
non-volatile write cache.

But I have a small problem - I don't know which write is last, until I
receive a Commit call.  That means that at Commit time, I should send
a "FLUSH".

I am calling a function based on blkdev_issue_flush(), but this causes
I big performance penalty even though my nvme ssd has VWC==0.

Does this make sense?

Perhaps blkdev_issue_flush() is intended to flush caches even if they
are non-volatile?

What is the "correct" way to get a "REQ_PREFLUSH" with a zero length
write, if not via blkdev_issue_flush()?

Thanks for any tips,
John Groves
