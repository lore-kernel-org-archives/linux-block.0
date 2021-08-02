Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61291C432BE
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 14:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47D9460F36
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 14:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbhHBOXb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Aug 2021 10:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbhHBOX2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Aug 2021 10:23:28 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE03FC05177F
        for <linux-block@vger.kernel.org>; Mon,  2 Aug 2021 07:14:12 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g21so5409275edb.4
        for <linux-block@vger.kernel.org>; Mon, 02 Aug 2021 07:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1pBlyQkB8jDj+kHSLqZwSFrA1UHmCtAGPqJJQMibeRE=;
        b=kTtcJk37j1vKTstkvnb9Q9LO2eY4SJ1nYwIJId5or0JtSKuOKVw4MRS8OJM5HQjbNL
         DZ9jsI/t29CgFpE77ZPJMlJcQitVaMPYP6hKTRFCMB9eQUhD7k9F1wwjBHYtTRIJPEvP
         OUrxtNbLNhiOR8YQ+lF45WknjLkIjfsYWFK7pGKuWp6LS4/h+o8kbDA1ro1+FeOIo7ra
         fVE0fTzUJgC3wUJ5mMYjufllC2yv5c/87IQ+s6ZK+DbXpa3tdMa+JYYmvHV9Pcj+Mu3m
         eValmNBUHorlxIqzxytaKfkgBdXzO4Hwt+65aPrNiNR8JxyqkAGp9Y5K96UoqNF98CVk
         32ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1pBlyQkB8jDj+kHSLqZwSFrA1UHmCtAGPqJJQMibeRE=;
        b=cdsk0Gj8jqbMooajhdsorQ+4G+IlceF4iYz/HoP+ZYiCSnXtXC0Ztf1Y+QWgBARX7t
         S2hKAw7cQF6Zb9XbUR3RZTXLgUNFU6uUgw3T/8V+HrNv5xpGo5YmEIEaaoSD8YLKbT9B
         h/aWDQ7tefq8xyhfquABjvigm6eb8sMpSt2CIQiPAqTKhPOsYQtCDa43da0hCVFCPp99
         mLfWeN6RfXJjxsw1NA6uHPVeANZdYuj4HmY47AXZ6LqbtsiW2aHbUsO4zzBu8Nf/eCj4
         mFFmUVY1Klihlh2WCiaj2BP6HOkYgmKRNbsdT7pYZheJ+8MxkWJxf3h4nuV0R5iXcGap
         71LQ==
X-Gm-Message-State: AOAM533Q6NA4UddUjoVtxhQrF1wWBxI0crWggD0uZytJXDTORWlUCwPu
        qxOHKD471IyXZ2gT6PHLDEjJWg==
X-Google-Smtp-Source: ABdhPJzZDW7bsIJonPJM/RWpGsJ5/vFWJAn83JVvwtZKZv4zG8eq+2qIqHjNxwCjZWRA0ZoCnF5MEw==
X-Received: by 2002:a05:6402:160c:: with SMTP id f12mr19594868edv.122.1627913651577;
        Mon, 02 Aug 2021 07:14:11 -0700 (PDT)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id o3sm6084403edt.61.2021.08.02.07.14.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Aug 2021 07:14:11 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        davidezini2@gmail.com, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 0/1] block, bfq: fix a bug causing a memory leak
Date:   Mon,  2 Aug 2021 16:13:51 +0200
Message-Id: <20210802141352.74353-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,
this patch fixes a bug that should not be super critical, in that it
should not cause any crash, but only occasional memory leaks.

Thanks,
Paolo

Paolo Valente (1):
  block, bfq: honor already-setup queue merges

 block/bfq-iosched.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--
2.20.1
