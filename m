Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2A6C4332F
	for <linux-block@archiver.kernel.org>; Thu, 13 Oct 2022 19:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiJMT14 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Oct 2022 15:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJMT1x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Oct 2022 15:27:53 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725A616D8A4
        for <linux-block@vger.kernel.org>; Thu, 13 Oct 2022 12:27:51 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id n73so2193219iod.13
        for <linux-block@vger.kernel.org>; Thu, 13 Oct 2022 12:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJMPfntCg3kekZt10F+0PN4QqWgYFf9wV91hd+TMMXk=;
        b=ldUoH7arvUmw+gcDgvGHsw7Ut3V2MEznQpNgrThm3Z6XGcvsTurlRxWObxDDYeN8nq
         l4ArxEflFgsOqn8evmFwCNwps8gtCECZepq7Hi1tNFeE6FTFGziFaXltOPLbIqGFq/YL
         hDv3XrDoawO1pCRqNn4OEWvCSGUDnh1qBGBN+HkcbxMgmMNviubJypwgQyBKuzzLSs+6
         1Ar8Sfl4Uq8HoZ84KokHwhykiwuLmPkEOr39TT3My5NZEl+PnAbIo7mZNZhsfmR4fA29
         gOzpC381gpPVClE8/28lch0Z+dtpOuvlfyal/cJXFhDHNmAORnuWtmKJsTzV1/X5Bqfx
         6iqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MJMPfntCg3kekZt10F+0PN4QqWgYFf9wV91hd+TMMXk=;
        b=IUhZVba5J9OCFcDBpF+40CzJh75a/GmxWeNrSZUFV8yudVkjoCZlOu/Sb5kY+T7xV8
         f2+5la6msTovO68Y5tcwrbjyyonZEZ5BrgcC2+PusxDbIr14h+vOjnbJ/i5s4Ik8FhzM
         Rf5sOoXWEYqBZx+Uw0LLniLR1usdNksLC4ALZVUjkELLetWClyv0FWWoia9k8TSwopLE
         bgB1CgW9Ayra/B8QrSVPKTb7fE5y3/+CMSh30Ov0UQStkVpxsOXQml6ST9iWEQACtQpt
         0rOglXuXaSltGtfnjE7iSiSZ+UZiSrIaFhDbNUwaKHe2xmFkIf3jgqItGqhDqeeoXMdE
         Q4gA==
X-Gm-Message-State: ACrzQf1e8bC+o6fNy30jNM84aTsHkJaCLb96hvLmgcNwg7o/kUohnXQG
        bHOqV/1xAzSZ6xytz2kZSA6nUsH5N8sRzfaX
X-Google-Smtp-Source: AMsMyM4akwqoBSvrFfxBp3lDhTjl0gWlX08/xiWRTP/fyid4qpQG+Pp6ZC3G+aSvGd6WabOKp+AMtw==
X-Received: by 2002:a05:6638:4304:b0:343:5953:5fc8 with SMTP id bt4-20020a056638430400b0034359535fc8mr854516jab.123.1665689270691;
        Thu, 13 Oct 2022 12:27:50 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v2-20020a02b902000000b0035b61be147fsm292126jan.21.2022.10.13.12.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 12:27:50 -0700 (PDT)
Message-ID: <57f8b4fd-02a2-94c9-3af0-8b4115356d7a@kernel.dk>
Date:   Thu, 13 Oct 2022 13:27:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Followup block fixes for 6.1-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Fixes that ended up landing later than the initial block pull request.
Nothing really major in here:

- NVMe pull request via Christoph:
	- add NVME_QUIRK_BOGUS_NID for Lexar NM760 (Abhijit)
	  avoid the deepest sleep state on ZHITAI TiPro5000 SSDs
	  (Xi Ruoyao)
	- fix possible hang caused during ctrl deletion (Sagi Grimberg)
	- fix possible hang in live ns resize with ANA access
	  (Sagi Grimberg)

- Proactively avoid a sign extension issue with the queue flags (Brian)

- Regression fix for hidden disks (Christoph)

- Update OPAL maintainers entry (Jonathan)

- blk-wbt regression initialization fix (Yu)

Please pull!


The following changes since commit 493ffd6605b2d3d4dc7008ab927dba319f36671f:

  Merge tag 'ucount-rlimits-cleanups-for-v5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace (2022-10-09 16:24:05 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.1-2022-10-13

for you to fetch changes up to 3bc429c1e2cf6fa830057c61ae93d483f270b8ff:

  Merge tag 'nvme-6.1-2022-10-12' of git://git.infradead.org/nvme into block-6.1 (2022-10-12 07:15:53 -0600)

----------------------------------------------------------------
block-6.1-2022-10-13

----------------------------------------------------------------
Abhijit (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for Lexar NM760

Brian Foster (1):
      block: avoid sign extend problem with default queue flags mask

Christoph Hellwig (1):
      block: fix leaking minors of hidden disks

Deming Wang (1):
      block: Remove the repeat word 'can'

Jens Axboe (2):
      Merge branch 'for-6.1/block' into block-6.1
      Merge tag 'nvme-6.1-2022-10-12' of git://git.infradead.org/nvme into block-6.1

Jonathan Derrick (1):
      MAINTAINERS: Update SED-Opal Maintainers

Sagi Grimberg (3):
      nvme-rdma: fix possible hang caused during ctrl deletion
      nvme-tcp: fix possible hang caused during ctrl deletion
      nvme-multipath: fix possible hang in live ns resize with ANA access

Xi Ruoyao (1):
      nvme-pci: avoid the deepest sleep state on ZHITAI TiPro5000 SSDs

Yu Kuai (1):
      blk-wbt: fix that 'rwb->wc' is always set to 1 in wbt_init()

 MAINTAINERS                   | 3 +--
 block/bio.c                   | 2 +-
 block/blk-wbt.c               | 3 +--
 block/genhd.c                 | 7 +++++++
 drivers/nvme/host/multipath.c | 1 +
 drivers/nvme/host/pci.c       | 4 ++++
 drivers/nvme/host/rdma.c      | 2 +-
 drivers/nvme/host/tcp.c       | 2 +-
 include/linux/blkdev.h        | 6 +++---
 9 files changed, 20 insertions(+), 10 deletions(-)

-- 
Jens Axboe
