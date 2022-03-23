Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7132C433F5
	for <linux-block@archiver.kernel.org>; Wed, 23 Mar 2022 19:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344362AbiCWTrB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Mar 2022 15:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241263AbiCWTrA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Mar 2022 15:47:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA9EF8B6FD
        for <linux-block@vger.kernel.org>; Wed, 23 Mar 2022 12:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648064730;
        h=from:from:sender:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc;
        bh=lSw1myUul/JfBJxzMKk7S5towi4LjKVp/1Za72ezB54=;
        b=LySLnh5D8ldF2An8lMEdM511ztji2IndrSg3bMjgzJrZ20yOdFoU4JcGu+5d09GTPsKUaZ
        Ym8It4T9o7hJ8TDmoW0pr9X5a+kgDNeXXhg+iKqqOJrPJfpLUCzR2kkgZP9amU8ksb5g+P
        J3NV9BSAlye41K19E24todAgpdanfxY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-gJeEuQpKNT-1tyN8BJeC6A-1; Wed, 23 Mar 2022 15:45:26 -0400
X-MC-Unique: gJeEuQpKNT-1tyN8BJeC6A-1
Received: by mail-qt1-f200.google.com with SMTP id h11-20020a05622a170b00b002e0769b9018so1995803qtk.14
        for <linux-block@vger.kernel.org>; Wed, 23 Mar 2022 12:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=lSw1myUul/JfBJxzMKk7S5towi4LjKVp/1Za72ezB54=;
        b=7hy98tfkIgdKJiBSr9gKKGEViqcHwIdJF9EOB+WpnS08FpkNPhqxTlypp3cvfCXKv6
         UnlNJF+5fR7QB5k/SuOVvFXUajDutfe3SNfz3wp6J6Q+ZpdGQKPuW3I6bDQlhPl2yi5H
         /SYO3JuKJcGH/NZ4TDh6SjMT4UtlgoplCGtRi+upyUFh1/xNsUdbWBm8egen8D6y9RyT
         nzhH4MkkIDLlpcrgzDK/+vGAZznbe77+rBm/4TUkSghP4lp39tQ9v2qEfcEGci2QihDo
         dzdE0wSA7Hd6gDEKC5UZKHYm973LEEV3VmEy8nwZF2rM7fuhlz+ngxdR8iUGZEC0DuZt
         Zozw==
X-Gm-Message-State: AOAM533+Zb8FlYvP5JBxvVt71k2oA2Y/7n3WKw1AvenwgqMYznVVqilk
        k6lnhM/i99+xroD+0rhaGCofbkNtWuL+HUlRtE+l8mQe1IePYbPwvrBxkbQIItoYnNW8ceXzEoE
        5jxYQNM0hhAQKda2WRStzog==
X-Received: by 2002:a05:620a:4442:b0:67d:b94a:8c6a with SMTP id w2-20020a05620a444200b0067db94a8c6amr1061909qkp.569.1648064725985;
        Wed, 23 Mar 2022 12:45:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx47UcAziqxaHCmQSZ1SIf9p3IFNqdEceNYCt1DNIo6G+Q2WNX/DpF1yfSQSseo4kE6sbUbPQ==
X-Received: by 2002:a05:620a:4442:b0:67d:b94a:8c6a with SMTP id w2-20020a05620a444200b0067db94a8c6amr1061900qkp.569.1648064725765;
        Wed, 23 Mar 2022 12:45:25 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id r11-20020ae9d60b000000b0067e5308d664sm545584qkk.92.2022.03.23.12.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 12:45:25 -0700 (PDT)
Sender: Mike Snitzer <msnitzer@redhat.com>
From:   Mike Snitzer <snitzer@redhat.com>
X-Google-Original-From: Mike Snitzer <snitzer@kernel.org>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH v2 0/4] block/dm: use BIOSET_PERCPU_CACHE from bio_alloc_bioset
Date:   Wed, 23 Mar 2022 15:45:20 -0400
Message-Id: <20220323194524.5900-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.15.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

I ran with your suggestion and DM now sees a ~7% improvement in hipri
bio polling with io_uring (using dm-linear on null_blk, IOPS went from
900K to 966K).

Christoph,

I tried to address your review of the previous set. Patch 1 and 2 can
obviously be folded but I left them split out for review purposes.
Feel free to see if these changes are meaningful for nvme's use.
Happy for either you to take on iterating on these block changes
further or you letting me know what changes you'd like made.

Thanks,
Mike

v2: add REQ_ALLOC_CACHE and move use of bio_alloc_percpu_cache to
    bio_alloc_bioset

Mike Snitzer (4):
  block: allow BIOSET_PERCPU_CACHE use from bio_alloc_clone
  block: allow BIOSET_PERCPU_CACHE use from bio_alloc_bioset
  dm: enable BIOSET_PERCPU_CACHE for dm_io bioset
  dm: conditionally enable BIOSET_PERCPU_CACHE for bio-based dm_io bioset

 block/bio.c               | 67 +++++++++++++++++++++++++++++++----------------
 block/blk.h               |  7 -----
 drivers/md/dm-table.c     | 11 +++++---
 drivers/md/dm.c           | 10 +++----
 drivers/md/dm.h           |  4 +--
 include/linux/bio.h       |  9 +++++++
 include/linux/blk_types.h |  4 ++-
 7 files changed, 71 insertions(+), 41 deletions(-)

-- 
2.15.0

