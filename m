Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D821C47096
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 16:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6543261001
	for <linux-block@archiver.kernel.org>; Thu,  3 Jun 2021 16:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhFCQs4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 12:48:56 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:40717 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCQs4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jun 2021 12:48:56 -0400
Received: by mail-io1-f45.google.com with SMTP id e17so7005744iol.7
        for <linux-block@vger.kernel.org>; Thu, 03 Jun 2021 09:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=PCSbcBf0W31nsxy3qW3PzBxpDwMQqcUZjWB1w5IxHgs=;
        b=LOv8mB0xUFrdpg6792KXyuxCXJTYx1sFYWKDsOgK3hYM3Tj7ikeyWmyjwYdcNp/23J
         r2EMCyr5YY/wD107bRRhVgVZ4ooq54aD2p28WyjNisB2H2WpktAmTVowZn0qNXBFz7qb
         TGCp/pl5rKbrMFYT+LWZDJ8sMhbimNhgUvrat7+9FfZ5WH3FHXojYIYVs84gRa6j2wzg
         npfJY8mh4IFL78S6MgozTuwYgeuuCd7tV8qKjDweHXP8IjH0YjGqtwnheJul8iame9Qy
         YRPO5ct9OWuMxzh8Y9SWSdg/AiuXXa2s88fDPg/oiwuKkwZnJM1LLSDtXi2uqfTZVm75
         3rPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=PCSbcBf0W31nsxy3qW3PzBxpDwMQqcUZjWB1w5IxHgs=;
        b=nzghix5eUKhQdOjebodS6SawxhuDvJiB2vqz0E3ZxL+bp0cQf6lNhRHTEMCfNubsPD
         yq3kr0GG4zjj9byOG5OJQ0gBv1lIkPFPcaqtYFlLsTs/W5lJe12Rpe7zugMKHblS0o0M
         bfl+yl4RZw5hzcIpwsMKEEKeLh3vp6mLIWSlO/UDedCVqhR0U4u6tkdEO5qfWPI2lFAR
         mwEYSFGfSTVyq/+U0QcGJjUzSyUzBtGuq7FYRzjQJ9Yu3JVXqlacpCGmxO+ZU+aN6Md5
         CWtCghj4ubuMoZInmqpMJ9OJhO10xCtXF4WgJ3PxACeIkZj1TQ5RoHVXTl5o+Ikk/taQ
         HezA==
X-Gm-Message-State: AOAM530kZECcC6hnUf/yqsmfAaWpN01hNy0ICnW1WFwUjZxv15hYUsdA
        1XcoNeL5FOdBxZ+VE6B/2YFf9H1A6ciziQLU
X-Google-Smtp-Source: ABdhPJwVI0s2ddt9UvcqkiqMAY7QsV4rHbzzd94Tvbz4szlh1lF5cGR6fuFFCdiuLtLRFudZYYKWkA==
X-Received: by 2002:a02:a784:: with SMTP id e4mr6115jaj.18.1622738770971;
        Thu, 03 Jun 2021 09:46:10 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l15sm2282550ilt.1.2021.06.03.09.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 09:46:10 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.13-rc5
Message-ID: <cdd66f53-8316-a4cf-6cb1-0050dcf8cfe9@kernel.dk>
Date:   Thu, 3 Jun 2021 10:46:09 -0600
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

Pull request from Christoph with NVMe fixes:

- Fix corruption in RDMA in-capsule SGLs (Sagi Grimberg)
- nvme-loop reset fixes (Hannes Reinecke)
- nvmet fix for freeing unallocated p2pmem (Max Gurtovoy)

Please pull!


The following changes since commit a4b58f1721eb4d7d27e0fdcaba60d204248dcd25:

  Merge tag 'nvme-5.13-2021-05-27' of git://git.infradead.org/nvme into block-5.13 (2021-05-27 07:38:12 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.13-2021-06-03

for you to fetch changes up to e369edbb0d8cee50efa6375d5c598a04b7cb3032:

  Merge tag 'nvme-5.13-2021-06-03' of git://git.infradead.org/nvme into block-5.13 (2021-06-03 07:42:27 -0600)

----------------------------------------------------------------
block-5.13-2021-06-03

----------------------------------------------------------------
Hannes Reinecke (4):
      nvme-loop: reset queue count to 1 in nvme_loop_destroy_io_queues()
      nvme-loop: clear NVME_LOOP_Q_LIVE when nvme_loop_configure_admin_queue() fails
      nvme-loop: check for NVME_LOOP_Q_LIVE in nvme_loop_destroy_admin_queue()
      nvme-loop: do not warn for deleted controllers during reset

Jens Axboe (1):
      Merge tag 'nvme-5.13-2021-06-03' of git://git.infradead.org/nvme into block-5.13

Max Gurtovoy (1):
      nvmet: fix freeing unallocated p2pmem

Sagi Grimberg (1):
      nvme-rdma: fix in-casule data send for chained sgls

 drivers/nvme/host/rdma.c   |  5 +++--
 drivers/nvme/target/core.c | 33 ++++++++++++++++-----------------
 drivers/nvme/target/loop.c | 11 ++++++++---
 3 files changed, 27 insertions(+), 22 deletions(-)

-- 
Jens Axboe

