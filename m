Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB48C433F5
	for <linux-block@archiver.kernel.org>; Sun, 31 Oct 2021 19:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED3B608FE
	for <linux-block@archiver.kernel.org>; Sun, 31 Oct 2021 19:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhJaToc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Oct 2021 15:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhJaTo2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Oct 2021 15:44:28 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5E4C061570
        for <linux-block@vger.kernel.org>; Sun, 31 Oct 2021 12:41:56 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id f10so11876662ilu.5
        for <linux-block@vger.kernel.org>; Sun, 31 Oct 2021 12:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=C8M3qNpN1mW8zyBMWiCfmeuZLnfR/RubXGWaWqMUjIY=;
        b=tkG2L1ehu+2qLZZzO33gBNT4X21Y0iAN1pnikqvvyWa0dNGpvz4+FoFoMagCr+2MD6
         7zGJ07g35noaYfbgAhpKkQ9x6lU4uLJP2tdWU9F5/+PyEA6Sm8UZj6gDiQEPuQXhJBfL
         qC2EtTFYcsRuCGz+6qVU65JZxwd98Pkb8sJdKwTk1gjVQGNRMWDc05UIj8cQTx0iOHyo
         yA2Co75m7Lo4vuSQBU66y/Ce22vVDWfZnxsGRqszR01w5xkOPOJNoWCxb+FxNCGKQ3io
         GYZgxHsebl9UswgddYxTW+lRTbSyO2HlUs+5YVjWXV3mQ1NN27sAtCF05JDMY4BivC03
         QhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=C8M3qNpN1mW8zyBMWiCfmeuZLnfR/RubXGWaWqMUjIY=;
        b=sXm657D1bZWU2Cx0XZnPSlaxn4SHTUqRGo97ixxyltqwa26LtIkbCphNENV3n76j1h
         Y6jUASnpmSxgXXeUxxyLuvnDEMG0x03cnASf6zZW/I3iZvn4zNrRe/D1vSLdeGgjwqO6
         E3ELrNwqnYkvg13r0YrjN4NOjaTMoI/XPBGc21T/RRwoXp8eYNjFBz2ucVDh+/jbCIxN
         /+8s6HHNGldeu25FiMuoTqDdW5H1BtxAFkZE5LyMwmU3/AAZDgchlUD111Nex8EzUO6r
         S7McUGFEYV2U+YA8SRvnsMv0FD2WHuzNfHvS0ocln61sELmcZ0IKDXc7z/C1/WPFY9d6
         c/9g==
X-Gm-Message-State: AOAM532f4NAZJyfRFlDjINU56ZklXlTSZ/dhMQ7EjTiLMfv6pRXiuiRq
        KH0WjzTvHwnm9sWFKbE1wEN2eJcfXxAi+g==
X-Google-Smtp-Source: ABdhPJzVfTre3FCZb9R7Dsqldc5dLvBIBQQRBYNT7DCMU68bmNUD6phlDxCSVd9c8rzsCtyn240XJw==
X-Received: by 2002:a92:4453:: with SMTP id a19mr17448131ilm.233.1635709316183;
        Sun, 31 Oct 2021 12:41:56 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id k10sm7373246ilv.4.2021.10.31.12.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Oct 2021 12:41:55 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] block device inode syncing improvements
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <9ba39eb9-2f4a-849e-f502-bdd63c6e7d98@kernel.dk>
Date:   Sun, 31 Oct 2021 13:41:55 -0600
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

On top of the core block branch, this topic branch contains improvments
to how bdev inode syncing is handled.

Please pull!


The following changes since commit 8e9f666a6e66d3f882c094646d35536d2759103a:

  blk-crypto: update inline encryption documentation (2021-10-21 10:49:32 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.16/inode-sync-2021-10-29

for you to fetch changes up to 1e03a36bdff4709c1bbf0f57f60ae3f776d51adf:

  block: simplify the block device syncing code (2021-10-22 08:36:55 -0600)

----------------------------------------------------------------
for-5.16/inode-sync-2021-10-29

----------------------------------------------------------------
Christoph Hellwig (7):
      fs: remove __sync_filesystem
      block: remove __sync_blockdev
      xen-blkback: use sync_blockdev
      btrfs: use sync_blockdev
      fat: use sync_blockdev_nowait
      ntfs3: use sync_blockdev_nowait
      block: simplify the block device syncing code

 block/bdev.c                       | 28 ++++++++++++-----
 drivers/block/xen-blkback/xenbus.c |  2 +-
 fs/btrfs/volumes.c                 |  2 +-
 fs/fat/inode.c                     |  6 ++--
 fs/internal.h                      | 11 -------
 fs/ntfs3/inode.c                   |  2 +-
 fs/sync.c                          | 62 ++++++++++++++------------------------
 include/linux/blkdev.h             |  9 ++++++
 8 files changed, 56 insertions(+), 66 deletions(-)

-- 
Jens Axboe

