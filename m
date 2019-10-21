Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFE3CA9EAF
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 22:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5870E20B7C
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 22:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbfJUW53 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Oct 2019 18:57:29 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:42348 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730350AbfJUW53 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 18:57:29 -0400
Received: by mail-pl1-f182.google.com with SMTP id c16so3623196plz.9
        for <linux-block@vger.kernel.org>; Mon, 21 Oct 2019 15:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5aXr3jQgX2MpSk6ZWDHNxus1OCT/PIWi9AKr3afTCps=;
        b=GaQomgZxjTrAHNEgxBjq6iRPkyGm71p3pGOCbsEOGvQiTYXbMMfOyiB2hDO+pDIdC6
         PMtuzvwXGU8wLSbCIxfs5kg6HrlGGvZ9uft7BVV3yuQ/JGgPKPrG8ASSiTN9qPcnUTLR
         8oTGgMLbkzWtrA97ya32QULY0+Xn/w19CmXMTp+J/HwNyBuSnHg6Nkl4qATx0vYg42IU
         r2Uomj1pLD/LZSSdHIX4mcfjk6H4D/ZwtJBudBi9dLlmMZzPfIf6h3h8Hrgpc7sXU4Mr
         dBBWYUEcpXpSycruDz9mC4ii0HG6+AOEPUoPKDhp6+XJA5UldRXQNIQvHbVmL49V80M6
         SitA==
X-Gm-Message-State: APjAAAU8ivSweMKG2kOKYn96Try1bZ/FwP3tf+4JbnW4xi6WQlQA++1p
        QnmPq69hjCUMtKXJ3zj1ZfD2aIc84BQ=
X-Google-Smtp-Source: APXvYqxaOlCe63Xb6fG74RVD9/3oyRIqmouGcJKcsykq8w1i53DrscX2cpA4pLrkNgy+9bMzEh8ygA==
X-Received: by 2002:a17:902:7c03:: with SMTP id x3mr402234pll.171.1571698648627;
        Mon, 21 Oct 2019 15:57:28 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id x70sm255474pfd.132.2019.10.21.15.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 15:57:27 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests 0/2] Add a test that triggers blk_mq_update_nr_hw_queues()
Date:   Mon, 21 Oct 2019 15:57:17 -0700
Message-Id: <20191021225719.211651-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
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

Bart Van Assche (2):
  Move and rename uptime_s()
  Add a test that triggers blk_mq_update_nr_hw_queues()

 common/multipath-over-rdma |  9 +-----
 common/rc                  |  9 ++++++
 tests/block/029            | 63 ++++++++++++++++++++++++++++++++++++++
 tests/block/029.out        |  1 +
 tests/nvmeof-mp/rc         |  2 +-
 tests/srp/014              |  2 +-
 tests/srp/rc               |  2 +-
 7 files changed, 77 insertions(+), 11 deletions(-)
 create mode 100755 tests/block/029
 create mode 100644 tests/block/029.out
