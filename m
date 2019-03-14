Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D22C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 20:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDC620854
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 20:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="aMyahQx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfCNUok (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:44:40 -0400
Received: from mail-it1-f177.google.com ([209.85.166.177]:40664 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfCNUok (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 16:44:40 -0400
Received: by mail-it1-f177.google.com with SMTP id l139so7322742ita.5
        for <linux-block@vger.kernel.org>; Thu, 14 Mar 2019 13:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=do0PAfp8FItvZFX0sahV1VSfZjDfkuSope8xU3dAOoA=;
        b=aMyahQx4t5tQsq6wBSJfVUqsrgLICUJVBbfWCfRdirOz52Eb6X4rKIsqLDkiO+G1+G
         ev6UqibBWclbwdKNgviNob3nPVImzblExCOKaRMAB93OKaEpTDHejxekQXd0D4ToWix7
         1H2qGWhfo3CQnOZpTHOAcpN4xnP6DPh+3z6f/33wpk0mispxcnCa/BgoF9Hgl9AogsFd
         RMB4Z5Ye3R86SLH8G1gz34AjIj3p+B93oXbkAFsfu3whjbPcK52smVv2yslpZHtJffCK
         YgNYrDhpjJT74enEwWl6ZBl1fWunwcTeINlVPPkWKmAvPy+47ITj/9rzjvT09dZZapyK
         uBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=do0PAfp8FItvZFX0sahV1VSfZjDfkuSope8xU3dAOoA=;
        b=TTBOlNax+WNcAOAI9sEG7jsBOpnd3HJ6MRlmUq1p/h/AaQWXWz9Q/H2mmO714cU6ZH
         M3+hSOF9a2egAoK/bqP5NfIPkDItrmFKR/UUtPxoHnKbxaZQafbtQcPKvj/lp7tIr/G9
         1cyvcLHW/KYNHPm5OLcVQVmJe+azXu2EvFDYv0rlcNpFanv+PK9cJFyhC/28agEYghc8
         nBh/AMaJWFaZg6J3PFIBlG8QJEFQ70huOrKCm1LOLrAXvRy+XQA2MiagUx6acqBk2sJ9
         u+PRcSrfHqFhSHnqrzgVgmPakA95jSjQIkrlScdDwvCrpBRQvf4OZddWXfz2dmRFP8oT
         vIPg==
X-Gm-Message-State: APjAAAX9/6erH+uOjrBBUocoSPs5dByXx1vGlCb3S/2dU9vmMkf57YHU
        GF2/BI6rS0pHtwqEXEQpSgrgOp7QexxISQ==
X-Google-Smtp-Source: APXvYqyoBeDUwuDIgUWpKhEvStBPU/R5cz9W9cAbHdUrKYf7x9a8H4aXLWj9ITNqWEFAYA0MqgXFhg==
X-Received: by 2002:a05:660c:12c2:: with SMTP id k2mr282243itd.17.1552596279669;
        Thu, 14 Mar 2019 13:44:39 -0700 (PDT)
Received: from x1.thefacebook.com ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w19sm1820538ita.33.2019.03.14.13.44.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 13:44:38 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     viro@ZenIV.linux.org.uk
Subject: [PATCHSET 0/8] io_uring fixes
Date:   Thu, 14 Mar 2019 14:44:27 -0600
Message-Id: <20190314204435.7692-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Here's a collection of fixes/changes that should go into this revision
(at least the first 5). The first 5 are based on Al's fixes for aio, the
next two are optimizations that allow us to bring back no-page-refs for
BVEC iterators, and the last is the cache hint.

Also find the patches here:

http://git.kernel.dk/cgit/linux-block/log/?h=io_uring-next

 block/bio.c                   |  43 ++---
 fs/block_dev.c                |  12 +-
 fs/io_uring.c                 | 388 ++++++++++++++++++------------------------
 fs/iomap.c                    |  12 +-
 include/linux/blk_types.h     |   1 +
 include/linux/uio.h           |  24 ++-
 include/uapi/linux/io_uring.h |   5 +
 7 files changed, 232 insertions(+), 253 deletions(-)

-- 
Jens Axboe


