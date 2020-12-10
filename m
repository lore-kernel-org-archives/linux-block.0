Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD8EC433FE
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 10:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 967CD23AC4
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 10:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgLJKTQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 05:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgLJKTJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 05:19:09 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359CAC0613D6
        for <linux-block@vger.kernel.org>; Thu, 10 Dec 2020 02:18:29 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id v22so4879171edt.9
        for <linux-block@vger.kernel.org>; Thu, 10 Dec 2020 02:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dthc2x5czv7Omf8LNqaI7gJTMFrZ7BUMJazoTpUaa1w=;
        b=WoAwdE6xVsnbsPuZ0t6piagBiojf7yIHyT35Q/hFX41G/fx5i2zxCmdiK/aIZc+faN
         dP95pJOE6ND5FLteKuucKvHYp+3j/1mwvAH9yVzY8EBV8kAZMt+Q78PWsMWC6boBuc76
         0QzC4IWwUnL7aamKSnXECyCSoghzmmh/rK99ytwGx30R+hv3Q/8mwHF8lcwKKWx9c1xx
         QQwZ3eORrbZkiunUIxKYuSGBoxPyPGet/ZceUnlx2JGDvv6MVLZvIro5xmrX/hBAlxkt
         0CXHZhsTRquLWlaens8TIASIDc05rbsf0xiR3RkO42EGSPm45v+Y4pDMIzTrFjv3Vwre
         XNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dthc2x5czv7Omf8LNqaI7gJTMFrZ7BUMJazoTpUaa1w=;
        b=P3Kq+7JqrmcmsSDkKtBrkD52WndzQCYmrSJsCnwIbLiXqUalc6E+Ubem2o5NFHkRJT
         YTVHxCKEgx+MoZoJXINoRdcMVmATPw1q2ZzSL2ZZWnvFZS4RR+kkEjn78gD2/NtcDw6A
         Fsr+Z7g3RcPnlRzvsl7ezfQVkPDCa2sIhRkjEA4jkjO/8zoT1QnpFUSvF0a/k6IuBMT7
         y8KfLqmvzmHLJ6ERxEOG5eYN2yYBrLLwdxsTeUOWEMokfsFCvndUZIOT2qizKCxU+d3D
         kfmh9xhMWxjUcDrA3zkqx/xCDtFyE+fsz8zlpgwIRqhagPRqbmkLTFMKFxUd9n/niTh5
         KWIQ==
X-Gm-Message-State: AOAM532dvlEqMcRxpO5KaDqXbmCC4k5lPlsp0YtlCovWUOIlHOVqAkFD
        cW2ZAnXphBdEsI1SbvsAZ7M1h8PkillCzQ==
X-Google-Smtp-Source: ABdhPJx2jdRLfBye6+O6vKZDe3A7mTuOPcnKVcamLj1w5hBsWx2fZUA1atNlggtOyyLkFOnoOzNUQg==
X-Received: by 2002:a50:e688:: with SMTP id z8mr6156322edm.129.1607595507734;
        Thu, 10 Dec 2020 02:18:27 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4938:300:58f0:963a:32b2:ff05])
        by smtp.gmail.com with ESMTPSA id s24sm3955878ejb.20.2020.12.10.02.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 02:18:27 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, danil.kipnis@cloud.ionos.com
Subject: [PATCHv2 for-next 0/7] Misc update for rnbd
Date:   Thu, 10 Dec 2020 11:18:19 +0100
Message-Id: <20201210101826.29656-1-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This is the misc update for rnbd. It inlcudes:
- 2 follow-up fixes for commit 64e8a6ece1a5 ("block/rnbd-clt: Dynamically alloc buffer for pathname & blk_symlink_name")
  one warning, and one possible memleak.
- one fix for race with dev session sysfs removal.
- fix for write-back cache & FUA.
- reduce memory footprint by allocate sglist on demand and do not request pdu
  from rtrs-clt.
- Typo fix.

change since v1:
- use kstrdup as Bart suggested.
- fix return code and leaking iu in block/rnbd-clt: Dynamically allocate sglist for rnbd_iu

v1: https://lore.kernel.org/linux-block/20201209082051.12306-1-jinpu.wang@cloud.ionos.com/T/#md330070d0688bbc57325ce0a6b2181f39dca495c

The patches are based on block/for-next.

Gioh Kim (3):
  block/rnbd: Set write-back cache and fua same to the target device
  block/rnbd-clt: Dynamically allocate sglist for rnbd_iu
  block/rnbd-clt: Does not request pdu to rtrs-clt

Jack Wang (2):
  block/rnbd-clt: Fix possible memleak
  block/rnbd: Fix typos

Md Haris Iqbal (2):
  block/rnbd-clt: Get rid of warning regarding size argument in strlcpy
  block/rnbd-srv: Protect dev session sysfs removal

 drivers/block/rnbd/rnbd-clt-sysfs.c    |  5 +-
 drivers/block/rnbd/rnbd-clt.c          | 94 +++++++++++++++-----------
 drivers/block/rnbd/rnbd-clt.h          | 12 +++-
 drivers/block/rnbd/rnbd-proto.h        |  9 ++-
 drivers/block/rnbd/rnbd-srv.c          | 12 +++-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c |  6 --
 drivers/infiniband/ulp/rtrs/rtrs.h     |  7 --
 7 files changed, 87 insertions(+), 58 deletions(-)

-- 
2.25.1

