Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4CEECAAD5
	for <linux-block@archiver.kernel.org>; Fri,  9 Sep 2022 17:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiIIR2X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Sep 2022 13:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiIIR2W (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Sep 2022 13:28:22 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1112911E6C7
        for <linux-block@vger.kernel.org>; Fri,  9 Sep 2022 10:28:21 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id k2so1152475ilu.9
        for <linux-block@vger.kernel.org>; Fri, 09 Sep 2022 10:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=qSNvpByHro7oe/Ng6HSOG33yP9Z+3DZQkc5HiQkUnGY=;
        b=EPoR/MKQsXBAfBuylTf3WM/vMyYEJHmLaksycmuHZ2q2os+GJSvke4wDeZg4rhKLWx
         D6WGtIpTjNjS0cjRKl6PmmGVkjtuaSotUyx6dc1kYvsjvKlu1uuwss8T+5i/Vxzf/dYn
         QYX0T3eppG2fHHBCaX96rdYO1+1r8r4hsvwvLlwmHk0mC32I+3nrnMk47yvhU7cV69Oy
         hdo+czZcweioLvrJEldBKdqJp8BRXe8vByDP16+3cHl2DYGdQ4mzejktSlajjcDj3sgK
         yLG3NCi5QEjh8L71DWe8U0VAJwaywVxBMJAs4N9pp2CBKAhdNisXbL68t5/r5rYHvDcW
         TXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=qSNvpByHro7oe/Ng6HSOG33yP9Z+3DZQkc5HiQkUnGY=;
        b=IDRot5bX34c8Xo5r/uSv4rDKv1V/XbK84J/CVkhDcy4aIoJcSGQ46VqGD7FX/A5gdM
         nBfkWZtv1TZskmuWtiouDaQp46gDw3JmWbKYOJ3AaedCBcSw7RCnhAvMHKytlAZ0pHdc
         t75zotULuLkAkrDqxnOYksrWH9MAFifqsABEvx/ZjeBuNfq6m/7bkfDgzPWr0Uc0wjU1
         6PxL/S73D4VlQgLbUGJlARLaaJOKBFvMfmRXO9Tep/jtDXwOJLTVl5NswcTVc46fP4/1
         Vt281Pgaek8EFctMXvMu+/7XbLqhoOpOwvfLoQCzmZagpoBAEGXVdmZagMRke+AXTu6a
         ISOg==
X-Gm-Message-State: ACgBeo2jv41hBv1+KwXRiJJXrJvd6/hfFc0axtXd7HKNzCG20eq2+pa5
        Rmsci/f+5AjmkzqkDP+RzyHBwJY9AxCvoQ==
X-Google-Smtp-Source: AA6agR5YaNWsE+6ljckF3mXi5Ehedp1s/8omvYsjqz25Tc6mL4E5X7S5+YstGG3eubnpuBlkEwMD+Q==
X-Received: by 2002:a05:6e02:170f:b0:2f1:6cdf:6f32 with SMTP id u15-20020a056e02170f00b002f16cdf6f32mr4710240ill.216.1662744500340;
        Fri, 09 Sep 2022 10:28:20 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id e4-20020a056e020b2400b002dd0cb24c16sm362124ilu.17.2022.09.09.10.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 10:28:19 -0700 (PDT)
Message-ID: <54f4f268-c33c-d1a1-4b38-75f9206be4e9@kernel.dk>
Date:   Fri, 9 Sep 2022 11:28:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.0-rc5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Set of fixes for block that should go into the 6.0 release:

- NVMe pull via Christoph:
	- fix a use after free in nvmet (Bart Van Assche)
	- fix a use after free when detecting digest errors
	  (Sagi Grimberg)
	- fix regression that causes sporadic TCP requests to time out
	  (Sagi Grimberg)
	- fix two off by ones errors in the nvmet ZNS support
	  (Dennis Maisenbacher)
	- requeue aen after firmware activation (Keith Busch)

- Fix missing request flags in debugfs code (me)

- Partition scan fix (Ming)

Please pull!


The following changes since commit 7a3d2225f1ae9e591fefd65c3bb1715dc54d96f1:

  Documentation: document ublk (2022-09-02 09:31:15 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-6.0-2022-09-09

for you to fetch changes up to 745ed37277c5a7202180aa276c87db1362c90fe5:

  block: add missing request flags to debugfs code (2022-09-09 05:57:52 -0600)

----------------------------------------------------------------
block-6.0-2022-09-09

----------------------------------------------------------------
Bart Van Assche (1):
      nvmet: fix a use-after-free

Dennis Maisenbacher (1):
      nvmet: fix mar and mor off-by-one errors

Jens Axboe (2):
      Merge tag 'nvme-6.0-2022-09-08' of git://git.infradead.org/nvme into block-6.0
      block: add missing request flags to debugfs code

Keith Busch (1):
      nvme: requeue aen after firmware activation

Ming Lei (1):
      block: don't add partitions if GD_SUPPRESS_PART_SCAN is set

Sagi Grimberg (2):
      nvme-tcp: fix UAF when detecting digest errors
      nvme-tcp: fix regression that causes sporadic requests to time out

 block/blk-mq-debugfs.c     |  2 ++
 block/partitions/core.c    |  3 +++
 drivers/nvme/host/core.c   | 14 +++++++++++---
 drivers/nvme/host/tcp.c    |  7 ++-----
 drivers/nvme/target/core.c |  6 ++++--
 drivers/nvme/target/zns.c  | 17 +++++++++++++++--
 6 files changed, 37 insertions(+), 12 deletions(-)

-- 
Jens Axboe
