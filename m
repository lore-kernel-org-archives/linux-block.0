Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:35424 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755309AbdIGNUC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Sep 2017 09:20:02 -0400
Received: by mail-io0-f180.google.com with SMTP id i14so4048724ioe.2
        for <linux-block@vger.kernel.org>; Thu, 07 Sep 2017 06:20:02 -0700 (PDT)
MIME-Version: 1.0
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 7 Sep 2017 15:20:01 +0200
Message-ID: <CAOi1vP-vbr+wnQAP24p3RHuHaS_4s1kQ1p=h8CjHKd_EAtc4uQ@mail.gmail.com>
Subject: Re: [PATCH V2 0/3] block/loop: handle discard/zeroout error
To: Shaohua Li <shli@kernel.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Shaohua,

You wrote:
> BTW: blkdev_issue_zeroout retries if we immediately find the device doesn't
> support zeroout, but it doesn't retry if submit_bio_wait returns -EOPNOTSUPP.
> Is this correct behavior?

I sent a patch for that yesterday, see "[PATCH] block: cope with WRITE
SAME failing in blkdev_issue_zeroout()" on linux-block.  It checks for
-EREMOTEIO, because that's what I hit, but I wonder if it should check
for -EOPNOTSUPP from submit_bio_wait() as well.  Can you think of
a case where, given bdev_write_zeroes_sectors() != 0, submit_bio_wait()
would fail with -EOPNOTSUPP and we would want to do explicit zeroing?

Please excuse broken threading.

Thanks,

                Ilya
