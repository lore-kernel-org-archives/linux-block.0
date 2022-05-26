Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A86C433F5
	for <linux-block@archiver.kernel.org>; Thu, 26 May 2022 16:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiEZQlT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 May 2022 12:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344474AbiEZQlR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 May 2022 12:41:17 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBBD4FC7B
        for <linux-block@vger.kernel.org>; Thu, 26 May 2022 09:41:17 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id hh4so2187268qtb.10
        for <linux-block@vger.kernel.org>; Thu, 26 May 2022 09:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=z+vKLXdt60QDKO4b9wBgGIXuJw5ArCpTgFr2gphTDQc=;
        b=54k934GOxySdEvoeURXnsotwqfX10lCGYkXfAfrL+jA+cnqbRiKnilb190ZFUMGwRQ
         QAOoR7g8jiZJpD9Kl1361fuo19nsW0hxelzOm3JAgKhoxpNFpqlv/DBNuCCFkW0YPqh9
         GEhsbYgEzFk6J8VTPpnNlDjP+RYOayvR6u9V0fzzPJvekaT1pqp5urQPyWa0zEe1+4xR
         ltFa1GqqN9b1pFksw6Xg7QUDXK/3t8XZasku5Ie9ziDpApB8Bk0SPCPK9rA1MYI5cA49
         WvQL0Hz/KrjbYvFci6KUUiw7F99U4jSY7C6WuM5N+LXN/lL/OTMp9gLv5192hFi60f6c
         JZ0A==
X-Gm-Message-State: AOAM530sPWo/UTSafn6bjdlo3pbOzZEmfTFhG28OzJbv99SvHKyMg+y+
        oiW3W4iyIs54KyYK06sXQMKw
X-Google-Smtp-Source: ABdhPJy95jqT31JGjEPtVMwTjrkY/rfbXKIerIVzATOcXvkzK5HGQljn97qXkoV5na7XMf+Bsbf25g==
X-Received: by 2002:a05:6214:224f:b0:43f:d536:d014 with SMTP id c15-20020a056214224f00b0043fd536d014mr31290972qvc.50.1653583276042;
        Thu, 26 May 2022 09:41:16 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id w21-20020a05620a445500b0069fc13ce209sm1638370qkp.58.2022.05.26.09.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 09:41:15 -0700 (PDT)
Date:   Thu, 26 May 2022 12:41:14 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [git pull] device mapper changes for 5.19
Message-ID: <Yo+tqngHo5JCZTJc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

These changes build on Jens' for-5.19 block tree because of various
block changes that impacted DM and/or prereqs for these DM changes.

The following changes since commit 069adbac2cd85ae00252da6c5576cbf9b9d9ba6e:

  block: improve the error message from bio_check_eod (2022-05-04 18:30:10 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.19/dm-changes

for you to fetch changes up to ca522482e3eafd005b8d4e8b1331c911505a58d5:

  dm: pass NULL bdev to bio_alloc_clone (2022-05-11 13:58:52 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Enable DM core bioset's per-cpu bio cache if QUEUE_FLAG_POLL
  set. This change improves DM's hipri bio polling (REQ_POLLED)
  performance by 7 - 20% depending on the system.

- Update DM core to use jump_labels to further reduce cost of unlikely
  branches for zoned block devices, dm-stats and swap_bios throttling.

- Various DM core changes to reduce bio-based DM overhead and simplify
  IO accounting.

- Fundamental DM core improvements to dm_io reference counting and the
  elimination of using bio_split()+bio_chain() -- instead DM's
  bio-based IO accounting is updated to account that a split occurred.

- Improve DM core's abnormal bio processing to do less work.

- Improve DM core's hipri polling support to use a single list rather
  than an hlist.

- Update DM core to pass NULL bdev to bio_alloc_clone() so that
  initialization that isn't useful for DM can be elided.

- Add cond_resched to DM stats' various loops that loop over all
  entries.

- Fix incorrect error code return from DM integrity's constructor.

- Make DM crypt's printing of the key constant-time.

- Update bio-based DM multipath to provide high-resolution timer to
  the Historical Service Time (HST) path selector.

----------------------------------------------------------------
Dan Carpenter (1):
      dm integrity: fix error code in dm_integrity_ctr()

Gabriel Krisman Bertazi (1):
      dm mpath: provide high-resolution timer to HST for bio-based

Guo Zhengkui (1):
      dm cache metadata: remove unnecessary variable in __dump_mapping

Mike Snitzer (14):
      dm: conditionally enable BIOSET_PERCPU_CACHE for dm_io bioset
      dm: factor out dm_io_set_error and __dm_io_dec_pending
      dm: simplify dm_io access in dm_split_and_process_bio
      dm: simplify dm_start_io_acct
      dm: mark various branches unlikely
      dm: add local variables to clone_endio and __map_bio
      dm: move hot dm_io members to same cacheline as dm_target_io
      dm: introduce dm_{get,put}_live_table_bio called from dm_submit_bio
      dm: conditionally enable branching for less used features
      dm: simplify basic targets
      dm: use bio_sectors in dm_aceept_partial_bio
      dm: simplify bio-based IO accounting further
      dm: improve abnormal bio processing
      dm: pass NULL bdev to bio_alloc_clone

Mikulas Patocka (2):
      dm stats: add cond_resched when looping over entries
      dm crypt: make printing of the key constant-time

Ming Lei (7):
      dm: don't pass bio to __dm_start_io_acct and dm_end_io_acct
      dm: pass dm_io instance to dm_io_acct directly
      dm: switch to bdev based IO accounting interfaces
      dm: improve bio splitting and associated IO accounting
      dm: don't grab target io reference in dm_zone_map_bio
      dm: improve dm_io reference counting
      dm: put all polled dm_io instances into a single list

 drivers/md/dm-cache-metadata.c             |   3 +-
 drivers/md/dm-core.h                       |  38 +-
 drivers/md/dm-crypt.c                      |  14 +-
 drivers/md/dm-delay.c                      |   3 +-
 drivers/md/dm-flakey.c                     |   4 +-
 drivers/md/dm-integrity.c                  |   2 -
 drivers/md/dm-linear.c                     |  11 +-
 drivers/md/dm-mpath.c                      |   8 +-
 drivers/md/dm-path-selector.h              |  15 +
 drivers/md/dm-ps-historical-service-time.c |   1 +
 drivers/md/dm-stats.c                      |  11 +
 drivers/md/dm-table.c                      |  16 +-
 drivers/md/dm-zone.c                       |  10 -
 drivers/md/dm.c                            | 556 +++++++++++++++++------------
 drivers/md/dm.h                            |   4 +-
 15 files changed, 409 insertions(+), 287 deletions(-)
