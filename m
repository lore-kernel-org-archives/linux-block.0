Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4468EC433EF
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 12:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 285BF6109E
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 12:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240151AbhJ0MX6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbhJ0MX6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Oct 2021 08:23:58 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71F8C061570
        for <linux-block@vger.kernel.org>; Wed, 27 Oct 2021 05:21:32 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v127so2411738wme.5
        for <linux-block@vger.kernel.org>; Wed, 27 Oct 2021 05:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sp0pQbduTQbHexYonKWa1MPA1rDfXkyXI5HPgTnXAKI=;
        b=R07mbs9lb27DpSzdZa+ZC11NZZ2MIZ8rjhZ1PllmTkYhPhnWj1sb6ugq/PgeKvbEmd
         dkEtiADHVm6DWUEjBVjHwxjZzZ5dtdI8tQgmIcSNesiOS5ouIDWK6b7klUYR5Wegf0CA
         nr4L0LnWSyeNs5LJePM/eBezSb7ozodiWuGbsoTPxEoHHY3B/mcqA6zT9O0kDik6bRoi
         Xl4jw0H4UGfXbV2ni8aA626OUTrJjOmj0+EbTaxwI+OZhk/QS4g3/pcp6qqBQVQfVrJi
         C+z/lmxk7RIi+t2W7ydAFkkHsA1FZLTtufAHBC0htVNzYTdZb2opI50taXg+j3MiDZxX
         AV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sp0pQbduTQbHexYonKWa1MPA1rDfXkyXI5HPgTnXAKI=;
        b=Uir0X/Prgvnu8uTPyE5lHB9i1zC75Ky/KC7cikjL3GhkD8OwQVeP8372AxygmZdI2/
         0kakkObLCuPHmtJRF0TivOcnLesQdS7C1jfWF0LqEHkMl7u23UE4FJWiQAR3/jK+DKYc
         uYffwTB424VxybSrYimQTU4Qti5LSxYc8yz/ruQ4ra/DO4Qrm7WGxTD03C67TgcnhY+U
         gLq85EP16CeH/YEYcVL/uGUS0Fg0CtigTCSLEeR1z4fG78l/F5pn9P9LmqrCNdL8gc/6
         +TLpVk9kmRfs1WjlgHh1ttaiXdtTmg5H686tqMAervti2Jxc7sM0ITC9mO5GQiaBajud
         kuEg==
X-Gm-Message-State: AOAM5316t/yd33qFAgAvHBbnRonayhDFnkQmT/28M1ZyWyDqmvBOc4rJ
        7xiLE6fJvzXLwQ/bW6LAVUvetihRByc=
X-Google-Smtp-Source: ABdhPJy0lHAm9pARb1GX8pR8iquJ4HRAHp6Ow+M0KcabQNOvq9cCOZPT8FZquKpkdfjVewdEqPLdVQ==
X-Received: by 2002:a05:600c:3b13:: with SMTP id m19mr2119621wms.172.1635337290805;
        Wed, 27 Oct 2021 05:21:30 -0700 (PDT)
Received: from 127.0.0.1localhost ([148.252.132.100])
        by smtp.gmail.com with ESMTPSA id d8sm22738807wrv.80.2021.10.27.05.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 05:21:30 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v2 0/4] block optimisations
Date:   Wed, 27 Oct 2021 13:21:06 +0100
Message-Id: <cover.1635337135.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

optimisations for async direct path of fops.c, and extra cleanups based
on it. First two patches from v1 were applied, so not included here.

v2: add another __blkdev_direct_IO() cleanup, 3/4
    rearrange branches in 1/4 (Cristoph Hellwig)
    inline bio_set_polled_async(), 4/4 (Cristoph Hellwig)

Pavel Begunkov (4):
  block: avoid extra iter advance with async iocb
  block: kill unused polling bits in __blkdev_direct_IO()
  block: kill DIO_MULTI_BIO
  block: add async version of bio_set_polled

 block/bio.c         |  2 +-
 block/fops.c        | 80 +++++++++++++++++++--------------------------
 include/linux/bio.h |  1 +
 3 files changed, 35 insertions(+), 48 deletions(-)

-- 
2.33.1

