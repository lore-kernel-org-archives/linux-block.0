Return-Path: <SRS0=keWk=7B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF61C433E1
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 08:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEC502084C
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 08:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="O2Wky9A8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgESICy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 May 2020 04:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgESICy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 04:02:54 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC65C05BD09
        for <linux-block@vger.kernel.org>; Tue, 19 May 2020 01:02:54 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g14so1787976wme.1
        for <linux-block@vger.kernel.org>; Tue, 19 May 2020 01:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GAvzowp8ctEQm7gDEd4YN2NPgCDtGpVSkCRU+hDllI4=;
        b=O2Wky9A8duWFoGp+rYjpSC7TU3//cc4PxKnhXm14syvXkMGjtoAZx5r+2dD9EEjaw8
         mEjRZPJBmzBNhma59aN5Hn3C6nd2TR9J+CBC4p2sgK9Yy1l2XGy/66MGx9e58sDdPTuD
         O76M7mN3bjI3KdGef5qiAx2H1Bwf1gVoAdA3c9ooYIRKaNqdHtYzhkPz9lW39isn17Oe
         tgO+sof0JCQ9xaIJGskoM5okQDc9mPD0nVoFlYFLWwgR2ZdajvyQztYkbkNxmfMcEgYs
         Y55qnN7SLKWV2DnFMItkhtRM6LgoUIWDE6PJwq9opSFr0n7TsWaZ6XjXKvFWI5sFoCkn
         lkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GAvzowp8ctEQm7gDEd4YN2NPgCDtGpVSkCRU+hDllI4=;
        b=eozIW47lUgbQREDGPiq+dvaf5IhQKECKS4h1LGf5h4nL+HmBAiaGnk43qjsHA0HS6V
         8sJGhT3n+6nUyetoHYQ+zwXXu6yqjZ5eLxNF/I3U9KrnoL+ceVQU8DdkrPhGI/x9kZv+
         voUK609OVyF/WsmHGvJBFImBKnxvbhAbASEhpGj59KfG+7eFmZISb2M5Sg6ahVc3KHzS
         4d52zIdfXC+wlV3D7AVXdfssT16Sf9hOZvQr0zZFqSmrtVOCTYUlmM9WOH/H/KesifRt
         hZFgVvEeZls8hMRmq+psxrgbcykj6a4IyDoQzJSHNhLNJJq2PgGKrdbDGmTwq+RkmrRp
         waIQ==
X-Gm-Message-State: AOAM5326aenkt8gSJI2pdnl6FfkdGDDNfcLM5eIHOrSwfR84KZpXdFzB
        duaWRKR1ThafQIRVZTQ+wvtV
X-Google-Smtp-Source: ABdhPJyYv429uc6XmHCaQKhGJrU9gXQ+XOl2Zv+wDcE8FrVLNhN172EIHdiBjZibiPINaTcoaegb2Q==
X-Received: by 2002:a05:600c:2197:: with SMTP id e23mr3983307wme.162.1589875371784;
        Tue, 19 May 2020 01:02:51 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id g10sm18915386wrx.4.2020.05.19.01.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 01:02:51 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org, jgg@ziepe.ca,
        linux-next@vger.kernel.org
Cc:     jinpu.wang@cloud.ionos.com, dledford@redhat.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, bvanassche@acm.org,
        rdunlap@infradead.org, leon@kernel.org,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
Subject: [PATCH 0/1] Fix RTRS compilation with block layer disabled
Date:   Tue, 19 May 2020 10:01:35 +0200
Message-Id: <20200519080136.885628-1-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <e132ee19-ff55-c017-732c-284a3b20daf7@infradead.org>
References: <e132ee19-ff55-c017-732c-284a3b20daf7@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jason, Hi All,

this fixes the compilation problem reported by Randy Dunlap for RTRS on
rdma for-next.

Jason, am I even doing the right thing sending the fixes for the issues
reported for the for-next for RTRS/RNBD to here?

Danil Kipnis (1):
  rnbd/rtrs: pass max segment size from blk user to the rdma library

 drivers/block/rnbd/rnbd-clt.c          |  1 +
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 17 +++++++++++------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h |  1 +
 drivers/infiniband/ulp/rtrs/rtrs.h     |  1 +
 4 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.25.1

