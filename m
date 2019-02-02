Return-Path: <SRS0=HKPG=QJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017DAC282D7
	for <linux-block@archiver.kernel.org>; Sat,  2 Feb 2019 16:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1F720823
	for <linux-block@archiver.kernel.org>; Sat,  2 Feb 2019 16:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JAx8uryX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfBBQeV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Feb 2019 11:34:21 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:33492 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfBBQeV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Feb 2019 11:34:21 -0500
Received: by mail-pg1-f178.google.com with SMTP id z11so4427241pgu.0
        for <linux-block@vger.kernel.org>; Sat, 02 Feb 2019 08:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=szQ8aP7uT5fPhqf6PmnrfH3JXlu+ea45wnerR3C3Hdw=;
        b=JAx8uryXF6Qwdsr8u78f0hEGe7XAwjScLgevGhXr1Cx+95cfWoiFpCWolQJywc0oW/
         1QvqjQZSvOJikVoeBdz4vgkW6+yP80iLni7F0J7Aau55UkwyEHzxdWV6em7AMNVj+hkh
         SLQ906WM3TIfgicbQ6LfqG31NpW3Kh9kv7Ddqlk0CbT5gh5ShZqlSqNM4V+1YhgxyMG6
         PIR1XjvGa4zAuM42EQP9AiF2gS97T2TfTggiJJDntGuH/JpS+z8JdlrjUVP3IGefS/vy
         l15ZOZ2+coZiJ/wJH6KSICKi0QxNo3THIKGkF4a/4WP65L0wdfqPqnjnfmiEQjyvvo1g
         nNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=szQ8aP7uT5fPhqf6PmnrfH3JXlu+ea45wnerR3C3Hdw=;
        b=TGGH9t2pRz+G82C0A7EkEz7HIDI8r3c+O6HMTv5+yUyRCKSvpVWP9Hiy1ladH9xh9+
         eblA7TQJApIxgBhrffrz5ZN7WR3jh2s+zagW9v4j8UUeYoGTkiHJAOsN2UnfiMP7hSc8
         nZKAvJWY6cb6xYhkvWnAvbXRmizd9I28MODyFd8hWVHmZbxVhuFCvzDW38yBhSkvqiTT
         0ck6OMg1O5S/1ULr/e7x87FlsnCn4iGuSJaEpeSyFAMWWbGW/1FVWWQrVXxjmczic4wL
         YMpvPXCwzGZkoZg5T+L0Yn6EnlCrwmjH0rgOk7LY3ZUJO/CSA8lGwSIynJiUfRhqFv9+
         Gn/Q==
X-Gm-Message-State: AJcUukdqEKbpHBc7S4XxBkQjduBp7NfVId0aKyCV+/wWsVBnjdvbDFRe
        4lwq6lfqSC+r5y8y1EyVQ/t9IfVtRuU=
X-Google-Smtp-Source: ALg8bN715AI55ITleQjyvVB6mKVXKbyq1u0mu/BjYkNg/6q7nGBOcTuVOSHiiYQkG11Vj/qbVsYBIw==
X-Received: by 2002:a63:d604:: with SMTP id q4mr39593554pgg.175.1549125259830;
        Sat, 02 Feb 2019 08:34:19 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u69sm31125571pfj.116.2019.02.02.08.34.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 08:34:18 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.0-rc5
Message-ID: <0c7cef81-1fe7-47fb-06ff-86a9536a9e8f@kernel.dk>
Date:   Sat, 2 Feb 2019 09:34:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A few fixes that should go into this release. This pull request
contains:

- MD pull request from Song, fixing a recovery OOM issue (Alexei)

- Fix for a sync related stall (Jianchao)

- Dummy callback for timeouts (Tetsuo)

- IDE atapi sense ordering fix (me)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20190202


----------------------------------------------------------------
Alexei Naberezhnov (1):
      md/raid5: fix 'out of memory' during raid cache recovery

Jens Axboe (2):
      Merge branch 'md-fixes' of https://github.com/liu-song-6/linux into for-linus
      ide: ensure atapi sense request aren't preempted

Jianchao Wang (1):
      blk-mq: fix a hung issue when fsync

Tetsuo Handa (1):
      block: pass no-op callback to INIT_WORK().

 block/blk-core.c         |  6 ++++-
 block/blk-flush.c        |  2 +-
 drivers/ide/ide-atapi.c  |  9 ++++++-
 drivers/ide/ide-io.c     | 61 ++++++++++++++++++++++++------------------------
 drivers/ide/ide-park.c   |  2 ++
 drivers/ide/ide-probe.c  | 23 ++++++++++++------
 drivers/md/raid5-cache.c | 33 +++++++++++++++++---------
 drivers/md/raid5.c       |  8 +++++--
 include/linux/ide.h      |  2 ++
 9 files changed, 93 insertions(+), 53 deletions(-)

-- 
Jens Axboe

