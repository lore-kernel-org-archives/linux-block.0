Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85041C433EF
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 17:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6925661152
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 17:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240774AbhKIRJd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Nov 2021 12:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240787AbhKIRJd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Nov 2021 12:09:33 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35C7C061766
        for <linux-block@vger.kernel.org>; Tue,  9 Nov 2021 09:06:46 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id f9so23297227ioo.11
        for <linux-block@vger.kernel.org>; Tue, 09 Nov 2021 09:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=t1EjrBYwva9SPsp+z6l2D6a+o6ggyHjhdLeIM3ul4uI=;
        b=snBW19aax0YeAgd0r9DbAhcjTrpM7JeSJHMYaQBLrbswiiQU2mv5c6/L8tgadgXUGF
         mQE4N0Q1Hu8qQcVToMOHKdKP/I5N/FbyC9F34MKbaMyW2FR9PQ+ZaJ8xZnRf25Lr+qvN
         yPImPaQaSRhbA2RF3QUdZINXbyJNDI+aQPZZD5K/MV8WLdpVvIQaFtFNpYriInAibK3o
         u1YfICpu7WfbvxR7xiAkMfujzPw0qVsxZGqTCzWMGFwOWUzx6P4NtBeVfBGh5qT8dgLD
         Xl3HTYxkNMJRAalkxbLN7hAIL+3Ekn1f/+TCbNsAAUup2JtLPKR41Xrvzz0FKgsz89Kl
         uBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=t1EjrBYwva9SPsp+z6l2D6a+o6ggyHjhdLeIM3ul4uI=;
        b=yLXY7hzOfQ1HNDF3EsWa3WjpUJSI93oQcTHgcVyZPoDT7D4oOM7Ecz8Xq4IGD7pkeL
         ako+yzp2IxiCNnt8auAG9TvrCo61rHkShIf0ygDZbEigoIkFYgto5J3xi+ZbhdvoNEDG
         4DTcShOU3/Ab+7uRCxxfjpHBdCfeookLNTO2wkwS+jf0Z1sXjWofzibWCrVL05hI0mak
         gKn+IAxgZRl/+NQuGrU3lPe+Vf8+9itONYzx4KIaLy7rWCCZNoICv9qWFlhcwnViId2Y
         TV9qM+61rOtKlSEDxB0mvYjpYLbaJGHs6Yd1wobkbqoXzE94gwmqkW+7Q9ZTD4PBYX53
         n1zA==
X-Gm-Message-State: AOAM5328TP2D4baiJzqlBIkOnmdK5uAj5QvCM7Bc/nDACwDJvoF32HjT
        CpovQ6MHI7XKqjfqJqUoMaldODDAWaCSq+QO
X-Google-Smtp-Source: ABdhPJy2AHC0iiRs30tc/hUyOw+M8ozFogcHCCbvJzu9dTXlAd/JT98xORmvNLji4RgMZfJX0Bjbhw==
X-Received: by 2002:a6b:7307:: with SMTP id e7mr496384ioh.211.1636477606093;
        Tue, 09 Nov 2021 09:06:46 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id h19sm12509893ila.37.2021.11.09.09.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 09:06:45 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Followup core block changes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <b711ba54-4726-0f3c-51ba-332edb7c5ad7@kernel.dk>
Date:   Tue, 9 Nov 2021 10:06:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Followup set of fixes that should go into the 5.16 release:

- Set of fixes for the batched tag allocation (Ming, me)

- add_disk() error handling fix (Luis)

- Nested queue quiesce fixes (Ming)

- Shared tags init error handling fix (Ye)

- Misc cleanups (Jean, Ming, me)

Please pull!


The following changes since commit 9b84c629c90374498ab5825dede74a06ea1c775b:

  blk-mq-debugfs: Show active requests per queue for shared tags (2021-10-29 06:53:34 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.16/block-2021-11-09

for you to fetch changes up to 26af1cd00364ce20dbec66b93ef42f9d42dc6953:

  nvme: wait until quiesce is done (2021-11-09 08:14:27 -0700)

----------------------------------------------------------------
for-5.16/block-2021-11-09

----------------------------------------------------------------
Jean Sacren (1):
      blk-mq: fix redundant check of !e expression

Jens Axboe (8):
      block: assign correct tag before doing prefetch of request
      block: replace always false argument with 'false'
      block: move RQF_ELV setting into allocators
      block: have plug stored requests hold references to the queue
      block: split request allocation components into helpers
      block: make bio_queue_enter() fast-path available inline
      block: move queue enter logic into blk_mq_submit_bio()
      block: ensure cached plug request matches the current queue

Luis Chamberlain (1):
      block: fix device_add_disk() kobject_create_and_add() error handling

Ming Lei (8):
      dm: don't stop request queue after the dm device is suspended
      blk-mq: only try to run plug merge if request has same queue with incoming bio
      blk-mq: add RQF_ELV debug entry
      blk-mq: update hctx->nr_active in blk_mq_end_request_batch()
      blk-mq: add one API for waiting until quiesce is done
      scsi: avoid to quiesce sdev->request_queue two times
      scsi: make sure that request queue queiesce and unquiesce balanced
      nvme: wait until quiesce is done

Ye Bin (1):
      blk-mq: don't free tags if the tag_set is used by other device in queue initialztion

 block/blk-core.c           |  61 +++++----------
 block/blk-merge.c          |   6 +-
 block/blk-mq-debugfs.c     |   1 +
 block/blk-mq-sched.c       |  15 +++-
 block/blk-mq.c             | 187 +++++++++++++++++++++++++++++++--------------
 block/blk-mq.h             |  12 ++-
 block/blk.h                |  35 +++++++++
 block/genhd.c              |   8 +-
 drivers/md/dm.c            |  10 ---
 drivers/nvme/host/core.c   |   4 +
 drivers/scsi/scsi_lib.c    |  62 +++++++++------
 include/linux/blk-mq.h     |   1 +
 include/scsi/scsi_device.h |   1 +
 13 files changed, 263 insertions(+), 140 deletions(-)

-- 
Jens Axboe

