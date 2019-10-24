Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0102CA9EAF
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 21:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73E021928
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 21:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbfJXVEC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Oct 2019 17:04:02 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:40914 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfJXVEC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Oct 2019 17:04:02 -0400
Received: by mail-pf1-f177.google.com with SMTP id x127so53560pfb.7
        for <linux-block@vger.kernel.org>; Thu, 24 Oct 2019 14:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wX1JyfE4mbsK6qrZyM8nGXOIyXlGbz+L0qlAykcLuns=;
        b=rrqxHdYjcVMaVqvtHlZbfm8f03tClKB/HYZ/3+KPrUl5GbPrv787wrMkcYd1IP2Txc
         bVURcLukvHbJSr7kHbn8nv+basEFOF0nMOX30WSdq/O+mJ7H5MStU4I4mL20LB0XWexx
         ZzlsZLNkCCvIf6KaVNrz6e3OCzmB+leCApAe09M8U1xPsRzG2LECurSIG4wtbcEXVPrI
         Gdigv5azIQvIdaaNLAki6jPG7LgN4d+hjMx7EJ1jQyHY4nmOufqWRHI+8Kxs0mOX3SGy
         a+1zFu22GbAvmXMVCdx2Jl6McX9JWzeDACCZBPUUDbKuJPXHS6oqb4Xi0CvT0Yh2Biwz
         VDFA==
X-Gm-Message-State: APjAAAUioAAswq2DdsXEPry2P2ruHcFXP21y44dxJrJo/FgwH8aqgFD5
        mTDC6tjg/C1TMWlw+XQ4xpg=
X-Google-Smtp-Source: APXvYqwJE/omL+ehwMV+EF9xlxWehl9CCb6GjtgktvAOPxE8yoDSGOSTUDC0tqGhGUhcEgSLOeJjGQ==
X-Received: by 2002:a17:90a:741:: with SMTP id s1mr9813176pje.113.1571951039482;
        Thu, 24 Oct 2019 14:03:59 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id i22sm28270127pgg.20.2019.10.24.14.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 14:03:58 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests v2 0/2] Add a test that triggers blk_mq_update_nr_hw_queues()
Date:   Thu, 24 Oct 2019 14:03:50 -0700
Message-Id: <20191024210352.71080-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Omar,

This patch series includes the test that I used to verify my recently posted
blk_mq_update_nr_hw_queues() patches. Please consider these patches for
inclusion in the blktests repository.

Thanks,

Bart.

Changes compared to v1:
- _uptime_s() now uses awk to read /proc/uptime.
- Removed subshells from tests/block/029.
- Changed find ... | wc -l into nproc.
- Skip kernel versions that do not support modifying the null_blk submit_queues
  attribute.

Bart Van Assche (2):
  Move and rename uptime_s()
  Add a test that triggers blk_mq_update_nr_hw_queues()

 common/multipath-over-rdma |  9 +-----
 common/rc                  |  5 +++
 tests/block/029            | 64 ++++++++++++++++++++++++++++++++++++++
 tests/block/029.out        |  1 +
 tests/nvmeof-mp/rc         |  2 +-
 tests/srp/014              |  2 +-
 tests/srp/rc               |  2 +-
 7 files changed, 74 insertions(+), 11 deletions(-)
 create mode 100755 tests/block/029
 create mode 100644 tests/block/029.out
