Return-Path: <SRS0=LQCZ=DA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4905C2D0A8
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 20:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70754206DB
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 20:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZb1qKvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgIWUGy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Sep 2020 16:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWUGy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Sep 2020 16:06:54 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E155C0613CE
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2020 13:06:54 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 16so1024690qkf.4
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2020 13:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=DcI9qzORAmpASB52sXLs4QqTzINHknlH96I3Bxuml6Y=;
        b=gZb1qKvxEy5Mbj+toIRPI5hK1aS5CEqsDpft3SLOrcTSRJ2aeWFiO3iuq7B5KRd8Aa
         OuG3316SQBKN5j3Wb3T/+JBdq5T/AQc5WdPlKEYwuA7VO/6H9dfIyvIu8XdNSRrfphvC
         EqdJyRm8FTT8pzgO9kETKLrA4u6jzutGXqkw3VcluQLQHKVac+pxBCYvdaV0WAdYBBVm
         Crm/PwwCm7L6QdIXC9dzM+11Mkhuc1HIPdqbgwCKQD8mxlDSmNI9rY527r8diNnjOj/n
         aB/UuaiHw9RksXNqwn5eNQ58suJqw2QtzR7+Cein01JO4hUrtaKMN2CYOuvsRObgPV1L
         JVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=DcI9qzORAmpASB52sXLs4QqTzINHknlH96I3Bxuml6Y=;
        b=UgKoCJFEjZfRul5b/DqN/5j+KvSznzIrZ9X2vCm+jmOIG9sCcY4nczOEcpI45MFPmI
         5qGeSGngo5S1LN2r3IHhjhzXA8e9ZUeYWMBLGpsG9mW7OQ6nQPl+AYR0diUIueSZjCfN
         wct17U6C8bewFW2nimw91FkLiS2IKKxHajw1iEjcjF6zwMgTsOvwBZevnoGCPaUVf/pH
         jrRvCYbXqV2CW5eVzye3S6YOsgAO7ZY1sPv9wSZo6kGprh7yLkSkmzq3KInbyHQVnHSY
         EcH7TDTnN7wurnFE8bBtbnghoE42YqKyzZBRzkgTZLW3HhJtiEu5BVdWqQui3qGRnSQr
         mzow==
X-Gm-Message-State: AOAM532aPALqeLGRtnXHF+VjQqYiQdXG8hfgCcFijm4RV67Xbd8KH2Pv
        kLQbz/i1fGIG1br6Bihy93k=
X-Google-Smtp-Source: ABdhPJxjk1Sp228tEBGNnm6jJLqzdkYXuLuQ3XUPPHsTMISElcknjzIthwkbM/aOpzptN9icZDPNJw==
X-Received: by 2002:a37:a548:: with SMTP id o69mr1584707qke.113.1600891613443;
        Wed, 23 Sep 2020 13:06:53 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id m97sm604091qte.55.2020.09.23.13.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 13:06:52 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, hch@lst.de,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 0/2] block/dm: add REQ_NOWAIT support for bio-based 
Date:   Wed, 23 Sep 2020 16:06:50 -0400
Message-Id: <20200923200652.11082-1-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

I got guilted into this by this Twitter exchange:
https://twitter.com/axboe/status/1308778488011337728

Started with this patchset from June and revised it:
https://patchwork.kernel.org/project/dm-devel/list/?series=297693
(dropped MD patch while doing so_.

Tested these changes with this test Jens provided:

[mikes-test-job]
filename=/dev/dm-0
rw=randread
buffered=1
ioengine=io_uring
iodepth=16
norandommap

Jens, please feel free to pickup both patches, I don't have any
conflicting DM changes for 5.10.

Thanks,
Mike

Konstantin Khlebnikov (1):
  dm: add support for REQ_NOWAIT and enable it for linear target

Mike Snitzer (1):
  block: add QUEUE_FLAG_NOWAIT

 block/blk-core.c              |  4 ++--
 drivers/md/dm-linear.c        |  5 +++--
 drivers/md/dm-table.c         | 32 ++++++++++++++++++++++++++++++++
 drivers/md/dm.c               |  4 +++-
 include/linux/blkdev.h        |  7 +++++--
 include/linux/device-mapper.h |  6 ++++++
 6 files changed, 51 insertions(+), 7 deletions(-)

-- 
2.15.0

