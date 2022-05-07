Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB925C433FE
	for <linux-block@archiver.kernel.org>; Sat,  7 May 2022 02:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348537AbiEGCOo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 May 2022 22:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356890AbiEGCOn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 May 2022 22:14:43 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBD85D5E5
        for <linux-block@vger.kernel.org>; Fri,  6 May 2022 19:10:59 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id e5so7468935pgc.5
        for <linux-block@vger.kernel.org>; Fri, 06 May 2022 19:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=4gOUiw5uQxUeOp2fX0fTYX1gJsz8NeIQ4cZ12I3BaOc=;
        b=74K8/WcX21yZKre/WRJ6g72xA49qIaoNpuMo1klv6oQEGu2j3fB7XEQvKThEUfniN1
         ubsUjpzUugwd9IBhJ+DDTtK43BMfS3CA0ymHDqTooM4GYb0GMiifC6SOt7+C2mZcSRsO
         iC/jrGmz/IMKQheGClAHOrW5T/FW692bF0J84v8BuQPKNdURIuBjvo2t4L3CNGhOyJA1
         XB9L0ouRkzQaZvLUFrYwO5gOnRr2SMG2COYUGI09830PagQfbgpIu0KCp76MS8VSWnrJ
         QGvp1WjtQ9yxItxcOjsskyPqeFYqCmdEfXr4sF/y5Ocu3xYAa5df0RIQHCK4omfKx8uY
         Xj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=4gOUiw5uQxUeOp2fX0fTYX1gJsz8NeIQ4cZ12I3BaOc=;
        b=1Z0ShZD3lVWf9GGnB3VDfln1MpjMVqKyNDiv8OSiz3du05QsyL7k4e2plEyg7YLTFa
         +VzpyXFD6jtX+ylJrLNaQNN/nS04GbUsAUjgeS8r5OBYfCooyLs70JDZEbtd+n4Beks1
         czmumz3SFhMLn2AdqfXOz5vj0gemr4xz4xmyakg1ayWC/+EveCQIkX3M4XtuxHnucskI
         P1x1cfpv7aILs9w+B/xKiwzDM4xHz5V3lkL820r2XbZ5iz2J4ImcCLzfS6eJYVxubwAO
         fpoMCHGzrYLP8LHLNA5OJeTFB2PG2ivZz542677YL0yyFAE8V1tvyfbjMoiJXeidLn2H
         Qq6Q==
X-Gm-Message-State: AOAM530UNAXpRdZ9+iOlVPr7N+iQ0FKE4/+yaYgkSSHCHFalaWB7aAZS
        Mmt3XDgFcoRj7WHySIb1UEaDmbgPyEzR/Q==
X-Google-Smtp-Source: ABdhPJwv5HWeC0MazIbUWT8tK7JpG4LStC/zh9JJ4OdY/zdBMKy9FUkYtrbUOU1J4S4XMncFDJNGdg==
X-Received: by 2002:a63:e51:0:b0:3a4:9d22:1fd5 with SMTP id 17-20020a630e51000000b003a49d221fd5mr5181433pgo.586.1651889458760;
        Fri, 06 May 2022 19:10:58 -0700 (PDT)
Received: from [192.168.4.166] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id n23-20020a17090a929700b001d7f3bb11d7sm8008464pjo.53.2022.05.06.19.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 19:10:58 -0700 (PDT)
Message-ID: <c9ef8d83-8f8e-0b03-b197-bd6d6105059a@kernel.dk>
Date:   Fri, 6 May 2022 20:10:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.18-rc6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Single revert for a change that isn't needed in 5.18, and a small series
for s390/dasd. Please pull!


The following changes since commit 09df6a75fffa68169c5ef9bef990cd7ba94f3eef:

  bfq: Fix warning in bfqq_request_over_limit() (2022-04-29 06:45:37 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.18-2022-05-06

for you to fetch changes up to f1c8781ac9d87650ccf45a354c0bbfa3f9230371:

  s390/dasd: Use kzalloc instead of kmalloc/memset (2022-05-05 20:08:27 -0600)

----------------------------------------------------------------
block-5.18-2022-05-06

----------------------------------------------------------------
Haowen Bai (1):
      s390/dasd: Use kzalloc instead of kmalloc/memset

Jan Höppner (2):
      s390/dasd: Fix read for ESE with blksize < 4k
      s390/dasd: Fix read inconsistency for ESE DASD devices

Ming Lei (1):
      Revert "block: release rq qos structures for queue without disk"

Stefan Haberland (2):
      s390/dasd: fix data corruption for ESE devices
      s390/dasd: prevent double format of tracks for ESE devices

 block/blk-core.c               |  4 ----
 drivers/s390/block/dasd.c      | 18 +++++++++++++++---
 drivers/s390/block/dasd_eckd.c | 33 ++++++++++++++++++++++-----------
 drivers/s390/block/dasd_int.h  | 14 ++++++++++++++
 4 files changed, 51 insertions(+), 18 deletions(-)

-- 
Jens Axboe

