Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43047C433EF
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 08:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2966460F6D
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 08:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238116AbhIMIy3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Sep 2021 04:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238084AbhIMIy3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Sep 2021 04:54:29 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CD8C061574
        for <linux-block@vger.kernel.org>; Mon, 13 Sep 2021 01:53:13 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so12323020otq.7
        for <linux-block@vger.kernel.org>; Mon, 13 Sep 2021 01:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=3xvNWywI97T4tWFgzxwRssL/X08dlRk9g/Y8iCoCYDQ=;
        b=VlRk6WdGK0ZkY/xrHitYJhSf4AP+q52xI2ybvdvmtRkI0C/WaREM74WTjpSQobx7WB
         PVv8OSMRb6E2NcZjU6YbAin0qmHTCvlezSEIPpdlh65UygOL0Vk0xRJUQJ/Nl/sJAKXA
         6WxxTZp7BZnEpXv3JPDhgGB3pndxeZ4osYtL2uT5lHa+QsBeBVYtgjkq+mBMPA6KD+ds
         G1+eE9Hc9f7/KEueF4xy7Kxofei2pcVISQbRYFaGl/k9KLhJ6dKGNr6zOtwajDC15vw5
         J8vcP1rPKCVknCRQ/X3tizTRheal27tp26PPNxUjRuBbaSGdifoVfoS34smpqsjEmfOh
         gK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3xvNWywI97T4tWFgzxwRssL/X08dlRk9g/Y8iCoCYDQ=;
        b=UAC2QbD59Hjr9dSXUAVKNGcLcZ0i166nlQR7QNK4C/ztUgeekNyHmFagaIma/ACH9y
         FMt9SzXeSX0m3cJRhwxcen4T+PzpCL/iMfIl7HbMi0RNZMugStOATlqJWjwe+9ncR5Bi
         zFAjIxqOojX8oi52481Aesyw9kLujjcUvhYr4Xizd4+kOYhu6+NIVWxFfc0pTnyz97TU
         wbyQFRkgljIOwaPPLjPdqPiRDccT1VbTqsBSphsKnerLxFu4L85NS3nen/4HioTGkYhl
         EMHTTvS+a6Oe5up8xC6D8+hVRIyMhX4O2cd8uMiCg95rZl85EUBwybDGSiWCzKRfFHgY
         GwtA==
X-Gm-Message-State: AOAM530/SlOjQJmUH1khhytvTts+HkFM7G2V+XmrTrQ4Z/Giv9Q4kKzE
        lJmSPiO4YjXT5wnf8Xjc8tODxoxx1spRHnHgAUZPaGs2LU8=
X-Google-Smtp-Source: ABdhPJzV7z08hOXbwrIkYqb2Gi2CjwFxR+6L+8Z8JJ9nZgCX2PgKfWU5ZbJixIPxYRKVHRtZyK7LzzDBft7hOJzLzqs=
X-Received: by 2002:a9d:6e0a:: with SMTP id e10mr8297698otr.259.1631523192926;
 Mon, 13 Sep 2021 01:53:12 -0700 (PDT)
MIME-Version: 1.0
From:   Kegl Rohit <keglrohit@gmail.com>
Date:   Mon, 13 Sep 2021 10:53:03 +0200
Message-ID: <CAMeyCbgzrbt_A_e=YGKdFyFexX0q7D15KMdL3jTKGw-YKzLA8Q@mail.gmail.com>
Subject: mmc host: abort pending mmc requests
To:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello!

I am trying to implement some special use-case.
On our platform the CPU will be notified with an interrupt if the
power fails. After that the system has ~100ms time to do some
tear-down tasks.
One important step is to store some information (~512KB) on some non
volatile storage.
EMMC seems to be a good choice because of the high throughput. But the
drawbacks are the non deterministic latencies caused by the EMMC
itself, the complex sdhci mmc host driver, the blocklayer, ...

Because time is critical I tried to implement this in the kernel space.

Most likely EMMC hardware latencies can be reduced by execution of a
block discard during boot-up. So in case of a power-fail no sectors
have to be erased, because they are pre-erased.

I looked at the mmc_test.c kernel module to execute raw mmc block writes.
For 512KB the write take ~60ms => looks promising

But the biggest concern is the influence of other tasks. The emmc has
multiple partitions.
So if i start a benchmark on another partition the write could also
take longer, because the mmc host driver has a lot of requests in its
queue.
I measured up to 6s. This is caused by the blocking call to
mmc_claim_host which waits for the queues to drain.

So i looked for a way to stop all queued mmc requests on the mmc host
before calling claim_host.

There exists some pstore implementations which have a similar use-case.
=> store data in block before panic reboot.

pstore_blk is mainline and can configured in two ways:
1. call block->panic_write if the block driver supports it. (Currently
only some mtd drivers and no emmc?)
2. Use "best_effort" and write to /dev/mmcblk via kernel_write() =>
possible with emmc

https://github.com/torvalds/linux/commit/f8feafeaeedbf0a324c373c5fa29a2098a69c458#diff-d3fb8bf94c21d538c62beccd243ca6266b4dec19c6d60a581aa6d71ba9874a53

This second option is also heavily influenced by other io, because it
uses the same system io scheduler like userspace?


But there exists also some more raw patch sets:
https://patchwork.kernel.org/project/linux-mmc/patch/1425015219-19849-1-git-send-email-jh80.chung@samsung.com/
https://patchwork.kernel.org/project/linux-mmc/patch/20201207115753.21728-2-bbudiredla@marvell.com/#23849559

And even some which tap into the sdhci driver to abort all ongoing
emmc requests:
https://lkml.org/lkml/2012/10/23/335


Because I want to keep it simple I started with some more basic commands:

The first try was to call
_mmc_blk_suspend(mmc_card);
before mmc_claim_host() => also slow

Next
blk_mq_freeze_queue(mmc_card->queue.queue)
before mmc_claim_host() => also slow

Next
mmc_blk_hw_queue_stop(mmc_card->queue.queue);
before mmc_claim_host() => better
By changing the scheduler to none and reducing max_sectors_kb. The
writes take up to ~100ms with parallel userspace write test running.
Without the write test it only takes ~60ms. So the scheduling of
userpace io still has some influence.

Do you know any way to forcefully stop all pending mmc host requests
to improve this further? I think mmc_blk_hw_queue_stop still waits for
the pending requests to be finished.
Or is there a way to queue my mmc block requests before all other
pending requests?

Thanks in advance!
