Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF427C433F5
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 03:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EFED61545
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 03:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhKQDlK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Nov 2021 22:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhKQDlJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Nov 2021 22:41:09 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3206DC061570
        for <linux-block@vger.kernel.org>; Tue, 16 Nov 2021 19:38:11 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id f9so1272083ioo.11
        for <linux-block@vger.kernel.org>; Tue, 16 Nov 2021 19:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RR9fPFpSWJ8iR0U613a2mzDj9OgVGoq9oxaurOZe9ew=;
        b=ffzmmcocy/lJiXs+tDI4gUeASKwxzdcDMjrLKNXOdVVBasiuX6LKHG1hMjzbRFlVMq
         OrmjOjFUttNFmUP2u4xpggz+WE3j00EEV8Tir4/4ujP6JsXOhJLZ+NOnSMUpfuZXZ9J9
         IYnGfzfDLDmDVc55Yr19p9QrP1UOpRFZB9JCfcm48kwoFEn8LQYhQ8mdpQgUPc+/PDA2
         IhEgyD+UXFSa2U+2UNLaiiq5IyEEj1KLVeejiZjiDYzqvY4/Mu8GFPMsqzun0SPH6WjO
         E4IBWdBEVHwyftERYeLIUXInLkiB9MssExR32GNCPKTkC/IfSQy1r8eFohxGT6Dl/4EJ
         66MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RR9fPFpSWJ8iR0U613a2mzDj9OgVGoq9oxaurOZe9ew=;
        b=rr2XjPu7Z48FI91hZwBXfjRMfcYTVj3x3neay0j+78XnduQKr+4HvF48QlMynanaxL
         74o7oFZZNmHy7WZJDCHS3woi1eGGMR0TwfxB2yQysFRzMxxBPkppao0VhFjCmHfnVkkh
         /ahOxyyA97UaWMIobi3qHSLEPZerPvX7vfghHGSI9E5+gNoP+JsC0RZk67m2RWfvBnBS
         VWzrQTBNqb/F0M7J2DCtjMyP6Qe06oxo9kdkEzWqclrvq00Z6plzIT/vF+cKDT5YlmQP
         t5AIURKYKu9Bqxadi3Js7fpWM4JNWiPvEI9EgYW7aKblnOYrr/nfjZW5uIekZ/Y3Fv2a
         BLEA==
X-Gm-Message-State: AOAM530WGGXJq3zoF+Xgf3CM6EWNcJq51z4rdT+1s9N3KNB79rkgT/zE
        oOMIDfsy1iVXuBCgoGSZHQGjylxxQjY05DLU
X-Google-Smtp-Source: ABdhPJzOTDqVFG8kZetQUz66z0FzD8zcRxxkIXVJSD3J82Q5bt0bQ/RGz1XVqGpOZZJl4Vv8UPgPwA==
X-Received: by 2002:a02:ab8f:: with SMTP id t15mr10098416jan.147.1637120290446;
        Tue, 16 Nov 2021 19:38:10 -0800 (PST)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id l13sm12563693ios.49.2021.11.16.19.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 19:38:10 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     hch@infradead.org
Subject: [PATCHSET 0/4] Add support for list issue
Date:   Tue, 16 Nov 2021 20:38:03 -0700
Message-Id: <20211117033807.185715-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

With the support in 5.16-rc1 for allocating and completing batches of
IO, the one missing piece is passing down a list of requests for issue.
Drivers can take advantage of this by defining an mq_ops->queue_rqs()
hook.

This implements it for NVMe, allowing copy of multiple commands in one
swoop.

This is good for around a 500K IOPS/core improvement in my testing,
which is around a 5-6% improvement in efficiency.

-- 
Jens Axboe


