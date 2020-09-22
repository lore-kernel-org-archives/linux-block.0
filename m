Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4FBC4363D
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 03:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85488206FB
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 03:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="2KWTco2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgIVDfJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Sep 2020 23:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbgIVDfI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Sep 2020 23:35:08 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EE3C061755
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 20:35:08 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b124so11156287pfg.13
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 20:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7QkOITZripORvfYFmAqjwDsc4o7hDGWfLOqnFTo7WBk=;
        b=2KWTco2NHZRxDcegJPUTJR/iA3i5RXFXlde0zICRzDXR4E6ThcksdQYDr/r1IHHY60
         2ULnejJw2PwcVzrOjGGjwwbBNDK55Tx+kvOl2Sw8cI9rQqtk088fOsk/XU7ruGL88nDQ
         6fLcJ6GGdVCdCujcef93p+4eMhzzz5req84UjgRq+X1F43+vNCFKEkgX+iiL8REzSM8V
         vjDC/UKXL2TVN6zxoQ0UanJK1vdgD6DF6tCAz9w4VgPASo5HE9nca1jkeRX/B0Gxp2Xl
         9Dtdk/zkQKfG3umO1jj6qNK3rdGNzoz4O+fJij3EdWG0zbDpE96w3XNtxSwGramPt8Y5
         efDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7QkOITZripORvfYFmAqjwDsc4o7hDGWfLOqnFTo7WBk=;
        b=N0TEvyzCDp7CzbVzeExa2HKfJIqsi1za1d3sXWhY3dgcEmHwlWpnrBrtIUhlSUnmxD
         C2tshtl/rzd73w4bt57yGXP0zGixivw4ujJ7nPEAfBBNvnplGiTOxScrJWh6bMre3N+2
         0sNjdc9o5EhhLL3UlGofKVBOxlPqcvuAV4pshDAxkSMcxhdllWdI7q23x7rphO+tbPrB
         3NOxvAysRCAweCRpbWGo4P/IJNokYmXKw7IJdbABvcRK9qqJUcjQm1/mFiOfc3c0DYqj
         S7o4uw5vUy2N6OA+rsC0BICcrAfEEigd1BoaTAAzZpeQG7X0lAAwqfUjLToPviX2QiSr
         ZLYA==
X-Gm-Message-State: AOAM533UlZC6TlPz0tlzCN1PX+LqP4cw3O50RLyF1C2MxGYwpmE0BOYt
        FyCQOp3mAYCe5SMzW5K2c/Ge3Q==
X-Google-Smtp-Source: ABdhPJwkW7c/HyVettrmYzhqoEZUTrbUSHaUdanzwtM3uelWZLzAOhJu/YTnfXliM/Z85yataGiF2w==
X-Received: by 2002:a63:cd0b:: with SMTP id i11mr1996891pgg.306.1600745708375;
        Mon, 21 Sep 2020 20:35:08 -0700 (PDT)
Received: from box.bytedance.net ([61.120.150.73])
        by smtp.gmail.com with ESMTPSA id mp3sm714859pjb.33.2020.09.21.20.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 20:35:07 -0700 (PDT)
From:   Hou Pu <houpu@bytedance.com>
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     mchristi@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, Hou Pu <houpu@bytedance.com>
Subject: [PATCH v2 0/2] nbd: improve timeout handling and a fix
Date:   Tue, 22 Sep 2020 11:34:55 +0800
Message-Id: <20200922033457.46227-1-houpu@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Patch #1 is a fix. Patch #2 and #3 are trying to improve io timeout
handling.

Thanks,
Hou

v2 changes:
* Add 'Reviewed-by: Josef Bacik <josef@toxicpanda.com>' in patch #1.
* Original patch #2 is dropped.
* Keep the behavior same as before when we don't set a .timeout
and num_connections > 1.
* Coding style fixes.

Hou Pu (2):
  nbd: return -ETIMEDOUT when NBD_DO_IT ioctl returns
  nbd: introduce a client flag to do zero timeout handling

 drivers/block/nbd.c      | 33 ++++++++++++++++++++++++++++-----
 include/uapi/linux/nbd.h |  4 ++++
 2 files changed, 32 insertions(+), 5 deletions(-)

-- 
2.11.0

