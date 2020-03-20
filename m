Return-Path: <SRS0=+z0d=5F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC98C4332D
	for <linux-block@archiver.kernel.org>; Fri, 20 Mar 2020 22:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3071020724
	for <linux-block@archiver.kernel.org>; Fri, 20 Mar 2020 22:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgCTWYX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Mar 2020 18:24:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37438 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgCTWYX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Mar 2020 18:24:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id a32so3775864pga.4
        for <linux-block@vger.kernel.org>; Fri, 20 Mar 2020 15:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EHXt022wAC+DKNrnSALL4TsiA912CS4MBsEr3zBAlc4=;
        b=choAACy3reeY3KQoF8Wpyq04KKqeZJo/zMnT2CeLw877Cyl4VqCzCaIiaw43jKVmkx
         3p3X+TgTvz6a7LyJev2FqPco3n2sbwEvpkAArnCYpZR7hcsgxUphvwGBY2WE3Fem6HRy
         isXN09mJjlAV4kE0N3Fk5Aoc2cAqhY8cOeudS1n7C0rjRcHKbTrhNFrm5FzJWqGfc/lV
         /QYFmzviPYLX7HvGAPFs709sBbpBWhcLuD7NVVGi7w+QEHSn62XN4IV2Vehn3xXuaXwA
         4qr0I7lOETIX4578q/a+Z6eVlVAuvFUJz6kdZuLe9O14lOCYXGL2ywJQjQkvTaFjPfpX
         42Ow==
X-Gm-Message-State: ANhLgQ2FfsMLq/XilAY0o3QP6kxEjAV0Eay5GSp1+U/vSNGdHZT8gLGp
        cYiyJtx53reQBF2Wt55DTfz7xhTRny0=
X-Google-Smtp-Source: ADFU+vt4XeE6EMur7n+VHPiLRhRVupyL0Ecj59S2D3vDOFiOIr8fx2FgDTEFHPMJAUcZSD6KxrJLcQ==
X-Received: by 2002:aa7:8806:: with SMTP id c6mr11374348pfo.175.1584743060315;
        Fri, 20 Mar 2020 15:24:20 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:c142:5d77:5a3f:9429])
        by smtp.gmail.com with ESMTPSA id z20sm6050530pge.62.2020.03.20.15.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 15:24:19 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests v3 0/4] Add a test that triggers the blk_mq_realloc_hw_ctxs() error path
Date:   Fri, 20 Mar 2020 15:24:09 -0700
Message-Id: <20200320222413.24386-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Omar,

Please consider this patch series for the upstream blktests repository.

Thanks,

Bart.

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

 common/multipath-over-rdma | 29 ++++++++------------------
 common/null_blk            | 21 ++++++++++++++++++-
 tests/block/022            |  3 ---
 tests/block/029            | 17 ++-------------
 tests/block/030            | 42 ++++++++++++++++++++++++++++++++++++++
 tests/block/030.out        |  1 +
 tests/nvmeof-mp/rc         |  2 +-
 7 files changed, 74 insertions(+), 41 deletions(-)
 create mode 100755 tests/block/030
 create mode 100644 tests/block/030.out

