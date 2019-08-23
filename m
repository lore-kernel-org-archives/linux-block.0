Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF210C3A5A2
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 15:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1ED021019
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 15:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ki9tAwKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405883AbfHWPl5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Aug 2019 11:41:57 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44114 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfHWPl4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Aug 2019 11:41:56 -0400
Received: by mail-qt1-f194.google.com with SMTP id 44so11566507qtg.11
        for <linux-block@vger.kernel.org>; Fri, 23 Aug 2019 08:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=S58Ut6awFbXGbTVwROsmK/yvGl2uzNqGRXDVfJ8fjtI=;
        b=ki9tAwKfBTW+y3PAASIHa/Uk8nGbCOtOz6jBgofCXyvNpOpeNoUh7A9JQVIgtFBEHy
         ASoGvShJr0/fZeQxP70KehnjJ1LzMEtYjTeESjC7jjOfFc+NTcJf0uWDjVFuqViJPoUn
         IVvQHVb+CQM2wZlj6DGLVwZiuI2tT6/9ub9GiyW+gxFYeqZMzs+MVXimKmSGq+h2r09v
         PIZFhxYG0UCdblZDYzzy36IBTCc0kOsizhL4fFn6571TiWXAJyRhxx+beCFLkfvgxpV2
         gjUyZV8xABXR2PT0s/32YGRDFTbvP6AEATq/Ai/HgNqtKfZ1UqsZHMFaU+cdwzsG9vd8
         iwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=S58Ut6awFbXGbTVwROsmK/yvGl2uzNqGRXDVfJ8fjtI=;
        b=QzADXbubm+KjlqrS5ynUbZUTS+NMBjlRvlRwycyey4CBdeu8KE4k02fnXIjlx9JqBk
         26X8bGYP4IpFwvrWG9b959s7VrX50Js/dqR9rOz1R3n9iBKZv15FjVCykpiX0OEpQNMq
         4gSl/UqlHUcWF8UmP2SLhrmcUh7qsJHmtDTcwrpnsMZ9Z3GnPXF50LsB810nba9HG2yc
         108Yhja9ZPgAbC7zmJ0E6QwjeksoRybRvFyI/v5vHV1BlKN+sIqgNfZSdBGqi51D0y1S
         9avrRqeIUMN8b3c77iCxiI5qCYCjOnitQPsWKw/A1Si2DmWKNsvinVzAtkYTHhqxnr+9
         cWkA==
X-Gm-Message-State: APjAAAU+dHMBZUfOzPRiR7f/i2EFICwodTn0mHXtBkeXe3rjiTGbfNv7
        9fE5NZNBXOCQQl32U67VLdQ=
X-Google-Smtp-Source: APXvYqwSnfUlkGS1tztrmwyBgMgAlVfIZEhOrURhEbQ5oVj4HH644m2tOyUdMAQ5G9Z8Vjuels2YZQ==
X-Received: by 2002:ac8:4a8f:: with SMTP id l15mr5442837qtq.29.1566574915981;
        Fri, 23 Aug 2019 08:41:55 -0700 (PDT)
Received: from localhost (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x145sm1667988qka.106.2019.08.23.08.41.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 08:41:55 -0700 (PDT)
Date:   Fri, 23 Aug 2019 11:41:53 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Bryan Gurney <bgurney@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Wenwen Wang <wenwen@cs.uga.edu>,
        ZhangXiaoxu <zhangxiaoxu5@huawei.com>
Subject: [git pull] device mapper fixes for 5.3-rc6
Message-ID: <20190823154153.GA24648@lobo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

More fixes than usual from DM at this stage in a release but...

The following changes since commit d45331b00ddb179e291766617259261c112db872:

  Linux 5.3-rc4 (2019-08-11 13:26:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.3/dm-fixes-2

for you to fetch changes up to 1cfd5d3399e87167b7f9157ef99daa0e959f395d:

  dm table: fix invalid memory accesses with too high sector number (2019-08-23 10:11:42 -0400)

Please pull, thanks!
Mike

----------------------------------------------------------------
- Revert a DM bufio change from during the 5.3 merge window now that a
  proper fix has been made to the block loopback driver.

- Fix DM kcopyd to wakeup so failed subjobs get completed.

- Various fixes to DM zoned target to address error handling, and other
  small tweaks (SPDX license identifiers and fix typos).

- Fix DM integrity range locking race by tracking whether journal has
  changed.

- Fix DM dust target to detect reads of badblocks beyond the first 512b
  sector (applicable if blocksize is larger than 512b).

- Fix DM persistent-data issue in both the DM btree and DM
  space-map-metadata interfaces.

- Fix out of bounds memory access with certain DM table configurations.

----------------------------------------------------------------
Bryan Gurney (1):
      dm dust: use dust block size for badblocklist index

Dan Carpenter (1):
      dm zoned: fix potential NULL dereference in dmz_do_reclaim()

Dmitry Fomichev (6):
      dm kcopyd: always complete failed jobs
      dm zoned: improve error handling in reclaim
      dm zoned: improve error handling in i/o map code
      dm zoned: properly handle backing device failure
      dm zoned: add SPDX license identifiers
      dm zoned: fix a few typos

Mikulas Patocka (3):
      Revert "dm bufio: fix deadlock with loop device"
      dm integrity: fix a crash due to BUG_ON in __journal_read_write()
      dm table: fix invalid memory accesses with too high sector number

Wenwen Wang (1):
      dm raid: add missing cleanup in raid_ctr()

ZhangXiaoxu (2):
      dm btree: fix order of block initialization in btree_split_beneath
      dm space map metadata: fix missing store of apply_bops() return value

 drivers/md/dm-bufio.c                              |  4 +-
 drivers/md/dm-dust.c                               | 11 +++-
 drivers/md/dm-integrity.c                          | 15 +++++
 drivers/md/dm-kcopyd.c                             |  5 +-
 drivers/md/dm-raid.c                               |  2 +-
 drivers/md/dm-table.c                              |  5 +-
 drivers/md/dm-zoned-metadata.c                     | 68 ++++++++++++++++------
 drivers/md/dm-zoned-reclaim.c                      | 47 +++++++++++----
 drivers/md/dm-zoned-target.c                       | 68 +++++++++++++++++++---
 drivers/md/dm-zoned.h                              | 11 ++++
 drivers/md/persistent-data/dm-btree.c              | 31 +++++-----
 drivers/md/persistent-data/dm-space-map-metadata.c |  2 +-
 12 files changed, 209 insertions(+), 60 deletions(-)
