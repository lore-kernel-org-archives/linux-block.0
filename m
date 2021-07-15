Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CA5C07E96
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 04:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7003E6136E
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 04:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbhGOE62 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 00:58:28 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:37656 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhGOE62 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 00:58:28 -0400
Received: by mail-pj1-f53.google.com with SMTP id o3-20020a17090a6783b0290173ce472b8aso5277865pjj.2;
        Wed, 14 Jul 2021 21:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WlFceL9MIGP0NYzw2JtqRAeYjpqbMSc3TmJmz+OF8Bg=;
        b=JvHUSR7bUcgoAOBaq3HHrlxTCVmAHTZJLdaZ2tmFevLzZfd8/M8BBjREal7cRlfFku
         xHgJwo2vICO4dU4lBzi7zWjk/VXxcyNMb6nk+aXchek4pngRfDMQqUCdY/elSpBtVrar
         gXgyMxqHVbwF35XpkfJofJUTGhYGZCk1c/AxO9aN0NqRiSgxYenOw1PWp2EsurP/gk7n
         2GbX8vJsE0tDj0n0vU4RlxECqULCUFO8PPhs4HLwoOw3hB6YXagj/3DsvhnHMZ3zNoJC
         sua6U89w5Vcpj4kMjS3nZ15kfWHhQiwgtblWalwwxQvTEdbPojvQSL/jozUaZkB49cKW
         TGJQ==
X-Gm-Message-State: AOAM531lmyl0+lXHXIsZmpsMCCeu3f31aRF5Xi1TkljafW1deMx7BXLc
        9iyeN9utL55l0u0nxb8dUf4=
X-Google-Smtp-Source: ABdhPJwVty21gvxZSRlBfjc6Ni3On8r00SDhHugOfBDQ1pUfYscu55jfNV9l09llT9F0CDVyQsZ95g==
X-Received: by 2002:a17:90a:4cc4:: with SMTP id k62mr7937337pjh.110.1626324935557;
        Wed, 14 Jul 2021 21:55:35 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id 10sm4611245pfh.174.2021.07.14.21.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 21:55:34 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 0/6] block: add error handling for *add_disk*()
Date:   Wed, 14 Jul 2021 21:55:25 -0700
Message-Id: <20210715045531.420201-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This v2 has the following changes:

  - rebases onto a fresh linux-next which includes Christoph's
    latest cleanups
  - dropping error injection as I inspect ebpf and other
    alternatives, yet I still tested this series with that
    patch and the only change needed was the last one.
  - adds a new patch, the last one,  to adjust to our
    preference now to always wish for users to call a cleanup
    like blk_cleanup_disk() when add_disk() fails.
  - dropped driver conversion

Although I've dropped driver conversion at this point I've
converted all drivers over, but that series is about 80
patches... and so should be dealt with after this basic core
work is reviewed and merged.

Luis Chamberlain (6):
  block: refcount the request_queue early in __device_add_disk()
  block: move disk announce work from register_disk() to a helper
  block: move disk invalidation from del_gendisk() into a helper
  block: move disk unregistration work from del_gendisk() to a helper
  block: add initial error handling for *add_disk()* and friends
  block: skip queue if NULL on blk_cleanup_queue()

 block/blk-core.c      |   3 +
 block/blk-integrity.c |  12 ++-
 block/blk-sysfs.c     |   5 +-
 block/blk.h           |   7 +-
 block/disk-events.c   |   8 +-
 block/genhd.c         | 229 +++++++++++++++++++++++++++---------------
 include/linux/genhd.h |  14 +--
 7 files changed, 180 insertions(+), 98 deletions(-)

-- 
2.27.0

