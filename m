Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898B2C433F5
	for <linux-block@archiver.kernel.org>; Sun, 31 Oct 2021 19:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7194A60EB1
	for <linux-block@archiver.kernel.org>; Sun, 31 Oct 2021 19:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhJaTpK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Oct 2021 15:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhJaTpH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Oct 2021 15:45:07 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A95C061570
        for <linux-block@vger.kernel.org>; Sun, 31 Oct 2021 12:42:34 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id p204so7548803iod.8
        for <linux-block@vger.kernel.org>; Sun, 31 Oct 2021 12:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Ye+eK9WKg7RD8X/56KrSW/Eh9eyMI6TOtSKK2Q/761w=;
        b=YD4aprUPtya1tv2lyxtg3of40PfmNwbOqQyAPpy7PIDvgLTreAdNxEXQsP3Vy59W6m
         qIecVBN4AEDOwt7V8Jx00dD+R/iuTARz+AXJ5Zy9dnjqF5Fo6i88tirj6W8MP64eAVvX
         oLYoGUWRYsAX+KClGakvm9/c9cFKyFKunw90QoDf3kVNBcxD19E4EAi/ffJotd8wyNa/
         zYCQm0KEY9q6xKkaMk8+Xq2VYmKC5oF8Z1nBy1gU8VrVP4cEtiX+S7tYZY7OoNyG92KA
         DMqdHuuzC/8FsWj/QyMqyjyW5Ls58AmxTucQ90blUfVn75xxeebTJsiM5RtBTjbEIX35
         1ruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Ye+eK9WKg7RD8X/56KrSW/Eh9eyMI6TOtSKK2Q/761w=;
        b=WoXNVemYV+gZoAiEeh1HhvfbH4xncOAor7bV2bfLtATdV7PzCJwUla56X6r4bHAWbf
         J5Jw44PTr/FRl3zkc5lL2zChdRKlPCNKGZNzNw8FS2I3D0AfL6AxmZWCkZn4ycMChrLl
         +MpHYQKkur/kpnHLIpYAo5kBjimsulCKffeldc1ulXnkcXmfdOB1COADhRx3DpUTWCdo
         3jpDt4HB9x/E0rdCvflVLkElqHrE82C4y7BVR+pkTEaJKeenEs7Qrf+IbZyU589yUsXr
         5l8FrH2/t/S3gInHza4gvGyVv4F6G8uMs2ROP/p+7osqMCHodJ6uvyShZOPBM4Bemw6R
         irXA==
X-Gm-Message-State: AOAM531SfaE6TotrMpJOcbwpac3ldO5q2sXpFjLA2+MnGw/dVSzPjv4R
        VCaZ3+w2aA6LqWCIsWDySKRsz/v4cUSOTA==
X-Google-Smtp-Source: ABdhPJwZW/lP8Avu7h3BBzRFR2nclyNK/ti5bJbqsbPgVqVHyuvDQfmNNipcm1PoFFpuQn523oWxXg==
X-Received: by 2002:a5e:8805:: with SMTP id l5mr16551739ioj.150.1635709354210;
        Sun, 31 Oct 2021 12:42:34 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id m10sm7125697ila.13.2021.10.31.12.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Oct 2021 12:42:33 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] block device inode syncing improvements
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <3017c47b-debe-0108-ddf3-279de7621883@kernel.dk>
Date:   Sun, 31 Oct 2021 13:42:32 -0600
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

On top of the core block branch, this topic branch contains improvements
to how bdev inode syncing is handled, unifying the API.

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

