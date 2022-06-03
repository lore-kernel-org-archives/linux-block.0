Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F5CC433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Jun 2022 05:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240495AbiFCFae (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jun 2022 01:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbiFCFad (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jun 2022 01:30:33 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7390238BE9
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 22:30:31 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id h62-20020a1c2141000000b0039aa4d054e2so5786782wmh.1
        for <linux-block@vger.kernel.org>; Thu, 02 Jun 2022 22:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=Q6RmMYZZS3YNA4h/3d5FnPuIp3grPTJIBtra+FKnT/A=;
        b=SRb4HgBJYRqYy8wbsQz9X2Ctqv1KHch8y4uepCTujGMIeCJXMj6MtwoJ9yAgCSD6gr
         hxMkFtIas2EZAtMpl4LgUctOMFmEjK9hPNNQmoURQ2EBXIK+DESn9/XvDwiqQ9Qklokv
         7uI8pkMzs/1XNqB/CiZ78CepKE/XVcn3WWPfeGO06bQaOXnLqpe+vI/g7GtkD2GN3x1U
         N3Jo+FM7QOWoeOnxBcCBjf4VwwIYnmXEwX4DoKNDG74K6yPt40tQOvPH/bjuamnmLPoP
         VYK6T9rJ2t4nbg6sfOaMciMAiBFIsTXC3HxgB+EsFSeXw+XXTV0+ieaQ9+kbsv0c+fWW
         9pYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=Q6RmMYZZS3YNA4h/3d5FnPuIp3grPTJIBtra+FKnT/A=;
        b=BP0XvoRd2LQN+N35qE1lrmB6Kg2s6z3PGVJslC3T8bBmJxIklRoXHUJChMHEPbM45X
         SDWAWCubyzwDH29OfgJlSEXWlwi0TMkMwkMLtO6ZBt00d5Qg6nOrHWAX6F6qmsqIm6fb
         Br8KXunfK6MZ3FD3A4MLbgII7L1kWYthqtAF6lMnd6CQ8RajZcwyDWurkPRETLz23UXT
         6iQf8k59Oc7CdLBpjHNSrASbJJHLGBROtZ77p1E4RZGHG+PVn5bf2T0m8tXpJA0pYb3R
         L6sjuFzTQVXgOQS+nCXYRHEG0kbYjeiYEIg3b9rYUnMKWzj/mBk5DyfrYoq+azTChKDh
         YG2g==
X-Gm-Message-State: AOAM532H9TiQM/Ny+7gAIm7szeKeARPcUiuTIcMWGLnMFkO7iCGgDDZq
        61q/0hqbw+B2hH0csiZb+yDaQTJd1LpigSK/
X-Google-Smtp-Source: ABdhPJzOKdM6GIEZOPOFQnRivuox7UpOHAquEsTUqNm/LGHN0XCwBxEhojbLJ3DIltw1JLcxO0v2tQ==
X-Received: by 2002:a05:600c:4e94:b0:397:63d7:1f6c with SMTP id f20-20020a05600c4e9400b0039763d71f6cmr6834766wmq.150.1654234229980;
        Thu, 02 Jun 2022 22:30:29 -0700 (PDT)
Received: from [10.188.163.71] (cust-east-parth2-46-193-73-98.wb.wifirst.net. [46.193.73.98])
        by smtp.gmail.com with ESMTPSA id e40-20020a5d5968000000b00213ba0cab3asm1446025wri.44.2022.06.02.22.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 22:30:29 -0700 (PDT)
Message-ID: <d6400df1-3a34-b17a-0647-a7f0bb63d559@kernel.dk>
Date:   Thu, 2 Jun 2022 23:30:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Follow up block core changes and fixes
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Just a collection of fixes that have been queued up since the initial
5.19 merge window pull request, the majority of which are targeted for
stable as well. One bio_set fix that fixes an issue with the dm adoption
of cached bio structs that got introduced in this merge window.

Please pull!


The following changes since commit 2aaf516084184e4e6f80da01b2b3ed882fd20a79:

  blk-mq: fix typo in comment (2022-05-21 06:32:16 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.19/block-2022-06-02

for you to fetch changes up to 41e46b3c2aa24f755b2ae9ec4ce931ba5f0d8532:

  block: Fix potential deadlock in blk_ia_range_sysfs_show() (2022-06-02 23:02:37 -0600)

----------------------------------------------------------------
for-5.19/block-2022-06-02

----------------------------------------------------------------
Christoph Hellwig (2):
      block: take destination bvec offsets into account in bio_copy_data_iter
      block: use bio_queue_enter instead of blk_queue_enter in bio_poll

Damien Le Moal (2):
      block: remove useless BUG_ON() in blk_mq_put_tag()
      block: Fix potential deadlock in blk_ia_range_sysfs_show()

Haisu Wang (1):
      blk-mq: do not update io_ticks with passthrough requests

Hannes Reinecke (1):
      block: document BLK_STS_AGAIN usage

Jan Kara (1):
      block: fix bio_clone_blkg_association() to associate with proper blkcg_gq

Jens Axboe (1):
      block: make bioset_exit() fully resilient against being called twice

Ming Lei (1):
      blk-mq: don't touch ->tagset in blk_mq_get_sq_hctx

Tejun Heo (1):
      blk-iolatency: Fix inflight count imbalances and IO hangs on offline

 block/bio.c               |   9 ++--
 block/blk-cgroup.c        |   8 +--
 block/blk-core.c          |   2 +-
 block/blk-ia-ranges.c     |   7 +--
 block/blk-iolatency.c     | 122 ++++++++++++++++++++++++----------------------
 block/blk-mq-tag.c        |   1 -
 block/blk-mq.c            |  10 ++--
 include/linux/blk_types.h |   4 ++
 8 files changed, 83 insertions(+), 80 deletions(-)

-- 
Jens Axboe

