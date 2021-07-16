Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00808C07E95
	for <linux-block@archiver.kernel.org>; Fri, 16 Jul 2021 14:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C64B260FE7
	for <linux-block@archiver.kernel.org>; Fri, 16 Jul 2021 14:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbhGPO14 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jul 2021 10:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbhGPO1z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jul 2021 10:27:55 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB2CC06175F
        for <linux-block@vger.kernel.org>; Fri, 16 Jul 2021 07:25:00 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id b14-20020a056830310eb02904c7e78705f4so9990956ots.13
        for <linux-block@vger.kernel.org>; Fri, 16 Jul 2021 07:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=g7fCH9z1o+FhUI94OWTsT7bPkqKdjEt9wSRt8sGwj80=;
        b=GwSnzZLLWPB7AB+0aj1LovlUAKNpDTwNS8LsEcptx37lGKn3Hj048hP+lC/mwfWNjU
         PeVUsXhzxUb0QQEZnitsBA8gm2P8oNuCFGmruxZJDDGxUCTUbhLkHeuOeXWk/6689IOd
         5aagQh1iotzXNAkO1+5/M1kepYFX3A2W71S4EWK/1LGoPDS09oWYPGyx1RMQEbjvGIHa
         Yr/0WKWcqCRX4jMSib3M6EvBJi+oeY+y40se/p9eeoiJuxTj4zZaHMugndq5ZDLyo8c5
         dDgTZ2DjCEXFOo2Zye6X8BPlmUAfvFc/XDoNHCNePKt6nONy2drPRroVVBQB7BdAwN/s
         zqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=g7fCH9z1o+FhUI94OWTsT7bPkqKdjEt9wSRt8sGwj80=;
        b=b+iUYjwwxXVrM6erSAdXCMYFpt+xGG7N+4SgvpobiQ8T1o8KiHW9tex2StGatGnJSw
         NSYwI7lGhKKMj3fVdMQ2lxDYqQOtVWi4VYZ9LDQIE9zby600CCffxrWwppLKfJGe9TyZ
         gUti/DdRO61dUMYVtAbRAokZeH+QMgBgFqfWlcLs4pUePijEeqoIctmm1B5H++pA7Uqa
         pK5oMbU1rCZcvalHeuZ8W1bqcNZz4vwQmAWsMjobT/FOKphnt2K7hNtoL06+dVn1UpSQ
         rQxibpuOTHbjKH/+4uIzfz/AnLJRcyStz8bxm5rpLxeO84lw7fQUC6SfW3zJrayNRIpG
         CC0w==
X-Gm-Message-State: AOAM531c4E8RepjBwVWjedaFlnnMQgU+MSL/FVANWACwlhjlGJjfcY5/
        xd4oTo2e1MnsvkGbzuw+qOWZRGD9ddAlZ9u0
X-Google-Smtp-Source: ABdhPJxpRUhsi7W1phU7Fksnw3T8YI8Gj3ZKUuaJAY94sr5afwzRiPJOLYyoo2X0dnQGHkiqaX5uxA==
X-Received: by 2002:a9d:2d82:: with SMTP id g2mr8771958otb.30.1626445499932;
        Fri, 16 Jul 2021 07:24:59 -0700 (PDT)
Received: from [192.168.1.187] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id l7sm1878505otu.76.2021.07.16.07.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 07:24:59 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.14-rc
Message-ID: <2b7767f1-3ff0-e65f-398d-4934417dc44e@kernel.dk>
Date:   Fri, 16 Jul 2021 08:24:57 -0600
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

A few fixes for the 5.14 release:

- NVMe fixes (via Christoph)
	- fix various races in nvme-pci when shutting down just after
	  probing (Casey Chen)
	- fix a net_device leak in nvme-tcp (Prabhakar Kushwaha)

- Fix regression in xen-blkfront by cleaning up the removal state
  machine (Christoph)

- Fix tag_set and queue cleanup ordering regression in nbd (Wang)

- Fix tag_set and queue cleanup ordering regression in pd (Guoqing)

Please pull!


The following changes since commit a731763fc479a9c64456e0643d0ccf64203100c9:

  blk-cgroup: prevent rcu_sched detected stalls warnings while iterating blkgs (2021-07-07 09:36:36 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.14-2021-07-16

for you to fetch changes up to 05d69d950d9d84218fc9beafd02dea1f6a70e09e:

  xen-blkfront: sanitize the removal state machine (2021-07-15 09:32:34 -0600)

----------------------------------------------------------------
block-5.14-2021-07-16

----------------------------------------------------------------
Casey Chen (2):
      nvme-pci: fix multiple races in nvme_setup_io_queues
      nvme-pci: do not call nvme_dev_remove_admin from nvme_remove

Christoph Hellwig (1):
      xen-blkfront: sanitize the removal state machine

Guoqing Jiang (1):
      pd: fix order of cleaning up the queue and freeing the tagset

Jens Axboe (1):
      Merge tag 'nvme-5.14-2021-07-15' of git://git.infradead.org/nvme into block-5.14

Prabhakar Kushwaha (1):
      nvme-tcp: use __dev_get_by_name instead dev_get_by_name for OPT_HOST_IFACE

Wang Qing (1):
      nbd: fix order of cleaning up the queue and freeing the tagset

 drivers/block/nbd.c          |   2 +-
 drivers/block/paride/pd.c    |   2 +-
 drivers/block/xen-blkfront.c | 224 +++++--------------------------------------
 drivers/nvme/host/pci.c      |  67 +++++++++++--
 drivers/nvme/host/tcp.c      |   4 +-
 5 files changed, 87 insertions(+), 212 deletions(-)

-- 
Jens Axboe

