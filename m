Return-Path: <SRS0=/LTC=27=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9433C282DD
	for <linux-block@archiver.kernel.org>; Fri, 10 Jan 2020 18:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB80A2080D
	for <linux-block@archiver.kernel.org>; Fri, 10 Jan 2020 18:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cfFoDfeM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgAJSLW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Jan 2020 13:11:22 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38200 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbgAJSLW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jan 2020 13:11:22 -0500
Received: by mail-pf1-f195.google.com with SMTP id x185so1504886pfc.5
        for <linux-block@vger.kernel.org>; Fri, 10 Jan 2020 10:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Zd/4PHH09oDT26HSXxoIBJR5pD9D4kV59rXf7Uwf2Bs=;
        b=cfFoDfeMAFzDxon9xAhd6qwW8artFpgcF1i3+Qg0GgjBFCu0UafFnZj744OPnehyd6
         jtP3Hsv+UKqDenB3Zk8Y34c/v7nC/rXXNcGjCO5//9gr9G1uCzw3HoHsq1IQgnqNcdQ4
         zFeOFKWev2uLzlxNp0W1e0oNKML5hyJ3FwfO8eOVJsR9x5nj9MkX11k7lizDH4/CwAJv
         xh4wSJPrfM3jbHyN5AwG/3VeaF6iWRhEWyYMea7HP4Rm22tyb8LvvmtzKV3J8E44O7NG
         VsjvB4SqqWNZZBQcrwzS3D/njGvGbmeSRZ6MX3hhegVyZ32B1G8rN/k0Oxk2Gkrlsjzs
         PRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Zd/4PHH09oDT26HSXxoIBJR5pD9D4kV59rXf7Uwf2Bs=;
        b=BSH7fC8V5Jt6Yq/jlOExffJALhXofdSvnqfWE0/mBs0AqjTpk/30LAQPHAOqpu+Pt6
         Fa5X/asbZxmVQO7MJl0ll/cuwnN2Y95rnxf9F4c6tp7leHm+f2fPAYTMeG2dDjCIpXQk
         EiuUY15flngn+MC9145QCyxyVjK7OBgSGGCJREzmnkixdvyMp8yAMoSzsP4QYTklJuwn
         e5G6UUL8oxK3Gb+RASDjg+iwqt9NTsne43MGLMcuGek7zFzSjUHZn/EYK/rHaaWIeFEB
         BikPCu5KwzqUX3GURetn7M7qif8u3jPyEBHX7bCUEnjvpsVUcrQqnPzpvvqS9Xamog3B
         QFTA==
X-Gm-Message-State: APjAAAWccb7cQPoo7bRj4LMD33q33XVkWrDxos1dsOPXsbQr7+BE8w1B
        gXM/UTPsVj9ZhPIhE+BrBwdJPZrVTzc=
X-Google-Smtp-Source: APXvYqwds9IRlrsk2s5mFQaUVi5x2ReG/aRSnojAzCkWeqnvq/NOQxTEF8wiylwznSpxrIC1/cewqw==
X-Received: by 2002:a63:500c:: with SMTP id e12mr5828654pgb.214.1578679881049;
        Fri, 10 Jan 2020 10:11:21 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id u26sm3521238pfn.46.2020.01.10.10.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 10:11:20 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.5-rc
Message-ID: <09fa9f3f-ca5c-f98a-d4a5-446810906107@kernel.dk>
Date:   Fri, 10 Jan 2020 11:11:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A few fixes that should go into this round. I popped out a patch in the
middle this morning as we're still working on that, that particular
patch is fixing a regression with 32-bit with the last segment split
fix. I'll send that in once we're happy with it.

This pull request contains two NVMe fixes via Keith, removal of a dead
function, and a fix for the bio op for read truncates (Ming).

Please pull!


  git://git.kernel.dk/linux-block.git tags/block-5.5-2020-01-10


----------------------------------------------------------------
Amit Engel (1):
      nvmet: fix per feat data len for get_feature

Jens Axboe (1):
      block: remove unused mp_bvec_last_segment

Keith Busch (1):
      nvme: Translate more status codes to blk_status_t

Ming Lei (1):
      fs: move guard_bio_eod() after bio_set_op_attrs

 block/bio.c                     | 12 +++++++++++-
 drivers/nvme/host/core.c        |  2 ++
 drivers/nvme/target/admin-cmd.c | 12 +++++++++++-
 fs/buffer.c                     |  8 ++++----
 fs/internal.h                   |  2 +-
 fs/mpage.c                      |  2 +-
 include/linux/bvec.h            | 22 ----------------------
 7 files changed, 30 insertions(+), 30 deletions(-)

-- 
Jens Axboe

