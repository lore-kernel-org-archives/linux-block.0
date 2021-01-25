Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDB4C433E0
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 19:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58C782100A
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 19:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbhAYTE0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jan 2021 14:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbhAYTEC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 14:04:02 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC85CC061574
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 11:03:14 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c128so528617wme.2
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 11:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7yI3OnceRYBWa4a+K3i7OmylV139r64Y53sM6tFF1pc=;
        b=vGPLomzK/0mzzIgD2mdfLDVzPGe2eqqBUu+lzY6wB3us4Vqpsn5XRQrxFMjhPPuo80
         ocCH/NDfSBUipg+dJnMgNUQlj+I/4oGhlV/hiZ5dj99C2KZZPxcouDMUT+FrTdOEuJKz
         dUIuftnunxMPaDS3yk9vvg5qOopffR4atu6jWk+WArM9V+sLeprZHUcJYHDHsEn72zBh
         664n6OrlWWYRW4YfFbIK+ZkhzM9SsHYmTK5RYoFqL/amz3h86wRKFX9TiEoqfmKSJoWH
         5hH5IA36fh2Kg3VKLaUccpbOBe/YnUL7Qi/NehOuFVbcdoaUqZBT7GBJODVToo69n2CL
         an0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7yI3OnceRYBWa4a+K3i7OmylV139r64Y53sM6tFF1pc=;
        b=DaK56vw71YDL4hELg3REEPQtcl2jlR3x+D4R/CmL2k0ZG65XZfJnYEtuQ7w/mM+8bP
         AuIn07ZLoeWuunPKErtjnWKX5F0VkK2yggLI50rwFasWB2d1lkMO+K9waQJ04U/fAm3I
         9mUPVkl+TWWadntIWIkrk79IWvnjiGo0H3HAcovV26sBk3MlJNDN6npxGEkLXqpBD/Zn
         3QrbvstPPYeTLm1GJYF/iZrGPjQ0R9E07wqAhxrf09OVsJftJE0pimjPiux7fTpidQnv
         o+ZyayXZzujZfax+nJ2sDrHMkvFlFZfw3xPaVBJp4In68MhAcq5hIi5v86Cu+nHhKEBB
         sNNw==
X-Gm-Message-State: AOAM531gP9aDrL5/v59pxSelTTyXkScrU2UY9t3ywa1Oz38oG2dD5Pg1
        khkITvR54DpCm2qVXNW5bVo3Aw==
X-Google-Smtp-Source: ABdhPJxjWbtW3OMST1Kzg22DiL3G59g/5zMAsCooQ5nTJujTBchIiKDJXqs8JXFFGfzOqv/M59F11g==
X-Received: by 2002:a1c:1b51:: with SMTP id b78mr1416552wmb.123.1611601393695;
        Mon, 25 Jan 2021 11:03:13 -0800 (PST)
Received: from localhost.localdomain ([37.160.159.175])
        by smtp.gmail.com with ESMTPSA id g194sm222534wme.39.2021.01.25.11.03.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 11:03:13 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX/IMPROVEMENT 0/6] block, bfq: second batch of fixes and improvements
Date:   Mon, 25 Jan 2021 20:02:42 +0100
Message-Id: <20210125190248.49338-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
here's batch 2/3.

Thanks,
Paolo

Paolo Valente (6):
  block, bfq: replace mechanism for evaluating I/O intensity
  block, bfq: re-evaluate convenience of I/O plugging on rq arrivals
  block, bfq: fix switch back from soft-rt weitgh-raising
  block, bfq: save also weight-raised service on queue merging
  block, bfq: save also injection state on queue merging
  block, bfq: make waker-queue detection more robust

 block/bfq-iosched.c | 328 ++++++++++++++++++++++++++------------------
 block/bfq-iosched.h |  29 ++--
 2 files changed, 214 insertions(+), 143 deletions(-)

--
2.20.1
