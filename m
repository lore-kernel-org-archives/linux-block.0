Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2555C433FE
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 16:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiJRQU5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 12:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJRQUy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 12:20:54 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D955BA3F58
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 09:20:52 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id i9so9638397qvu.1
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 09:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/mmgDfGKB2W6PRUEFzLxW7KICbLn+XjG+eqWRhrcmOU=;
        b=gk0WuZR1eRt/VVllN/AzxhXYGrDgAIwfVyzejl7PZFsngLWj8ZTDK5794m12v7U6nh
         OM2tjlsnBC4yVQXAG7TIe1K9fV4gCccUxMXyG1NFCurZI+u0qAM2IGRNVJSyrBg8dT6e
         n+RkrzCj1pHA1R6sMtbaxQUzDFfugKAW4RiXQmpqOCJZInfmB50IDasq9IM3i00TlGai
         cP8Iw4ZDOiNU6XdKDRE7UQgm3Dr4ayL425Kn0035LSZ8WKC2GO8tHIphmUtzFPY/v8tp
         eOBfxcnTt6LP1EXhnb9KPtd3Gi8tMFHimI3vLti3gHwMYw4RKyhBJFhRWevarVAkJs04
         OAjw==
X-Gm-Message-State: ACrzQf1r375HGET4rCt4gSeBt1+u9qWQGz/53PjyufQBQ2M4ndJ2gNcs
        ta4BmABxfwD0hmky3GamBOij
X-Google-Smtp-Source: AMsMyM7Rw3L0Y2ai/yquews02o6/G5Xu6/dKPlVdzV9roJ4q+sFgTNEAJuIHNA0cHHqzubGFlnaMWA==
X-Received: by 2002:a05:6214:500d:b0:4af:8e3c:d254 with SMTP id jo13-20020a056214500d00b004af8e3cd254mr2935011qvb.36.1666110052039;
        Tue, 18 Oct 2022 09:20:52 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id cb23-20020a05622a1f9700b0039cc22a2c49sm2173671qtb.47.2022.10.18.09.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 09:20:51 -0700 (PDT)
Date:   Tue, 18 Oct 2022 12:20:50 -0400
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
Subject: [git pull] device mapper changes for 6.1
Message-ID: <Y07SYs98z5VNxdZq@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

I missed sending the DM changes during the 6.1 merge window. Slipped my
mind largely due to there not being anything super urgent or more
elaborate this cycle.

But there is one additional stable@ fix from Mikulas that I'll send
separately since it requires the recently introduced test_bit_acquire().

The following changes since commit 1c23f9e627a7b412978b4e852793c5e3c3efc555:

  Linux 6.0-rc2 (2022-08-21 17:32:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.1/dm-changes

for you to fetch changes up to a871fb26aba8911ea313dc7bd28f3e788a80fdb4:

  dm clone: Fix typo in block_device format specifier (2022-10-04 19:00:22 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- DM core replace DMWARN with DMERR or DMCRIT for fatal errors.

- Enhance DM ioctl interface to allow returning an error string to
  userspace. Depends on exporting is_vmalloc_or_module_addr() to allow
  DM core to conditionally free memory allocated with kasprintf().

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

Mikulas Patocka (4):
      dm: change from DMWARN to DMERR or DMCRIT for fatal errors
      dm ioctl: add an option to return an error string to userspace
      mm: export is_vmalloc_or_module_addr
      dm: support allocating error strings to enhance errors returned to userspace

Milan Broz (1):
      dm verity: Add documentation for try_verify_in_tasklet option

Nathan Huckleberry (1):
      dm verity: enable WQ_HIGHPRI on verify_wq

Nikos Tsironis (1):
      dm clone: Fix typo in block_device format specifier

Shaomin Deng (1):
      dm cache: delete the redundant word 'each' in comment

 Documentation/admin-guide/device-mapper/verity.rst |   4 +
 drivers/md/dm-cache-policy.h                       |   2 +-
 drivers/md/dm-clone-target.c                       |   2 +-
 drivers/md/dm-ioctl.c                              | 125 +++++++++++-------
 drivers/md/dm-raid.c                               |   4 +-
 drivers/md/dm-rq.c                                 |   4 +-
 drivers/md/dm-stats.c                              |   2 +-
 drivers/md/dm-table.c                              | 139 +++++++++++----------
 drivers/md/dm-verity-target.c                      |  18 +--
 drivers/md/dm.c                                    |   9 +-
 include/linux/device-mapper.h                      |  18 ++-
 include/uapi/linux/dm-ioctl.h                      |  14 ++-
 mm/vmalloc.c                                       |   1 +
 13 files changed, 205 insertions(+), 137 deletions(-)
