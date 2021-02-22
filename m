Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CA4C433E0
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 18:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E737A64E5B
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 18:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhBVSe4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 13:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbhBVSeB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 13:34:01 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C84C061574
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 10:33:21 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id 17so4969270pli.10
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 10:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=PQCX9jiWDr4UVPdlnE++OV+yP9M0iDGXpR60ukaDi5I=;
        b=RYoaNT276OuYQNAXmV8AcM7x4mjjPC1igOX6ogwAZYcgBHcjCmCTgmZDW9Gcldafoy
         Eywk354V+ORmRTtP0q03D286ToBkLdrG8hxdSTNUJ7NNJItEZuiuUxCXu/Yv7DWfEr2A
         3UR9gAffGqZfPaSCXprOxImO0j5Wt1hYYSyiSfkTtbnSUuo27M/DCA/J7ALMpiVoe9aC
         63K3Rpo7kpZCakguI7kdjsN8RXPBn8jZ6tWGY+kz+QEFfZgHlFYfISUA/7UcNxCngtVK
         PW5wNX4p5xKZNIi73/SHdc0JhlYsq7FEdZO+k8XOqPVwqoyQPZpF9H39MsUHtg2W7C/l
         mL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=PQCX9jiWDr4UVPdlnE++OV+yP9M0iDGXpR60ukaDi5I=;
        b=pF7OVi2YB7+lqYAo3Lpj4S8BUfoEMz98kpgB8g10Po7/3XBuMIs/klp0SOvDvBXgtI
         wM8zcJcg6o9ZGKVZTVavNUya6IfBytFzAD//T5XbHbK8eYkWxRArUzB3iywhHhoTjjwi
         gbUv5UsaT4fCNrmAD3BbJG9E2mQiVLnm5s5luAfwuUubSUqbwMtX7zDTgNzTIz1tKYdw
         Vx4Q5VsZPyn7Os7griQ1TGsbKV6MALZG4Q72zXNwpul48cBj45THH4K5rtwes8wMPo+P
         8Rj5037ENcZH9T5zyX3f349hav7i5PgfY+/gQaM1E6kvpuYQitJlPn/0AMKVlT8ZlBwK
         axPw==
X-Gm-Message-State: AOAM533f37MRSor/pJBi44NJWDNjZ0XIzSo5ZMhvS33jrtzca4DpzSlE
        rtQujiLvh7GpElENNmvhDZAMZvHpi4cazA==
X-Google-Smtp-Source: ABdhPJw5rDkBYS1n6zkJj2Zbu/qNtgrdGyO/PFSBIUIPuWqy4US3mmP+WjZNVFbrm5EgPZg9/oxahw==
X-Received: by 2002:a17:90a:2e09:: with SMTP id q9mr25649494pjd.89.1614018800350;
        Mon, 22 Feb 2021 10:33:20 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21e8::169c? ([2620:10d:c090:400::5:f523])
        by smtp.gmail.com with ESMTPSA id z12sm124455pjz.16.2021.02.22.10.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 10:33:19 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block IPI improvements
Message-ID: <755b2ae7-7b30-fc93-71cb-3492d04a49a9@kernel.dk>
Date:   Mon, 22 Feb 2021 11:33:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Separate pull request for this one, as it depended on a core change that
has now gone in through the tip tree. Change from Sebastian, avoiding
IRQ locking for the block IPI handling.

Please pull!


The following changes since commit 92bf22614b21a2706f4993b278017e437f7785b3:

  Linux 5.11-rc7 (2021-02-07 13:57:38 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.12/block-ipi-2021-02-21

for you to fetch changes up to f9ab49184af093f0bf6c0e6583f5b25da2c09ff5:

  blk-mq: Use llist_head for blk_cpu_done (2021-02-12 08:28:02 -0700)

----------------------------------------------------------------
for-5.12/block-ipi-2021-02-21

----------------------------------------------------------------
Jens Axboe (1):
      Merge branch 'sched/smp' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip into for-5.12/block-ipi

Sebastian Andrzej Siewior (3):
      blk-mq: Always complete remote completions requests in softirq
      blk-mq: Use llist_head for blk_cpu_done

 block/blk-mq.c         | 109 +++++++++++++++++++------------------------------
 include/linux/blkdev.h |   2 +-
 2 files changed, 42 insertions(+), 69 deletions(-)

-- 
Jens Axboe

