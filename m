Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A50CC433DB
	for <linux-block@archiver.kernel.org>; Thu,  4 Mar 2021 17:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FC6264F4C
	for <linux-block@archiver.kernel.org>; Thu,  4 Mar 2021 17:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239857AbhCDRqx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Mar 2021 12:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239471AbhCDRqL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Mar 2021 12:46:11 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3FFC0613DC
        for <linux-block@vger.kernel.org>; Thu,  4 Mar 2021 09:45:26 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id h7so1196940wmf.3
        for <linux-block@vger.kernel.org>; Thu, 04 Mar 2021 09:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rXaJslfVGFd4I1PVUecAya+J9M63qQzcgrFaUeqS3G4=;
        b=poIaEQhPZD7c97Ta/89fLbRAqxE/l89mKOqvE1YNyap6A1vnRsTYPN8jrCQSGU7QaE
         ntIVgtj2PKU4lY2Jso2EDiL7qSPDA2It/LDLru2j0Yo0y/gw8HybtGU5KZLAQ2dzZpZW
         e7T/bT2TQkpDST5xyOYltrtBTignnGYUNSllXb7aJ5cO64U4bv8IiaoXUERkMeC2hRnz
         xCMUs0dyiVr7R6AGPLk7aBuGY7RNqQhTr5dMzJToZj0yZi/hBKKJk9J7AoP4X0FCekaA
         j3mZHJnXiF4lvQExiACTenvElYT8VrrupGjHJRsqxN0Uiyjg2ejZIXsOn0oeSB5mokki
         cHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rXaJslfVGFd4I1PVUecAya+J9M63qQzcgrFaUeqS3G4=;
        b=mEX2qqCWuGUfY0Ltyk2OFCGJqLM3Y2geZPGNtdnNzHkDCQl8JHdI/hvwH9LzMtLPZA
         tTjuNQHpOVZgM6DHhGh55tA4q0mvWaYJeM7v0GFpDGuu7v7g1GMXoDD7dIhjOZJ0jv0p
         4e1m09qA/l7wm64Wa6Og1k8jpXfryMgLjdij7/514Kr14NXiFrneg5H1w7wQsAHHaq2/
         +/y4AmfLblpq4n3S3a0XxaT7zryOLCQ6fIYiLdkHALfvg1PajzAIsXQ/wE6XrWWaE8CW
         TPgWdH476J2Nmc3YlrWlmxLuDIoDe+RbACRSsEpEnPwkT6NOV0o+GR4tpa7lB8pwkhoG
         GkAQ==
X-Gm-Message-State: AOAM530L4bYS8HC+c5lvUwjU+L54FjJmWCE9Ap+de4ZNISltJ5bwQeOK
        X2FwsozORAsyFq8w+PZYUABKQ/VGMvmMww==
X-Google-Smtp-Source: ABdhPJwiBl226sC48a8NyG5YjwNz/OiBuc8bTc64WtoijosTkoWHfL2y9wF7qfDCJVv6CcbrPsHlyA==
X-Received: by 2002:a1c:2ed4:: with SMTP id u203mr5182877wmu.45.1614879924889;
        Thu, 04 Mar 2021 09:45:24 -0800 (PST)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id a21sm271023wmb.5.2021.03.04.09.45.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Mar 2021 09:45:24 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX/IMPROVEMENT V2 0/6] revised version of third and last batch of patches
Date:   Thu,  4 Mar 2021 18:46:21 +0100
Message-Id: <20210304174627.161-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
this is the V2 for the third and last batches of patches that I
proposed recently [1].

I've tried to address all issues raised in [1].

In more detail, main changes for V1 are:
1. I've improved code as requested in "block, bfq: merge bursts of
newly-created queues"
2. I've improved comments as requested in "block, bfq: put reqs of
waker and woken in dispatch list"

Thanks,
Paolo

[1] https://www.spinics.net/lists/linux-block/msg64333.html

Paolo Valente (6):
  block, bfq: always inject I/O of queues blocked by wakers
  block, bfq: put reqs of waker and woken in dispatch list
  block, bfq: make shared queues inherit wakers
  block, bfq: fix weight-raising resume with !low_latency
  block, bfq: keep shared queues out of the waker mechanism
  block, bfq: merge bursts of newly-created queues

 block/bfq-cgroup.c  |   2 +
 block/bfq-iosched.c | 399 +++++++++++++++++++++++++++++++++++++++++---
 block/bfq-iosched.h |  15 ++
 block/bfq-wf2q.c    |   8 +
 4 files changed, 402 insertions(+), 22 deletions(-)

--
2.20.1
