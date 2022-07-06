Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF29C43334
	for <linux-block@archiver.kernel.org>; Wed,  6 Jul 2022 17:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbiGFRou (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Jul 2022 13:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbiGFRof (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jul 2022 13:44:35 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D1B2C114
        for <linux-block@vger.kernel.org>; Wed,  6 Jul 2022 10:44:06 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id f14so11639040qkm.0
        for <linux-block@vger.kernel.org>; Wed, 06 Jul 2022 10:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CGOgkgQZQXAdQrhuO5tahsN/l1uZl0yMW/oNjzAib68=;
        b=sBsYOsK/0WnXCJZ4+JmmweZ0aU9HTOC/TkgNo5xclz8fzodFk9qQgSKo1KlL9UPRYi
         j0KGAJNL5IUtW1bwAEG3sYJgeDCuIlQICdol/ZdOobEIAdxfFkGcTi9KuUQFC8ONQQKl
         nsBwijkO4zN8wM7BA+iNofSAVvEUt5B6I0y2R33EU4/KRyDwiGKiLJc/APbifyriLfB2
         Odss1rmlGUjqVrAJtAnwO6Vx/DVdIftAgB3MSmp1t98WMhpIL2ijSTu9hggb1yYd8WfU
         Xw5eJ/d6XlwkepTnp1vUfvadbhcRRI/YA+qC4RO6+cNEnZ3Dqf0hGyIPHqMGgGQrqj/n
         imTA==
X-Gm-Message-State: AJIora9fxLmZlLYDiYCuBOPAVAKr+9DLsfGCdNS0uyqTI8d9OULFvbIZ
        ElRtOW+iGY1oCr1ihFvkLEYNefDUFEUA
X-Google-Smtp-Source: AGRyM1tUhODwWG5/sstKbjAnzaQnX7VL7/kOTwaRgoTY3Ftmym2Mbm9mh6r/EU4qNea1cCa4IXC0+w==
X-Received: by 2002:a05:620a:e06:b0:6a7:316a:33f1 with SMTP id y6-20020a05620a0e0600b006a7316a33f1mr28433306qkm.52.1657129444704;
        Wed, 06 Jul 2022 10:44:04 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id u12-20020a05620a454c00b006afd667535asm20912043qkp.83.2022.07.06.10.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 10:44:04 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org
Subject: [5.20 PATCH v3 0/2] dm: improve bio splitting at expense of requeue complexity
Date:   Wed,  6 Jul 2022 13:44:01 -0400
Message-Id: <20220706174403.79317-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.15.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This v3 moves all bio_rewind() code to drivers/md/dm-io-rewind.c for
exclussive use by DM core's dm_io requeue support via dm_io_rewind().

It was determined that block core doesn't need to expose bio_rewind()
for more general use. If/when that changes we can revisit, armed with
the understanding of how DM's use of bio_rewind() has faired.

These changes are now staged for 5.20 inclussion via linux-dm.git

Ming Lei (2):
  dm: add bio_rewind() API to DM core
  dm: add two stage requeue mechanism

 drivers/md/Makefile       |   2 +-
 drivers/md/dm-core.h      |  13 +++-
 drivers/md/dm-io-rewind.c | 166 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/md/dm.c           | 121 +++++++++++++++++++++++++--------
 4 files changed, 273 insertions(+), 29 deletions(-)
 create mode 100644 drivers/md/dm-io-rewind.c

-- 
2.15.0

