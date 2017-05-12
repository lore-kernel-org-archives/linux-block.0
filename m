Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35394 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753488AbdELStI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2017 14:49:08 -0400
Received: by mail-pg0-f41.google.com with SMTP id q125so14657457pgq.2
        for <linux-block@vger.kernel.org>; Fri, 12 May 2017 11:49:08 -0700 (PDT)
Date: Fri, 12 May 2017 11:49:05 -0700
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: Announcing blktests
Message-ID: <20170512184905.GA15267@vader.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi, everyone,

At LSF/MM, we talked about the need for somewhere to dump tests for the
block layer/storage stack. I've put together a test suite inspired by
xfstests here: https://github.com/osandov/blktests.

I started out with the opinion that we should reuse xfstests for this,
but it became clear that the requirements for testing block devices are
slightly different, and it diverged significantly from there. In
particular, blktests supports:

- Per-device tests. You can configure a list of test devices and the
  per-device tests will run on each one (currently in serial, we can
  support parallel runs in the future if needed).
- No-device tests. Some tests don't need to run on real hardware, and we
  can just set up a null-blk or scsi-debug device.
- Performance numbers. In addition to the output comparison pass/fail
  that xfstests supports, blktests can also report arbitrary test
  metrics which don't affect whether the test passes but can be useful
  for spotting regressions.

Jens and I wrote up an initial set of tests, but there are a lot more we
can still write. I'm also happy to take feature requests, just email me
or open an issue on the GitHub repo.

Thanks,
Omar
