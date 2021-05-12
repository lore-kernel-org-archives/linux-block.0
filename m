Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49923C43460
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 07:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 354826192B
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 07:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhELHDV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 03:03:21 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:44642 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhELHDP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 03:03:15 -0400
Received: by mail-pj1-f48.google.com with SMTP id lj11-20020a17090b344bb029015bc3073608so2780094pjb.3
        for <linux-block@vger.kernel.org>; Wed, 12 May 2021 00:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tX2/HIactIt7NjJSfm6Bq6JyF+8TGI+Z7Qcq3Vw2vvQ=;
        b=A+E4P+kI6i7ATZ0OEOqTbrweXxAlb0B/MW1AqCV3M+WyUInVz2zLiEjxIpjmb5wT8p
         0brtDo7JbdOLV9NkLeItwJpj5TcgmWhqOvXR6ygWLmiB14a5mnrBzCXFngcA0AiTu0EB
         nAyL+1qKw/2wy8ZgrOaPJImou70YRyY0kLre/qzygJQk2F9PzPhSbGpYena832B1zrN+
         9bn0ZBO2DcGXzUgmpTTJY9LxxmkZY5GNJkMW8r2eaBXzxnCHJmk1SNF+espoa+AxbOMy
         Hui4/ihZYgRTdLnHYLkymNsdzvHbSsj4wH9QRuiiLD+RHka+Yas+GbR8bG1ZiZtcWC/H
         LjeA==
X-Gm-Message-State: AOAM533c03KlNG915+v36KA7LqHC7C+GTg421S1SqVUlxDZH6ID1EQgR
        apLq+fy/TbrzVeKXTrcl0oY=
X-Google-Smtp-Source: ABdhPJxQ5tuvFh24jFY8ukJdFYrb4nf6N4blRBraw2SHNhZAF8j5yGAJOvafvUx7XGsZztGVeGRjnQ==
X-Received: by 2002:a17:90b:310b:: with SMTP id gc11mr38152951pjb.118.1620802927731;
        Wed, 12 May 2021 00:02:07 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 204sm15355085pfw.158.2021.05.12.00.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 00:02:03 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id A2344418C0; Wed, 12 May 2021 06:14:24 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     osandov@fb.com, linux-block@vger.kernel.org
Cc:     bvanassche@acm.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 0/2] blktests: add add_disk() error handling testing
Date:   Wed, 12 May 2021 06:14:18 +0000
Message-Id: <20210512061420.13611-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This adds the tests for testing error handling on the add_disk() paths.

Luis Chamberlain (2):
  null_blk: add ability to use a quiet modprobe
  block: add add_disk() error handling tests

 common/null_blk     |   8 ++-
 tests/block/013     | 156 ++++++++++++++++++++++++++++++++++++++++++++
 tests/block/013.out |   4 +-
 3 files changed, 164 insertions(+), 4 deletions(-)
 create mode 100755 tests/block/013

-- 
2.30.2

