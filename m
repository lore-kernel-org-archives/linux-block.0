Return-Path: <SRS0=XUQF=5A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347FDC10DCE
	for <linux-block@archiver.kernel.org>; Sun, 15 Mar 2020 22:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C4F20674
	for <linux-block@archiver.kernel.org>; Sun, 15 Mar 2020 22:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbgCOWN2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Mar 2020 18:13:28 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:35815 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbgCOWN2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Mar 2020 18:13:28 -0400
Received: by mail-pl1-f179.google.com with SMTP id g6so7053422plt.2
        for <linux-block@vger.kernel.org>; Sun, 15 Mar 2020 15:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P80wRltRqG6LplwZKmF5QUEUV9hDVHBpMbVjKF9/ubo=;
        b=NUpBzMaZ4YmpQGs6vohzatGJ+3pya16LaqXNSRtwN2aXlBRSbNwPoEhsYkIDi3sY7I
         ZWF99j8vl9J6PSRjV4J7amf0wnLY6AgP7WS7cdpIkDdg4XKQ1wTNdYmDNSxVlgBJBzPv
         jefVrqOwbb2/dzrxuwstEHao2p6eW5F9+qt9nmFXo8iiyXNThQYSdnKCVX5Vpcqpi4cy
         +yu30V/Wz2NBx9C92QCWCYASryCSDLbiaQJvImdan1DTdTghc5dCoGsquOT2WpWFSLYP
         cCsdFc4WfuvXVC1ZF0NVLUDEbIXgAsxykMHHpqUXTSr+0F+FT4phnnH3N6rgKkP1Tnko
         oJMQ==
X-Gm-Message-State: ANhLgQ3uuLGhkmyUd0njz4DRgiFnd8hotdfMpRezlY1Fe0S1vkd49FOX
        mWeFho5+TUdVNzb7uNlRaU4=
X-Google-Smtp-Source: ADFU+vtNEdb5UVOqq8DDRrWlZXSQMcTPdkcOKxaKo4XxXaiSFkqSJ+/AI7QMlk3Mwqkii6lmqsu3lw==
X-Received: by 2002:a17:90a:326f:: with SMTP id k102mr21866862pjb.48.1584310406554;
        Sun, 15 Mar 2020 15:13:26 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:dc50:2da4:5bd2:69ab])
        by smtp.gmail.com with ESMTPSA id d1sm39192976pfn.51.2020.03.15.15.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 15:13:25 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests v2 0/4] Add a test that triggers the blk_mq_realloc_hw_ctxs() error path
Date:   Sun, 15 Mar 2020 15:13:16 -0700
Message-Id: <20200315221320.613-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Omar,

Please consider this patch series for the upstream blktests repository.

Compared to v1, three patches have been added that refactor null_blk
loading, unloading and configuration.

Thanks,

Bart.

Bart Van Assche (4):
  Make _exit_null_blk remove all null_blk device instances
  Use _{init,exit}_null_blk instead of open-coding these functions
  Introduce the function _configure_null_blk()
  Add a test that triggers the blk_mq_realloc_hw_ctxs() error path

 common/multipath-over-rdma | 29 ++++++++------------------
 common/null_blk            | 26 +++++++++++++++++++----
 tests/block/022            |  3 ---
 tests/block/029            | 17 ++-------------
 tests/block/030            | 42 ++++++++++++++++++++++++++++++++++++++
 tests/block/030.out        |  1 +
 tests/nvmeof-mp/rc         |  2 +-
 7 files changed, 76 insertions(+), 44 deletions(-)
 create mode 100755 tests/block/030
 create mode 100644 tests/block/030.out

