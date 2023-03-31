Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E7EC761A6
	for <linux-block@archiver.kernel.org>; Fri, 31 Mar 2023 15:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbjCaP3i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Mar 2023 11:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjCaP3g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Mar 2023 11:29:36 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E7F1E72D
        for <linux-block@vger.kernel.org>; Fri, 31 Mar 2023 08:29:25 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-62810466cccso1172426b3a.1
        for <linux-block@vger.kernel.org>; Fri, 31 Mar 2023 08:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680276565;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQUGPz0qcXXrxveNBeVls1pTBlF0uQ0B3+T95P7gxSI=;
        b=Y/5WRuQy9v0Un8yCtbFd38fPOUfWRhhDirYUjYwOr2AH2SvLGtNOvQL84rNmaxMb7U
         v8IOcEHOKfEDnX4l4sj47U3gOCoogVaRp497HL8Nw9XHQCzCHaqUNs32a5afo/y3sw/w
         0MHC+4qspTMQgR4GsuiTWTYCaCokGSXfd+T/FPp8wMVGVdooGKSNl/OzvIEvQGVYTRQ8
         MwyK4AE48D7fH5U0MHr4p8Tq9G96DlkgkR66D67E3dp31lxeCD/zK78PDU52TFmDWqRY
         yjsNhePiACkec2Ii9LqKuGNDiLrhPJRhv2gIsOrjbgGNgdt5xxSjpNv9maI7f0EMIPBI
         srLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680276565;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hQUGPz0qcXXrxveNBeVls1pTBlF0uQ0B3+T95P7gxSI=;
        b=Qz876bewxr/oMF+BPPeESKKIkTQ3+oQFCyBDpI/jWlaZHmzng6Ft+OXgD8V4emega+
         43KzN3tE9WUlKWkIFJuGgNM14DMq5OBqtb7fjm6OKHQuHh3yHQxjxEC6okD7X1zUE3A2
         WA3Y+4o5LCUxTtmKpDjJxmeNbZJMbNXJqBkrZ6R3UqkGnZ9XZaDVXDmZUatc8r1gEBmq
         2q3U4sYojCTQpOW2nnaDmO0H/0ahfAoLsO58dzPQcvYc5giHKKETi0p/SE5xyfu+Vegs
         bdfA7cR9D+owp//bfpK3+kJdA3092p56T186FaBnEiadGFmW8qYJq2dK6+9XTgKFw8/c
         Z7Aw==
X-Gm-Message-State: AAQBX9ev0iLgb38Nkm3j/jKAYh64OzKttA2odvs104HAI8/DJxSwYP7m
        IwgGhr62kDSOiJa3XnBrH927u1x0f2eLvHDgNl2+bg==
X-Google-Smtp-Source: AKy350ZoyF0ji0KkhDmA7to6DHI/hODruOKWBBVYv8bAU0tPZwmKPZiIPb50uP3Hs/n0AZuPhQhIuA==
X-Received: by 2002:a17:902:8e83:b0:19f:382d:9734 with SMTP id bg3-20020a1709028e8300b0019f382d9734mr6620697plb.3.1680276565312;
        Fri, 31 Mar 2023 08:29:25 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id jm21-20020a17090304d500b001a1fe42a141sm1716168plb.115.2023.03.31.08.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 08:29:24 -0700 (PDT)
Message-ID: <c8733191-0707-6bac-ed60-f28ef537cf92@kernel.dk>
Date:   Fri, 31 Mar 2023 09:29:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.3-rc5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A few block fixes for 6.3-rc5:

- NVMe pull request via Christoph:
	- Mark Lexar NM760 as IGNORE_DEV_SUBNQN (Juraj Pecigos)
	- Fix a possible UAF when failing to allocate an TCP io queue
	  (Sagi Grimberg)

- MD pull request via Song:
	- Fix a null pointer deference in 6.3-rc (Yu Kuai)

- uevent partition fix (Alyssa)

Please pull!


The following changes since commit f915da0f0dfb69ffea53f62101b38073e0b81f73:

  Merge tag 'nvme-6.3-2023-03-23' of git://git.infradead.org/nvme into block-6.3 (2023-03-23 13:02:20 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.3-2023-03-30

for you to fetch changes up to 24ab70d83784a807c9ddff939ea762ef19bd4ffd:

  Merge tag 'md-fixes-2023-03-29' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.3 (2023-03-30 20:29:47 -0600)

----------------------------------------------------------------
block-6.3-2023-03-30

----------------------------------------------------------------
Alyssa Ross (1):
      loop: LOOP_CONFIGURE: send uevents for partitions

Jens Axboe (2):
      Merge tag 'nvme-6.3-2023-03-31' of git://git.infradead.org/nvme into block-6.3
      Merge tag 'md-fixes-2023-03-29' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.3

Juraj Pecigos (1):
      nvme-pci: mark Lexar NM760 as IGNORE_DEV_SUBNQN

Sagi Grimberg (1):
      nvme-tcp: fix a possible UAF when failing to allocate an io queue

Yu Kuai (1):
      md: fix regression for null-ptr-deference in __md_stop()

 drivers/block/loop.c    | 18 +++++++++---------
 drivers/md/md.c         |  3 ++-
 drivers/nvme/host/pci.c |  3 ++-
 drivers/nvme/host/tcp.c | 46 ++++++++++++++++++++++++++--------------------
 4 files changed, 39 insertions(+), 31 deletions(-)

-- 
Jens Axboe

