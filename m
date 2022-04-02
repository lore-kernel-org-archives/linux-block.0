Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB186C433EF
	for <linux-block@archiver.kernel.org>; Sat,  2 Apr 2022 17:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242606AbiDBSBO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Apr 2022 14:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiDBSBN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Apr 2022 14:01:13 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F084477C
        for <linux-block@vger.kernel.org>; Sat,  2 Apr 2022 10:59:21 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id w21so4866741pgm.7
        for <linux-block@vger.kernel.org>; Sat, 02 Apr 2022 10:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=KARQoxN+swpbBLhre9m9uQ6DP0HU+CblvIQCT7poyNM=;
        b=ASZBFPXkZS1SBmqr1Bf02wZzDObyjdg5ub7Iip5YgiZs7rrdFGQmADnzYnX/Da2OVT
         9vmglw6fEZT3RqfXaCzdd8xwqkJPU47v1uTcSfbEVLFwIttwG/eTl7SYkNEucMscoK6r
         OhhnaJ5xZZQ+C7dLOwl0essn7KfxdbFpmGq6l/SChulnsic6qrdLni+/qnaMiRr3ssVh
         4rdb3fa/vQrzw9OYxKyPTC6UjbHh0qllKUr2ge0Fi/sYkgmXc8glTWFe/yGx5MPjBkm7
         06zfXhJHF4FC4hfBL/mYyzji4Bw0bo5ep7yZwUKbA7DQ1HqIF4cpcpTmq5+HFlZYupq+
         0vWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=KARQoxN+swpbBLhre9m9uQ6DP0HU+CblvIQCT7poyNM=;
        b=OkAA6zLDbna7ZbnGZvVatMy9qaB1/WgVE3SFa4TtJNi0EBUiFCO9Jak6uuJu1kuwBi
         qECyQTD5MfUP83w7ZWa1Bnr/9KyYGx7wpN+pAxgwOAlHRfWTO8FIXEXk9qgLl4SQY7nu
         8+fqxnO9tJ4MHgyqmGVnYv9tYwMpZStYscpkm+nImitf1joczXhqqN2o0hOyooNW6vWs
         ijsLmZDG9IQc/oO/DlWvJFmj8lXEWlAyLP1fniYSexGfuuxOUOiPb0MEDm4sDDsgSDL0
         eH3IU18g07Qtd9M85AQ6kmdzxLLZT2UGIfEOjXyg7KZ+R0e5LTB8ljEGECekPsWl+BlG
         xOBg==
X-Gm-Message-State: AOAM5312zYUh5CL2B8J0M6JZx41KUpdDI+lVLGzXPinb4J/zeHxyNA3C
        4cAdAXCwERfa1ar9W7RH+GFgQw==
X-Google-Smtp-Source: ABdhPJzF/yh4i3Qlnywi67WPwUr8C87fsAbCmtG6bj8MCyHJi4MRrvUTI7QUNCamzrojr+wt0jpMow==
X-Received: by 2002:a63:4a09:0:b0:382:597:3d0d with SMTP id x9-20020a634a09000000b0038205973d0dmr19698694pga.18.1648922360594;
        Sat, 02 Apr 2022 10:59:20 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d21-20020a056a0024d500b004fb0e7c7c3bsm7471254pfv.161.2022.04.02.10.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 10:59:20 -0700 (PDT)
Message-ID: <6a73de2a-5cba-edd3-ecec-e0206f158b2d@kernel.dk>
Date:   Sat, 2 Apr 2022 11:59:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "Gabriel L. Somlo" <somlo@cmu.edu>, Borislav Petkov <bp@alien8.de>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Follow up block driver fix
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Got two reports on nbd spewing warnings on load now, which is a
regression from a commit that went into your tree yesterday. Please pull
this, reverting the problematic change for now.

Thanks!


The following changes since commit 2651ee5ae43241831ca63d7158bb2b151a6a0e1f:

  drbd: remove check of list iterator against head past the loop body (2022-03-31 17:08:15 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.18/drivers-2022-04-02

for you to fetch changes up to 7198bfc2017644c6b92d2ecef9b8b8e0363bb5fd:

  Revert "nbd: fix possible overflow on 'first_minor' in nbd_dev_add()" (2022-04-02 11:40:23 -0600)

----------------------------------------------------------------
for-5.18/drivers-2022-04-02

----------------------------------------------------------------
Jens Axboe (1):
      Revert "nbd: fix possible overflow on 'first_minor' in nbd_dev_add()"

 drivers/block/nbd.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

-- 
Jens Axboe

