Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C9AC433ED
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 09:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0844E61285
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 09:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhELJnL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 05:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhELJnL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 05:43:11 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E255C06174A
        for <linux-block@vger.kernel.org>; Wed, 12 May 2021 02:42:02 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gx5so33991146ejb.11
        for <linux-block@vger.kernel.org>; Wed, 12 May 2021 02:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l67ByTuTDoxE8yyQ8qcNrrbIp/HYHnBIsJgxG8dbjrI=;
        b=VB9h/9qWvHCD1s8q/hkPC/FNEHZNZrvAVjNYXTEvbyL0YZYhdSlLIp0fqLuIpoAw2V
         YAtX8WW1yq9KV1c7fqhLQkRj/bR8gBVyjbTvUfKVXc6dN/Tq2+PhiUxdZ75i28ssV3N8
         oRCmPhULFyZzRNQzYevfoV/IqbKMxBGNyjuGGwa74A6HWjOZlSKIcqHKYriLnluVCA3g
         KFHZU/2kqqQ8Swy/RJHg67lhuqY6nr6EEyjO79YYRVFY5h0CJFJOj9jWUGoeVjYRfder
         bB5NwJzovXwvSqSCXBR3SjDkPoHGqo5uBqQkvBgRlrKd303CXrgYWGvV1z3ibdf6+gTJ
         Cxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l67ByTuTDoxE8yyQ8qcNrrbIp/HYHnBIsJgxG8dbjrI=;
        b=WxtKu8ol05LwIHbjKNuAndCN/m7Pl0saal25LtuDW2mvcj9+Rb+Dua8HN4QXSV5n/t
         zhrk8T5CYGBt96q9uUSXBLeAZHUNRktKgAyA7XFMYMbUnnk8Du0AF4ETYbFYtjXUV9af
         gVS2Bce6QSZodccgbE/BHVqJMas1dYa5wc5NOXnYMbVWC3S3tjTsUk9pa2ufsxF7oupe
         0Zq/S67rzdT/09nYK0hEB9QYW+ScwNnOvnXA8X5nzRwizlsClHiInw2k775ome7oM076
         ICeBsiMsW8qzuvirBBI/DmOtzEFOYr9x4GvAd3bSjv6SFK13oMeVLk0PSGbZ/JZBe1NW
         UPmA==
X-Gm-Message-State: AOAM533Q6P3brEo4YDbKhb4qcljjb4pMDHs7ftMhF0ERQKLYiH9AI7lV
        J9UNcQV+AQxIu1hnHqoss0BvCg==
X-Google-Smtp-Source: ABdhPJwA/wyTJH2N1EhbJuFMeD0itT6fZEu7ZC6i1v9R/3IFDDjXAZRFolYivRZ28QLfDFgNNpXSnw==
X-Received: by 2002:a17:906:7ac9:: with SMTP id k9mr37393045ejo.229.1620812521113;
        Wed, 12 May 2021 02:42:01 -0700 (PDT)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id p22sm17068261edr.4.2021.05.12.02.41.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 May 2021 02:42:00 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@redhat.com, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 0/1] block, bfq: a bugfix for stable merge
Date:   Wed, 12 May 2021 11:43:51 +0200
Message-Id: <20210512094352.85545-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
this patch fixes a bug I've found while debugging a failure reported
by Yi Zhang [1].

This patch seems to make that failure disappear [1]. Yet it was tested
only together with other debug patches (which add logs and invariant
checks), so I don't know whether the other patches influenced the
outcome as well. At any rate, this patch does fix a bug.

Thanks,
Paolo

[1] https://www.spinics.net/lists/linux-block/msg67840.html


Paolo Valente (1):
  block, bfq: avoid circular stable merges

 block/bfq-iosched.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

--
2.20.1
