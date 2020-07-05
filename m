Return-Path: <SRS0=GQ+f=AQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F435C433E0
	for <linux-block@archiver.kernel.org>; Sun,  5 Jul 2020 13:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A4AE20739
	for <linux-block@archiver.kernel.org>; Sun,  5 Jul 2020 13:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="j2jbHsrF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgGENF6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 Jul 2020 09:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgGENF5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 Jul 2020 09:05:57 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4C1C061794
        for <linux-block@vger.kernel.org>; Sun,  5 Jul 2020 06:05:57 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id md7so724885pjb.1
        for <linux-block@vger.kernel.org>; Sun, 05 Jul 2020 06:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=8hS9v/Wq2EmMJjFyv9QN9KzBMgFZNbV5hSqDzWbJAq0=;
        b=j2jbHsrF/hIaYgrlKaFvlv2OtdZt55QAJlC6rNH5/89pTwdEABl8KQA28S1+2lun7V
         zyE1um92hoyH+aEERA01omXLMw8iQW+ijlc51/Ow24hP/f8q8jGGASllId/qC4RoO7Za
         u0/5vc9J6ZefOoJDfjAKE6Lov79JB4ReoqEwUur+Y/BuPzte5B1F1jRNtPu3zv/zIVrI
         ECWgYS4BOgeEW77DOjP+Ws1Rm+L2rnZxaX+0NkE5ZfjQuvpbn06S/8dROvLhH3Fhk1Jm
         eJLGjvb5ZQAD7ORy/5nV5zWUqq5iKztQYgtdnFBWBsI0G2f3PRLwUmjedwYy0hx1ghrM
         6+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=8hS9v/Wq2EmMJjFyv9QN9KzBMgFZNbV5hSqDzWbJAq0=;
        b=nW1DNoIan7GHqAVho/li8ZCcitLsrV4g7HIIw7A3SfYoiRe9ygjNPMnI/76ZB+GcCG
         1s2bD0uztrW4qtdtUdi8AKqDhYyuEV3RzMjmLK2YnSad1l7cwD9aVZnxFxT44LlCiH8S
         0pX6oKLjn/fGtVBIfl6S7nMdMC8I2Z9eE+fNCBBML2MYABopwqmrKvvTIjRapu4CukX8
         vlqERZm3YlBfR/RoPeNgbIRmhD86BfBoaueoGLZv2PgBHnt26/dqJBZKVCEUGv8QTB0Q
         q/dqOYLk/qq8qPnhbC7xoG0GpCBHSbtBDv3jEA1SBkKncP9zIzzzfLYYKPI6quwHwqeP
         mCaA==
X-Gm-Message-State: AOAM533v+nwpokl+BXI8Ix3xJ/yP6lVAo1XeP4KSgXclT7+5TUVL4ej6
        WA0R9X01mpgDEqvU8odU5PWbQ1xKZwtTMA==
X-Google-Smtp-Source: ABdhPJwgfZxribzc1C+B36nf57xf6Sl4YX2b6dDJHeolIahF2Uh3RBJ5z/C3vdeOZO2W+E8MjveyJw==
X-Received: by 2002:a17:90a:324c:: with SMTP id k70mr48604108pjb.18.1593954357125;
        Sun, 05 Jul 2020 06:05:57 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id e8sm7353985pfl.125.2020.07.05.06.05.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2020 06:05:56 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.8-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <38cb5040-bc16-298d-bc78-624f22a9f0a1@kernel.dk>
Date:   Sun, 5 Jul 2020 07:05:55 -0600
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

A few later fixes came in after the initial -rc4 pull request, let's
flush them out before the release is tagged.

- NVMe pull request from Christoph
	- Fix crash in multi-path disk add (Christoph)
	- Fix ignore of identify error (Sagi)
- Fix a compiler complaint that a function should be static (Wei)

Please pull!


The following changes since commit e7eea44eefbdd5f0345a0a8b80a3ca1c21030d06:

  virtio-blk: free vblk-vqs in error path of virtblk_probe() (2020-06-30 19:02:58 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.8-2020-07-05

for you to fetch changes up to 3197d48a7c04eee3e50bd54ef7e17e383b8a919e:

  block: make function __bio_integrity_free() static (2020-07-02 12:38:18 -0600)

----------------------------------------------------------------
block-5.8-2020-07-05

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme: fix a crash in nvme_mpath_add_disk

Jens Axboe (1):
      Merge branch 'nvme-5.8' of git://git.infradead.org/nvme into block-5.8

Sagi Grimberg (1):
      nvme: fix identify error status silent ignore

Wei Yongjun (1):
      block: make function __bio_integrity_free() static

 block/bio-integrity.c         |  3 ++-
 drivers/nvme/host/core.c      | 12 +++++++++---
 drivers/nvme/host/multipath.c |  7 ++++---
 3 files changed, 15 insertions(+), 7 deletions(-)

-- 
Jens Axboe

