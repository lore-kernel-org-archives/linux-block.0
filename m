Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081A1C433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 21:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346052AbiFOVBr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 17:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236331AbiFOVBo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 17:01:44 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8525523E
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 14:01:44 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id w21so12559333pfc.0
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 14:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NWduQzxr9F+o2a7mTrA8EXnP0DZh4N2Y+SwXQ5vvL7g=;
        b=BiRmJZ0YK5TP68K+PYFzttOX4cfKR8oob7ct5SUPzKkIAG31PqBMuTVc4TgZxSpAOq
         wxHbML1PNHt8Ciehyz5yjlixjgMbe9PvW5V/gaigDHurVALNy1WGU0Vc9f8AYTxI62eP
         UNCpQSG42WjBZFgoaqHwy3lTkAoWObwSVPK5kCRaCyMF4DkUDXJPoUnC5AinJYHykT46
         U5zyOWzmp7hWNJ8B/BE6Cae526Q07DX9vjaT79xHuknMIFyhmj/g0XyVx0YAUjGUMcLv
         kBsJe6rd3k7HxGATuq8Jgjt1iR6xsiruXjs7UOt3PTMJi9UhY4c/JzR9VIa/XYZeV8yl
         J9zg==
X-Gm-Message-State: AJIora8BJN9BOAkBeXSc1SLBnOm/cTFn+EmNnD+y3dsf5AVEUdG761vd
        wZQ0KsZJ3GF5rEGQ84t9B5Pa+OZro2U=
X-Google-Smtp-Source: AGRyM1sLNgmK4tWR//Ig8tykwM5v7gXIhavdavKxUR9eQYs+tR9h2hXUs1QH32O87rsiNAvaAX/SKQ==
X-Received: by 2002:a65:6044:0:b0:3fc:674:8f5a with SMTP id a4-20020a656044000000b003fc06748f5amr1454890pgp.436.1655326903748;
        Wed, 15 Jun 2022 14:01:43 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:36ac:cabd:84b2:80f6])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902ed8c00b0015e8da1fb07sm68986plj.127.2022.06.15.14.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 14:01:42 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/3] Three small block layer patches
Date:   Wed, 15 Jun 2022 14:01:33 -0700
Message-Id: <20220615210136.1032199-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

These three patches are what I came up with while reading block layer code in
preparation of the patch series for improving zoned write performance.

Please consider this patch series for kernel v5.20.

Thanks,

Bart.

Changes compared to v1:
- Modified patch 3/3 as suggested by Ming Lei.

Bart Van Assche (3):
  blk-iocost: Simplify ioc_rqos_done()
  block: Rename a blk_mq_map_queue() argument
  block: Improve blk_mq_get_sq_hctx()

 block/blk-iocost.c |  2 +-
 block/blk-mq.c     |  2 +-
 block/blk-mq.h     | 12 ++++++------
 3 files changed, 8 insertions(+), 8 deletions(-)

