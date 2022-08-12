Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC30C25B08
	for <linux-block@archiver.kernel.org>; Fri, 12 Aug 2022 12:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbiHLMs6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Aug 2022 08:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238212AbiHLMsz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Aug 2022 08:48:55 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A59AA59AA
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 05:48:55 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 24so710833pgr.7
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 05:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=7ZYQjBwRXSaIkz5D61Jl/CDVRMlG6Eot6msf86NvUkg=;
        b=yjWV2fmg5u6Rwh/rNp/075YUe6QfM5Xz/RLDDGZ9RmLXoQUaBXysl46cz3UxDXTUri
         OLu36UpeTVCw3F2ktMI/B9zAX93KpJfVUt1NVQ2fSCbP5OYcH8qHdtom7BaXcgeB9GcB
         e7pc6GO3vqv30MbfiwELCEYxksbFz1p4tdyy7kOiP3NrGYXz9tu6pLib0of57LIggu3i
         p+9Lz5Ig8S9dIm3dUzVdUUp2LJtOOwGLWfZSLFUGvVm1ELlabMjD4YzJmXL1YDzcoCyC
         7Kjw1ZJAhjKd7E9UAZ1SwcDDmC2xt2xieQYqxIYkmWwzWlJ8SbLNqeouZeacdDeKwTeA
         yqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=7ZYQjBwRXSaIkz5D61Jl/CDVRMlG6Eot6msf86NvUkg=;
        b=2lXE+b42bc++oYz/ufDLdCaMvK4tVH/VBfW7i2yRDXhQGTs0iJqqeRRvtyR5fEIMwL
         erK8aNUgV59YOkyQL7yyrtIOtDMedibpSABXtUfzYW/k+XT4QPxtWORsXBrmmLU2XOZc
         HQXoX7U2poRInW6u8aAoeeF4aB+jpI60YEwoWNM+MzmAGttOmtr464nO+LrpB+f6ialg
         wN43Mv7V4Ud6Uvlp7FZTn6zMCgGqV80o6LPEMb4Mv7/2/QusbTW+5mojAi4y6Coedt3m
         B//jfPqYXb8pfoJRbN4KY0K9NwGAG+Kg2YydWxocjtkHcmvvK0bQG/UhRedeGY2Ja3Hy
         kNUA==
X-Gm-Message-State: ACgBeo15+J3oUspbTkqDsQT6sQd2Id1/OAjyUY+gzM1VP/HkHJxutbaE
        uYiwuBIE+veqnr9znn8JgPB2mkE8MlcRmg==
X-Google-Smtp-Source: AA6agR7GzDlHhEnrzySqOGcR0oC3IkiOTdS2ggytPPXlqQJgzb0kouRN7LV7W2bk+DjBWBHDYye+mA==
X-Received: by 2002:a05:6a00:1a4f:b0:52e:33bf:f3d with SMTP id h15-20020a056a001a4f00b0052e33bf0f3dmr3696577pfv.61.1660308534538;
        Fri, 12 Aug 2022 05:48:54 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j125-20020a625583000000b0052e987c64efsm1569213pfb.174.2022.08.12.05.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 05:48:53 -0700 (PDT)
Message-ID: <b244d065-93f3-cc44-19a1-801b301875f5@kernel.dk>
Date:   Fri, 12 Aug 2022 06:48:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.0-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Minor set of fixes for 6.0-rc1:

- NVMe pull request
	- print nvme connect Linux error codes properly (Amit Engel)
	- fix the fc_appid_store return value (Christoph Hellwig)
	- fix a typo in an error message (Christophe JAILLET)
	- add another non-unique identifier quirk (Dennis P. Kliem)
	- check if the queue is allocated before stopping it in nvme-tcp
	  (Maurizio Lombardi)
	- restart admin queue if the caller needs to restart queue in
	  nvme-fc (Ming Lei)
	- use kmemdup instead of kmalloc + memcpy in nvme-auth
	  (Zhang Xiaoxu)

- __alloc_disk_node() error handling fix (Rafael)

Please pull!


The following changes since commit fa9db655d0e112c108fe838809608caf759bdf5e:

  Merge tag 'for-5.20/block-2022-08-04' of git://git.kernel.dk/linux-block (2022-08-04 20:00:14 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-6.0-2022-08-12

for you to fetch changes up to aa0c680c3aa96a5f9f160d90dd95402ad578e2b0:

  block: Do not call blk_put_queue() if gendisk allocation fails (2022-08-12 06:42:06 -0600)

----------------------------------------------------------------
block-6.0-2022-08-12

----------------------------------------------------------------
Amit Engel (1):
      nvme-fabrics: parse nvme connect Linux error codes

Christoph Hellwig (1):
      nvme-fc: fix the fc_appid_store return value

Christophe JAILLET (1):
      nvme-fabrics: Fix a typo in an error message

Dennis P. Kliem (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA XPG GAMMIX S70

Jens Axboe (1):
      Merge tag 'nvme-6.0-2022-08-11' of git://git.infradead.org/nvme into block-6.0

Maurizio Lombardi (1):
      nvme-tcp: check if the queue is allocated before stopping it

Ming Lei (1):
      nvme-fc: restart admin queue if the caller needs to restart queue

Rafael Mendonca (1):
      block: Do not call blk_put_queue() if gendisk allocation fails

Zhang Xiaoxu (1):
      nvmet-auth: use kmemdup instead of kmalloc + memcpy

 block/genhd.c                          | 4 +---
 drivers/nvme/host/fabrics.c            | 8 +++++++-
 drivers/nvme/host/fc.c                 | 5 ++++-
 drivers/nvme/host/pci.c                | 2 ++
 drivers/nvme/host/tcp.c                | 3 +++
 drivers/nvme/target/fabrics-cmd-auth.c | 4 ++--
 6 files changed, 19 insertions(+), 7 deletions(-)

-- 
Jens Axboe

