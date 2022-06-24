Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D72C43334
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 03:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiFXDWT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 23:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiFXDWT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 23:22:19 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A35A60F2E
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 20:22:18 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id q4so2878606qvq.8
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 20:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=nog/N1Tt1ilQPRIuhQxXtOK39ivjIhmHL+Bl4v+3mIQ=;
        b=Cm/1zjC4JdiGsq9AMB/Z8FelLQ2OzxIdD5VC+GDTM6/Zuk6Otqcux1ZTIzrgA79e4x
         9FY/IekYSuGd7E4qThYcP0iRJV6sdrB2dWcFSfaE0NpO7aXuYe9MpS7eycJjzH9H0FF9
         JUnug/XlfMToQOpmtDHHEqPNbqiUbhQC0fK4zWFYUpmkT5pGUqi7EVzEnErTL8YtDlzr
         oWtlIIxaDfO/rqXtBHVPQ/9HwfDBvFANxwq5u3uCmXbm9OStqFd0hp3gblSqVx5ODQEF
         sO1CGRXRTquN3ZsYRo427wyV4PxRtbm6BZKGioqMio4A57iQIbyqE95Q/NMsHpgqPpFh
         hiXA==
X-Gm-Message-State: AJIora+dxs5NY/BToLYlcY4tX5SWy4GNE8N7dlePpVSCWtda+aqZEdjF
        fxczpurGHGDqxNaMLjpU7DAY
X-Google-Smtp-Source: AGRyM1tkHW0wE62UC0PoNkwESXmY+aMzJTLD+4A2/3Rw4gPzEspCelrkZGeZgcpali0vKtyT22BTrw==
X-Received: by 2002:a05:622a:118b:b0:305:bc2:c7c9 with SMTP id m11-20020a05622a118b00b003050bc2c7c9mr11356378qtk.61.1656040937303;
        Thu, 23 Jun 2022 20:22:17 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id z16-20020ac84550000000b003052599371fsm678363qtn.12.2022.06.23.20.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 20:22:16 -0700 (PDT)
Date:   Thu, 23 Jun 2022 23:22:16 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Benjamin Marzinski <bmarzins@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Nikos Tsironis <ntsironis@arrikto.com>
Subject: [git pull] device mapper fixes for 5.19-rc4
Message-ID: <CAH6w=awrSaC5zmPEwR95mr02wtU5ti4qjXa-DiwpVe6XmzzcLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.19/dm-fixes-4

for you to fetch changes up to 90736eb3232d208ee048493f371075e4272e0944:

  dm mirror log: clear log bits up to BITS_PER_LONG boundary (2022-06-23 14:55:43 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix DM era to commit metadata during suspend using drain_workqueue
  instead of flush_workqueue.

- Fix DM core's dm_io_complete to not return early if io error is
  BLK_STS_AGAIN but bio polling is not in use.

- Fix DM core's dm_io_complete BLK_STS_DM_REQUEUE handling when dm_io
  represents a split bio.

- Fix recent DM mirror log regression by clearing bits up to
  BITS_PER_LONG boundary.

----------------------------------------------------------------
Mike Snitzer (1):
      dm: do not return early from dm_io_complete if BLK_STS_AGAIN without polling

Mikulas Patocka (1):
      dm mirror log: clear log bits up to BITS_PER_LONG boundary

Ming Lei (1):
      dm: fix BLK_STS_DM_REQUEUE handling when dm_io represents split bio

Nikos Tsironis (1):
      dm era: commit metadata in postsuspend after worker stops

 drivers/md/dm-core.h       |  1 +
 drivers/md/dm-era-target.c |  8 +++++++-
 drivers/md/dm-log.c        |  2 +-
 drivers/md/dm.c            | 15 ++++++++++-----
 4 files changed, 19 insertions(+), 7 deletions(-)
