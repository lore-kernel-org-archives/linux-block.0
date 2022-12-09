Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8DEC4332F
	for <linux-block@archiver.kernel.org>; Fri,  9 Dec 2022 14:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiLIO4H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Dec 2022 09:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiLIOzq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Dec 2022 09:55:46 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D96F80A29
        for <linux-block@vger.kernel.org>; Fri,  9 Dec 2022 06:55:08 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id m18so12058198eji.5
        for <linux-block@vger.kernel.org>; Fri, 09 Dec 2022 06:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NGS8p58llTH0j/JtmBIf8IcqQNNb3dOfgpZWMO+4qxc=;
        b=ZKM+8vmyIyGnqJGMg1PLrEyjzHURIQ49nrR+4Cjb2tDfhRzSNwsUBEQ3CDMpzbTWlK
         wKbONKbccHcx7tdtrRxI5jqvo+xhjD+v6FvDo2UjxteCxErRQ8jOMzBOaQkbcMIJvv39
         wPgwsSPiQ+Ng/npOz16yJBEtmbjEy8VV+fP6aW9bqBRCwzBpOHK4zWUmd1AeFlqG26W4
         5ZYMibLNHHIudvWomfOP0bxVYcHEieLRIlFflAwXX/V/d5gmZ+Kvk3dyz0dTQo1rpCsd
         KCaqDixfrYloL6JFEoI9btVVm7ggxh3H4TGOiPkp+r4FjxgD+eGf5J6O9HXV1XMPDAj1
         pUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NGS8p58llTH0j/JtmBIf8IcqQNNb3dOfgpZWMO+4qxc=;
        b=b+BBoSbkl6kHcMtc50Up7ISHlYx8F3bpA3jIIGnUfeDC0GEtu6a7+l9UJ4ItS5Phb0
         TmJBPe1gOX/oddRTle+6FGNcduzFqK8X23tU1TyqoCSGe2qjklCrSvO5YWbi9rP75NB4
         rVq5XQDnr4TVIES/i1eR2S0H/bC/17hoHJHEHtbT6rY0S6c9kn1UgjjVkHrDwr2CVNW/
         i+Tx5Z7pfCcjO7F/RnnC2zozR8BNXorjYPYhld8FxEfX2jt7JqVEkk7Q4kTREx5tNr5/
         GP1gMoPjvzEJE/q96AR3GwK3ORGMbyjipdCeP4H7AJV2kQjoA1QbEOsVppL8plPKXMCY
         dFjg==
X-Gm-Message-State: ANoB5pn8SQuyIKMDkKJMI+RqRZU2w2EAp8y2IVym+WixMDgdc+omlxDc
        fW6pL3Pxv9mQA/PnRcXeJv8niw==
X-Google-Smtp-Source: AA0mqf7K+mE1v7tZQxx275XaT1evbeQtA2Yf7MlJpotalKJ4eJCBxIJUmePOtFfIcVRJx6XFbXGQGA==
X-Received: by 2002:a17:906:30d3:b0:78d:f454:ba10 with SMTP id b19-20020a17090630d300b0078df454ba10mr5517836ejb.15.1670597706776;
        Fri, 09 Dec 2022 06:55:06 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id l4-20020aa7c304000000b0046b1d63cfc1sm716856edq.88.2022.12.09.06.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:55:06 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 0/3] DRBD file structure reorganization
Date:   Fri,  9 Dec 2022 15:55:01 +0100
Message-Id: <20221209145504.2273072-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To make our lives easier when sending future, more complex patches,
we want to align the file structure as best as possible with what we
have in the out-of-tree module.

Christoph Böhmwalder (3):
  drbd: split off drbd_buildtag into separate file
  drbd: drop API_VERSION define
  drbd: split off drbd_config into separate file

 drivers/block/drbd/Makefile        |  2 +-
 drivers/block/drbd/drbd_buildtag.c | 22 ++++++++++++++++++++++
 drivers/block/drbd/drbd_debugfs.c  |  2 +-
 drivers/block/drbd/drbd_int.h      |  1 +
 drivers/block/drbd/drbd_main.c     | 20 +-------------------
 drivers/block/drbd/drbd_proc.c     |  2 +-
 include/linux/drbd.h               |  7 -------
 include/linux/drbd_config.h        | 16 ++++++++++++++++
 include/linux/drbd_genl_api.h      |  2 +-
 9 files changed, 44 insertions(+), 30 deletions(-)
 create mode 100644 drivers/block/drbd/drbd_buildtag.c
 create mode 100644 include/linux/drbd_config.h


base-commit: f596da3efaf4130ff61cd029558845808df9bf99
-- 
2.38.1

