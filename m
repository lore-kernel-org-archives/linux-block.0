Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D1FC76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 14:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239377AbjDFOwg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 10:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238925AbjDFOwT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 10:52:19 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEE5B769
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 07:51:03 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id o11so37733970ple.1
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 07:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680792663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jsN7tdxypihrla/GoL2oV2FbQRrK9CjsAVFPGAuvGMk=;
        b=hNPXzmSIy/mxvyggQ3ydVzZKSJmXyokWxnfuXMrXOwox3waYSO9HkrwG/OUveIPAvb
         0K5NAGLjHQD+lM5P1nRRJVprnOaQL4Yhfr7DAOL0LM57bac3qiLBE+nZ9nlINlUQfvAl
         nd+qBy402VJeQOrbVrqxNZsJkIAV84N4iRmTdQI9H5+1HvIx8HAxnCon4Ba7mIVD947S
         Echo6XtpjPCS2sx+NwqR0Mr5flBYxeMj9uAbB2Jig4vvOEz2N6OUEuHaEZxxtThXRWG5
         WYNKwgpvc4oRkks7blCcpPDF6gXXQes14x/fCEhLVsH8qMuEejRxJuVeDKB+LyGPZMj0
         x1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680792663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsN7tdxypihrla/GoL2oV2FbQRrK9CjsAVFPGAuvGMk=;
        b=yQQrCTpNgjLfD4afHhm4qmvciiW1HWD2EuRLFbJXnsBud458uR4cXJlUSf9G1SXQ1V
         LNFDZAukK0qda6Xe7fdeGYb95AnB5JddVskWn2rgHqbJij0Vf15aocxoJF+ymuHhX4sF
         bbxEy8tLeVEaN5WlXL8FLGeOWn6KrvhvW31pc16ylzVL9DxQr8gFi17OgAlXjdwB2UYJ
         3fy11bmiOai4p11b7HSvnekS5mU0Q8vHB4938q8hZJCGAm5bDwMK6KvMsP1JOpwMfp7y
         XEC3+NHEWeP0exqv0YmYOQnnJiU6oYWo4AGoArtQf05JS6N+rdjV6riHNG8wCS/4n6bt
         1rxQ==
X-Gm-Message-State: AAQBX9c+tWOXsbM9KHvacqB3lZOEkBIB/kh8h/T+b6q+FYTXXEI+uquc
        BEw3CEdvSTKo1d9PwWY3s8hNSQ==
X-Google-Smtp-Source: AKy350bG80qA6UgZFZIQWG7FVa/XWqHC70y/fiV8BLBfS2SIDCo6c3bZAJd6N7wRrR8QcqITiwzauQ==
X-Received: by 2002:a17:902:ced0:b0:19e:7a2c:78a7 with SMTP id d16-20020a170902ced000b0019e7a2c78a7mr12747837plg.57.1680792662798;
        Thu, 06 Apr 2023 07:51:02 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e63:f500:18d3:10f7:2e64:a1a7])
        by smtp.gmail.com with ESMTPSA id i4-20020a170902eb4400b0019ca68ef7c3sm1487398pli.74.2023.04.06.07.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 07:51:02 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 0/3] blk-cgroup: some cleanup
Date:   Thu,  6 Apr 2023 22:50:47 +0800
Message-Id: <20230406145050.49914-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

These are some cleanup patches of blk-cgroup. Thanks for review.

v2:
 - Add Acked tags from Tejun.

Chengming Zhou (3):
  block, bfq: remove BFQ_WEIGHT_LEGACY_DFL
  blk-cgroup: delete cpd_bind_fn of blkcg_policy
  blk-cgroup: delete cpd_init_fn of blkcg_policy

 block/bfq-cgroup.c  | 12 ++----------
 block/bfq-iosched.h |  1 -
 block/blk-cgroup.c  | 25 -------------------------
 block/blk-cgroup.h  |  2 --
 4 files changed, 2 insertions(+), 38 deletions(-)

-- 
2.39.2

