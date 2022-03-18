Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55917C433EF
	for <linux-block@archiver.kernel.org>; Fri, 18 Mar 2022 17:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiCRRG2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Mar 2022 13:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239496AbiCRRG1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Mar 2022 13:06:27 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D03C30DC5E
        for <linux-block@vger.kernel.org>; Fri, 18 Mar 2022 10:05:08 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id b16so9994982ioz.3
        for <linux-block@vger.kernel.org>; Fri, 18 Mar 2022 10:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=gnGhXbv42l+coz8zYUiKIZoMSVg6YT1PKWPDZgBEbS0=;
        b=ITKJ3Xjg09M53AfQOEzxAlKEWBoUe54Icg4/uNoh9EGzH3hpMPHU9qpGtgjMtaai9x
         JMJ6PX8nxuUpWkttk5Ys0vi3IT1osiDgdzrkOIHcahyE6i0S34u1L6WT/lvHOUQf4DQZ
         O1tdLjO/WUYECqSgHUxFi+rGe0CaRs/xNsG9EmsbtBmhatE++BgCNNPk4swTOCMQwDbG
         LmMLVB3JmV45DtSY8qVY1hcxNi9i/0zywdpAFBW2Gktptn9nM9Muknw+MaWE3IWRLg19
         A007Jm+TJpzyRlrvViC60h8sMfZPr64qZS0asG2CXDjMt+AWvDXEJKzil7pg1eKnJhVZ
         fBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=gnGhXbv42l+coz8zYUiKIZoMSVg6YT1PKWPDZgBEbS0=;
        b=E5gtXjadvBY+CqTaqIs0kkrMTTsRaTJfCsWleVLU+oCld6BwBY9lvYg1dNBuYo8Vk8
         S8+XfwWtXZJ3vvgmTWzFyaoYwAYr9pXI2jMOxnjpze539SmhwwsNGzfL6keS++4V+B/Q
         0UkVQ4kdbv21yfbJZ2Zci8fC4VlmvELCgNJqfDwZ48oRk7QNqtk9cfwfCx7PAzxQivBR
         aIG0ewZfHJK2QZ0E5+An9/0zHWQhzw/ztCsyPxQv8RNb40zF47QTKazlxZFFiQYjRUMK
         4rTvpBwdu3gY2N1toY/AgHTBLwzeUOMv1QFyWW9+Unhju0Kyc1/QMAPgXULISCqiE96Y
         dUAw==
X-Gm-Message-State: AOAM531va6xehs/X9msQdV7VXWDcZrzYKNH3RXQBALB01wUibHTGUjt4
        aq66UGSD1cHChL/JoKn9KZxagscZFfYJtcb/
X-Google-Smtp-Source: ABdhPJzLZPrN2N/WawdhgABOCvwsTvsRwQxsrFoCFeAUj1MPfo+LXQdOsH+qED9284HXZn1JJiKUew==
X-Received: by 2002:a5e:990b:0:b0:645:e9e5:3a9b with SMTP id t11-20020a5e990b000000b00645e9e53a9bmr4689428ioj.164.1647623107653;
        Fri, 18 Mar 2022 10:05:07 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m4-20020a0566022e8400b006463059bf2fsm4798303iow.49.2022.03.18.10.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 10:05:07 -0700 (PDT)
Message-ID: <667d556f-dc12-0cc2-2abf-5a478fd93d35@kernel.dk>
Date:   Fri, 18 Mar 2022 11:05:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] block fixes for 5.17-final
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Two fixes that should make 5.17:

- Revert of a nvme target feature (Hannes)

- Fix a memory leak with rq-qos (Ming)

Please pull!


The following changes since commit 0a5aa8d161d19a1b12fd25b434b32f7c885c73bb:

  block: fix blk_mq_attempt_bio_merge and rq_qos_throttle protection (2022-03-08 17:48:39 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.17-2022-03-18

for you to fetch changes up to f6189589fa7cc4fb6b53f2929f69f0505123202f:

  Merge tag 'nvme-5.17-2022-03-16' of git://git.infradead.org/nvme into block-5.17 (2022-03-16 05:43:25 -0600)

----------------------------------------------------------------
block-5.17-2022-03-18

----------------------------------------------------------------
Hannes Reinecke (1):
      nvmet: revert "nvmet: make discovery NQN configurable"

Jens Axboe (1):
      Merge tag 'nvme-5.17-2022-03-16' of git://git.infradead.org/nvme into block-5.17

Ming Lei (1):
      block: release rq qos structures for queue without disk

 block/blk-core.c               |  4 ++++
 drivers/nvme/target/configfs.c | 39 ---------------------------------------
 drivers/nvme/target/core.c     |  3 +--
 3 files changed, 5 insertions(+), 41 deletions(-)

-- 
Jens Axboe

