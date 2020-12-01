Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7968C64E7A
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 12:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F6E32084C
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 12:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="RWoTNTSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgLAM5C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 07:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbgLAM5B (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Dec 2020 07:57:01 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BD5C0613CF
        for <linux-block@vger.kernel.org>; Tue,  1 Dec 2020 04:56:15 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id f9so3898570ejw.4
        for <linux-block@vger.kernel.org>; Tue, 01 Dec 2020 04:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xHTwekTMHBxnzJvZgFr7Rrub1GZfhNFwsQwlD3O2K1U=;
        b=RWoTNTSW1M042+k5M7VQxKEO4QG+Tv5qRlOcyxZfamL01nFTX4xiLQMWhJ0PVjgbdq
         2J6AROcEYP4pl1Ebfk69Fwch3z8Y94mwwUB82UaYTtols0RJ6oYCQxuqB0hHOSKiCSnS
         +Rk6LIGSSCxSPh0L+o8biy2Na55HtHAsj0h0ONRVlPOYWbxY91cU85UWWxq+KWz2ioFf
         U9NxNHDnHvZzkh12DHwhYUj0w/mBrJb7Cb1+11PAggL+KhpVQpgB/gE8gWmY9JmGPLLX
         d/PB+7UGRfCkFdqQ6ivgiOwUgcBRWrZFdAy0uQBeDbEx/3nIecx20Jn9WKylQCi5ghvj
         1m3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xHTwekTMHBxnzJvZgFr7Rrub1GZfhNFwsQwlD3O2K1U=;
        b=j4XhO82lzrbsO/Ermqh/nSdeYYZS6YPPNZDcPq2tsmTWQQwOM/hovfISaGxY6OUQhX
         Lagv1gkLfRGzsRVR7zTy19jPCvvT8S4R8JKQi1QLm60VA09WPjJgql67B+PAxBWXbSVp
         36aE3bzRA5+Kv4Id9wEcnKxwyqjuIwBH2BHgtVhNdJF3icZiYhXSgz7BbIFM4YHJ27Gb
         FQORATT3QR3zTtuwbIeRhBzzXNYNdjuyD41DoKlC5Co+41+ruEh08qxofCxSJkNBaoBs
         VANafJBAIon+/WSacaLOLj/vNyJhigBV2LnB1QGOkbMbqA9rtNm3tJFxiETn9asyMgE0
         jOAg==
X-Gm-Message-State: AOAM530Yi8JvuFNolFmOcxjfAhOHOZNLkg7lzaVxdaaR01T/fDGGqAeW
        sgvCUXavnUXwJyL2TAasBQtZXA==
X-Google-Smtp-Source: ABdhPJyNIkNoBljyczIcLAxluT/ncJslz82vRxuNdgyl0p0COQRoENkoyaekMBGw5TpbyXVtmyxQnQ==
X-Received: by 2002:a17:906:c1c6:: with SMTP id bw6mr2783569ejb.199.1606827373837;
        Tue, 01 Dec 2020 04:56:13 -0800 (PST)
Received: from ch-wrk-javier.localdomain (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id be6sm796864edb.29.2020.12.01.04.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 04:56:13 -0800 (PST)
From:   javier@javigon.com
X-Google-Original-From: javier.gonz@samsung.com
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [PATCH 0/4] nvme: enable per-namespace char device
Date:   Tue,  1 Dec 2020 13:56:06 +0100
Message-Id: <20201201125610.17138-1-javier.gonz@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Javier González <javier.gonz@samsung.com>

This series enables a per-namespace char device that is always presented
to the host, independently of the block device associated with the
namespace. This allows user-space to use the char device's IOCTL
interface when the kernel rejects the block device due to unsupported
features. Examples of these features include unsupported PI
configurations, ZNS features such as zoc, or unsupported command sets
such as KV.

One of the things that I would appreciate more input on is the naming
convention. This series follows the hidden device naming nvmeXcYnZ, but
I am not sure how this will work out with multipath. The concern is if
we will have unfixable naming collisions that will jepardize user-space
tools depending on this naming.

Thanks to Christoph for proposing this in the first place and Christoph
and Keith for early reviews of this patchset!

Javier

Javier González (4):
  nvme: remove unnecessary return values
  nvme: rename controller base dev_t char device
  nvme: rename bdev operations
  nvme: enable char device per namespace

 drivers/nvme/host/core.c | 172 ++++++++++++++++++++++++++++++++-------
 drivers/nvme/host/nvme.h |   3 +
 2 files changed, 146 insertions(+), 29 deletions(-)

-- 
2.17.1

