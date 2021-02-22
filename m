Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CFDC433DB
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 19:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D3D860295
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 19:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhBVTCG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 14:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbhBVTBw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 14:01:52 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02571C061786
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 11:01:12 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id r17so4692902ejy.13
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 11:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cO0n+kDhRqglr/P/GbTAppuURUzykOPvLpaYKMcFMqQ=;
        b=wk3heYfrGUh3a5PY/WRnJ0DxEgvvMc3H8hKd9TgphqPTsJ6VcWStQsJ+PADWxWPGDC
         RIv6tRYLHa2MeZomyhNRfuHvkcNpeDftzJx3LVQ1bBpTeKFL6Y7mzkJNMP2IMvFTJhVp
         sRVdcf6iafFetLwICd3BMM9DGI6qOwhLgFZjJbBTi300//4znvzk6dGRirITQvsG7wRv
         NX328lshVh6hNq8b7um4DxuXPjVuzlRn8DIEKbd0futCjYEPbd7/J+ZvugqYSuMEmkTl
         lj3BynOSVR8kvlSwacIdPxaLvR26JJjsB5yj206wcp+Q9e6eK/B2peJ1vjtaqEcH4HFH
         JQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cO0n+kDhRqglr/P/GbTAppuURUzykOPvLpaYKMcFMqQ=;
        b=Y7Bbj+qemWY0v8RLzi5XdEk8RinAgxe8CmsBCTsSHKCKWFBYcZ3t/K01DWKNcRMFmJ
         zcmmNy4k66xZcabtz/subOQ77kcyQU3JrlpTZXHhOjJ0stXObXOWRUikVRUQueAoCqU6
         ptOt+BntnvDcOZXtFL1bUk176Ar9wnxAgT+P09NxkyO0aotYQGAsXeXSBgWQr6I/ovzm
         bNJM+aFptahAB1T3AYnXozJu2PuhX2IYqDKuZMRybI4T0CQugLyOn5bejdfemTEMEB+x
         wUNktKJ0myYY+KJH3zwb7kru/oyiTSNl/5L5xgQbxeEKvgoioswEsA2W4DszssxXmY/B
         v+SQ==
X-Gm-Message-State: AOAM530k7yDVrjhHqH89wp+PIIhQHpD4BwQ6wn4AilPDbBeIKEyDd09I
        V0oFS75zkKhQfOlIHXGBk6NIDw==
X-Google-Smtp-Source: ABdhPJyN1wRP4Y/RqGqZEEEabE+0WmBvUNR3R808wxGUQPJSR/YsPm0jPxCc4WgO59u4tzItIKLgpA==
X-Received: by 2002:a17:906:2bc2:: with SMTP id n2mr21304233ejg.381.1614020470723;
        Mon, 22 Feb 2021 11:01:10 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id d23sm9204528ejw.109.2021.02.22.11.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 11:01:10 -0800 (PST)
From:   javier@javigon.com
X-Google-Original-From: javier.gonz@samsung.com
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, minwoo.im.dev@gmail.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [PATCH V5 0/2] nvme: enable char device per namespace
Date:   Mon, 22 Feb 2021 20:01:05 +0100
Message-Id: <20210222190107.8479-1-javier.gonz@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Javier González <javier.gonz@samsung.com>

These two patches enable a char device per namespace, also through
multipath. It is possible to test this in QEMU using Keith's and Klaus'
tree in nvme-next

     http://git.infradead.org/qemu-nvme.git/shortlog/refs/heads/nvme-next

Keith: Regarding nvme-cli support, once this is in place, we will send a
patch to nvme-cli so that this device is shown in verbose mode. Do you
have anu thoughts about this?

Changes since V4
  - Added support for multipath (from Minwoo)
  - Fixed typo in commit message for sysfs naming
  - Rebase into nvme-5.12

Changes since V3
  - Use a dedicated ida for the generic handle
  - Do not abort namespace greation if the generic handle fails

Changes since V2:
  - Apply a number of naming and code structure improvements (from
    Christoph)
  - Use i_cdev to pull struct nvme_ns in the ioctl path instead of
    populating file->private_data (from Christoph)
  - Change char device and sysfs entries to /dev/nvme-generic-XcYnZ to
    follow the hidden device naming scheme (from Christoph and Keith)

Changes since V1:
  - Remove patches 1-3 which are already picked up by Christoph
  - Change the char device and sysfs entries to nvmeXnYc / c signals
    char device
  - Address Minwoo's comments on inline functions and style


Javier González (1):
  nvme: enable char device per namespace

Minwoo Im (1):
  nvme: allow open for nvme-generic char device

 drivers/nvme/host/core.c | 173 +++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h |   9 ++
 2 files changed, 165 insertions(+), 17 deletions(-)

-- 
2.17.1

