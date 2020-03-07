Return-Path: <SRS0=wE/y=4Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E620C10F00
	for <linux-block@archiver.kernel.org>; Sat,  7 Mar 2020 19:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A6D2073C
	for <linux-block@archiver.kernel.org>; Sat,  7 Mar 2020 19:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="q2ezQDl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgCGTOS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 7 Mar 2020 14:14:18 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51811 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgCGTOS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 7 Mar 2020 14:14:18 -0500
Received: by mail-pj1-f66.google.com with SMTP id l8so2523113pjy.1
        for <linux-block@vger.kernel.org>; Sat, 07 Mar 2020 11:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=0PJ7lqAt0N6ePb+6DkzQ8KhyWW4ojoGxpG4tp/+VjeI=;
        b=q2ezQDl6qPppxhXDYAOTmDrcIRbCbFkfOB4mJou9K6OUUScCxQGdnJfDW5a9BC2R7O
         g0trPtqAPXsbeOa9gngyXkaTWercbZTlqDL7HOQbRJaU5OT2pG0j094Wd9DMS/kZ7/F5
         dz4oZ8JEVmNVrB7UCgimbcCnO3XgB7FDvvwzMHiqFs30mWLmjVmSTQaA3t7SSPorW41N
         zPOLfCA5FLnMzg2hKocUDdVnKYSfm39x7Gc/ExD8nGPGsRqytRfEHXRC1mePwzSU57VO
         /3CK0W8GINE6u4yjKTgHNu6Kg7cZODgCaEtCEhKF7FKtgFWAoUqF9jo99yTWEk5/qJMa
         NOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=0PJ7lqAt0N6ePb+6DkzQ8KhyWW4ojoGxpG4tp/+VjeI=;
        b=rbWVuJ4jAmmH06mncNa2A8C+0vB6M2guUh5M7peT4z4gpLKBLqi19UtbMVDtW0l+j6
         15ks/7hye1iTNXdVeDuju4iHFDK/YUtfSy1uiac9dz3rFYK301SI/zJy7bYlXRExToIh
         6p1KYhS7O4CfzXJzsADu3sIzEEQrtTDMPDBfGURKXRPPZUVYhg+kCIn2SHOB3GNsG0wx
         fEUBjuEuKijKcXpYDIftMjjaM2XEHgJ3OEJHNE3EaiLD2e0Wy0veusIP4dIN+1M8oXXz
         vwrl9RGjjCaGI7flisFYmNWVhCV4rEbJn1UYDEsbT3d2v10xz6DquBp2YKilpE4HLl4x
         +wNA==
X-Gm-Message-State: ANhLgQ2Tm5goIbcR0/O+aVV+UGqrmzlTDDc9v6KiyCy5RSTijplRGBO+
        J1eQ1DxeyTpomhyBeuTpW//N3f0hTlc=
X-Google-Smtp-Source: ADFU+vtSGXymYu0V6H6KvLk+hwyl48mhWC3b/KczWAM7XFvFRi6VNKLBqJMsHlRjJRwH+/PWlP8SQw==
X-Received: by 2002:a17:90a:1596:: with SMTP id m22mr9984759pja.73.1583608455557;
        Sat, 07 Mar 2020 11:14:15 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id r24sm14455457pfg.61.2020.03.07.11.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2020 11:14:15 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.6-rc
Message-ID: <fa40d7d0-75b7-b30d-7f00-4346c33dd17e@kernel.dk>
Date:   Sat, 7 Mar 2020 12:14:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Here are a few fixes that should go into this release. This pull request
contains:

- Revert of a bad bcache patch from this merge window

- Removed unused function (Daniel)

- Fixup for the blktrace fix from Jan from this release (Cengiz)

- Fix of deeper level bfqq overwrite in BFQ (Carlo)

Please pull!


  git://git.kernel.dk/linux-block.git tags/block-5.6-2020-03-07


----------------------------------------------------------------
Carlo Nonato (1):
      block, bfq: fix overwrite of bfq_group pointer in bfq_find_set_group()

Cengiz Can (1):
      blktrace: fix dereference after null check

Daniel Wagner (1):
      block: Remove used kblockd_schedule_work_on()

Jens Axboe (1):
      Revert "bcache: ignore pending signals when creating gc and allocator thread"

 block/bfq-cgroup.c        |  9 +++++----
 block/blk-core.c          |  6 ------
 drivers/md/bcache/alloc.c | 18 ++----------------
 drivers/md/bcache/btree.c | 13 -------------
 include/linux/blkdev.h    |  1 -
 kernel/trace/blktrace.c   |  5 ++++-
 6 files changed, 11 insertions(+), 41 deletions(-)

-- 
Jens Axboe

