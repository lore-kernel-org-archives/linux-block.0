Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564DCC433ED
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 23:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2548161131
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 23:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbhDOXP7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Apr 2021 19:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbhDOXP6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 19:15:58 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAACC061574
        for <linux-block@vger.kernel.org>; Thu, 15 Apr 2021 16:15:32 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id 1so19563705qtb.0
        for <linux-block@vger.kernel.org>; Thu, 15 Apr 2021 16:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=A2s2OPIGot51QKltNpTIuUg2YDwX1FQEhuCnxgRK/jE=;
        b=uW2CDH33NH/4zz5ntTk7aMqjkleJZLBlea4NFuebMro2OdQo5SDOxqJjXWpYCD4DGi
         A8VgdmLYIDDf9Xxvc5sN9QnqWSNkec4JReEnbJ0IGcDMp86ri1FHitV9khS1CZBOV986
         CSIoQCSvI7NqCKBxQK22R3ebHgBslXZwbtVrE1d/sZAfkThzUEGSd3bbYW3qdReccLj0
         v1vg3yqHKSnrRcTI9AYCOf5RW9UVqrbHyytI2DSqaOM+QJi0+DwN634DOE45YJGY1clW
         tUhe1YaAeTwy9uP8I39JUzQTxRlBnoBUWMKmt+ql9ipSP6bhY8TdGPx32Md/IVg4b3Sy
         fBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=A2s2OPIGot51QKltNpTIuUg2YDwX1FQEhuCnxgRK/jE=;
        b=hOIa/W51k4yl7YqFQEu24uPSvKaslPWqk/LZNB013Fxo/KVzvgnukpr5O/D1BjlK69
         3kFIkf9W4agXi2EORwLObMMdaM2Wd0u1gwh83D5sR7UZWvTtBCriI79t91YQEYntCi/Y
         TN81m9xYta++vOlXns42ZOR/Lj5aN9foqsMVpiM8z0aR9+mJWukx94lEKtPYCi2HIVdf
         NEoWmMbyknXj22cfTkPT5OnLw7t4Z+q0n6Z8qyuppxB8vr5u57IwE4QkpO+YLatjTxYw
         fMoeTtjommGODbgx96wQ6GhePTrp0oks2rY3ExwRnRbpmOZ4IQkhYSrD6YitNAbn0jd8
         BVOQ==
X-Gm-Message-State: AOAM532mVaSp4B/40OFTIX4x3VhSpETCUpKXTwrCbCSpIgGRI7FeRrGV
        GD1ASpxkb1uVzR70o0lbd7Y=
X-Google-Smtp-Source: ABdhPJwAgbtdrrcWaDUhxSmioFl2dV0taaSqWO02nP0rl5pOrMokGKWTzXuEaUGSdiGHrWDedY0uGg==
X-Received: by 2002:ac8:7f53:: with SMTP id g19mr5286316qtk.249.1618528531955;
        Thu, 15 Apr 2021 16:15:31 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id v127sm3099344qkh.37.2021.04.15.16.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 16:15:31 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH v2 0/4] nvme: improve error handling and ana_state to work well with dm-multipath
Date:   Thu, 15 Apr 2021 19:15:26 -0400
Message-Id: <20210415231530.95464-1-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

I just rebased and tweaked these 4 patches ontop of v5.12-rc7.

Been carrying an older ~5.9 based version in RHEL8 (since RHEL8.3,
August 2020; yes the patchset I just mistakenly emailed instead of
this patchset):
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=nvme-error-handling-fixes/for-5.9

RHEL9 is coming, would really prefer that these changes land upstream
rather than carry them within RHEL.

All review/feedback welcome.

Thanks,
Mike

Chao Leng (1):
  nvme: allow local retry for requests with REQ_FAILFAST_TRANSPORT set

Mike Snitzer (3):
  nvme: return BLK_STS_DO_NOT_RETRY if the DNR bit is set
  nvme: introduce FAILUP handling for REQ_FAILFAST_TRANSPORT
  nvme: decouple basic ANA log page re-read support from native multipathing

 drivers/nvme/host/core.c      | 45 +++++++++++++++++++++++++++++++++++++------
 drivers/nvme/host/multipath.c | 16 ++++++++++-----
 drivers/nvme/host/nvme.h      |  4 ++++
 include/linux/blk_types.h     |  8 ++++++++
 4 files changed, 62 insertions(+), 11 deletions(-)

-- 
2.15.0

