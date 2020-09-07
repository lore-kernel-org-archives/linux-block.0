Return-Path: <SRS0=p3ox=CQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3820AC433E2
	for <linux-block@archiver.kernel.org>; Mon,  7 Sep 2020 11:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFC112166E
	for <linux-block@archiver.kernel.org>; Mon,  7 Sep 2020 11:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeTED2d8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgIGL3V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Sep 2020 07:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbgIGL3B (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Sep 2020 07:29:01 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D96C061573;
        Mon,  7 Sep 2020 04:28:59 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a26so17812374ejc.2;
        Mon, 07 Sep 2020 04:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WRP9M9nSNXL4MuVp90IJd9szrbHQ4+1D+FMdTDd3MKE=;
        b=oeTED2d8rZ8Ed5gBKxWfFoNbmp7xoC3UIr/eI9hK9SyJZZI7MG+7XJzGO/nbt479b/
         k/AEDNeWagv85nAz/OWLRUix/73OEW3v6rf4qbgR3QqEbAzjU/StJ/E1aZ3Smo4OzsEx
         wGeRINtjtlMIqLu//JJbiknaiLIENC2KtCBZjjUU1xEPWcFZB+1O7rLdUIQ3FoslMqUg
         mOCvaGA0TrxFsqCZmElvb1nZ/pY9OlQ4j144+uyKm4T97S37UmnUlQ2QV/bY1rT3DZDX
         8C1Dz4niO5k63KUW/6y4be9M1Z/xjm63dBsI4Y8dljnOXN97xyV96bG7pBTfCQCBpyne
         9+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WRP9M9nSNXL4MuVp90IJd9szrbHQ4+1D+FMdTDd3MKE=;
        b=YF6cl6eDiw0WDZX40oysf/nYsDH7NQl1rINQL0rJJxDIeVHBGzaTaTYgoYQGfPQ31l
         e0xvK1xj/n5G+mMLcSil1BnUAK1c8ofIYBWJBWpGRcTwmNpoyvrhYoa4rLyTRDlVL2Ua
         4C8w2veIYaMraRA2tnZ7Jm4pSAEFajMizdctAuDfx4xdTNnmwzxn8tmV3eTu3Hv7Ml+e
         gsTRgW1bbXMGInQIDrEeVG19ak9Fs1da5HyEAofCQDgM1tLfKnseh7lYPFeNXmhCvuxI
         HwjRbiJpdv0eyJ1h2Y/XFEh7/Ro1rPoVepHJG/keTlkVvceXMe11yLa2UqhnuoB2rm2Z
         NCDA==
X-Gm-Message-State: AOAM532XjNZRW1XYwnu/1WQa1PNCHN1gRPwEsz5t+/SVbCU0Uyo7hzBE
        wrJipFtvl8tCvKJ2uNRQDAk=
X-Google-Smtp-Source: ABdhPJzqPI+Fn8MusvsQJ7qlymd+nHs23tmwAbfJxmXD44h2oAbDoulrqwyl1MnZfc1QNS2x8/2aUg==
X-Received: by 2002:a17:906:692:: with SMTP id u18mr20207775ejb.43.1599478138078;
        Mon, 07 Sep 2020 04:28:58 -0700 (PDT)
Received: from localhost.localdomain ([2a01:598:b902:e05f:7139:914b:4eed:99b3])
        by smtp.gmail.com with ESMTPSA id k6sm13826528edj.93.2020.09.07.04.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 04:28:57 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     beanhuo@micron.com
Subject: [PATCH v2 0/2] Fix two incorrect comments
Date:   Mon,  7 Sep 2020 13:28:43 +0200
Message-Id: <20200907112845.3420-1-huobean@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

v1--v2:
    correct inaccurate patch title and commit message

Bean Huo (2):
  block: fix incorrect comment in vdc_port_probe()
  fs: isofs: fix incorrect comment in zisofs_readpage()

 drivers/block/sunvdc.c | 6 +++---
 fs/isofs/compress.c    | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.17.1

