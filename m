Return-Path: <SRS0=kddI=WE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF147C433FF
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 20:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A3321743
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 20:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389974AbfHHUFQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:05:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42135 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732704AbfHHUFP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Aug 2019 16:05:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so44606390pgb.9
        for <linux-block@vger.kernel.org>; Thu, 08 Aug 2019 13:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q33UV+kyAkfwjtWCI6GSA1j4rOL/y9CvPBxJLJxZjEs=;
        b=NiXHYWAduV5zrcHKenEwVQFYRs83SNEsliPY6PO6+83xdLl+6DMxtLbJ7tqCZJ5Yli
         tMG1gtqoQSvKjiQfYXScoIwg4ujJTey2hc/Ly+7AaYvgIplwkaLkNCf5DtBkTrgchMiE
         rPYgykiKcQcYd61WvDPThg6SaX0P4gOTwdn87HSll3GdY25Jjxw+M8FtSkR8DvZ4E/uv
         826KSBvsAfeYaX794fgztGLViLgfuTt9sLeTscILWaWa26XhJmfGt0X09Gg3YqTqjdoV
         z4BsB/wxzkrbfqWpcJSeo1Mb8hd9qwymlVWMw/BlCdFWP65bAkFJPJEUWrZK0o5YWw9n
         IKTA==
X-Gm-Message-State: APjAAAX+cw5rz2GUO/cQ0a66JtmQuG9v8Bzv1+0RdBd44hcFLQRAxL1t
        Z/O9R8aR21kDR2Ck8rwZk2wIkO5u
X-Google-Smtp-Source: APXvYqzUBIQaEUnUQMH6YbZOrPo8TfNC4qh4S2xVnEYxUby8QJNRAAhnK1xelVPq/Fh327yzXAzaMg==
X-Received: by 2002:a17:90a:d983:: with SMTP id d3mr5724376pjv.88.1565294714757;
        Thu, 08 Aug 2019 13:05:14 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id b6sm83307093pgq.26.2019.08.08.13.05.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 13:05:13 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests 0/4] Four blktests patches
Date:   Thu,  8 Aug 2019 13:05:02 -0700
Message-Id: <20190808200506.186137-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Omar,

This series includes one improvement for the NVMe tests, two improvements for
the NVMeOF-multipath tests and version two of the SRP test that triggers a SCSI
reset while I/O is ongoing. Please consider these for the official blktests
git repository.

Thanks,

Bart.

Bart Van Assche (4):
  tests/nvme/rc: Modify the approach for disabling and re-enabling
    Ctrl-C
  tests/nvmeof-mp/rc: Make simulate_network_failure_loop() more robust
  tests/nvmeof-mp/rc: Make the NVMeOF multipath tests more reliable
  tests/srp/014: Add a test that triggers a SCSI reset while I/O is
    ongoing

 tests/nvme/rc      |   4 +-
 tests/nvmeof-mp/rc |   7 +--
 tests/srp/014      | 107 +++++++++++++++++++++++++++++++++++++++++++++
 tests/srp/014.out  |   2 +
 4 files changed, 115 insertions(+), 5 deletions(-)
 create mode 100755 tests/srp/014
 create mode 100644 tests/srp/014.out

-- 
2.22.0.770.g0f2c4a37fd-goog

