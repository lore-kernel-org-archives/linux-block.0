Return-Path: <SRS0=UEoe=DD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEB1C4727D
	for <linux-block@archiver.kernel.org>; Sat, 26 Sep 2020 02:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F081D20866
	for <linux-block@archiver.kernel.org>; Sat, 26 Sep 2020 02:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0hLuG+A9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgIZCXq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Sep 2020 22:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZCXp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Sep 2020 22:23:45 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C48EC0613CE
        for <linux-block@vger.kernel.org>; Fri, 25 Sep 2020 19:23:45 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k8so4960656pfk.2
        for <linux-block@vger.kernel.org>; Fri, 25 Sep 2020 19:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=9SC9FN0TcSwba3rVoKCf65Lswd66pc0Vn+dP/qQ7jJI=;
        b=0hLuG+A9DrC+A27ahmIBJkqcZBwHYdvAyr0VL217iGC7xLwt8lFdh9VaIwvUYswuOM
         /P4NJHTN9VpKuOPQn183kQmBGLP912EGBSk1SetVjIs/BQbFoFv4BhAnom2yWlsUrDHZ
         mE573UnIFJwFFk8uPwSZVjRXEiRiGC5wFLnn+ecJOZ6mjTcp4niKg1tp1w2fNfCoLvFm
         BwpUDny/aT0QFFsCCU/hWwHJg5LpQtPo4JBrKdI39HiP6HF6YQAxCEHgrt0DQkddXIIm
         gXQn6agzgo815pddhmO2Q7Hm8No6xtKvAPIj4J1JhI6MzzAlf9Mz4BmVy2YBwZQz0nWv
         Glnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=9SC9FN0TcSwba3rVoKCf65Lswd66pc0Vn+dP/qQ7jJI=;
        b=TuXqiDAWCYIf6qJeKnK3qPLZx3vh6BdqoYfXwcukjMufmOyoiVcTCr9mNrWhNGUs7j
         WsgH1LxrTS6OG2d8JaP4PhIKV+/nMj7yn7gmk1r462ftn9n7xL1JOVdeTz6jflsZR6y1
         O99bEEpFcKvuKodShxTmA+Y5Mj3BIH1WOj+OXETkYU4kTY4pIegeeYITeLvFKTGgU0t7
         P7gyf22U+QWOunzNZd9Za64KAQ86gQmaH50DOAlbFhPox7brXRHM4ZcObX/UYHEChJUZ
         QLw5o1xcaQEJ63SuXCGwlgGTXKNktvvqaDwWAQDZeCdJKZbb0jI0fRUgXF1xY5yZBV9R
         zseA==
X-Gm-Message-State: AOAM5322Wfk5f7XJI+ZGsu+eoKrITsHhOy66NjJZQpaUIMv1ZSw8lk4Y
        TswCizyL5fUUOEUsIvD0/MlKHT67wwHvyiCl
X-Google-Smtp-Source: ABdhPJyl060Mz7OKXBLBxerrwPypYCyvqST0QWoliLlhDLwRIAMMe6Sj1gvvoQpXfO0wa07uQe/gxQ==
X-Received: by 2002:a63:2fc7:: with SMTP id v190mr1343922pgv.250.1601087024342;
        Fri, 25 Sep 2020 19:23:44 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id q7sm3309928pgg.10.2020.09.25.19.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 19:23:43 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] block fixes for 5.9-rc
Message-ID: <a43f5477-7da2-f4b1-bb61-3c1b613da334@kernel.dk>
Date:   Fri, 25 Sep 2020 20:23:42 -0600
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

NVMe pull request from Christoph, and removal of a dead define.

- fix error during controller probe that cause double free irqs
  (Keith Busch)
- FC connection establishment fix (James Smart)
- properly handle completions for invalid tags (Xianting Tian)
- pass the correct nsid to the command effects and supported log
  (Chaitanya Kulkarni)"

Please pull.


The following changes since commit 4a2dd2c798522859811dd520a059f982278be9d9:

  Merge tag 'nvme-5.9-2020-09-17' of git://git.infradead.org/nvme into block-5.9 (2020-09-17 11:49:44 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.9-2020-09-25

for you to fetch changes up to 3aab91774bbd8e571cfaddaf839aafd07718333c:

  block: remove unused BLK_QC_T_EAGAIN flag (2020-09-25 07:54:50 -0600)

----------------------------------------------------------------
block-5.9-2020-09-25

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvme-core: don't use NVME_NSID_ALL for command effects and supported log

James Smart (1):
      nvme-fc: fail new connections to a deleted host or remote port

Jeffle Xu (1):
      block: remove unused BLK_QC_T_EAGAIN flag

Jens Axboe (1):
      Merge tag 'nvme-5.9-2020-09-24' of git://git.infradead.org/nvme into block-5.9

Keith Busch (1):
      nvme: return errors for hwmon init

Xianting Tian (1):
      nvme-pci: fix NULL req in completion handler

 drivers/nvme/host/core.c  |  9 ++++++---
 drivers/nvme/host/fc.c    |  6 ++++--
 drivers/nvme/host/hwmon.c | 14 ++++++--------
 drivers/nvme/host/nvme.h  |  7 +++++--
 drivers/nvme/host/pci.c   | 14 +++++++-------
 include/linux/blk_types.h |  3 +--
 6 files changed, 29 insertions(+), 24 deletions(-)

-- 
Jens Axboe

