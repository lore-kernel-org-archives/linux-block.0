Return-Path: <SRS0=gQfC=TF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235A1C004C9
	for <linux-block@archiver.kernel.org>; Sun,  5 May 2019 15:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB621208C2
	for <linux-block@archiver.kernel.org>; Sun,  5 May 2019 15:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F43QrZVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfEEPGb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 May 2019 11:06:31 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:43926 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfEEPGb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 May 2019 11:06:31 -0400
Received: by mail-pg1-f182.google.com with SMTP id t22so5144365pgi.10
        for <linux-block@vger.kernel.org>; Sun, 05 May 2019 08:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OQHmsLZg85Ox1XaWwtwcBlCGC9l529kXQWnEyWbchlo=;
        b=F43QrZVknc8Ewd2WJLDr6muQ/riLQPAV8BJS538cprdnnRBcU7xhoI9gxpJ5mlEpme
         DsdQOU01CzupHtoM+KgZqYm4qIZzgc3aNa/UQ4tPOINEEeyhzJt6tIA86ecsWjQoTYwY
         mUNkVGmUnlmiS74eNmwbmj99emLKOpmKMkezugVeUIxSB6fwzlVAPKFpAZC/OmjpHDoU
         KJ66folwBUBee0M1G4fVI69lmMtWHJu/bDcLBynmQYJR0GrTpJ0VUr7b1932EOJwQmpn
         fAfsoSzF2HzCWSr+tmZHiQnoh6Ph1Qihxj3fz6EOKSfgrDZLBxlACyg0mQjGLwdez8Xw
         lh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OQHmsLZg85Ox1XaWwtwcBlCGC9l529kXQWnEyWbchlo=;
        b=g5c0F1L8DM1OPrF/OUiMU/hF95QG1pD9kNqyohRJVdryVvkzHoBDxRturiGFjSrxjt
         kaNn7aela9ptpbF4KsLlXVK+NBqr0LGHIN4Bjfs0xGeeuTglLV3tN9pXMhJoK30I5EJc
         6wcDycW06okIVkjxwLtu2yxUQDmiAwNCDPSBNeBiej+q+RZkukvnaT0i35ypT8TnrEfc
         R8tICuCxuUq8Nz3WiA6mfg8jNNJYChkheOUenfT0svcUy7ynxufRHieAz/IC4aV/Imx0
         IID3n67k3ASPOhjnrkhr/OV3BqciSMSK0pM8p4twwWa8jDyB/ggEhGvF3oQMcZy6Cira
         dkKA==
X-Gm-Message-State: APjAAAXo9urd6gPgm586enbNl91RiZ0yrT+LgkSMaMJrD4F98cTmwURK
        HcEIBpKxfxOKGD0EBOPzEG6LPkR4jsM=
X-Google-Smtp-Source: APXvYqycwM1fu+pHfN/qrcKzZkVXcdlyEGEcqupfuPmNsEmmIC8XQ2+GtWTlM+nxjAnqyMsleYMJvA==
X-Received: by 2002:a63:171c:: with SMTP id x28mr25250347pgl.12.1557068790594;
        Sun, 05 May 2019 08:06:30 -0700 (PDT)
Received: from localhost.localdomain ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id e1sm10152381pfn.187.2019.05.05.08.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 08:06:29 -0700 (PDT)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH 0/3] blktests: nvme: Fix pass data of nvmet TCs
Date:   Mon,  6 May 2019 00:06:08 +0900
Message-Id: <20190505150611.15776-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Omar,

This patchset fixes mismatch between expected pass data and real data
printed out for nvmet testcases.

It has been long time to have changes for nvmet and nvme-cli.  The
following commits can explain why the pass data has to be updated.

About genctr:
  Commit b662a078 ("nvmet: enable Discovery Controller AENs")

About treq field:
- nvmet:
  Commit 9b95d2fb ("nvmet: expose support for fabrics SQ flow control
                    disable in treq")
- nvme-cli:
  Commit 2cf370c3 ("fabrics: support fabrics sq flow control disable")

Please correct me if I'm wrong here. :)

Thanks,

*** BLURB HERE ***

Minwoo Im (3):
  nvme: 002: fix nvmet pass data with loop
  nvme: 016: fix nvmet pass data with loop
  nvme: 017: fix nvmet pass data with loop

 tests/nvme/002.out | 2002 ++++++++++++++++++++++++++--------------------------
 tests/nvme/016.out |    4 +-
 tests/nvme/017.out |    4 +-
 3 files changed, 1005 insertions(+), 1005 deletions(-)

-- 
2.7.4

