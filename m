Return-Path: <SRS0=x5xE=3G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F34C33C9E
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 04:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B293720748
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 04:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0I6MXkCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgAQEdt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jan 2020 23:33:49 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38432 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgAQEds (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jan 2020 23:33:48 -0500
Received: by mail-pf1-f196.google.com with SMTP id x185so11330617pfc.5
        for <linux-block@vger.kernel.org>; Thu, 16 Jan 2020 20:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=+lpQXccIrjzkHHcI8DfYUB2fAuW+rG5Ub6d8UNQ4Om8=;
        b=0I6MXkCLKNyEukUyP+U8+73r4vVleG7QKzImui4F9p5hML364/SF8jvOQW2eT3DyoX
         PHHmRRdMHf9ygZJzL8PBUhIg+5RedASg8TRykly2yfVrwKf+q17Nz1GUxWt4B3CbwHik
         lYvyd3kqSpnoxS2QAzBtEAG1VokqRFoRuL+EgVsyMST9Xmoq/eJtUYcM43LIW5Dt5dYn
         kjlgWuF/7px5kRpJbxPkGHMUGS3rW1OAZwrNFdQbujHIV0CV72k0TYdiRuBxLmntaseX
         DyERgWCMyyXgTEDnhLB9YdS1kEz0ltg2EzT93teE8fMa2IK8yAvTAYo//56w5hxJnwBy
         Jn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=+lpQXccIrjzkHHcI8DfYUB2fAuW+rG5Ub6d8UNQ4Om8=;
        b=e68OpqrrmyMbMldPSuDYDZR+Vin8FiXCatkhW80O+f+B1ZhajjxRD7LQfUJCdK921c
         JhOfKKDt/LyTjg+1wZeUwOAJwLt0+kBkssjeyfdLnAiWxKj0i8wOuD/nOyuNdqmxj+he
         BZOGwS7DhPM9dN5zR8ib0JUJTFY4E/J0WPKj3ejlQMTs4k5q7UPJUE2NGhZINbIurXPw
         akzAszb//r/Kd/hcnniOCg57TVwT25Bfef4Zi78pqnKNUjjf4oShuPE+itVS+flSMrtr
         kdJGH86qQMbiA8Yi/vrw4j5nGF16sbtFwY/uMrqc2EoVlFnp7FVC4cYoznfYPZyDpuog
         +MgA==
X-Gm-Message-State: APjAAAVpHGFy0uZMAMRveeF7C5oYkh4uYif3EvBL8f6KY8WJi/Qok5yX
        UfEomusAnUFYdSD891e3LRQfTOvsHr8=
X-Google-Smtp-Source: APXvYqzRm8XuqKEaB0xg95vwuJQyQIF6sUZqft+QFfCwe08hYMI3m+W1MtxzWEMN1wbquu2+GhX84w==
X-Received: by 2002:a63:f107:: with SMTP id f7mr43597029pgi.76.1579235627988;
        Thu, 16 Jan 2020 20:33:47 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id p17sm26758976pfn.31.2020.01.16.20.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 20:33:47 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.5-rc7
Message-ID: <3351f62c-671a-11d6-db8d-d78366bbf50b@kernel.dk>
Date:   Thu, 16 Jan 2020 21:33:46 -0700
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

Three fixes that should go into this release:

- The 32-bit segment size fix that I mentioned last week (Ming)

- Use uint for the block size (Mikulas)

- A null_blk zone write handling fix (Damien)

Please pull!


  git://git.kernel.dk/linux-block.git tags/block-5.5-2020-01-16


----------------------------------------------------------------
Damien Le Moal (1):
      null_blk: Fix zone write handling

Mikulas Patocka (1):
      block: fix an integer overflow in logical block size

Ming Lei (1):
      block: fix get_max_segment_size() overflow on 32bit arch

 block/blk-merge.c               | 9 +++++++--
 block/blk-settings.c            | 2 +-
 drivers/block/null_blk_zoned.c  | 4 +++-
 drivers/md/dm-snap-persistent.c | 2 +-
 drivers/md/raid0.c              | 2 +-
 include/linux/blkdev.h          | 8 ++++----
 6 files changed, 17 insertions(+), 10 deletions(-)

-- 
Jens Axboe

