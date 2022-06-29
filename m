Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B95C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 21:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiF2VzR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 17:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiF2VzQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 17:55:16 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946DF20F6F
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 14:55:15 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id z12so13125298qki.3
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 14:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mgLvicxygsgFWfkkr4Nfr2kLCpJ+k85KjEN3Gw0z4Zk=;
        b=b3t86ArL6QWtna+zNP7pfckJRPQKLPrXtyQTQIXeMF8dmI/QKweZ/FexvtMISyMY8x
         FG6PBtFFo76Qna/nUWpn9rMWEYpkrjeeO0Q5wOreaflaRJxOvXrqlhjdDPHHAjXD6+9B
         xhz3iZO9sYbeJie9weCXyokVq+QNd5DIWLdI69c7DNmp7oSBI1jMtarMlLDZTW+Sunu9
         X/RMffzipPyfj+n7iGQkzSorigWuuijCurWirdHIvYtYypcxchf8E8jAxEUbxLqyyAyx
         JMxkuYdfoZRVcCw77HaZPppHoiaStBjimNTUtZCCNjA2abUyhyRa5Ia1Qs4QhP6vAdQ0
         s29A==
X-Gm-Message-State: AJIora8Pfz2TAAeH7AgW0AiN90zlYLYKQTPbCvd1UGnMWPaboRITFPbL
        8XiV0VZyyVI1yqSpQhja9H/t
X-Google-Smtp-Source: AGRyM1uXQvQsptKSLy23DUES/xRH4SfsIle9GVnQzewwll2BBUehX9+zCu4ZlGzioPk5MgGrHAZPcQ==
X-Received: by 2002:a37:a589:0:b0:6b1:ba97:5dbf with SMTP id o131-20020a37a589000000b006b1ba975dbfmr1611512qke.772.1656539714605;
        Wed, 29 Jun 2022 14:55:14 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id d8-20020ac85ac8000000b00304e70585f9sm12400080qtd.72.2022.06.29.14.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 14:55:14 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Eric Biggers <ebiggers@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 5.20 v2 0/3] block/dm: add bio_rewind to improve DM requeue
Date:   Wed, 29 Jun 2022 17:55:10 -0400
Message-Id: <20220629215513.37860-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.15.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This v2 is the by-product of my having picked up v1's patch 2+3 and
folding them (into patch 1 of this v2 series). So patch 1 of this v2
is settled and will be merged into 5.20.

Patches 2 and 3 are the result of me having gone over the v1 code. I
folded in the copy-n-paste bugfix that Eric Biggers kindly pointed out
in v1. I also updated patch headers and code comments for clarity. And
I also renamed some variables, tweaked some style knits (subjective
but whatever).

This code is available in linux-dm.git's 'dm-5.20' branch:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-5.20
Which is based on Jens's for-5.20/block

I'll obviously rebase 'dm-5.20' ontop of Jens's branch if/when he
picks up patch 2 in this series.

This code is passing all my tests so far but testing is ongoing.

All comments welcome.

ps. I was told Kent had replied to the v1 thread while I was working
on this v2, I kept focus on finishing this v2. I'll check my email in
a bit.

Ming Lei (3):
  dm: improve BLK_STS_DM_REQUEUE and BLK_STS_AGAIN handling
  block: add bio_rewind() API
  dm: add two stage requeue mechanism

 block/bio-integrity.c       |  19 +++++
 block/bio.c                 |  20 +++++
 block/blk-crypto-internal.h |   7 ++
 block/blk-crypto.c          |  25 ++++++
 drivers/md/dm-core.h        |  11 ++-
 drivers/md/dm.c             | 189 ++++++++++++++++++++++++++++++++++----------
 include/linux/bio.h         |  21 +++++
 include/linux/bvec.h        |  33 ++++++++
 8 files changed, 281 insertions(+), 44 deletions(-)

-- 
2.15.0

