Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE84C433EF
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 19:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhKWTSf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 14:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhKWTSe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 14:18:34 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D22FC061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 11:15:26 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id x9so127460ilu.6
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 11:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sw5dR9aljceDlLtYm8RT0BLbyRkmY6aojqzf7cur6pc=;
        b=5Gh0HlE74Wf66LmYfr6t1h45keBlPbatgc02GUxR9e6koqyoG46e1cpYDNf5PtHZ7f
         DBw1AUqECj9Ux7PT1t9EBMuKIVbra6E++bZHnjeK20NggmESESq+Y45dG4tpEtYM1NLs
         F1E/FY0UbCgo3VecIeqlyYAUyKcd4j9q+97ktoCX2OjG/ZyRmtQWty9/6Os3Ov9c7Y7R
         R1m+zNr0LLGIi/C1nIvF3y3ATiK0r8euSEywzDnFyjj7hwq1g57sdcGdb+EUjVkV7s84
         Ooara3CftxdvEJZuF+AkaLXzL1l8Baj0nR1AQszQN/ZjfQJuaZoYEqBvudUC6yZYrtFw
         L7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sw5dR9aljceDlLtYm8RT0BLbyRkmY6aojqzf7cur6pc=;
        b=KrTTkbcGGZnG7b9sxyhI++DhlP4i7dV9tbnHSAA90t26RJwFp61kCR0leMY0Hb/K/f
         FmpkyFn9XQvRcpbv1IKjuMxkh0ZBBi+rREmDy7UHScQCFTZfnzDshw2tyOzkRe5szL5V
         +FWblyawPC7agI9wWa0wf12s3js/aD0RVyX/4OOEszOABb7/83/O8/2OkKzq5A5irHQK
         WtNIRLj3it8zHKP6YubPghWLoednhN5u/hh2rUwYmx06xsZyCd5Jc5UyzFSyQ28gP3O3
         fRN3bajhavZs6ARYBjbBH90KFSie9IYuFuLV5d6JPC61WvZ7ClyMpjO9Q4TRLPLMNjHZ
         U/PQ==
X-Gm-Message-State: AOAM533X0V80BLNSETEP7fdMRPaMre0pMFIjcfp8QXLC5GZG50A9ev4Z
        h71IKaDaZW/EKpwAGboilZhspUjr/3qreRhM
X-Google-Smtp-Source: ABdhPJyBW1Q0L3DEh6mLnc5VY492OIzSSuay7MtyZIQ2khptiN7Bb5gg+DyC8y3eSELEZyHdITZgCw==
X-Received: by 2002:a05:6e02:1d84:: with SMTP id h4mr7855102ila.265.1637694925418;
        Tue, 23 Nov 2021 11:15:25 -0800 (PST)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v62sm8050399iof.31.2021.11.23.11.15.25
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 11:15:25 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Subject: [PATCHSET 0/2 v3] Misc block cleanups
Date:   Tue, 23 Nov 2021 12:15:17 -0700
Message-Id: <20211123191518.413917-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

First patch avoids setting up an io_context for the cases where we don't
need them, and the second patch prunes a huge chunk of memory in the
request_queue and makes it dynamic instead.

Since v2:
- Use cmpxcgh() for poll_stat install
- Move poll_stat alloc + enable into blk-stat
- Remove now dead export


