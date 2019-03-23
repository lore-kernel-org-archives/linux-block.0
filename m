Return-Path: <SRS0=7zlQ=R2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316E0C43381
	for <linux-block@archiver.kernel.org>; Sat, 23 Mar 2019 15:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E707021902
	for <linux-block@archiver.kernel.org>; Sat, 23 Mar 2019 15:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vk5bkrmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfCWPzq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Mar 2019 11:55:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41527 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfCWPzq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Mar 2019 11:55:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id d25so3505176pfn.8
        for <linux-block@vger.kernel.org>; Sat, 23 Mar 2019 08:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Jd/YXc1qKt1q6tV4oHdVTJwqcG1SAatWmR/Er9krL64=;
        b=vk5bkrmdmdDKk+78t9rfCeFtA22yUXV9I4C3XNkkusUflmIyLtLEGK1jXz/GiBf9ja
         +WhGXu+SMAavvbXtiBW3Xf4khndj5sd4XlsJDHOlE5ELuO2C7Cu+EnDeNpHNU4Ub6ghp
         /KDXcAUPzylkv2SIkbuT1e1IcG/8uGjJ1REjFrDVEneABm007xSoxbTTmAwBDggnHGIa
         /Fsd539J6Gw/84mkEiVQJI/izJVDEvVVHMhOiooWZU+qSZOQ5BFfLtMzVSuCBjRVbbhu
         8w8Zi/S/NfyfSsD12+hPr+8hVSHUKgcayG8luZsFKKvpnvxiStm2mQUP06zF6gxieFJc
         xbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Jd/YXc1qKt1q6tV4oHdVTJwqcG1SAatWmR/Er9krL64=;
        b=OL/RBdqVruXRz5J3N1E89uYGpy9MO0q8AT4WqUv/HNwRiOhV8xShNWfha3+H6ep65U
         WzJMNbxxo3S1Wwg8C7Zy+er/uV3+YwKESe8rMfkyjYmzyWGq5kQTkmFDzAuWOqhqXJoN
         C+by0afamwozCw4HfywcxeWhkuATryXzTb8TDmLlCXMICEIy+Zuc4dgKgaIBq+pcfOqb
         g8CVbfvl6I4Ht48nBbu9SULS7Fpzd1tCYmKBO61Mib6ybbtDMCon30/IX9JhIMpW65if
         aUVuMwW8r/+/bwssXtRtm/M9/uRp//YtEYq93d4I71URzoIeDY9nMQgTAAXJZPozh/Ra
         C3Wg==
X-Gm-Message-State: APjAAAXdViiuivUC6kPmbVi0cPsY3tv2uYbP+Nua6Tm/IwgowfRoL1fW
        U7xhNkOk4xBAJF1K7sHR7QopfQQ7G7GAZ/10
X-Google-Smtp-Source: APXvYqxgBpcaFIuxB6kx1d9lFDtFwb32vFGmZ40A+2VQqZaPVKd+G7Jd8sZH/RXgQgWbkgSjgoBWJg==
X-Received: by 2002:a65:63c2:: with SMTP id n2mr14629546pgv.439.1553356544570;
        Sat, 23 Mar 2019 08:55:44 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id i13sm13098981pgq.17.2019.03.23.08.55.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 08:55:43 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.1-rc2
Message-ID: <88dc23a0-2baf-6a56-36b4-6c8144d1ed7a@kernel.dk>
Date:   Sat, 23 Mar 2019 09:55:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A set of fixes/changes that should go into this series. This pull
request contains:

- Kernel doc / comment updates (Bart, Shenghui)
- Un-export of core-only used function (Bart)
- Fix race on loop file access (Dongli)
- pf/pcd queue cleanup fixes (me)
- Use appropriate helper for RESTART bit set (Yufen)
- Use named identifier for classic poll (Yufen)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20190323


----------------------------------------------------------------
Bart Van Assche (3):
      block: Unexport blk_mq_add_to_requeue_list()
      blk-iolatency: #include "blk.h"
      blkcg: Fix kernel-doc warnings

Dongli Zhang (2):
      loop: access lo_backing_file only when the loop device is Lo_bound
      blk-mq: remove unused 'nr_expired' from blk_mq_hw_ctx

Jens Axboe (2):
      paride/pf: cleanup queues when detection fails
      paride/pcd: cleanup queues when detection fails

Shenghui Wang (1):
      sbitmap: trivial - update comment for sbitmap_deferred_clear_bit

Yufen Yu (2):
      blk-mq: use blk_mq_sched_mark_restart_hctx to set RESTART
      block: add BLK_MQ_POLL_CLASSIC for hybrid poll and return EINVAL for unexpected value

 block/blk-cgroup.c         |  9 +++++----
 block/blk-iolatency.c      |  1 +
 block/blk-mq.c             |  8 +++-----
 block/blk-mq.h             |  2 ++
 block/blk-sysfs.c          | 12 +++++++-----
 drivers/block/loop.c       |  2 +-
 drivers/block/paride/pcd.c |  6 +++++-
 drivers/block/paride/pf.c  | 16 +++++++++++-----
 include/linux/blk-mq.h     |  3 ---
 include/linux/blkdev.h     |  3 +++
 include/linux/sbitmap.h    |  2 +-
 11 files changed, 39 insertions(+), 25 deletions(-)

-- 
Jens Axboe

