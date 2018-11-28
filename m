Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57397C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 13:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF032081B
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 13:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="e41twc6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF032081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbeK2AhY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:37:24 -0500
Received: from mail-pg1-f181.google.com ([209.85.215.181]:44552 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbeK2AhY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 19:37:24 -0500
Received: by mail-pg1-f181.google.com with SMTP id t13so9508777pgr.11
        for <linux-block@vger.kernel.org>; Wed, 28 Nov 2018 05:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=WpGOWSkrG9oQpLPAd0ltOeQAGjvj+k6qGmfMf/BhSb8=;
        b=e41twc6rumTz/oZlYPm6Iw0AX+8Knw637wwv3RIfUq/i/ktCtN4oWF+6Ap4Xhzv7zm
         rCMMMvo6GJwMyDlK8i9u9TmhbUGC3tVH3AQ68BRU8/Zw7rYd4gPM2CStJM1PAir9RPs/
         XSRtYAkL1+grBhwbykzR857J0U9vp11AFJKU6eiujvdxDph1fLRcyszYr/nbuZewTIYH
         IbkFhn6yNtTLnhNMniZ8l5P5+KG09Ibyf6omvgqXTCT77vVL/t0i0m0B9r2uEBtDJ+qV
         ssKHZPdlBsgAwg6GBRZtyEOxd7s+F9Lcb4dhiPnXIoe52s5/yvlOYW7txoNWgxVOtzxe
         XyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=WpGOWSkrG9oQpLPAd0ltOeQAGjvj+k6qGmfMf/BhSb8=;
        b=jBpfb7yFJVT/KGyJHcb81bzU8a2O3gbSci2Ttn5RgfuT/PQDY8WH/GaK2wWDU3L0gR
         sIsMrbSsqwyNDWq1YyUHwBuV80D5XX8P1DkTdUREoD84q7MT3Wu5VNJYhV9gGCAJ8SL1
         yj8N6EMonP4jkghe+FmCAq7yf1RF0RxViYYwpudtx2LjJFVc0EpTFcIhjfPrlaQQ035r
         PC1NRpikidYIfwEuwa0FBZESLWnb2b9bDNXeS/4Qo9qUAIw4Lv9YHeomG8JY2h5pRG92
         CKG8xUGzmfiiWKNwShexfC9Tx0M8HPoelrzNNlm81n3XKWQz+Ok9D7c2H3s9Feir3SCC
         oojg==
X-Gm-Message-State: AA+aEWagS002/9C8sXcH7tEmAspKjMskHpsqcesvb0kugNHfjqagt0iH
        OdQNhKX28xbE2QmvxaZhRxSGEBVs6l8=
X-Google-Smtp-Source: AFSGD/Vn58+q4HBI24Tnuyd93nhIdsfrjBF5vT2O+N3Xvni+p2alZvu7PqWEU1gxkdboCWYDPNbQJQ==
X-Received: by 2002:a63:580a:: with SMTP id m10mr32804761pgb.332.1543412142935;
        Wed, 28 Nov 2018 05:35:42 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id q75sm4744925pfa.38.2018.11.28.05.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 05:35:41 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCHSET v2 0/8] block plugging improvements
Date:   Wed, 28 Nov 2018 06:35:31 -0700
Message-Id: <20181128133538.20329-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Series improving plugging for fast devices, but some fixes in here too.

Patch 1 changes the logic for when we sort the plug list, switching
it to only doing it if we have requests for multiple queues in the
plug (and enough requests to warrant an actual sort).

2-6 add a ->commit_rqs() hook and implement it in drivers that use (or
will use) bd->last to optimize IO submission. If a driver currently uses
bd->last to know if it's needed to kick the hardware into action, there
are cases where we flag bd->last == false, but then fail to submit any
further IO due to other resource constraints. We probably get saved by
the fact that this happens for the case where we have pending IO and
that will eventually guarantee forward progress, but we really should
kick IO into gear at that point.

7 improves plugging for blk-mq.

In terms of improvements, for virtualized nvme, I've seen a 2-x IOPS
improvement with proper handling of bd->last with this series.

Changes since v1:

- Fold the plug case for blk-mq, do it if we have 1 hw queue, or
  if we have ->commit_rqs().
- Add disable/enable IRQ to ataflop
- Drop nvme ring index helper
- Rework when to sort patch

-- 
Jens Axboe


