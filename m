Return-Path: <SRS0=bHvQ=DU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2291FC433E7
	for <linux-block@archiver.kernel.org>; Tue, 13 Oct 2020 15:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB0A4251E9
	for <linux-block@archiver.kernel.org>; Tue, 13 Oct 2020 15:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovYq1JC8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgJMPkD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Oct 2020 11:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgJMPkD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Oct 2020 11:40:03 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DEEC0613D0
        for <linux-block@vger.kernel.org>; Tue, 13 Oct 2020 08:40:02 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id o18so333632ill.2
        for <linux-block@vger.kernel.org>; Tue, 13 Oct 2020 08:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=BWuxsuYMy3Ft55pYDqFEGYRHo/hYknbOtywffUE0H5w=;
        b=ovYq1JC8P1vZUXip/SXh432jJbS4dkoiFTz/1vOUXS807MVGklFeJlezRon7xjULyP
         57/AEtszmN6AbZRA/GUKjIXzgR89PwwJi7EuOAfucLwn47ZsQ2JrAQ2laojOtjL/XqbG
         BKuzIoRWERVAhpwj6G9nIoQhYqCXaCsVip+B/mmo5kB4umIHd1xEOEMaoXay+5HgBIPY
         ghbintz7flBUhgheF80hQge2bDt2OnuCE0S+Dfz5n9N6DGYGVrivSUCs29cw7o7cX0MC
         620pnuBC5e4RJbQKpi5f6mCiUH3SWs/4eRNtbZ0/wcWjIiTDr7DOqxADJELzE3Km3ysm
         SEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=BWuxsuYMy3Ft55pYDqFEGYRHo/hYknbOtywffUE0H5w=;
        b=jESX+iYcOpuEfQX3CoaPs8N+1uXttxXM74vQ+Zl26K90JZY10+ugFUxweiNywc7HNn
         lBO0RdHf4w0cNaWZBzAlhV1iuI1qvoccaPPLj+FzKfwh5MYyBo/GjZA/dQrIDLtlz1h+
         X28ct4g36kvYp6UDUnRbOyDSxRzqSkHB1oEX8gj9twWMX001s4m3YChL5qETohakST8x
         Q7tQXabVqmeHFscugXVCRlqa2kwXpKSL9ELcXUbNsNGl/kihjZHF2j2b+cp8Muec7OqO
         M9l/sI4DOSbZ2mjorYlhOryrb43Txgm+SLsjiPYYnqHrY4EBZ4V5rof+3PRSJ1Upcvlk
         TYxA==
X-Gm-Message-State: AOAM532BrCbQ5rr7+HqNaHn+Wn8KvcXUaKHd/osRJsLIXFTc1WSPBxPh
        lpsKrOLwngIwSmL+Ybrrq9IkReTyNmD69U3H
X-Google-Smtp-Source: ABdhPJw+v+8uC/SgIsasTewA6kgT3YFEGQloMx7V+htsbeYNSiAqG3w6VuLhFnFx/uWvPZkxeTAg3Q==
X-Received: by 2002:a05:6e02:1110:: with SMTP id u16mr433826ilk.181.1602603602118;
        Tue, 13 Oct 2020 08:40:02 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id b17sm105160ilo.86.2020.10.13.08.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 08:40:01 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
Date:   Tue, 13 Oct 2020 11:40:00 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [git pull] device mapper changes for 5.10
Message-ID: <20201013154000.GA53766@lobo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

This pull's changes depend on various linux-block changes (as noted in
the refernced merge commit's header).

The following changes since commit 1471308fb5ec4335f9ae9fc65f65048dbe7c336e:

  Merge remote-tracking branch 'jens/for-5.10/block' into dm-5.10 (2020-09-29 16:31:35 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.10/dm-changes

for you to fetch changes up to 681cc5e8667e8579a2da8fa4090c48a2d73fc3bb:

  dm: fix request-based DM to not bounce through indirect dm_submit_bio (2020-10-07 18:08:51 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Improve DM core's bio splitting to use blk_max_size_offset(). Also
  fix bio splitting for bios that were deferred to the worker thread
  due to a DM device being suspended.

- Remove DM core's special handling of NVMe devices now that block
  core has internalized efficiencies drivers previously needed to
  be concerned about (via now removed direct_make_request).

- Fix request-based DM to not bounce through indirect dm_submit_bio;
  instead have block core make direct call to blk_mq_submit_bio().

- Various DM core cleanups to simplify and improve code.

- Update DM cryot to not use drivers that set
  CRYPTO_ALG_ALLOCATES_MEMORY.

- Fix DM raid's raid1 and raid10 discard limits for the purposes of
  linux-stable. But then remove DM raid's discard limits settings now
  that MD raid can efficiently handle large discards.

- A couple small cleanups across various targets.

----------------------------------------------------------------
Huaisheng Ye (1):
      dm thin metadata: Remove unused local variable when create thin and snap

Mike Snitzer (17):
      dm table: stack 'chunk_sectors' limit to account for target-specific splitting
      dm: change max_io_len() to use blk_max_size_offset()
      dm: push md->immutable_target optimization down to __process_bio()
      dm: optimize max_io_len() by inlining max_io_len_target_boundary()
      dm: push use of on-stack flush_bio down to __send_empty_flush()
      dm: simplify __process_abnormal_io()
      dm: eliminate need for start_io_acct() forward declaration
      dm table: make 'struct dm_table' definition accessible to all of DM core
      dm: use dm_table_get_device_name() where appropriate in targets
      dm raid: fix discard limits for raid1 and raid10
      dm raid: remove unnecessary discard limits for raid10
      dm: fix missing imposition of queue_limits from dm_wq_work() thread
      dm: fold dm_process_bio() into dm_submit_bio()
      dm: fix comment in __dm_suspend()
      dm: export dm_copy_name_and_uuid
      dm: remove special-casing of bio-based immutable singleton target on NVMe
      dm: fix request-based DM to not bounce through indirect dm_submit_bio

Mikulas Patocka (1):
      dm crypt: don't use drivers that have CRYPTO_ALG_ALLOCATES_MEMORY

Qinglang Miao (1):
      dm snap persistent: simplify area_io()

 block/blk-mq.c                        |   1 -
 drivers/md/dm-cache-target.c          |   2 +-
 drivers/md/dm-core.h                  |  56 ++++-
 drivers/md/dm-crypt.c                 |  17 +-
 drivers/md/dm-ioctl.c                 |   2 +-
 drivers/md/dm-mpath.c                 |  16 +-
 drivers/md/dm-raid.c                  |   9 -
 drivers/md/dm-rq.c                    |   2 +-
 drivers/md/dm-snap-persistent.c       |  11 +-
 drivers/md/dm-table.c                 |  84 +------
 drivers/md/dm-thin-metadata.c         |   6 +-
 drivers/md/dm.c                       | 404 +++++++++++-----------------------
 drivers/md/dm.h                       |   3 -
 drivers/md/persistent-data/dm-btree.c |   3 +-
 include/linux/device-mapper.h         |   1 -
 include/uapi/linux/dm-ioctl.h         |   4 +-
 16 files changed, 224 insertions(+), 397 deletions(-)
