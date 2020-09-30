Return-Path: <SRS0=Yhvv=DH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC31C2D0A8
	for <linux-block@archiver.kernel.org>; Wed, 30 Sep 2020 03:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDC812076D
	for <linux-block@archiver.kernel.org>; Wed, 30 Sep 2020 03:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="lpaHpVFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgI3DYI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Sep 2020 23:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgI3DYI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Sep 2020 23:24:08 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E90AC061755
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2020 20:24:06 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id jw11so83149pjb.0
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2020 20:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NwE7i74AuLDH0Fg4fY0Imy1bHpX3sGiN2a+2wH0x5Aw=;
        b=lpaHpVFxeUbAycwqEq+dqDfNkNIpL8PpQ9uyAMX09hB34OpIeeoRbnH+RqatUvxJl0
         QlrzVjh3Jji4/KVUFgpZrZOpyqm1XzHnXrBoDaFikdfaT+cHtLVNQEIWqm0FNJlVs/Zl
         uf9oglP6DiMZFBD8NLbUjpPx2Ey7Jq9gwGQwQHF4p1Fo7GW5Q4Jemc+NXPw+m8p8W2FU
         Odzz4yqwlf7+/BGxx/59FFuiZvPT3A2yJuzmnBzeyhxOOWfwCGilkq14X93EGT4Khe5z
         +6RJQ72BwbZHOr4YuLF263NZXJtANc6GG2s0YOpGC/qlLIqvvTDa6gb3N6ulIkera9Yh
         cNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NwE7i74AuLDH0Fg4fY0Imy1bHpX3sGiN2a+2wH0x5Aw=;
        b=b8e4lhVbZ9F+xEGYmOu7HLkBttdOSWzNxDblLsGEdeHvx6RKlvyhvtx+6BcTSRAYTT
         dkzYF3YJ0IMuthdA9lWXNGX+9t6htgNo0xNLASk0o22XsPfIMo+ZhNJt9xmtTwYq20U/
         TAS9qMlKH8+F6wZBX5rruRNDsgg5BJLZcKefcoMSXEyLBmKBsshjnB20DyOcDNfrRWmu
         P8V1FWpDHjvba1zbh/H4/3DyU1xc+XwHRClJ9/012b3GnJPbXsiSNlwvBFsfVcbwYWDi
         kSLi4Xm/OK/ix2Y/TX4O/cKMdYSwnb3kAOLGhwrDR7q2CCZ8wCkzR89sxkXy7FRgIF3F
         jc8g==
X-Gm-Message-State: AOAM532eh6S/iOnBy5lftXXzWW7nwfIH55sxFHrHuDykJXANjw5qebNi
        DrCW8zkaH/LWezuGJtwnrvdU5HgejyAS/mRy
X-Google-Smtp-Source: ABdhPJxNPWswpvqpHT8Jy/8mIsOtJ790xLBWEKWe2VTaNtFgevoBAO9F7IQJ37tS9CDI0MqTjb5tqA==
X-Received: by 2002:a17:90b:104f:: with SMTP id gq15mr607382pjb.215.1601436246107;
        Tue, 29 Sep 2020 20:24:06 -0700 (PDT)
Received: from box.bytedance.net ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id w195sm226105pff.74.2020.09.29.20.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 20:24:05 -0700 (PDT)
From:   Hou Pu <houpu@bytedance.com>
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Pu <houpu@bytedance.com>
Subject: [PATCH v3 0/2] nbd: improve timeout handling and a fix
Date:   Wed, 30 Sep 2020 11:23:48 +0800
Message-Id: <20200930032350.3936-1-houpu@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Patch #1 is a fix. Patch #2 is trying to improve io timeout
handling.

Thanks,
Hou

v3 changes:
* Add 'Reviewed-by: Josef Bacik <josef@toxicpanda.com>' in patch #2.

v2 changes:
* Add 'Reviewed-by: Josef Bacik <josef@toxicpanda.com>' in patch #1.
* Original patch #2 is dropped.
* Keep the behavior same as before when we don't set a .timeout
and num_connections > 1.
* Coding style fixes.

Hou Pu (2):
  nbd: return -ETIMEDOUT when NBD_DO_IT ioctl returns
  nbd: introduce a client flag to do zero timeout handling

 drivers/block/nbd.c      | 33 ++++++++++++++++++++++++++++-----
 include/uapi/linux/nbd.h |  4 ++++
 2 files changed, 32 insertions(+), 5 deletions(-)

-- 
2.11.0

