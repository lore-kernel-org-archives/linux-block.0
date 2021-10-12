Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FB3C433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 17:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 515D360F21
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 17:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhJLRR3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 13:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhJLRR3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 13:17:29 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D846EC061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 10:15:27 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id s17so19330707ioa.13
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 10:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TEZ+j+7Xnya4ZmMY8NH2kLnjeHnmslYOas+kzo29PwU=;
        b=U1Ll6A94DorWI94ovVjj1I9ioVr3GdBh/W9TcgO/5zHZk+CbgQEVMd4qJ/MDZrrvap
         4iVn2IilZ3ZWllcnwtAKVecDwEnXnrhbb9R7Q5NSVcoNv78YNx3GNrgQPPdckSUOMW/v
         B511qFzIwavFCS9MUy/kTjqTDdMslqAG/7lbfL6UvK+ECOt8RRXlf/CLpGhUinj2e+/F
         fumMu/IPdE1AEvLa12+zHtEQAJlYlhRWNL5S42/JpGdGYTeCAiTTN/ruY6/BS/Rcml2O
         Rl1++9cq7E+x4eX/r1TucoF2q/vOD6jC1JTev8IY57p+jchAe+WtkeQblig+QAGkhU1m
         x4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TEZ+j+7Xnya4ZmMY8NH2kLnjeHnmslYOas+kzo29PwU=;
        b=eV1xU8GFeteJ+5pd/kqly0kLKgec1VM2YsJUP3chCyqbHX+5sqwMwiI5M20RB0YcWY
         JcOvgxoiuF5jexEKO58zImqB4oVUTOnHxXR8ZqJQ3KjOLgFki4SWzw5DkAhX9UkuaUDZ
         nu5QRF76L2FHr8a/e+dA4XajoroIOYybB7MqlVHwqZVN2MDuxRNmWI2lURjz3JiCoMo+
         FWSNbsO/yP6/jJYAQDzHD05popoAmBF6SpIKjkhXzk1p4w4SDHOrP4/x/LY7vkxSEDT5
         77ALObky/wYZRH2BchByfJybXa8DA77atrQ8SuvjBsHOomkuoPDSBn24v/7xRZH9elFt
         0I6A==
X-Gm-Message-State: AOAM533jcCjpXTh2k0KPioJ9Bjxl0oKMGjjrQNCXZi4SvXGtvqdn6JvI
        tjhlVaPhEMwllxAJhB22xp2D5/Vkn4k80w==
X-Google-Smtp-Source: ABdhPJwj0WrhuAC9qUtC3Z+DL9Q6pVWbu8Zkh7xTuwLFRpQEw8GPVCDWebwiTGtiqa/BVQYhuT99Ew==
X-Received: by 2002:a05:6602:2188:: with SMTP id b8mr24919007iob.217.1634058926930;
        Tue, 12 Oct 2021 10:15:26 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id w15sm4577824ill.23.2021.10.12.10.15.26
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 10:15:26 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Subject: [PATCHSET 0/2] Improve batched tag allocation
Date:   Tue, 12 Oct 2021 11:15:23 -0600
Message-Id: <20211012171525.665644-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

We can do better than implementing batch tag allocs as just repeated
calls into sbitmap. Add a sbitmap helper to grab a batch all at once,
and use that instead.

Testing with instrumentation added, we get very close to the full batch
count. For NVMe, if I run with 32 batch submits, the actual success
batch size is ~31 on average. This is close to ideal, as one hw queue
will have a 63 tag size and hence we get 31 of 32 tags once every 1/32
alloc. This could be improved, but wasting the extra cycles in sbitmap
to skip to the next index for that case doesn't seem worth it.

-- 
Jens Axboe


