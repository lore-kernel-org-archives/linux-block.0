Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BDEC61DA4
	for <linux-block@archiver.kernel.org>; Mon, 13 Mar 2023 22:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjCMW3z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Mar 2023 18:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCMW3y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Mar 2023 18:29:54 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3259869CCB
        for <linux-block@vger.kernel.org>; Mon, 13 Mar 2023 15:29:53 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso50466pjf.0
        for <linux-block@vger.kernel.org>; Mon, 13 Mar 2023 15:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678746592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+cDZBFg4+sLfTVl0lHEWTrnMA1SY40Bzt4Pz1p3665s=;
        b=hq6kVxFAtkrq3Ewqqt9Kyb8JDJsB71QkLXq4YRWCUfPc8nsiGX+ehY+uW2sa7X0woQ
         4Cy+nxh2aVIdRJhlOjSHjMbsOEHj9E4J0batJcyf8gs34jpFaEmF+N258+vCKhdo24Ry
         JfTqLXkp+Sar+jjWV3g7F4BnuxWCO610LFmoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678746592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+cDZBFg4+sLfTVl0lHEWTrnMA1SY40Bzt4Pz1p3665s=;
        b=hH6msDxbnYvwxPQEPCMV7xGkJZhTsWH34UPAPjNvtuevW2ffMoXC4SEjPV5KFSp/ap
         ZUK2IWs6x+GPgLiWOPT9y+YOQTHqo97CtEbRnVr2kcnWEre7PYnncnH44cPejNuoiPt/
         SoiFJuApnAPKh9y4BxcY93pfYyNW//D3rGzQUgURsPEpC0oTO9ylBgybjxOMZ0T0+eRo
         +a+7qHWWgkhANET8TobCOinl0AdWhDPIO7YeDk0Vhsn4mxE3/L6RxPXMx947RMc1wusu
         gzZFzWE7n1UEVn148p96wj5g4k79QRvpplUafFaNjlFbn8YslCT6YrH5+NhLqj10HCEu
         PsCg==
X-Gm-Message-State: AO0yUKXK3+J5vOwMkd5DNENw9Ldb6vgl8KXFzlnEOTw/qlkNyERtT63G
        VnRrcRw8EnKLQfyhQYjcVEHMyA==
X-Google-Smtp-Source: AK7set+tsI6mjf1YmgDV7GcGW+bHf/BJP7/foLKzNYnTq8RcMGiGu3XY7oAgJ00CozH69W6A9oLLtQ==
X-Received: by 2002:a17:902:b716:b0:19f:3b86:4715 with SMTP id d22-20020a170902b71600b0019f3b864715mr5590127pls.8.1678746592674;
        Mon, 13 Mar 2023 15:29:52 -0700 (PDT)
Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2d4:203:157:b07d:930a:fb24])
        by smtp.gmail.com with ESMTPSA id km8-20020a17090327c800b0019aa8149cb9sm352440plb.79.2023.03.13.15.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 15:29:52 -0700 (PDT)
From:   Khazhismel Kumykov <khazhy@chromium.org>
X-Google-Original-From: Khazhismel Kumykov <khazhy@google.com>
To:     stable@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Khazhismel Kumykov <khazhy@google.com>
Subject: [PATCH v5.10 0/5] bfq bic/cgroup interaction uaf fixes
Date:   Mon, 13 Mar 2023 15:27:52 -0700
Message-Id: <20230313222757.1103179-1-khazhy@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pulls in uaf fix for bfqq->bic along with fixups. I pulled in the
backport dependencies that were also present in 5.15-lts.

NeilBrown (1):
  block/bfq-iosched.c: use "false" rather than "BLK_RW_ASYNC"

Yu Kuai (4):
  block, bfq: fix possible uaf for 'bfqq->bic'
  block, bfq: fix uaf for bfqq in bfq_exit_icq_bfqq
  block, bfq: replace 0/1 with false/true in bic apis
  block, bfq: fix uaf for bfqq in bic_set_bfqq()

 block/bfq-cgroup.c  |  8 ++++----
 block/bfq-iosched.c | 19 +++++++++++++------
 2 files changed, 17 insertions(+), 10 deletions(-)

-- 
2.40.0.rc1.284.g88254d51c5-goog

