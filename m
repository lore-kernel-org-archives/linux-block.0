Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C196CC4332F
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 21:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiJRVha (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 17:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiJRVh3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 17:37:29 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA4D67479
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 14:37:25 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id 8so9585103qka.1
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 14:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qucTfioTfkNWPiEspTo39qx+nKJrutlIOcYMZym3P+I=;
        b=dAH3dghkgy4XiSQTzi+JWAZoeQ6Bz4USxLYHS5R2H42NhaPPKlGly1r24/gQekiB32
         pIkwwYJHxx40OOJCjMOlSUkdaiuBoOFBo0lsoqiLTjpn8VSAb7uJjnlZIqjrmc6+zUE8
         TZrvl+Gzpb7TsskL8zKJXwB4Amb/yHyGfaBIqp/H7/lEsSOpLxvq+k08pCORXFR+jqIc
         OSjrVq/8N7qqEHGm+cfxPnXUgSXrNNKdPeX+LWzOSP89/hO8n4HZo4Dvl+rHqOh0avsb
         g5sQ8deKjaZaQJLCYcM2+5bvTZQO2mjTGho9Nj9cI4TxTmZEz1ZpKjN3yBQEtXPFXsaK
         V+oA==
X-Gm-Message-State: ACrzQf2QACfuGtn9gIkC7HAy8G21lBBQAx858OlcSci3gKPHnQVP7uuQ
        PkVVd+qEvT03NmJLC+RaeWxzXvjhvtDs
X-Google-Smtp-Source: AMsMyM4At/fG60tC2mMfxvZET8ME+iGLCQzyZE1N0TiB9lYPVFAtWa9SVDXQrmEBtekB1mkTzcgOOA==
X-Received: by 2002:a37:ae87:0:b0:6d1:debe:4cf4 with SMTP id x129-20020a37ae87000000b006d1debe4cf4mr3458565qke.655.1666129044312;
        Tue, 18 Oct 2022 14:37:24 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id bm30-20020a05620a199e00b006e42a8e9f9bsm3285240qkb.121.2022.10.18.14.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 14:37:23 -0700 (PDT)
Date:   Tue, 18 Oct 2022 17:37:22 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [git pull v2] device mapper changes for 6.1
Message-ID: <Y08ckqIVOmGVVX5e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

I dropped the DM ioctl changes to allow returning an error string to
userspace.  I rebased the unrelated earlier DM changes (from tag
for-6.1/dm-changes) ontop of the 'for-6.1/dm-fix' tag... and arrived
this single new tag (for-6.1/dm-changes-v2) for you to pull.

The following changes since commit bb1a1146467ad812bb65440696df0782e2bc63c8:

  Merge tag 'cgroup-for-6.1-rc1-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup (2022-10-17 18:52:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.1/dm-changes-v2

for you to fetch changes up to 5434ee8d28575b2e784bd5b4dbfc912e5da90759:

  dm clone: Fix typo in block_device format specifier (2022-10-18 17:17:48 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix dm-bufio to use test_bit_acquire to properly test_bit on arches
  with weaker memory ordering.

- DM core replace DMWARN with DMERR or DMCRIT for fatal errors.

- Enable WQ_HIGHPRI on DM verity target's verify_wq.

- Add documentation for DM verity's try_verify_in_tasklet option.

- Various typo and redundant word fixes in code and/or comments.

----------------------------------------------------------------
Genjian Zhang (1):
      dm: remove unnecessary assignment statement in alloc_dev()

Jiangshan Yi (1):
      dm raid: fix typo in analyse_superblocks code comment

Jilin Yuan (1):
      dm raid: delete the redundant word 'that' in comment

Mikulas Patocka (2):
      dm bufio: use the acquire memory barrier when testing for B_READING
      dm: change from DMWARN to DMERR or DMCRIT for fatal errors

Milan Broz (1):
      dm verity: Add documentation for try_verify_in_tasklet option

Nathan Huckleberry (1):
      dm verity: enable WQ_HIGHPRI on verify_wq

Nikos Tsironis (1):
      dm clone: Fix typo in block_device format specifier

Shaomin Deng (1):
      dm cache: delete the redundant word 'each' in comment

 Documentation/admin-guide/device-mapper/verity.rst |  4 ++
 drivers/md/dm-bufio.c                              | 13 ++--
 drivers/md/dm-cache-policy.h                       |  2 +-
 drivers/md/dm-clone-target.c                       |  2 +-
 drivers/md/dm-ioctl.c                              | 78 +++++++++++-----------
 drivers/md/dm-raid.c                               |  4 +-
 drivers/md/dm-rq.c                                 |  4 +-
 drivers/md/dm-stats.c                              |  2 +-
 drivers/md/dm-table.c                              | 78 +++++++++++-----------
 drivers/md/dm-verity-target.c                      | 18 ++---
 drivers/md/dm.c                                    |  9 ++-
 11 files changed, 110 insertions(+), 104 deletions(-)
