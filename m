Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E48C636C9
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 783EF613D4
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 20:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhGOVCX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 17:02:23 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:39712 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGOVCX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 17:02:23 -0400
Received: by mail-pf1-f182.google.com with SMTP id b12so6704730pfv.6;
        Thu, 15 Jul 2021 13:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BGmRoeKnP9PrlkLUiiQRhwCuDHfT0YXEUY07IbS+73o=;
        b=HFV3NG2S4yZD+LXx2weZ2dzZYAfSlMvVc646ddMXo7GMiNFyShvTVU8iUHyxyHXuUC
         Y+s5IrQOzBSbkFV6fL79xDh3DraGJ+i2WP1q/fHpdCBvU1NnMWJGiphWKyZQ0EkSiUbJ
         WKJBFAwsd8cURhNgNqNzLt6L5CmWI8QIbtOF03Uby4SeXakeCHLVmtLDWVA+gh+X00LE
         2nL2mHNeforj9p4DXIcb7HuBCXPDfPPMRX/fPv8GHMaqUaJtDXVTNlNgKs6vz26blWMS
         UkL7uC6WkThRtUCt5PM5uY1qqVdXJHWuRKX3wEIA2t71n9zVc45FMEHWMcpXifZBQ1uE
         CFnQ==
X-Gm-Message-State: AOAM532cCfFzSpmjjW7lhuuRbsM4Qu7kJeOmpQJR5i6ZBvPGKApKA3HG
        GqnXBedai9YXquG97E0rJyU=
X-Google-Smtp-Source: ABdhPJyTrsjeLhI1g18/7wadZ7pScXXmzp9ButbgQqjoJp/O5SpfywC1CumUO/E96cbO5wY+EKkXcg==
X-Received: by 2002:a65:62da:: with SMTP id m26mr6385654pgv.370.1626382768107;
        Thu, 15 Jul 2021 13:59:28 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id 20sm7726467pfi.170.2021.07.15.13.59.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 13:59:26 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 00/12] block: *add_disk*() driver conversions __register_blkdev()
Date:   Thu, 15 Jul 2021 13:59:08 -0700
Message-Id: <20210715205920.2023980-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is the 4th group of driver conversion examples. This set is
complete, as there are only a few drivers which use __register_blkdev().
The __register_blkdev() call uses an optional probe call, and if set
will be used when blk_request_module() is called for the block device.
Since these probe calls can fail, now that we added *add_disk*() error
handling, take advatage of this and extend the probe call to capture
the errors.

There are only a few drivers which benefit from this. The meat of the
work is the last patch, which includes all driver conversions. The rest
of the patches are adding add_disk() error handling in the other
places of the drivers.

Luis Chamberlain (12):
  floppy: fix add_disk() assumption on exit
  floppy: use blk_cleanup_disk()
  floppy: add error handling support for add_disk()
  scsi/sd: use blk_cleanup_queue() insted of put_disk()
  scsi/sd: add error handling support for add_disk()
  scsi/sr: use blk_cleanup_disk() instead of put_disk()
  scsi/sr: add error handling support for add_disk()
  block/ataflop: use the blk_cleanup_disk() helper
  block/ataflop: add a helper for removing disks
  block/ataflop add error handling support for add_disk()
  block/brd: add error handling support for add_disk()
  block: make probe in blk_request_module() return an error

 block/genhd.c           | 15 ++++++----
 drivers/block/ataflop.c | 66 ++++++++++++++++++++++++-----------------
 drivers/block/brd.c     | 17 ++++++++---
 drivers/block/floppy.c  | 48 ++++++++++++++----------------
 drivers/block/loop.c    |  6 ++--
 drivers/scsi/sd.c       | 11 +++++--
 drivers/scsi/sr.c       |  7 +++--
 fs/block_dev.c          |  5 +++-
 include/linux/genhd.h   |  4 +--
 9 files changed, 105 insertions(+), 74 deletions(-)

-- 
2.27.0

