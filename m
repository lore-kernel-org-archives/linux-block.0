Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061DEC433E6
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 12:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C08622311F
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 12:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404464AbhAZM1V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 07:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404430AbhAZKv7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 05:51:59 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3B3C061756
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 02:51:18 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c127so2285664wmf.5
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 02:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=db4DEJ/Q3N9d5WkZ8df7AudDavBMLE/1f2NlVKxQEYc=;
        b=bJDXC2xJZS7knr6BW2QWR8M8TSd0BR+jcFln03nh0fNQax817QqmDhTQaYwzcomcIl
         5YGDhdc6N6im+5Eqx5VrrMi9zyD7rc/fhsPvns6iiBvdbfoiox3Tf8lyRkBfVORwtnn+
         Ti5+OzxAtiZGa50gUVEhgUtGCn41lAGTBmGEhPpjotAgvQ1phHe4z2zALtIGVlwoDcTi
         w90Ft9Km+r4MxDyNB2Ru/mcdTQ0TRDX1wlemfB2yK42g4QfxFSRh6OeZ2USQn7/HJ+4R
         EDUna/KZP+I70HioD5w0lXzl7G/iRxFJFN+yFMPhGiowrbBQpR7IVzBNxWi/YQXevdsZ
         nIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=db4DEJ/Q3N9d5WkZ8df7AudDavBMLE/1f2NlVKxQEYc=;
        b=J9po+A0dzlQamBqD+NCGfAJHGXRVPflagRS795EZ7UxqfoE3wJUxH3RUJWRLmnqOeG
         zJCk7A2Amj8aKo9MJabFcFg2KeFhnB48skVhOZmQerJ5O2orxk2r95drT4OevC6zB0t+
         dsAcURhyUr7ac0w9yqN8GWX9OvfxNTglaCJqaMNuS7EmOBfzRtsIRpz0iAjO5bJFMIR1
         HvPKJRG03Ce31FXe0bUpOasubw56Sqgd8dtMyL2qfsxDyeCLAj1VXYDO7yHuPzL2Nsx7
         WJuUg/iOEjzPPT1fzgApOtzBXKcnEPbmgLARDkV0kejwS7Jnkmv0Abwzrnd0c3iX/tbs
         yVCQ==
X-Gm-Message-State: AOAM532GAUmm1stVfcmxP2ztoLU75t0BF3S/qNxXU9hMVAR4Xkg4VuRi
        2e5n2EQ+ByEi8mLaykawlwD8uQ==
X-Google-Smtp-Source: ABdhPJxoS0T4r1Eh0KBwNxa9jC0eIUTyCqRnQWHyZXkLnzTtqnA+eozhZd6XzKMfp0e9nXlw77AalQ==
X-Received: by 2002:a1c:984a:: with SMTP id a71mr4044123wme.175.1611658277465;
        Tue, 26 Jan 2021 02:51:17 -0800 (PST)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id h18sm7177879wru.65.2021.01.26.02.51.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2021 02:51:16 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX/IMPROVEMENT 0/6] block, bfq: third and last batch of fixes and improvements
Date:   Tue, 26 Jan 2021 11:50:56 +0100
Message-Id: <20210126105102.53102-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
here's batch 3/3.

Thanks,
Paolo

Paolo Valente (6):
  block, bfq: always inject I/O of queues blocked by wakers
  block, bfq: put reqs of waker and woken in dispatch list
  block, bfq: make shared queues inherit wakers
  block, bfq: fix weight-raising resume with !low_latency
  block, bfq: keep shared queues out of the waker mechanism
  block, bfq: merge bursts of newly-created queues

 block/bfq-cgroup.c  |   2 +
 block/bfq-iosched.c | 362 +++++++++++++++++++++++++++++++++++++++++---
 block/bfq-iosched.h |  15 ++
 block/bfq-wf2q.c    |   8 +
 4 files changed, 365 insertions(+), 22 deletions(-)

--
2.20.1
