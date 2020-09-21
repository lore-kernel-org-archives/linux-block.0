Return-Path: <SRS0=nPog=C6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4344C43463
	for <linux-block@archiver.kernel.org>; Mon, 21 Sep 2020 10:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8555A206E5
	for <linux-block@archiver.kernel.org>; Mon, 21 Sep 2020 10:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="LbJ1WGK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgIUK5c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Sep 2020 06:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgIUK5b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Sep 2020 06:57:31 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5797C061755
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 03:57:31 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id fa1so7269315pjb.0
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 03:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LMBUI6Fmhk4dVucq9AzM0QSmMF7KbZUqiP0bTlSjq0I=;
        b=LbJ1WGK31+9bPUgqsPzlwNMXNJev+ldV2Lq5WGAxZb8tM7/8wEffEl4vXOiZL4N9Js
         AFhOpDQn+xkz2zQnyFpiTn025Pr0dWv70duzRjkvF6fRTdUqfA7Z0ktuWuaAAWQm8xi5
         kOmubfVc9/kEetzhC8agMMwyiYoSWKxDyNls1iOPMwIUrPmHXRwU/0EbhmHCydFOZCDZ
         +muN1zoGonrpYm+6QhWBvJOKQrjKEoRACzY32UY2DrfRvga+FKEhpaKtnzlX0gj4NZr6
         rnCxA0ba7nD3xiES77tU0E9kvdYKWzjGK1rNB+kMjKN1Wcg4HSMr1jFVtu7glg9SaNn1
         smXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LMBUI6Fmhk4dVucq9AzM0QSmMF7KbZUqiP0bTlSjq0I=;
        b=t12WogUO2rrJk5vVyQifxtlot7CYKiigv/j7ysKY8mUO0UsL5cylMIolZmXWVawX8n
         /K6o7lNSrSnNEvkvP99lPAq5Z2kMhLGlRbNXAf2HTC3hbiPcPISJmugTI22lO0lHZuVq
         6kUzRSEs2GmqSSeTZRjWWK//lSJhU4mTU0YhodEiQ+lg8khfI6VnB6nCB3JpRbgxijrU
         5jhtsKkP+spODGj7MyShc7gcQT+fVo1hy12zF1pGrGji1ubH+THyTubP1orhzEpZgnCJ
         D5Ykp68gKEUQvPb8dZW34PRWi8dF/u9X09Vk5KQp5CxTKKKylU5m0M1otXWxGJvSjkHR
         g8SA==
X-Gm-Message-State: AOAM530OvLYMZZ9PupfqsvtTjhkknlpz55QUH/mmF3xDzDUZb0BzA7t1
        hcBOsuJe7iuWHhetn670iYVwmGS2TX5RTw==
X-Google-Smtp-Source: ABdhPJy+d+Dlj/7r/2tSMN2/k0zQajzw5GRf5/uecx0w/UEnV2VkqS0v98RW7WSEMv/+877yccKYBQ==
X-Received: by 2002:a17:90a:d596:: with SMTP id v22mr25151925pju.146.1600685851315;
        Mon, 21 Sep 2020 03:57:31 -0700 (PDT)
Received: from box.bytedance.net ([61.120.150.73])
        by smtp.gmail.com with ESMTPSA id x62sm2792533pfx.20.2020.09.21.03.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:57:30 -0700 (PDT)
From:   Hou Pu <houpu@bytedance.com>
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     mchristi@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, Hou Pu <houpu@bytedance.com>
Subject: [PATCH 0/3] nbd: improve timeout handling and a fix
Date:   Mon, 21 Sep 2020 18:57:15 +0800
Message-Id: <20200921105718.29006-1-houpu@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Patch #1 is a fix. Patch #2 and #3 are trying to improve io timeout
handling.

Thanks,
Hou

Hou Pu (3):
  nbd: return -ETIMEDOUT when NBD_DO_IT ioctl returns
  nbd: unify behavior in timeout no matter how many sockets is
    configured
  nbd: introduce a client flag to do zero timeout handling

 drivers/block/nbd.c      | 36 +++++++++++++++++++++++++++++++-----
 include/uapi/linux/nbd.h |  4 ++++
 2 files changed, 35 insertions(+), 5 deletions(-)

-- 
2.11.0

