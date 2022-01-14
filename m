Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B24C433FE
	for <linux-block@archiver.kernel.org>; Fri, 14 Jan 2022 15:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243042AbiANP67 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jan 2022 10:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243027AbiANP67 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jan 2022 10:58:59 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F49C061574
        for <linux-block@vger.kernel.org>; Fri, 14 Jan 2022 07:58:58 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id ay4-20020a05600c1e0400b0034a81a94607so5711480wmb.1
        for <linux-block@vger.kernel.org>; Fri, 14 Jan 2022 07:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ayEQw7tWlpAmxVLehsjA/vgjx56AX5VHIr3iunAN42w=;
        b=DnHaRSudk2Og1M0A8kppqgjb4qsDOdZ166SizsOTRNBQedg2xBAzeJCJuk05yKZm9F
         Ht2//3LvpQm2A+v4GEovsLgcQkVcy07OiRMTD5FuNReomCDIAQIxLS4nYeQzozeNDSlI
         1GRjhGtlG8npd3XOCP1pMmKtdufyrjziIKos2cAr+nfFGP3y7pPWmJvZsO2pA6uRGyXb
         OH0ITDrQqKMeCRKAUcH1OBM2KaaSpMErKQrXSAP827sQ8WH7Ma1mfZYojMT6WIlsEPr+
         EjWwhB18+ZZ5DoZCReJbjSUXulW4xkYs2D8TcTValmBD7usVXpTXNvIbNa4j0lXT8h2k
         uyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ayEQw7tWlpAmxVLehsjA/vgjx56AX5VHIr3iunAN42w=;
        b=HQijcgyBWjdcNJWASgmLDh41cBNsXX/9MsCz8t84sVa2AfoaMCSDs3Eitp2VIb7VDE
         1CAW/Liz6Bsqa7zazRrQYmniLNXZRAkABU65H2k03bqkJF1AX2ksjxGTSOrulj/e9Kpp
         1/nNBdf1+Dex14XsY1jbRaue4gs7oKoPmDy6xMCBWBLrUyGn3DbE8vQ240TMbhNXQeS2
         4t9L7A8D9XEWNTm/odBIp9toQiU0DtJlHn5NH+TUxyryAqfR7PYaYHvR+Cul2+3YnPnz
         cH9dIEUglJyCEXDXMlHkIqBjiJ3ZbJ6RAGRwS5wRtuqNBHvWYskKaHE4vQRwebz8F33U
         um3Q==
X-Gm-Message-State: AOAM530huGFnYe2ZtuexAX2dQP4IG9KZ81bTVs9x9APio2FjSui821i5
        9+oh/YOrfHxXfSNoQ2t0/7+9ldxgCDjFDw==
X-Google-Smtp-Source: ABdhPJy8lu8LjL/Wy4Yjknw/uTOcfvJ0Z7gj+BPLOB+HU8rHRg1qM+wQ1gni0haP4ySeqYFHaKQNVA==
X-Received: by 2002:a05:6402:c19:: with SMTP id co25mr9549581edb.33.1642175937387;
        Fri, 14 Jan 2022 07:58:57 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id j5sm1930246ejo.171.2022.01.14.07.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:58:57 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCH for-next 0/2] Misc RNBD update
Date:   Fri, 14 Jan 2022 16:58:53 +0100
Message-Id: <20220114155855.984144-1-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Please consider to include following change for next merge window.
 - fixes warning generated from checkpatch
 - removes rotational param from RNBD device

Gioh Kim (2):
  block/rnbd-clt: fix CHECK:BRACES warning
  block/rnbd: client device does not care queue/rotational

 drivers/block/rnbd/rnbd-clt.c   | 15 ++++++++-------
 drivers/block/rnbd/rnbd-clt.h   |  1 -
 drivers/block/rnbd/rnbd-proto.h |  4 ++--
 drivers/block/rnbd/rnbd-srv.c   |  1 -
 4 files changed, 10 insertions(+), 11 deletions(-)

-- 
2.25.1

