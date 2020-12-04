Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD61C4361A
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 15:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20CB622B47
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 15:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbgLDPV4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Dec 2020 10:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbgLDPV4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Dec 2020 10:21:56 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FCFC0613D1;
        Fri,  4 Dec 2020 07:21:15 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id l23so3330390pjg.1;
        Fri, 04 Dec 2020 07:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nQyESLQvhW6QjC9n3RaFvyayxvhMqs/AWY4nVz29xxI=;
        b=sEX/oiSW0zN0q6FZMbp/Gf/nlmsHyKYz1IL2bkw6dXSAcX4mO+CJkgr7QSqRyL2w44
         +75ksjHBAcBU3TM0fltlyskA+LoXVvT8xiSOrgptPuySrdArA0Clfr6OHt5cD0xO+8ox
         IXMvxQXc3qH5yjBkQq0vDeYAByuIRuoJlGvs72xJVs8D3aU2YyTn3A381njO6MVG5QY2
         gdq+wGGBnupSu3nXLWm7Ek4nDZiAxtz64ipHpU3r7Akvr+5g8chwgmCXhowy4lAGWeWa
         A4ZuYZ17KdeMxugBBZfnWcDb3aflX80IDpiGrP1xptQRAqpEaOlcUokBKCfMAChlZ/Hb
         Riyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nQyESLQvhW6QjC9n3RaFvyayxvhMqs/AWY4nVz29xxI=;
        b=PeI3tPS5K7RPgaAUfEg+XrY1tMAO0m2pZiZeexxFnKLHp8LRPSdZi67dQouw7DTEHS
         jcn5EiU2qi1pP78i9St+QDEtkmUNpmyndyXgNo84TiwixiTsd58lXF3xeevES/QCseEK
         GHw3xevIe4PN8/J9lyr52dtCgrUh3svb5qIhm++2tpK6Y5KWxFaKGSRm42M+bWBtT0Jv
         m6MfOqt2bVpXGBc5hFv/VBRU2UrKVepVcHkHt+crcMgOPgBsAmNRPSGdX3dETfK1ZBV3
         XqSHKmL3AklyHlYpXz04jlZrFrEcQjcethhWoG3UtqHqiIRllF7/6avj+MWNFIlVKxeD
         Y83g==
X-Gm-Message-State: AOAM533s/hmgnf6RW2a7DxlEUdWjnlUyFg9O/JZ13PJ4O7kUu2sGkw8q
        N+g7LfF9x5M3/94G4QXTHfsbDgHajwDBhQ==
X-Google-Smtp-Source: ABdhPJwPBVBXnxlFrFzzDTD1WUwGMpE8SY8r26T2xiQL1jvVX4XWc4DxeMLiXrsFd3lYoBNe+iz1+g==
X-Received: by 2002:a17:902:c104:b029:da:5206:8b9b with SMTP id 4-20020a170902c104b02900da52068b9bmr4394150pli.46.1607095275212;
        Fri, 04 Dec 2020 07:21:15 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id d20sm2407286pjz.3.2020.12.04.07.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 07:21:14 -0800 (PST)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH 0/3] blk-mq: trivial helper and fixes comments
Date:   Sat,  5 Dec 2020 00:20:52 +0900
Message-Id: <20201204152055.31605-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

This patch set contains:
  - Introduce a helper to allocate tagset tags for the first time
    without 'realloc' keyword that used to be taken.
  - Fixes for comments need to be updated.

Please have a look.

Thanks,


Minwoo Im (3):
  blk-mq: add helper allocating tagset->tags
  blk-mq: update arg in comment of blk_mq_map_queue
  blk-mq: fix msec comment from micro to milli seconds

 block/blk-mq.c | 14 ++++++++++----
 block/blk-mq.h |  2 +-
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.17.1

