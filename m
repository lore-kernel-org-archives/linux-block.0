Return-Path: <SRS0=MX1A=5N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6769AC43331
	for <linux-block@archiver.kernel.org>; Sat, 28 Mar 2020 18:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4724B20717
	for <linux-block@archiver.kernel.org>; Sat, 28 Mar 2020 18:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgC1SW6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 Mar 2020 14:22:58 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:47014 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgC1SW6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Mar 2020 14:22:58 -0400
Received: by mail-pf1-f178.google.com with SMTP id q3so6260099pff.13
        for <linux-block@vger.kernel.org>; Sat, 28 Mar 2020 11:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RDFjenPnsAxFbB5ndvEVdorIwnWpF1fdqXVp8/5nTOA=;
        b=HyGpcKhKXHx5XsG/hK+xCwM3KZ5hSV4axWpFuEj18+V/Su1PI9Fw9raPQaXaUiK2nA
         8uj4spjFTcreQVm8vOquyW9RlI79aMhEotRVTbdSOWVHXqKareCAPJAMS6aqc70n1eZf
         VSTrrdJKs/dsRNr1Wl4TOw5rLz2EyM3S0pc+M2lVab04OukROhhoQFjhBT1sLqttNgG0
         p13WeaXb56E3QzkUt3V9JYWIyC9rv4b5aRgV77rD7EJ20fWCjH3bKcEKdQKLcasiDHnJ
         /OAstu3N11hJysEKfDSxy+L4nDv61hBWcVR1gITd30oF7WjmdYPVZa5KKPDo0ntYrsCa
         IaFQ==
X-Gm-Message-State: ANhLgQ2ExfTUQ2pC7pFRDiYp42fGiBsY0t65tqixUvHwld+Y72O35ldR
        HkWMIg2XIUN5h9HCwkYEwyg=
X-Google-Smtp-Source: ADFU+vsqQejfSDdP6meEsBqprL4kKees68dq7B9VUoqT9zea7Utfjj+qgPfJQHKgROnC3b5U2Jqoow==
X-Received: by 2002:a65:5a87:: with SMTP id c7mr5218928pgt.237.1585419777098;
        Sat, 28 Mar 2020 11:22:57 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:597d:a863:13de:4665])
        by smtp.gmail.com with ESMTPSA id e126sm6659179pfa.122.2020.03.28.11.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 11:22:56 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Daniel Wagner <dwagner@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests v4 0/4] Test the blk_mq_realloc_hw_ctxs() error path
Date:   Sat, 28 Mar 2020 11:22:47 -0700
Message-Id: <20200328182251.19945-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Omar,

Please consider this patch series for the official blktests repository.

Thanks,

Bart.

Changes compared to v3:
- Addressed Daniel Wagner's review comments.

Changes compared to v2:
- Addressed Omar's review comments.

Changes between v1 and v2:
- Added three patches that refactor null_blk loading, unloading and
  configuration (Chaitanya).

Bart Van Assche (4):
  Make _exit_null_blk remove all null_blk device instances
  Use _{init,exit}_null_blk instead of open-coding these functions
  Introduce the function _configure_null_blk()
  Add a test that triggers the blk_mq_realloc_hw_ctxs() error path

 common/multipath-over-rdma | 29 ++++++---------------
 common/null_blk            | 21 ++++++++++++++-
 tests/block/022            |  3 ---
 tests/block/029            | 17 ++-----------
 tests/block/030            | 52 ++++++++++++++++++++++++++++++++++++++
 tests/block/030.out        |  1 +
 tests/nvmeof-mp/rc         |  2 +-
 7 files changed, 84 insertions(+), 41 deletions(-)
 create mode 100755 tests/block/030
 create mode 100644 tests/block/030.out

