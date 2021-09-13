Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA05C4332F
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 11:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 660A660F44
	for <linux-block@archiver.kernel.org>; Mon, 13 Sep 2021 11:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239335AbhIML1z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Sep 2021 07:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239575AbhIML1y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Sep 2021 07:27:54 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40432C061760
        for <linux-block@vger.kernel.org>; Mon, 13 Sep 2021 04:26:38 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id n30so5809345pfq.5
        for <linux-block@vger.kernel.org>; Mon, 13 Sep 2021 04:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rz/6XvgdNoOIdVbvI4mwKeVZY1sVrkUVZ3EnU4pT4rU=;
        b=Xk6Azf+YawiKfB5FY+ef0aHr4lcGmXzfcSyku4T4sJF73uZuN7SuifATbWcVwyFU5S
         LMimQVl/YGeEa/gZorRlhViYpISoiOl59jeoMWzkB1QVz4UQ6LXg9arGIWWbhP33CbB4
         FUof3AjR9QK9p9KxbJbTw6mQ81lbfAR0U4mX3Y0T8smzt3OjfE2KS7kYd+eoM8WcAanX
         C3HnXx8iWpORlaiK0l6G6V4W1d+DR2vzboZ1PH2Gy3Iws1cMzfp/r3wwJaGYuaRPPCAJ
         Pe/gLNl1O6FewaFSGs8FULYW/e+qk1EI/LEf7vsshPkZKLAL/AiuH6tmqWaSIuX/z/wZ
         GhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rz/6XvgdNoOIdVbvI4mwKeVZY1sVrkUVZ3EnU4pT4rU=;
        b=s/AYSwKlox66m/hNpZejI1UcVO/KMaCCCr9g3E5/UYO1OvGyw1bRQY6wpS45cjz98k
         MeCj7/UzeNRn3Oj6vTRzAnP4Zo6j93ZkIu+sqHah0h4buSL9WAKjXjhjeIaMpKBI9Tqa
         b02An9s32R0GT9SsagZWgncR6mDLKmOQCZV4rhapY4jPyAKHDdWk+GYrUpJ5qV9ubNdm
         sCKossTsZrPoIpt7NRu1IlwxADDf4EciOTNz0ieegKyUrA9D50Zn8PqYulnBT3d1ArzH
         RSa0DFVCENDkUFOfqM5z4SBwZXSGxlmaj7DdKsxM0nyUs81WBbiDxMRAear3hadacwQS
         I41w==
X-Gm-Message-State: AOAM532XXA+zxugG88VMpi8SsOkGrOy//rC18ASuMnurOKcC89+WGp+W
        U88HPILaLW8ExZUBDmJ0z+F0
X-Google-Smtp-Source: ABdhPJxgADjQmayK/fwksa0871G2vOcC21wpaydwkHKLFWhnke6wadGoJpZKsE7E0mYF9wrc4AnAyw==
X-Received: by 2002:a62:1c96:0:b0:3f5:e01a:e47 with SMTP id c144-20020a621c96000000b003f5e01a0e47mr10705481pfc.76.1631532397740;
        Mon, 13 Sep 2021 04:26:37 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id w188sm6726703pfd.32.2021.09.13.04.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 04:26:37 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     axboe@kernel.dk, josef@toxicpanda.com, hch@infradead.org
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        yixingchen@bytedance.com
Subject: [PATCH 0/3] Add invalidate_gendisk() helper for drivers to invalidate the gendisk
Date:   Mon, 13 Sep 2021 19:25:54 +0800
Message-Id: <20210913112557.191-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series comes from Christoph Hellwig's suggestion [1]. Some block
device drivers such as loop driver and nbd driver need to invalidate
the gendisk when the backend is detached so that the gendisk can be
reused by the new backend. Now the invalidation is done in device
driver with their own ways. To avoid code duplication and hide
some internals of the implementation, this series adds a block layer
helper and makes both loop driver and nbd driver use it.

[1] https://lore.kernel.org/all/YTmqJHd7YWAQ2lZ7@infradead.org/

Xie Yongji (3):
  block: Add invalidate_gendisk() helper to invalidate the gendisk
  loop: Use invalidate_gendisk() helper to invalidate gendisk
  nbd: Use invalidate_gendisk() helper on disconnect

 block/genhd.c         | 21 +++++++++++++++++++++
 drivers/block/loop.c  |  6 +-----
 drivers/block/nbd.c   | 12 +++---------
 include/linux/genhd.h |  1 +
 4 files changed, 26 insertions(+), 14 deletions(-)

-- 
2.11.0

