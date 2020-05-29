Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491DCC433DF
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 20:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C7D320B80
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 20:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nx8EWoDe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgE2ULP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 16:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgE2ULP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 16:11:15 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D054BC03E969
        for <linux-block@vger.kernel.org>; Fri, 29 May 2020 13:11:14 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o6so449709pgh.2
        for <linux-block@vger.kernel.org>; Fri, 29 May 2020 13:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Rv6PuLEgnRd+tT33smN4BQPe8owNOFO8tCDYPE0B/+U=;
        b=nx8EWoDeT106og6xvrbaVTjDcWNd2cJdKk4iyxfab/QPfCrgjmi53OUug/nIiJ63AL
         Uc6RoHm2ZXSgdVWFsZM0/PfYXGG7mZioT+oYekelG2XzBfIhUL93tMwS1Ovf2Zfg9pFD
         VufHUMlF2rm+qBhXSabJFnflPo/zFygFou7YwHMnrnCM6Gjnd2hsrH20fp0iENPzc2Ax
         oVTO/JISaPsTmJISGw+UGNwng1pge+CfWLGMCRrlz+R8+TYaR4vD0MtokO5a3SBQAs71
         S2wsWxH3p6XeawwBbdzcNsajPhIAxeDMsHAEb5P8uEQqqXFK4VbScfyBerRhnVdJpfBq
         EyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Rv6PuLEgnRd+tT33smN4BQPe8owNOFO8tCDYPE0B/+U=;
        b=DLHYoHHogaTwwm8gLsncOvO6f9aXcuSbqktW5K6zlAChiH6cD+5WNBwTGX/uY/f2t9
         R8bYwjVzCRK5dGjmvLMa86lAHlqssDI7440UpUmAcdvguKe35lIHQaA1gA1qFGXJIUQi
         AZFrTZ0Fh0bx+IlIYZcHkiSVYiO18oTpxNEJrdZbkH48f8aOu19btQe3Rwu4vyjersUC
         aqP2ZSBxQ8r5PIvC5udjwg2avBk3/QIHm0yzPRDExnsxvSgr6fYwSU45UYf08cvO6Hw3
         AQmH826AZ8K0KX9kLuTu1Yk8qZkGbJdeSJekw8N9MCptn04qb3XCH39814+tDXEmA5kX
         JW9Q==
X-Gm-Message-State: AOAM533Ts4MvPV7BJ0qhc3C++wEApuntCEqdmHvZktoc8EIw9TxqV4B4
        LMxLXHKdrUrPBJdblGKZvaJHIJ+1YR6/gw==
X-Google-Smtp-Source: ABdhPJwGLWcZ1gUHUZJMgZkr3aFQ6BvgCK7PMOHfVus1px7XtFlrCRdPRHDVYdgq/Cukl40SLBtIzg==
X-Received: by 2002:a62:1844:: with SMTP id 65mr10495597pfy.112.1590783073911;
        Fri, 29 May 2020 13:11:13 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id k4sm7990412pfp.173.2020.05.29.13.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 13:11:13 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.7 final
Message-ID: <19c1adb7-0bd0-9657-2cce-0a6393631b46@kernel.dk>
Date:   Fri, 29 May 2020 14:11:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Two small fixes:

- Revert a block change that mixed up the return values for non-mq
  devices

- NVMe poll race fix

Please pull!


  git://git.kernel.dk/linux-block.git tags/block-5.7-2020-05-29


----------------------------------------------------------------
Dongli Zhang (1):
      nvme-pci: avoid race between nvme_reap_pending_cqes() and nvme_poll()

Jens Axboe (2):
      Merge branch 'nvme-5.7' of git://git.infradead.org/nvme into block-5.7
      Revert "block: end bio with BLK_STS_AGAIN in case of non-mq devs and REQ_NOWAIT"

 block/blk-core.c        | 11 ++++-------
 drivers/nvme/host/pci.c | 11 +++++++----
 2 files changed, 11 insertions(+), 11 deletions(-)

-- 
Jens Axboe

