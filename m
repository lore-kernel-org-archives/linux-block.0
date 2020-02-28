Return-Path: <SRS0=/0DQ=4Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4D5C3F2CD
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 18:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7231E24677
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 18:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0QmnyHRC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgB1SoY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Feb 2020 13:44:24 -0500
Received: from mail-il1-f176.google.com ([209.85.166.176]:36324 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgB1SoY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Feb 2020 13:44:24 -0500
Received: by mail-il1-f176.google.com with SMTP id b15so3605350iln.3
        for <linux-block@vger.kernel.org>; Fri, 28 Feb 2020 10:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=aAfAj4RCtJ4DHhDqAaws7ZQvW1EeARaZ0ciLLyZ1UsQ=;
        b=0QmnyHRCkNANFInsWJlD8VGfsIKWBgcko+nnttSjLAQTY/eqV0gFK1OFT8ZIGCTyJC
         VZpSFvYIwG8Czl+d0RgipSAitfX13rnyrpk8w7irsl+jKvvwoDLWpOh0Tnulx9bQsQNR
         3IzdxF55KviYGUCIPKXiuvT5MZ2FjyEfmMv1UP6UJes2ysD84ooymhSzPHQlRocw4wPS
         zmug7s4CMt3RHZJrSduzN0ZjzPFGonovlh5WZT45LXcQji0EmUkDirpMPQX41bSw8Np5
         V7Cwjc53i5CWTEsmu46Xb2r+coX2EwJW1nCjKKx2Sz2uKr9+ConLqxlCgNYQIIV6MORo
         XKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=aAfAj4RCtJ4DHhDqAaws7ZQvW1EeARaZ0ciLLyZ1UsQ=;
        b=V7D0j4CLJW9TTY3SXMwVv5A7YICQJQG9Tf6g9nRnfUA/mc14qKkFSuuHuRu4u83hid
         YmV2/43Bcz0M6+U7y6pQal5+FXqTRD5AJi+eZt51ohMV3PReIwXJKNuJNbIahA0S17DF
         ox1BgcYLC1dWRmzMtPXj1wYaaY2g5tmLiuqbSRDcXLNSEa8gdgFIndY6RESPRJw7KHov
         IKS8krlkmZ/UwNfLzB71EHGiRxgmlLtvPZvZrlm+jtqN7UFsccYHqOsf87D1NMJDkA7p
         27XIwM3N1qb5ImrJCsFGQANzh9YEd7x58ZWqfITQ+371MiPg/zsGwYI0qnz7BONw0QlR
         kufg==
X-Gm-Message-State: APjAAAVMMH4B3dJXKjNU4xhv2cceZZRJnMniOWtRH02atcFmY7Ox77MO
        AvcmCgr1RVSU3CGGeu0lKTEj7y+2g4A=
X-Google-Smtp-Source: APXvYqxuL75uP+rRBFS8/9luCumX2od3EQ+YwKUTlM11I70puh7lK4Uz5Tdq73oyqVYu9rXouxS66A==
X-Received: by 2002:a92:8656:: with SMTP id g83mr5842917ild.9.1582915462253;
        Fri, 28 Feb 2020 10:44:22 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j4sm1130251ilf.21.2020.02.28.10.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 10:44:21 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.6-rc
Message-ID: <20fc1cef-97db-f9be-e308-58e539b97298@kernel.dk>
Date:   Fri, 28 Feb 2020 11:44:21 -0700
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

A few fixes for the block side that should go into this release. This
pull request contains:

- Passthrough insertion fix (Ming)

- Kill off some unused arguments (John)

- blktrace RCU fix (Jan)

- Dead fields removal for null_blk (Dongli)

- NVMe polled IO fix (Bijan)

Please pull!


  git://git.kernel.dk/linux-block.git tags/block-5.6-2020-02-28


----------------------------------------------------------------
Bijan Mottahedeh (1):
      nvme-pci: Hold cq_poll_lock while completing CQEs

Dongli Zhang (1):
      null_blk: remove unused fields in 'nullb_cmd'

Jan Kara (1):
      blktrace: Protect q->blk_trace with RCU

Jens Axboe (1):
      Merge branch 'nvme-5.6-rc4' of git://git.infradead.org/nvme into block-5.6

John Garry (1):
      blk-mq: Remove some unused function arguments

Ming Lei (1):
      blk-mq: insert passthrough request into hctx->dispatch directly

 block/blk-flush.c             |   2 +-
 block/blk-mq-sched.c          |  22 +++++---
 block/blk-mq-tag.c            |   4 +-
 block/blk-mq-tag.h            |   4 +-
 block/blk-mq.c                |  28 ++++++-----
 block/blk-mq.h                |   5 +-
 drivers/block/null_blk.h      |   3 --
 drivers/block/null_blk_main.c |   2 -
 drivers/nvme/host/pci.c       |   2 +-
 include/linux/blkdev.h        |   2 +-
 include/linux/blktrace_api.h  |  18 +++++--
 kernel/trace/blktrace.c       | 114 ++++++++++++++++++++++++++++++------------
 12 files changed, 136 insertions(+), 70 deletions(-)

-- 
Jens Axboe

