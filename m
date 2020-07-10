Return-Path: <SRS0=lEwc=AV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAD1C433E2
	for <linux-block@archiver.kernel.org>; Fri, 10 Jul 2020 15:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1454020720
	for <linux-block@archiver.kernel.org>; Fri, 10 Jul 2020 15:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zy6QqPgj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgGJP7D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgGJP7D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jul 2020 11:59:03 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08972C08C5CE
        for <linux-block@vger.kernel.org>; Fri, 10 Jul 2020 08:59:03 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id y2so6556029ioy.3
        for <linux-block@vger.kernel.org>; Fri, 10 Jul 2020 08:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=sshxZROtMsL3bx2E1WBVCj0HhuInivzg75r7U9dWl/E=;
        b=zy6QqPgjsxNy7F9M7UAhNMSKcUxGRFIyk8IMpE7lDF6FeP0ck/WOWY5cCZjo8XfHYq
         Ms+eGiA/dG7Z8lr3aF08Jt7UOVlV2VTLH8N1hqPQE8YGd2EzWlo2OdzuSptqla54itF2
         m9mbfx2ZviDQI8JNZMbydFrem70MsPbJnW4DK00lj2rmFLPXiZ/PNU044mpvJKQAz83x
         mjpCfIt758DNvmzH7mA70FPxRExDIoSkakx0xvDC3jF1MuCBTOMXl8weRmivy35ldWzG
         +AyPzqvHDVErzyazw+FL4E16haWlBYIGqnmAx/bqA1pv610ceJwXInudBV41UgYz+R0B
         a7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=sshxZROtMsL3bx2E1WBVCj0HhuInivzg75r7U9dWl/E=;
        b=ny1ygsejfUHuqLh+yytC7TbyrUEq24zfNSYxdGuUpi5y4hfxNSX1AUwoPKl5V473mT
         VZ5hsfkgTTZ+jJhYS8sRqqhxK6ezWpkv76WR9ehacMuOYanNgdM4F8swtUtbkLCNZXN9
         ipHX18TX5cTwnt+dqy3fCRVcd9DOFXMQ6lk5Vnmk2iJEITE81eb3Qi21lLYMFMAPpfR6
         I0Lp8bjlKes+zhOru9nsNw2Be7xdBCL1mOIKrUyFA56fI/E6AtJLJdBi9ZI3cHw540Ot
         oNXpmyToI8HYFlSLTa8NzIxWrvKwFCx+SKyio57RgNBAgGXoTMbM6Lqpu49MqODdjW9z
         ljRA==
X-Gm-Message-State: AOAM5312ZH+ukX+c0fPZfC43HxEVTcQwgJYIs0m2DLL5ffGjrhvTZPX+
        kt3CcCFhgIUf9ioqc/GM32WwQ4Q9ITMG4A==
X-Google-Smtp-Source: ABdhPJwg7iAi/O7ky69PwuK6nucNlMK4iXOpG0BtyJdNJoU3Xai5Om7yvdzI2veCoPTEvlY0JKJkqQ==
X-Received: by 2002:a05:6602:2cc9:: with SMTP id j9mr47985948iow.181.1594396741998;
        Fri, 10 Jul 2020 08:59:01 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t74sm3782744ild.6.2020.07.10.08.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 08:59:01 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.8-rc5
Message-ID: <2f92637d-8261-2cc1-fde0-66731020e435@kernel.dk>
Date:   Fri, 10 Jul 2020 09:59:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

- Fix for inflight accounting, which affects only dm (Ming)
- Fix documentation error for bfq (Yufen)
- Fix memory leak for nbd (Zheng)

Please pull!


The following changes since commit 3197d48a7c04eee3e50bd54ef7e17e383b8a919e:

  block: make function __bio_integrity_free() static (2020-07-02 12:38:18 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.8-2020-07-10

for you to fetch changes up to 579dd91ab3a5446b148e7f179b6596b270dace46:

  nbd: Fix memory leak in nbd_add_socket (2020-07-08 15:42:18 -0600)

----------------------------------------------------------------
block-5.8-2020-07-10

----------------------------------------------------------------
Ming Lei (1):
      blk-mq: consider non-idle request as "inflight" in blk_mq_rq_inflight()

Yufen Yu (1):
      docs: block: update and fix tiny error for bfq

Zheng Bin (1):
      nbd: Fix memory leak in nbd_add_socket

 Documentation/block/bfq-iosched.rst |  9 +--------
 block/blk-mq.c                      |  4 ++--
 drivers/block/nbd.c                 | 25 +++++++++++++++----------
 3 files changed, 18 insertions(+), 20 deletions(-)

-- 
Jens Axboe

