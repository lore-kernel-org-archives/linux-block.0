Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C650AC433ED
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 10:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1DD4613B7
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 10:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237784AbhDMKx3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Apr 2021 06:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236800AbhDMKx2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Apr 2021 06:53:28 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2755C061574
        for <linux-block@vger.kernel.org>; Tue, 13 Apr 2021 03:53:08 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id x12so4379136ejc.1
        for <linux-block@vger.kernel.org>; Tue, 13 Apr 2021 03:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Hf/23mY+u8oASzHMsVd82BGfQhaSyWbL1MmnPZrFAk=;
        b=EbGhdA8MVQz3nhg885lHUKx31oV65RgJFjo7reBgElw2kd6Tl2AoWksoBStfshd5tR
         t1+82pA/GX0uJn04gXZ+cxAGVfUqKmKhFNxAMkzZnOZLSR6CpxHCyYLbKgD83Nc/GDY1
         qlFFki7J1iRIB1el2a4WPHnS7uFta8aM/fQCMJVNunNB4ZaJNeeWqcMbbDR0DXyXyejE
         bdHI+EfciRsg4sSglqJ3NFb93a7RGdVbmLQIJ6dBiCstqCWom1RZbvtr6f2Nv3uR2V2y
         +7rfmLWEHNQu2eHvmPQgiCLc5kV86gaLLR4Hxz+wlRGbYPG5t8h4PG84rt5KcvwQjtFO
         mh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Hf/23mY+u8oASzHMsVd82BGfQhaSyWbL1MmnPZrFAk=;
        b=T4U1E2+l7dxG7foW1jhmzSr76VrZp7UTPhr2XSQ100vlZLXTuWyXBWyJ79X/fnuoW2
         0d6+UDqH0Nwim34j4wxjAT5JmN1+Hs9fAem0yAOhHDR/XfVK8cNKj7oyMhE8p5NrlpCl
         /wtn6enSa5+Vtb2/gPitG+Eagm32FfGv0gnMnt+OqvPl7chDMo5UznUm4gq7MQWRsiZL
         bIKo4rftRn9324bYrFimGXEUbDBSL0X0Jmm0HNPt/78j3DCg55qifDxihyuBTIrAQESd
         BiW2YQYt4/McqDJjGENVu/+Qg846dp4m64TcEoFbLxM7nDxqiYuBLBtAaDUzvFUKb4SE
         YJ/w==
X-Gm-Message-State: AOAM533nkYGb5xR+LgzeHTxZM1qaJs74w5tjLvqTUyDD1O2Fq+R7OrEj
        jj93SF0qShuFcu5HjdNdp/F5Tg==
X-Google-Smtp-Source: ABdhPJy++1B5UAiEgJzw/vDjN9WcHMXDtiX1tjOOr5v24mSrjYnQAJmTVsBMT+ggRhFfs0qYiWG6Wg==
X-Received: by 2002:a17:906:6dd9:: with SMTP id j25mr30956848ejt.507.1618311187514;
        Tue, 13 Apr 2021 03:53:07 -0700 (PDT)
Received: from dellx1.cphwdc ([87.116.37.42])
        by smtp.googlemail.com with ESMTPSA id m5sm9140064edi.52.2021.04.13.03.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 03:53:07 -0700 (PDT)
From:   "=?UTF-8?q?Matias=20Bj=C3=B8rling?=" <mb@lightnvm.io>
X-Google-Original-From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
Subject: [PATCH 0/4] lightnvm pull request
Date:   Tue, 13 Apr 2021 10:52:53 +0000
Message-Id: <20210413105257.159260-1-matias.bjorling@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Please pick up when convenient.

This PR officially deprecates the lightnvm subsystem and prepares
it to be removed from kernel 5.15 and onward.

The lightnvm subsystem has been superseeded by the recently standardized
NVMe Zoned Namespace (ZNS) Command Set specification. Together with other
advancements in NVMe, it is now possible to implement all of the features that
the original OCSSD work introduced.

Thanks for enabling me to contribute the subsystem. It has been an incredible
journey. While the subsystem itself had not had that many users outside of
academia and initial PoCs, it has been instrumental in gaining
enough mind-share in the industry, which ultimately has allowed ZNS SSDs to
emerge. Thank you!

All,

Thanks to all of you that has been contributing over the years. It
has been a pleasure working with you. I look forward to continue
working with many of you on ZNS and other emerging technologies.

Best, Matias

Chaitanya Kulkarni (1):
  lightnvm: use kobj_to_dev()

Christoph Hellwig (1):
  lightnvm: deprecated OCSSD support and schedule it for removal in
    Linux 5.15

Tian Tao (1):
  lightnvm: return the correct return value

Zhang Yunkai (1):
  lightnvm: remove duplicate include in lightnvm.h

 drivers/lightnvm/Kconfig      | 4 +++-
 drivers/lightnvm/core.c       | 4 +++-
 drivers/nvme/host/lightnvm.c  | 2 +-
 include/linux/lightnvm.h      | 2 --
 include/uapi/linux/lightnvm.h | 1 -
 5 files changed, 7 insertions(+), 6 deletions(-)

--
2.25.1

