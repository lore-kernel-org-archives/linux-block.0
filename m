Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C1DC4363D
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 17:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6DFA20739
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 17:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UXv2i89o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgIVRFy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Sep 2020 13:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgIVRFy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 13:05:54 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A69AC061755
        for <linux-block@vger.kernel.org>; Tue, 22 Sep 2020 10:05:54 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id o20so13017839pfp.11
        for <linux-block@vger.kernel.org>; Tue, 22 Sep 2020 10:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=9Q4Bf1dL7sYozMlXm/4HSpdViZeWtz+/bQbnO2aHrJY=;
        b=UXv2i89oWiNPbNB309fw2x2ZGJgNnTwvsPzBOHQJK9QrFaqhPTCnoSjBI1qyqD6rG8
         qRSU0lByGjfu2HXc5vl2qSNxApKwy3zbsoJwy/E1MOwH5DJascAxPNXGXsSDfHSXZga5
         MqYO+XlpnsF4zkjCd9gqOtiDgAFDxdJmkNV3M/FT7fuZbAziGGtg5veNjwonI//u9Up/
         iPsUmtVxr9IlZyjb99q19c+wFrsP3WKZB9SbeV5PSI+Tg5nLh8MvzAUHxfbsSG2WpkH7
         Vj0S3YQ4g3dOmxWYZbwh/GtSBwv/N1MVIk8HWksc3mhD9qkEM37j8tDGQ6/s5RZF0fss
         a0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=9Q4Bf1dL7sYozMlXm/4HSpdViZeWtz+/bQbnO2aHrJY=;
        b=LcXCRgSstUeRRi6AHod5GwTm+V7TWs6xD59ZuxW/AW4FWh7a5ub63exrRHjp1pyhbb
         i7FwonV2Eyehu4J5TZ0X4Hzih3Lf+T2BqVq3ZEXA5izUHANGQ+fsDojMMSlPa46d+MqP
         /fN1XXt2+gyBhcmfHN1LxB/cQIMDUmeU/ntMbGGqccmuNB6gQwzq52qSFnhLnIn+vc4f
         W9dI11+u7GN2gbctpeZW2IjPm37sbwY9tlmBzD+7jvyjO2vK54f/YFGzkl2Zubol0paS
         WDenBQITPKRPsNNK/bsXhRnGPq3GV5dI/dQ1tZ3SVzyqPlAAl5xGjwgdnKBn/Kc0YDMD
         WeMg==
X-Gm-Message-State: AOAM533T8GLN6inI6qH1uVNU4ohVSAQxYo3/aQbBXDxVKc6q28lRZAGk
        uMv9Ifrc66qUKrqK1cN4JmZS8WvO94FXUw==
X-Google-Smtp-Source: ABdhPJxFGcuVnM8GDuXuxAnx2V5pR0B/ZGESBqlGWqOWjhdZHYt6ttxSpsajK3w24Vhf3VVOLEZ81A==
X-Received: by 2002:a17:902:d68e:b029:d2:2a15:5516 with SMTP id v14-20020a170902d68eb02900d22a155516mr5314584ply.75.1600794353360;
        Tue, 22 Sep 2020 10:05:53 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f207sm16603202pfa.54.2020.09.22.10.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 10:05:52 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.9-rc
Message-ID: <ba52c998-b99a-e8bc-c78f-583e5e09e045@kernel.dk>
Date:   Tue, 22 Sep 2020 11:05:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A few NVMe fixes, and a dasd write zero fix.

Please pull.

The following changes since commit fd04358e0196fe3b7b44c69b755c7fc329360829:

  Merge tag 'nvme-5.9-2020-09-10' of git://git.infradead.org/nvme into block-5.9 (2020-09-10 07:12:22 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.9-2020-09-22

for you to fetch changes up to 4a2dd2c798522859811dd520a059f982278be9d9:

  Merge tag 'nvme-5.9-2020-09-17' of git://git.infradead.org/nvme into block-5.9 (2020-09-17 11:49:44 -0600)

----------------------------------------------------------------
block-5.9-2020-09-22

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvme-core: get/put ctrl and transport module in nvme_dev_open/release()

Christoph Hellwig (1):
      nvmet: get transport reference for passthru ctrl

David Milburn (1):
      nvme-pci: disable the write zeros command for Intel 600P/P3100

Jan Höppner (1):
      s390/dasd: Fix zero write for FBA devices

Jens Axboe (1):
      Merge tag 'nvme-5.9-2020-09-17' of git://git.infradead.org/nvme into block-5.9

Necip Fazil Yildiran (1):
      nvme-tcp: fix kconfig dependency warning when !CRYPTO

 drivers/nvme/host/Kconfig      |  1 +
 drivers/nvme/host/core.c       | 15 +++++++++++++++
 drivers/nvme/host/pci.c        |  3 ++-
 drivers/nvme/target/passthru.c |  2 ++
 drivers/s390/block/dasd_fba.c  |  9 ++++++++-
 5 files changed, 28 insertions(+), 2 deletions(-)

-- 
Jens Axboe

