Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFF9CCA479
	for <linux-block@archiver.kernel.org>; Fri,  1 Jul 2022 16:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiGAQZp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Jul 2022 12:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiGAQZo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Jul 2022 12:25:44 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE6140A09
        for <linux-block@vger.kernel.org>; Fri,  1 Jul 2022 09:25:44 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id k14so783231qtm.3
        for <linux-block@vger.kernel.org>; Fri, 01 Jul 2022 09:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=CqLS9/VnMCYBuMzbL3e0tU8Vk7oa/JV3t+gC5Xn/h/k=;
        b=RZAqdBmuhIc+ihwcegqL4Hg5zdzu1EP4x+QECpbLjfGV+h2IL2Kbls+6Y7ISWrno8L
         UCWNivqAnGlZwsZATx4/15RYWeY4L9YGu5SqFow3IrLOmraJyT0O8UVlVp8/QhAMejyQ
         xAPOfn+hnvKUCWtVlKp/pc/NiKbRoKYzuwyla+C2a5VLfwnFds3hegpjG8J+QhbMx4wj
         /bCBU4zt1tMy1MABIA64pbViI07RcQoRqlI8KSIVM3AYPvhBoAfcVClV/Gy1z+jRgVow
         Pmp/Pp8/3A4WCbLfzBMzc0bfuVMXWWlmL548lmSJezcas6k2XSg6wOQWV8XgUWJzKLDR
         Z+6A==
X-Gm-Message-State: AJIora9n6kgwA7PQkNaH1kruT5g16zAb/xzQInvHKiR8PutD9x4HxzF6
        wgqo8nRtCi4Oy0mOjtuEegKb
X-Google-Smtp-Source: AGRyM1tzR5+oekiebA2Cl4ZcA8vDGKaik3m8+xoET3D9HB7EA7KAOUlWMkJMC/Ms3M1Oy/CjZO9H4Q==
X-Received: by 2002:ac8:570f:0:b0:31d:3692:36e0 with SMTP id 15-20020ac8570f000000b0031d369236e0mr4051034qtw.343.1656692743249;
        Fri, 01 Jul 2022 09:25:43 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id k201-20020a37a1d2000000b006a716fed4d6sm17007710qke.50.2022.07.01.09.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 09:25:42 -0700 (PDT)
Date:   Fri, 1 Jul 2022 12:25:41 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org, Alasdair G Kergon <agk@redhat.com>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [git pull] device mapper fixes for 5.19-rc5
Message-ID: <Yr8gBVNDik5el/n/@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit 90736eb3232d208ee048493f371075e4272e0944:

  dm mirror log: clear log bits up to BITS_PER_LONG boundary (2022-06-23 14:55:43 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.19/dm-fixes-5

for you to fetch changes up to 617b365872a247480e9dcd50a32c8d1806b21861:

  dm raid: fix KASAN warning in raid5_add_disks (2022-06-29 19:48:04 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- 3 fixes for invalid memory accesses discovered by using KASAN while
  running the lvm2 testsuite's dm-raid tests. Includes changes to MD's
  raid5.c given the dependency dm-raid has on the MD code.

----------------------------------------------------------------
Heinz Mauelshagen (1):
      dm raid: fix accesses beyond end of raid member array

Mikulas Patocka (2):
      dm raid: fix KASAN warning in raid5_remove_disk
      dm raid: fix KASAN warning in raid5_add_disks

 drivers/md/dm-raid.c | 34 ++++++++++++++++++----------------
 drivers/md/raid5.c   |  6 +++++-
 2 files changed, 23 insertions(+), 17 deletions(-)
