Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E8EC4332F
	for <linux-block@archiver.kernel.org>; Fri, 11 Nov 2022 20:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiKKUxO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Nov 2022 15:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiKKUxM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Nov 2022 15:53:12 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8E386D57
        for <linux-block@vger.kernel.org>; Fri, 11 Nov 2022 12:53:10 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id i5so3064808ilc.12
        for <linux-block@vger.kernel.org>; Fri, 11 Nov 2022 12:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/N5dh8Y4qp5wbIJDG1mJS9Xu2k3yzjM+oOOsvyXPMI=;
        b=a9vs07VLkzBfwGdw4ooidPTf+zKX2WTu4p0cEwJGj0gPMB2PUso0pd9pamyu+rF0J0
         xUCxse5IQ3LFYfmxeuWzySZCD2JrDH6Cu1J6boUZQ2BKvjZyZPsGRfpkY6DPl7DKjXgH
         PEbBTWCNNSd6XIUEcp3LWyzmvQzfKvzejOk6dePj/9GqxVT+ltCJWyhFJ8Yv73j2Cis9
         p+oFG3cYoUY1e2MLcmOtxE39oiO7zg+QEBN/6TL87GEBoRLsYvFO/5Tw4fbDYhbcqkDQ
         3lbcBMfWEB4h97X1ic2jd1qBJpv+rzfCxHjeDJrdhL1kJ4m88PIjAXDKwrgT5U4ZVNrP
         rmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2/N5dh8Y4qp5wbIJDG1mJS9Xu2k3yzjM+oOOsvyXPMI=;
        b=H03gvyHKbzFC2HyKFm3PnCQx7kehvvosIda8dl/WAxQRuScrVpm64E37XUfSVQtT/4
         BIT+E2HnsA+Zsg0+JWQGLl9GovQLsd3ufONJQh/7jxZp6SV6Af25QXptsYmMyYpe/Uzn
         95IbCFK9feUBZ5ax/GFA8q2NZzpkXsjGEt02aj70UnGCEVVHgZfNFWpT9zyi/sClGef1
         uJgHTCGolaKg/mpNZHXV1ECX4uFhDu8xL+h5sYHyCxFND986jz/Gcx9T9xjpUerKMRMi
         C+mI6QcJ5rAWsYlQFUd7bDlU0nroeZGX8biAzZcp4jXSVOjWo8qz+tnx0/0ZQck0oIKq
         HsuQ==
X-Gm-Message-State: ANoB5pn24CDQmoOtwFdWWnZ/NTOIa+sDOl7FCGkF9ht65gYc4v3bvrPR
        kjif2qzFXKkmfZFV6qdsH7Rc/2TOOzF3kA==
X-Google-Smtp-Source: AA0mqf52DVscYZLq3m2KoYKmh/j8/fhf82Eg9ZyddQBIiJOXhZtImyUmcLY8Ilf2XuOp5ov9OVcaFA==
X-Received: by 2002:a05:6e02:1046:b0:2fa:f363:2696 with SMTP id p6-20020a056e02104600b002faf3632696mr1892913ilj.174.1668199989814;
        Fri, 11 Nov 2022 12:53:09 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d123-20020a026281000000b00375126ae55fsm1056956jac.58.2022.11.11.12.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 12:53:09 -0800 (PST)
Message-ID: <38f29c47-61fb-3882-a054-a577ec41996c@kernel.dk>
Date:   Fri, 11 Nov 2022 13:53:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.1-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A few fixes for this release:

- NVMe pull request via Christoph
	- Quiet user passthrough command errors (Keith Busch)
	- Fix memory leak in nvmet_subsys_attr_model_store_locked
	- Fix a memory leak in nvmet-auth (Sagi Grimberg)

- Fix a potential NULL point deref in bfq (Yu)

- Allocate command/response buffers separately for DMA for sed-opal,
  rather than rely on embedded alignment (Serge)

Please pull!


The following changes since commit 878eb6e48f240d02ed1c9298020a0b6370695f24:

  block: blk_add_rq_to_plug(): clear stale 'last' after flush (2022-10-31 20:21:38 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.1-2022-11-11

for you to fetch changes up to df24560d058d11f02b7493bdfc553131ef60b23d:

  Merge tag 'nvme-6.1-2022-11-10' of git://git.infradead.org/nvme into block-6.1 (2022-11-10 06:55:02 -0700)

----------------------------------------------------------------
block-6.1-2022-11-11

----------------------------------------------------------------
Aleksandr Miloserdov (1):
      nvmet: fix memory leak in nvmet_subsys_attr_model_store_locked

Jens Axboe (1):
      Merge tag 'nvme-6.1-2022-11-10' of git://git.infradead.org/nvme into block-6.1

Keith Busch (1):
      nvme: quiet user passthrough command errors

Sagi Grimberg (1):
      nvmet: fix a memory leak

Serge Semin (1):
      block: sed-opal: kmalloc the cmd/resp buffers

Yu Kuai (1):
      block, bfq: fix null pointer dereference in bfq_bio_bfqg()

 block/bfq-cgroup.c             |  4 ++++
 block/sed-opal.c               | 32 ++++++++++++++++++++++++++++----
 drivers/nvme/host/core.c       |  3 +--
 drivers/nvme/host/pci.c        |  2 --
 drivers/nvme/target/configfs.c |  8 ++++++--
 5 files changed, 39 insertions(+), 10 deletions(-)

-- 
Jens Axboe
