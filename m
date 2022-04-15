Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C408C433EF
	for <linux-block@archiver.kernel.org>; Fri, 15 Apr 2022 20:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242926AbiDOUq0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Apr 2022 16:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiDOUqZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Apr 2022 16:46:25 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC816EC67
        for <linux-block@vger.kernel.org>; Fri, 15 Apr 2022 13:43:54 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id b17so7116168qvf.12
        for <linux-block@vger.kernel.org>; Fri, 15 Apr 2022 13:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=dskBOhb9QspscL9XWUhdQTNZeNyaY8giFcfTVpvjXl0=;
        b=aGZo5iE0n7kMCtPV4LMqCyInl8OzbtWBs0+7RTb0LJ6RdVLz5s9MSTBpol4c3OF90l
         IXva3k0BrmrJmDKre/+gOO8/fGttYPDJVq+kmnosDGEA/NH4HMW5Cbql35C9okAwyRzD
         P8zHtDcTGqGGawZRTek6sJBjsOeHcOQ0SMi+bawBRvWf9mZF6/gPFECci4la+hPsj6ck
         az8ek92hHd6jFrb8xSOhDMk6YdP7Y7f+ws0UIMgEH7XdwvgV0BlzYpcExM3n9dVlo4EI
         gtWynmoZgzeYGFa0vy3vuiZIs4byDwnQujCGVe+OR4RUKOP2ml6Da4vfMgKEoOmQsG0u
         eTtw==
X-Gm-Message-State: AOAM533/ylggFdZkzPL3JIC9137Pim30FcluzhT92yYRWZ6DKJBRmgwt
        3Lqr8JF77sIUP+Q+IqNe55Xo
X-Google-Smtp-Source: ABdhPJx2mZgf+C5WY/ENtFTxQGhP2UyjJL9VrfeBaCTo88B1PevALPYO/NvrKfZRsRCQ8h9kR2d62g==
X-Received: by 2002:a05:6214:1bce:b0:441:2d37:1fd1 with SMTP id m14-20020a0562141bce00b004412d371fd1mr548106qvc.10.1650055433456;
        Fri, 15 Apr 2022 13:43:53 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id k2-20020a37ba02000000b0067dc1b0104asm2850502qkf.124.2022.04.15.13.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 13:43:53 -0700 (PDT)
Date:   Fri, 15 Apr 2022 16:43:52 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [git pull] device mapper fixes for 5.18-rc3
Message-ID: <YlnZCHVZNRobAvPZ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e:

  Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.18/dm-fixes-2

for you to fetch changes up to 92b914e29af3e99589f2d2876616c0b534892ed4:

  dm: fix bio length of empty flush (2022-04-15 16:16:09 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix memory corruption in DM integrity target when tag_size is less
  than digest size.

- Fix DM multipath's historical-service-time path selector to not use
  sched_clock() and ktime_get_ns(); only use ktime_get_ns().

- Fix dm_io->orig_bio NULL pointer dereference in dm_zone_map_bio()
  due to 5.18 changes that overlooked DM zone's use of ->orig_bio

- Fix for regression that broke the use of dm_accept_partial_bio() for
  "abnormal" IO (e.g. WRITE ZEROES) that does not need duplicate bios

- Fix DM's issuing of empty flush bio so that it's size is 0.

----------------------------------------------------------------
Khazhismel Kumykov (1):
      dm mpath: only use ktime_get_ns() in historical selector

Mike Snitzer (2):
      dm zone: fix NULL pointer dereference in dm_zone_map_bio
      dm: allow dm_accept_partial_bio() for dm_io without duplicate bios

Mikulas Patocka (1):
      dm integrity: fix memory corruption when tag_size is less than digest size

Shin'ichiro Kawasaki (1):
      dm: fix bio length of empty flush

 drivers/md/dm-integrity.c                  |  7 +++--
 drivers/md/dm-ps-historical-service-time.c | 11 +++----
 drivers/md/dm-zone.c                       | 49 +++++++++++++++++-------------
 drivers/md/dm.c                            | 18 +++++------
 4 files changed, 45 insertions(+), 40 deletions(-)
