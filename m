Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A619C433F5
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 21:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383255AbhLCVtS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 16:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbhLCVtS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 16:49:18 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4242BC061751
        for <linux-block@vger.kernel.org>; Fri,  3 Dec 2021 13:45:54 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id b13so3010971plg.2
        for <linux-block@vger.kernel.org>; Fri, 03 Dec 2021 13:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lIxjR3FPLX688QMW1cWlK5lmUuTks0cMHajAmnAY3e0=;
        b=2E2kBEtHQXlrmkm7xX1wGtqNhI27jIRUYTlp3ioRfomf96lCS7vS6Oda8KnhMPjR+q
         5OQ3zVxIT3ndZbkNsCD5TB5U5EMl/AfhoeUJ9z7GTogTz3zoPEAWm0AHcwLPPmhrqv6L
         INbHl10vLhIzAUu9iLxnfNGdLFCn8yiFxMnuP7ZcwAhwQvzMRwgxpR9GQadzMooUpBXU
         qPqGugKqb1XRy2+/QaPNzEWW4rvPI3p5Y9XpEp9H/NgXmBNsn5gl8SczSmKNej+xvcja
         P7dAiISqx4rdgPmOSMGp+wjjDmSxkGgF7ggO2Z4LuuET5d0jGjhJZVPvFbctew4XxhXs
         p6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lIxjR3FPLX688QMW1cWlK5lmUuTks0cMHajAmnAY3e0=;
        b=LViDoGxWsk4SP+y2ryofC4ujaKsvMJlP31mAhk9N9pa79c+V1BlBj/iyQYK14Rid0i
         ciDUXe9EFTWCyI8UbJxRma9KW6Ox3qnCFWE0Ija35ommUNYE6X1sW+ZcSNGQ8ohQK26Y
         vjUHbODOQ4He8q7/MtyNF/sp+r1ljfW396sjK6oJADQkhPgjp5AJLTa1gOUFthn5eOxf
         KVjyw5UClxzEvWGIOEZSAHPyjLSky9yEB7JcpIDDpc5abx/H/GSD4HXG4hD8UOuGKQ3+
         GwcW/wKMvq3Uvi3VvAdgWdLMpnaaGrjuWBQ46rstjWvIhsXEwXaHp5jjN9bfF29sccb3
         fBHQ==
X-Gm-Message-State: AOAM530APFd8+cH0CzwqAw8fE54C9w2XZSzdiTJ7+vIg5c1klAeML2N9
        b+JK9P/8r/U1uYJJfCZ7oT5TJtl0Utv+dCE/
X-Google-Smtp-Source: ABdhPJxUu/Evwa67mjOdElNgoK5Q8D7SfYw92iHnHsGeQr7go2JhNqDUUTLx29dne4Ti2IFMTiDiLg==
X-Received: by 2002:a17:90a:5b:: with SMTP id 27mr17302729pjb.148.1638567953400;
        Fri, 03 Dec 2021 13:45:53 -0800 (PST)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id f4sm4436225pfj.61.2021.12.03.13.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 13:45:52 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCHSET v2 0/4] Add support for list issue
Date:   Fri,  3 Dec 2021 14:45:40 -0700
Message-Id: <20211203214544.343460-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
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

Changes since v1:

- Addressed review comments
- Rebase on top of Ming's hctx lock change
- Clean ups
- Bypass for shared tags

-- 
Jens Axboe


