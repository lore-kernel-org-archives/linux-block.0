Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEA7C32771
	for <linux-block@archiver.kernel.org>; Wed, 28 Sep 2022 19:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbiI1TzR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Sep 2022 15:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbiI1TzQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Sep 2022 15:55:16 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A81B286CB
        for <linux-block@vger.kernel.org>; Wed, 28 Sep 2022 12:55:14 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id v2so17787302edc.7
        for <linux-block@vger.kernel.org>; Wed, 28 Sep 2022 12:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=iyycBCK0NNl8E30Z+4DtXcZiRG0olQqpTeLI0obxIz8=;
        b=7rYDDWIr7Z6cW1rZ+8/E+rqBmzjs3bd5Z8hWgZrRV77afiipGSwbr0696i1NoZpXQp
         6WZtbQRfyXyY2A0n0UNa11VI3DhnupoOOu+lUWT0DPLRQ83fSBonvaafhp9Iozp6qaVY
         eGu0Sv7/j3i08My3OlY4M0ViAmLRtpMxPYQv02UcP02FjRUJnTELgzBzY4KG/XWahluJ
         Gj0ZrcSAiG23bBh4gbk7mrKiPAM2iwUh44nZA0uEexhWQRHRydSbDfEQBN2izFe8z/qB
         sjBshMqu13EUkc3UGWHyPdcGwOoUQQKRnoCVbbY3Ygi0Ze+ax0Eel/UMIwkxv4FmjLge
         npkA==
X-Gm-Message-State: ACrzQf2MUCh7Z2XDUNP7WggD8gywxI6RfFTQfCxZ0+n5rlNk/Kvgy4+0
        aQDpNVS2pDGtpYW88eecevk=
X-Google-Smtp-Source: AMsMyM61kr+zoTEsDafTgmogLbwOkf40C75jIS2C9n2L4A0G+n1bvyNSuwEzneeXIJJ+lS8s1SUJJg==
X-Received: by 2002:aa7:cb87:0:b0:43b:e650:6036 with SMTP id r7-20020aa7cb87000000b0043be6506036mr34929160edt.350.1664394913026;
        Wed, 28 Sep 2022 12:55:13 -0700 (PDT)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id 16-20020a170906329000b007389c5a45f0sm2845747ejw.148.2022.09.28.12.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 12:55:12 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH rfc 0/1] nvme-mpath: Add IO stats support
Date:   Wed, 28 Sep 2022 22:55:09 +0300
Message-Id: <20220928195510.165062-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I've been hearing complaints about the fact that the nvme mpath stack
device does not expose IO stats just like any normal block device,
instead people need to check the bottom namespaces hidden devices,
mapping back to the mpath device node.

This really sucks, especially for observability hooks/plugins that
I've seen people do.

This is an attempt to make the nvme mpath device expose normal IO stats.
Given that nvme-mpath doesn't have any context after submitting the bio,
we use the core completion path to start/end stats accounting on its
behalf, a similar practice that we use for other multipath related stuff.

Given that its not too invasive, I decided to keep it
in a single patch, but I can certainly split it in to
smaller patches if anyone thinks I should.

Feedback is welcome.

Sagi Grimberg (1):
  nvme: support io stats on the mpath device

 drivers/nvme/host/apple.c     |  2 +-
 drivers/nvme/host/core.c      | 10 ++++++++++
 drivers/nvme/host/fc.c        |  2 +-
 drivers/nvme/host/multipath.c | 18 ++++++++++++++++++
 drivers/nvme/host/nvme.h      | 13 +++++++++++++
 drivers/nvme/host/pci.c       |  2 +-
 drivers/nvme/host/rdma.c      |  2 +-
 drivers/nvme/host/tcp.c       |  2 +-
 drivers/nvme/target/loop.c    |  2 +-
 9 files changed, 47 insertions(+), 6 deletions(-)

-- 
2.34.1

