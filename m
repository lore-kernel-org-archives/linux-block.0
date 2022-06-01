Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3F8C433EF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 20:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiFAU7u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 16:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiFAU7u (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 16:59:50 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C74209064
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 13:59:49 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id 190so2295944qkj.8
        for <linux-block@vger.kernel.org>; Wed, 01 Jun 2022 13:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3Il2sr4cXjU8yOwsfjBHoPflo5uLJpNZAFsBDi52fpw=;
        b=cI/TeRnId1z485OsSbUBpFj4EVVeErJxqgReJx0JRdE6BQCAnMNe8jq0hwvykAgJ4T
         iTUbmuhnjSGqVPzz4vADOmpLyBdu6o9TNo8r0fuQSbWafhgKCYnR6TQC4Ju7ewRNdwU8
         HEQfw72ymCPWUcQQITP546+MQpp2lo4q883mbn8vgskUHI4ZMPfK14hQ0oQiErHkFmFy
         0bwjJiDoRIJxa4Nv3itzy58UK5+aoSEghowVK2xFMXn8ApjFoxHPUD9E4c5tsEujyUD9
         PpBBu4Wmmg9tB91Op+lIi9Gf5F5QNWdsswGEUj+1cCJCa850wehD6ttIAkgUwmaN0R1E
         zExw==
X-Gm-Message-State: AOAM5300m4gtm0nuiQUK86UqMAKQfArptvP3KowLEW8cwch3+v121Zzx
        UQgoiUY621GQx9UuAMqAW2cr
X-Google-Smtp-Source: ABdhPJyD9xv6RupucWCiGGBWA4YEtS55Ndss4nBseM+kOnW6oYvBleLUYOueHZSBL+6CJAA6y254sg==
X-Received: by 2002:a05:620a:1a22:b0:6a5:dac3:7fb1 with SMTP id bk34-20020a05620a1a2200b006a5dac37fb1mr1077202qkb.377.1654117188277;
        Wed, 01 Jun 2022 13:59:48 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id d16-20020ac81190000000b002f93ece0df3sm1681790qtj.71.2022.06.01.13.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 13:59:47 -0700 (PDT)
Date:   Wed, 1 Jun 2022 16:59:46 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Sarthak Kukreti <sarthakkukreti@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: [git pull] device mapper fixes for 5.19-rc1
Message-ID: <YpfTQgw6RsEYxSFD@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit ca522482e3eafd005b8d4e8b1331c911505a58d5:

  dm: pass NULL bdev to bio_alloc_clone (2022-05-11 13:58:52 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.19/dm-fixes

for you to fetch changes up to 4caae58406f8ceb741603eee460d79bacca9b1b5:

  dm verity: set DM_TARGET_IMMUTABLE feature flag (2022-05-31 16:22:30 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix DM core's dm_table_supports_poll to return false if no data
  devices.

- Fix DM verity target so that it cannot be switched to a different DM
  target type (e.g. dm-linear) via DM table reload.

----------------------------------------------------------------
Mike Snitzer (1):
      dm table: fix dm_table_supports_poll to return false if no data devices

Sarthak Kukreti (1):
      dm verity: set DM_TARGET_IMMUTABLE feature flag

 drivers/md/dm-table.c         | 19 +++++++++++++++----
 drivers/md/dm-verity-target.c |  1 +
 2 files changed, 16 insertions(+), 4 deletions(-)
