Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315A9C433EF
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1074360F6F
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbhJQBkB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 21:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbhJQBkB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 21:40:01 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627EDC061765
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:37:52 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id i11so11204297ila.12
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xknGY1Cd1KoqX+iPqx4k2rcP9O/nHmQCHpmV8BGk3hA=;
        b=Wg8EJBqFYOfSwjmFVGH1nyksmaEJaGj8OR6RvKRNmSoYjwPyF6lPTELLq3bti1UIj1
         2DO+/SYyXZThzzkRjFczxI/Q1WKnYH9B2HnGtHCN/z5svci/z6dN3iLHRySzcZBu0yP+
         RXwXvGONiWhf8fWB/7KGbcmGE7ri9n1JxcC65TNZQcotLxFyqezFYznYJIVreY9/ZBdz
         pE4EtsQ4NhRIz8L5xLWW0GE+N7ztxI5hZ9MbM6vQgTg+ahIiSQFUqH1gcpa+lVYSczcV
         d8U0J7WZFQ4g9WUbcf0eJjSLIRIi4AdyBAU8/fQu4ft/04KW3W6PIyxwjwlTEty78yae
         ShlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xknGY1Cd1KoqX+iPqx4k2rcP9O/nHmQCHpmV8BGk3hA=;
        b=NoKu26+fDqaZe9A4XfoywZ4ejMutTjHyom3O+ZeTtnUqoBK7n2jpiSk0xjCGHtOg+L
         KYcbEBfcEYKovccFwabtR6tFXr8i03ojC3h9Y3Yo8ZM2vhf0LXWdGnEH81ONe/zWfr06
         CEhn/uRXCbxjtW3r9l14dnnANVyGcJoTok5VPW/BkqsGdFEeAG1SJucqS4lRzH0B1OYg
         8sj4Bxzub7+dSaZViQOYxtaomvwh5E5FztlzzgLGxtek3oKGW3TOu932S7U9wjiLN4BT
         gfiy6p8tlyJlMoQOhOQWqCUDiCqLFNvqKJgvf8KYmB2hZqN9zUINi1etLgNN7IwZRTuG
         Pmuw==
X-Gm-Message-State: AOAM532SBiDgnD8zgmqzR97m+Wql0GUsfdA6rmWact3uAg38qewaQhPA
        /qdvXYqgaz2oC04wdtviJF/84Gf+3R1zgQ==
X-Google-Smtp-Source: ABdhPJw5+z3j2V4qeuKVw1r3wXk5wIu4Ln6yCrIkI1eexDO0ztNjWbkF5JpdQK+bFzya36Fcr6OO4w==
X-Received: by 2002:a05:6e02:d8f:: with SMTP id i15mr9865029ilj.62.1634434671576;
        Sat, 16 Oct 2021 18:37:51 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j17sm4934383ilq.1.2021.10.16.18.37.51
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 18:37:51 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Subject: [PATCHSET 0/14] Various block layer optimizations
Date:   Sat, 16 Oct 2021 19:37:34 -0600
Message-Id: <20211017013748.76461-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Various cleanups and optimizations that I've worked up while pushing
out IOPS-per-core from ~5.5M to ~8.2M.

-- 
Jens Axboe


