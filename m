Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D808C3F6B0
	for <linux-block@archiver.kernel.org>; Fri, 12 Aug 2022 01:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbiHLBaw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Aug 2022 21:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbiHLBau (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Aug 2022 21:30:50 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E8F13D2C
        for <linux-block@vger.kernel.org>; Thu, 11 Aug 2022 18:30:48 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id c20so4998215qtw.8
        for <linux-block@vger.kernel.org>; Thu, 11 Aug 2022 18:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=yUY3y7VRwdC6vJJ5qbh6vFjQfNfR51ousKDLvXQmjxA=;
        b=RzhP5i5iOil8JgSjK/A8hjBMNehzHnHSQibhW8VDwm9QJEZd/NXgRXjQEQI3UwVaJC
         0xZFfvYobj0AQykco8Ss8BDagujlMJue2wwIY8KBYTcgBg82C4OYHzpPubBhDLicOwZ+
         QkK9A+HtuO+jy71xQxZnKL0EalTmyaslp7B45SgUFoBh7ofKAPUih76M9epXMeNlXHlR
         PDCwn2EOE0F/gUCvXsq4BFqWhGQU9JJyWzIZpH6suu23z2Zvozh+tkkHbSRpI0OaK10L
         LdpjDdpD8G/zskRGpsLbqj7IuIjQNOiHxthMSQ+WFMu3Btw7C0esmymgnzL5NVzXSYwu
         D+DQ==
X-Gm-Message-State: ACgBeo19v3OGwQ4BgG0pyR1/zTrXze7PUWclqfsOaEaaLEstPeNFWA5z
        4U/7Hms+6J5sXKKV4I2ASmVe
X-Google-Smtp-Source: AA6agR5UJL/V77XrRkAMi1IA+MwyYdPA1zrHNsV15uH9IyLRY3wJ9BpRRbznCeYo40CI+asyvf6Nfg==
X-Received: by 2002:a05:622a:104c:b0:343:587c:1bc8 with SMTP id f12-20020a05622a104c00b00343587c1bc8mr1756103qte.484.1660267847293;
        Thu, 11 Aug 2022 18:30:47 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id s12-20020a05620a29cc00b006b6757a11fcsm756086qkp.36.2022.08.11.18.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 18:30:45 -0700 (PDT)
Date:   Thu, 11 Aug 2022 21:30:44 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan Huckleberry <nhuck@google.com>
Subject: [git pull] device mapper fixes for 6.0-rc1
Message-ID: <YvWtRMgKKKSEcEAr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit 12907efde6ad984f2d76cc1a7dbaae132384d8a5:

  dm verity: have verify_wq use WQ_HIGHPRI if "try_verify_in_tasklet" (2022-08-04 15:59:52 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.0/dm-fixes

for you to fetch changes up to e3a7c2947b9e01b9cedd3f67849c0ae95f0fadfa:

  dm bufio: fix some cases where the code sleeps with spinlock held (2022-08-11 11:10:42 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- A few fixes for the DM verity and bufio changes from the 6.0 merge.

- A smatch warning fix for DM writecache locking in writecache_map.

----------------------------------------------------------------
Mike Snitzer (3):
      dm bufio: simplify DM_BUFIO_CLIENT_NO_SLEEP locking
      dm verity: fix DM_VERITY_OPTS_MAX value yet again
      dm verity: fix verity_parse_opt_args parsing

Mikulas Patocka (2):
      dm writecache: fix smatch warning about invalid return from writecache_map
      dm bufio: fix some cases where the code sleeps with spinlock held

 drivers/md/dm-bufio.c         | 20 +++++++++++++-------
 drivers/md/dm-verity-target.c | 14 ++++++++++++--
 drivers/md/dm-writecache.c    |  3 ++-
 3 files changed, 27 insertions(+), 10 deletions(-)
