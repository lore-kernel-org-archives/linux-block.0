Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C288EEB64DD
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 00:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjGZA5t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jul 2023 20:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjGZA5t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jul 2023 20:57:49 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2CEBC
        for <linux-block@vger.kernel.org>; Tue, 25 Jul 2023 17:57:48 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-668704a5b5bso5715709b3a.0
        for <linux-block@vger.kernel.org>; Tue, 25 Jul 2023 17:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690333067; x=1690937867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KoAI0+yJn1bZO4OLBFOtxcRzcvl5h1y9fY2a1p+jQBA=;
        b=gEIInZeGRcwfDhjGNxH6kYxEqYyDsGjW5O7Fm3RfhjpFlpeORPDFfLEOohiJCxWxW9
         T9EbFGWIDSMar9G6i8IHq7IM/2ZI/nD+lRfsFjl+nPQft8blaQJ34u4r1+cUnETcjVjq
         jK/K2Xdy+tHtq9LcplD6ai8fGyKeSsVWoHbGoT5LtNrAm/DS/aekWys9x7MXAFRpNF77
         dTSZFAkxWh7m3YlWetWHuvYnO/zuWUmm1+c16EBYVDZga/mBY0nx655Vyl+JWDicoDeF
         xDe1tyjpl60kktNFBHp+CD2iu7vS1a3mSQNXRUDNy2YWVBVXR/WQq1ATLg76uQIU6E5H
         dI6A==
X-Gm-Message-State: ABy/qLa0xEHx+KdIx8IPcMrlbE2AkkQn/mn4TaMooUJHNEwLkfFMd4YJ
        lILt50QSUkz6z97Ld3gLFQk=
X-Google-Smtp-Source: APBJJlGaPEpbLBDQX6x9T8hHdDvd2oxmGlLFPPorNf6SqhsGOLCDG0nc7xNW/a0UIqPydbpWpy0mwg==
X-Received: by 2002:a05:6a21:71cb:b0:105:6d0e:c046 with SMTP id ay11-20020a056a2171cb00b001056d0ec046mr835918pzc.26.1690333067342;
        Tue, 25 Jul 2023 17:57:47 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([2601:642:4c05:4a8d:dbda:6b13:2798:9795])
        by smtp.gmail.com with ESMTPSA id t10-20020a63954a000000b005634bd81331sm11090138pgn.72.2023.07.25.17.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 17:57:46 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 0/6] Improve the performance of F2FS on zoned UFS
Date:   Tue, 25 Jul 2023 17:57:24 -0700
Message-ID: <20230726005742.303865-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This patch series improves write performance for zoned UFS devices. Please
consider these patches for the next merge window.

Thank you,

Bart.

Changes compared to v2:
 - Renamed the request queue flag for disabling zone write locking.
 - Introduced a new request flag for disabling zone write locking.
 - Modified the mq-deadline scheduler such that zone write locking is only
   disabled if both flags are set.
 - Added an F2FS patch that sets the request flag for disabling zone write
   locking.
 - Only disable zone write locking in the UFS driver if auto-hibernation is
   disabled.

Changes compared to v1:
 - Left out the patches that are already upstream.
 - Switched the approach in patch "scsi: Retry unaligned zoned writes" from
   retrying immediately to sending unaligned write commands to the SCSI error
   handler.

Bart Van Assche (5):
  block: Introduce a request queue flag for pipelining zoned writes
  block/mq-deadline: Only use zone locking if necessary
  block/null_blk: Add support for pipelining zoned writes
  scsi: Retry unaligned zoned writes
  scsi: ufs: Enable zoned write pipelining

Bart Van Assche (6):
  block: Introduce the flag REQ_NO_WRITE_LOCK
  block/mq-deadline: Only use zone locking if necessary
  block/null_blk: Support disabling zone write locking
  scsi: Retry unaligned zoned writes
  scsi: ufs: Disable zone write locking
  fs/f2fs: Disable zone write locking

 block/blk-flush.c                 |  3 ++-
 block/mq-deadline.c               | 28 ++++++++++++++-----
 drivers/block/null_blk/main.c     |  2 ++
 drivers/block/null_blk/null_blk.h |  1 +
 drivers/block/null_blk/zoned.c    |  3 +++
 drivers/scsi/scsi_error.c         | 37 +++++++++++++++++++++++++
 drivers/scsi/scsi_lib.c           |  1 +
 drivers/scsi/sd.c                 |  3 +++
 drivers/ufs/core/ufshcd.c         | 45 ++++++++++++++++++++++++++++---
 fs/f2fs/data.c                    |  1 +
 include/linux/blk_types.h         |  8 ++++++
 include/scsi/scsi.h               |  1 +
 12 files changed, 123 insertions(+), 10 deletions(-)

