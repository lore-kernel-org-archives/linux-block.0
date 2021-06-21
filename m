Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DE7C4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 23:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 373CF61245
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 23:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhFUXcq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 19:32:46 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:33438 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbhFUXcq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 19:32:46 -0400
Received: by mail-pg1-f182.google.com with SMTP id e20so15452608pgg.0;
        Mon, 21 Jun 2021 16:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GrMPD8Q/N3dXfJ5cKEITmI3LLNMjso9lYG7XVTDPL9g=;
        b=sP4cgqgWwsWU4sEGOCdT96zZmcCiMp5+TtI2yBs/IME2ZDvSsEA9lvPja5I0hsGTLN
         b6uCNnDCrM+e8cj6JZTr9bf7lUjH63yd0G5PTV3J/j0ED233yQAw7wg/CxuGtX7CT+M5
         vDaEh0jTY94ydcmF2dBRJq7Z8Xb9ouQ6trIABlg3i9Gt5CsEugzBtH21IWeJT7yGXPFv
         zfdtFyQTm+cp+4Zr+zhfdqT9YljNvjpAikFATnkExmgo07qTMQqBdIpXjiZxbPpnhJTj
         XBCeDFZMEQn1MaqBqoHbVE2Z5P8l0tWpflv8Y1X+Whl3+zhegdmhuYmPgT4Bw+k2emAR
         z3gw==
X-Gm-Message-State: AOAM531VAYEVSIzcCndo9JFXYyMby+FW+D/v4l0Rr98S3RfpRLDVWRWW
        OfjUkL/tc8NMIc0Av2iNYo8=
X-Google-Smtp-Source: ABdhPJzTFvEUMxNJ8Q96FLYGL45LpBqAZ/xRXBF7ssJPlgsoSrFzzZmLIai2l4mBmUuiJi9pX2BlUg==
X-Received: by 2002:a63:2fc4:: with SMTP id v187mr881795pgv.59.1624318230604;
        Mon, 21 Jun 2021 16:30:30 -0700 (PDT)
Received: from localhost ([173.239.198.97])
        by smtp.gmail.com with ESMTPSA id y1sm4991356pgr.70.2021.06.21.16.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 16:30:29 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     minchan@kernel.org, gregkh@linuxfoundation.org, jeyu@kernel.org,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com
Cc:     mcgrof@kernel.org, axboe@kernel.dk, mbenes@suse.com,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        jikos@kernel.org, rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] zram: fix few sysfs races
Date:   Mon, 21 Jun 2021 16:30:10 -0700
Message-Id: <20210621233013.562641-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This v3 changes the approach for the deadlock fix with wrappers which
provide the same solution of the try_module_get(). This is less code,
should be easier to review.

The last patch is also new. I dropped the bdget() stuff for the block
device and instead am doing a direct kobject fetch as well as a bus get to
provide a more generic solution without having to require each type to
implement its own refcounts.

This series also available on my linux-next repository:

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20210427-sysfs-fix-races-v5

Luis Chamberlain (3):
  zram: fix crashes due to use of cpu hotplug multistate
  zram: fix deadlock with sysfs attribute usage and driver removal
  drivers/base/core: refcount kobject and bus on device attribute read /
    store

 drivers/base/base.h           |   2 +
 drivers/base/bus.c            |   4 +-
 drivers/base/core.c           |  42 +++++++++-
 drivers/block/zram/zram_drv.c | 141 ++++++++++++++++++++++++----------
 drivers/block/zram/zram_drv.h |  40 ++++++++++
 5 files changed, 181 insertions(+), 48 deletions(-)

-- 
2.30.2

