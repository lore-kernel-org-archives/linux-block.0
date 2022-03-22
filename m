Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC92C433EF
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 19:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiCVTvA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Mar 2022 15:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiCVTvA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 15:51:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7240C4F9CC
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 12:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647978570;
        h=from:from:sender:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc;
        bh=Ra70WqR4k9WaEnGzMfMHq7N8Yl2YrFMOg3wm/QlzybE=;
        b=jPEXh70C4cyOWt9+F4QaGWkIFRRRZhw4Clz77JMfAmU1zna9WVl8je8+LtrqWB3uYAE1Dz
        3Ld04RLMU5QPuzUA6QkJCYjOJCs0btTeLHX2JyJB1LS8I8rckk+PUO//kTOcoa3bdUXYnN
        VzAIGZHqwJAIae5/43RZgcNqIyKWRHc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-oQqMY_5GP1CosSTIyqvxcw-1; Tue, 22 Mar 2022 15:49:29 -0400
X-MC-Unique: oQqMY_5GP1CosSTIyqvxcw-1
Received: by mail-qv1-f71.google.com with SMTP id z1-20020ad44781000000b00440ded04b09so13210264qvy.22
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 12:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Ra70WqR4k9WaEnGzMfMHq7N8Yl2YrFMOg3wm/QlzybE=;
        b=y5Ar9uGhvDjIpgJVEyZ/DffsnIax0ZwRFck1epWbtwqTHEPdL3P7rmw5hmKIOaAD+Z
         zHAnezHonnCh9DtYCmb6Dzif5W4BZnKh87JtBSZ8sLav7WtvhSWlaB4GCVogb5egAYz4
         o8TQJ/EB3cUmZGISBOgw/UFXOBGOhpK8kYgrmihu8+Xp+PdiF9XUql/9kdwjrPTLIrcv
         4Z9FE6d5l5W77DFzEsvsp/Dxl09BdYD5Ql/YtuaPxug/J6HTBcjzXFvJSUrO84Ph0KKQ
         hcnoB12JJE5nvzekDwYSXtLfXGLZNzDFALhBOUYgGEAGOSp7Scaf4lkJEWMyiap+sRin
         DQdw==
X-Gm-Message-State: AOAM531EPA/Zj6/BvnBQfPoL5nlW9AC9F3KoNFV167dGA6lsknHTmGzj
        nIFuM3SDcAp1YTOA926GpRqnzy/Gn8thx+o3mC1zhJ2MY+tCOL1oMq6RQu128dBzxG8UdK8j75W
        ko9C0hcEWsnwgHIVc2KUaGA==
X-Received: by 2002:ac8:5c45:0:b0:2e1:9144:2849 with SMTP id j5-20020ac85c45000000b002e191442849mr21355797qtj.510.1647978568659;
        Tue, 22 Mar 2022 12:49:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuAUFri4nvEvVZF2RbL13ATvmIkasPUTw6SWWeNMQNB5h7Rc+g8WP6K964HYpvWyTYncWNsg==
X-Received: by 2002:ac8:5c45:0:b0:2e1:9144:2849 with SMTP id j5-20020ac85c45000000b002e191442849mr21355785qtj.510.1647978568427;
        Tue, 22 Mar 2022 12:49:28 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id x20-20020ac85f14000000b002e1ee1c56c3sm13518520qta.76.2022.03.22.12.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 12:49:28 -0700 (PDT)
Sender: Mike Snitzer <msnitzer@redhat.com>
From:   Mike Snitzer <snitzer@redhat.com>
X-Google-Original-From: Mike Snitzer <snitzer@kernel.org>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 0/3] block/dm: use BIOSET_PERCPU_CACHE from bio_alloc_clone
Date:   Tue, 22 Mar 2022 15:49:24 -0400
Message-Id: <20220322194927.42778-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.15.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

I ran with your suggestion and DM now sees a ~7% improvement in hipri
bio polling with io_uring (using dm-linear on null_blk, IOPS went from
900K to 966K).

I'd appreciate it if you could pick up the first patch for 5.19.
I'll rebase dm's 5.19 branch on block once it lands.

(FYI, this series builds on linux-dm.git's "dm-5.18" branch, and the
commits in this series are available in linux-dm.git's "dm-5.19"
branch).

Thanks,
Mike

Mike Snitzer (3):
  block: allow BIOSET_PERCPU_CACHE use from bio_alloc_clone
  dm: enable BIOSET_PERCPU_CACHE for dm_io bioset
  dm: conditionally enable BIOSET_PERCPU_CACHE for bio-based dm_io bioset

 block/bio.c           | 56 ++++++++++++++++++++++++++++++++-------------------
 block/blk.h           |  7 -------
 drivers/md/dm-table.c | 11 +++++++---
 drivers/md/dm.c       | 10 ++++-----
 drivers/md/dm.h       |  4 ++--
 include/linux/bio.h   |  7 +++++++
 6 files changed, 57 insertions(+), 38 deletions(-)

-- 
2.15.0

