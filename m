Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87D1C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 14:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FB7218AC
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 14:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nyQ2yoQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfCOOys (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:54:48 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:44599 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfCOOys (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 10:54:48 -0400
Received: by mail-pg1-f169.google.com with SMTP id h34so6622035pgh.11
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2019 07:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=/yvxxA+FLLhscO8u6OKwrwRMS+O7hwJIZ7ddpfpqfKo=;
        b=nyQ2yoQZg3HCY1lJusi/pmP1mqWnWJwqmy4AZkqmTgpksWcmre9RdlVR/LWD6NA/NB
         v8o0CL78hwPDx0fcKTmfNxt95OR2Vz5axdPx430l/aJ4AJQsET5ShGAQGu+vXSBp/PLc
         Moy+1BzegY0wGqckQzE0NvEAHR6oGscp463afNyKdHgRF9Tq2aDv+cIq2wdddvDdGbNE
         7p99Kaaq+gFdfvoZfYDOQSMrPtSx9dUf2YyAKSoyp8JRV2TJTCXoKOHXtneDfF0/R5Tn
         SHn3rShhvHjSWZDcFtUDGHYcmwXQkKWsl6wHkxQlMZRx8F1pxR7XtOIH+QXtu/VOfYg1
         eIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/yvxxA+FLLhscO8u6OKwrwRMS+O7hwJIZ7ddpfpqfKo=;
        b=Uq/fMRVl4sVmgIZbMJ7E4Pdp6mzhpdl10QNXAVX4DeZ6khz3WUAqwthEwZwiFsVIoE
         YYxciUQITpwcmi9Z1IQ165Lg9OKC5nJbY0XnzsAYHw+3+WxsoWJ1GO+X/lsXpyK37VZK
         TaBmW1y1xW73tRVHlb1MOzYandS9yPmC+pe2NigO237upOppLZwHsnN9vpwPTOWV2PIM
         Dx1M+I7av7oZN/1WWBDv85w9LrZVcsV6re3Q5jImJdHsoGYtlfG4riU2007xamBOV353
         WqkZbbNZcuxcRTYxcX2qI/0vU9d/OXR0vcN2btv4hJcduecKLExtk7z5wwCLjJ8kBgmE
         t2Jw==
X-Gm-Message-State: APjAAAUM2I3VyZZV4O3/85lcKR6q+e4ng9qX0AcurDuD1rotTyW9tcUp
        rViE8Bf/et0+bqjvoLzVsqzy7g==
X-Google-Smtp-Source: APXvYqwzPB8A80Af8yl5NGGl62w/ecyRGE5XXD5ySe7iWnotX2oh2QsvMm9DHzuYqsxDtiSahH/obg==
X-Received: by 2002:a65:5cc4:: with SMTP id b4mr3865242pgt.334.1552661687654;
        Fri, 15 Mar 2019 07:54:47 -0700 (PDT)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t10sm3192272pgo.27.2019.03.15.07.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 07:54:45 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     viro@ZenIV.linux.org.uk
Subject: [PATCHSET v2 0/7] io_uring fixes
Date:   Fri, 15 Mar 2019 08:54:35 -0600
Message-Id: <20190315145442.21127-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I separated this into a strict fixes series, then we can focus
on the last few optimizations for this series once that is in.
Hence this is a v2 of the series from yesterday.

Through testing of the various modes of operation and opcodes,
I found a few issues in the previous series. This further cleans
up the file and reference handling, and passes all the tests I
can throw at it.

Please review, thanks.

 MAINTAINERS   |  10 ++
 fs/io_uring.c | 444 +++++++++++++++++++++++++-------------------------
 2 files changed, 229 insertions(+), 225 deletions(-)

-- 
Jens Axboe


