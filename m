Return-Path: <SRS0=0pY0=BJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FEFC433DF
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 09:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE0552082E
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 09:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="QakGgDDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgG3JOK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbgG3JOI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jul 2020 05:14:08 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE37C061794
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2020 02:14:06 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id df16so3071238edb.9
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2020 02:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+3ddxAyb3kBRLN0+vCsVgcAuWV90DDj2OqVWBg1nu7g=;
        b=QakGgDDUVxZrZDCUT2vwZRcVzU8wMu/qPTW2+VNaFqTm4XQuO9+HD04I2WuwRMZ96V
         0KF/9C923eN3GQwYwPvSAealZO3Z4h6sb6PY0HEWbSlbEKOkIYQPwlopqg6g8vMsfm5I
         SR127GYLO3/XzgxXyAIBM2krNfq6x13Sq5NfuU3Q0LVwzI1kcSCrjkhsiEj/W7NcfIke
         vi/MkLOY8mCje9BIGK1ql7U7N3VCjWYUws9zB/UcmBxMEFh0iBAybSsrILy4r/hvpxUG
         Kv5ngdspf6xEdN1E/tkuF+POnMMRE83lMTaobp79tsMUijL6gpfX+5bjz9Hu77BevPCO
         YRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+3ddxAyb3kBRLN0+vCsVgcAuWV90DDj2OqVWBg1nu7g=;
        b=UA7q0F18IgIVF8g4iI2aLkynvEpjCtF9Q2Ocjv8939xGh3sBjaLONkiEFciid0S+jh
         QOIviv0nByxGo2mchjEIlD+86B8Ei7otQ1SezjHgXHMmQYHs7FIec/rJRhnPun+U7Wz7
         hP+fS/IYroD51CmIFgyeVRElEzKX6rn9I88qJra7RwNUgV5AtgETpy3lj3CUD1DFuTur
         fCJYFzXh4zKMDlwDmO/zgLJLLaJlRtkJG9ZJiwvM0Qm0h3f464s9VAcXYz+WdqpaBdP6
         nO8ZT0HMRJqUGThif+0AlWJy0959tWd8ibAiC6jHnxX5JlgzezqLmGwlACAJ3MdmOyvQ
         W8Hw==
X-Gm-Message-State: AOAM532tZinj9mDHIpbnU4EI2YTRCnpzc/QfQaEGmrkqDT/0yrEURkyD
        lO6LScFAcGN/sSkcHY4AHkDRzA==
X-Google-Smtp-Source: ABdhPJxw1U6sWqrF839DMPjMzr2r+j37G1eTF/EfD7CoG/tZf8RjxFzNqn/cWh6EKUyngd6oJ1mngQ==
X-Received: by 2002:aa7:d693:: with SMTP id d19mr1758486edr.317.1596100445484;
        Thu, 30 Jul 2020 02:14:05 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:b189:874e:eb6c:1105])
        by smtp.gmail.com with ESMTPSA id c7sm5002955ejr.77.2020.07.30.02.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 02:14:05 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V2 0/2] Two patches for rnbd
Date:   Thu, 30 Jul 2020 11:13:56 +0200
Message-Id: <20200730091358.9481-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

V2:
* add Acked-by tag from Danil and Jack.

Hi Jens,

Could you take a look at this patchset?

Thanks,
Guoqing

Guoqing Jiang (2):
  rnbd: remove rnbd_dev_submit_io
  rnbd: no need to set bi_end_io in rnbd_bio_map_kern

 drivers/block/rnbd/rnbd-srv-dev.c | 37 +++----------------------------
 drivers/block/rnbd/rnbd-srv-dev.h | 19 +++++-----------
 drivers/block/rnbd/rnbd-srv.c     | 32 ++++++++++++++++++--------
 3 files changed, 31 insertions(+), 57 deletions(-)

-- 
2.17.1

