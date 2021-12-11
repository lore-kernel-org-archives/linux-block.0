Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3815FC433EF
	for <linux-block@archiver.kernel.org>; Sat, 11 Dec 2021 06:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhLKGJy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 11 Dec 2021 01:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhLKGJy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 11 Dec 2021 01:09:54 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF87C061714
        for <linux-block@vger.kernel.org>; Fri, 10 Dec 2021 22:09:54 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id f18-20020a17090aa79200b001ad9cb23022so9232407pjq.4
        for <linux-block@vger.kernel.org>; Fri, 10 Dec 2021 22:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=6QU7B8YVuZCZSFzndCjDSkgQIVVsz6OqHMvNKa3XN/0=;
        b=PoecPpt33cZDmUTdC4oKqD5UhUp+me2j3gcsndZ6YkkJNlFtUzVCRow/5O2pBSUMS5
         QBvGHLOxsfllWRF4gEWkhBhXD9OyYDCxbOdiCEwT1K8ySn59cTv15JRmPY5A43PC0/I4
         AYpLjL6fUV1vnP/0TgTWNpi/Eevwn7O5nj3kOXduyIFHVZtF/akQsrmmyZCzZ3Dtevua
         xqQisubDemREWMEosWC6vNpaws9soiiJ2JjZArI6gdA6lDn4fw0WOzE0O8LlBTdYsuoS
         qaCdmvMWflTB6nSHz8tDfNSIjVXQh753VRryN/OsmAOH51ZJpieiKhsfIXRSdBGwxNYE
         q8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=6QU7B8YVuZCZSFzndCjDSkgQIVVsz6OqHMvNKa3XN/0=;
        b=KqNvjpKvItjZtAVZPHBZ82O70zcrO8vI1UXdsLIM8xHpXSbR7DR6ulRjUESZUWwl/X
         ba+uHnS55vDJYs3Zyz6NWUoCSEqGoyk5ft+xNtVWeAL+VKHbCMPMUG8ELb/rF0JF6Jgx
         qxDXzRqJ2qckC99FbMrtGzn5jfzZSwfjrLv6rJftZZA/wON2YrtOrQdg+2ASlClm9O2M
         3zCQLxei0I8SPDi/gJIwPt93gOCFY2wCEkUJ7Rd7TqE0ESsW5U+ttBAnA3lyyUbTXyQU
         vSCJJhWfp7APgfbQyPyeZ4LVjXA6QXg1kzwFhOOg5rKT/DrlKKZXZVETByOjv6fwnPLH
         zvUw==
X-Gm-Message-State: AOAM533W++CJicGqCPQu9oxTgrr8H704j1iRZ6TsWGBc3U6ZittTJmOO
        5OgTUV/y9JnEjv//QRxroWE2oc8773jQ5w==
X-Google-Smtp-Source: ABdhPJwwpIGp0dtdAfhL1jYVEHtkKLn/0ObL/z6OQS+K8pqlNTjwbGiJo0QgcAAy7YJIyGLXjgjNiA==
X-Received: by 2002:a17:902:b588:b0:143:b732:834 with SMTP id a8-20020a170902b58800b00143b7320834mr81241407pls.22.1639202993423;
        Fri, 10 Dec 2021 22:09:53 -0800 (PST)
Received: from [172.20.4.26] ([66.185.175.30])
        by smtp.gmail.com with ESMTPSA id p188sm5065579pfg.102.2021.12.10.22.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 22:09:53 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.16-rc5
Message-ID: <b2e03df4-5be8-4e82-54ad-4dfc9b9d47ac@kernel.dk>
Date:   Fri, 10 Dec 2021 23:09:52 -0700
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

A few block fixes that should go into this release:

- NVMe pull request
	- set ana_log_size to 0 after freeing ana_log_buf (Hou Tao)
	- show subsys nqn for duplicate cntlids (Keith Busch)
	- disable namespace access for unsupported metadata
	  (Keith Busch)
	- report write pointer for a full zone as zone start + zone
	  len (Niklas Cassel)
	- fix use after free when disconnecting a reconnecting ctrl
	  (Ruozhu Li)
	- fix a list corruption in nvmet-tcp (Sagi Grimberg)

- Fix for a regression on DIO single bio async IO (Pavel)

- ioprio seteuid fix (Davidlohr)

- mtd fix that subsequently got reverted as it was broken, will get
  re-done and submitted for the next round

- Two MD fixes via Song (Markus, zhangyue)

Please pull!


The following changes since commit e3f9387aea67742b9d1f4de8e5bb2fd08a8a4584:

  loop: Use pr_warn_once() for loop_control_remove() warning (2021-11-29 06:44:45 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.16-2021-12-10

for you to fetch changes up to 5eff363838654790f67f4bd564c5782967f67bcc:

  Revert "mtd_blkdevs: don't scan partitions for plain mtdblock" (2021-12-10 11:52:34 -0700)

----------------------------------------------------------------
block-5.16-2021-12-10

----------------------------------------------------------------
Christoph Hellwig (1):
      mtd_blkdevs: don't scan partitions for plain mtdblock

Davidlohr Bueso (1):
      block: fix ioprio_get(IOPRIO_WHO_PGRP) vs setuid(2)

Hou Tao (1):
      nvme-multipath: set ana_log_size to 0 after free ana_log_buf

Jens Axboe (3):
      Merge tag 'nvme-5.16-2021-12-10' of git://git.infradead.org/nvme into block-5.16
      Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.16
      Revert "mtd_blkdevs: don't scan partitions for plain mtdblock"

Keith Busch (2):
      nvme: show subsys nqn for duplicate cntlids
      nvme: disable namespace access for unsupported metadata

Markus Hochholdinger (1):
      md: fix update super 1.0 on rdev size change

Niklas Cassel (1):
      nvme: report write pointer for a full zone as zone start + zone len

Pavel Begunkov (1):
      block: fix single bio async DIO error handling

Ruozhu Li (1):
      nvme: fix use after free when disconnecting a reconnecting ctrl

Sagi Grimberg (1):
      nvmet-tcp: fix possible list corruption for unexpected command failure

zhangyue (1):
      md: fix double free of mddev->private in autorun_array()

 block/fops.c                  |  3 +--
 block/ioprio.c                |  3 +++
 drivers/md/md.c               |  4 +++-
 drivers/nvme/host/core.c      | 23 ++++++++++++++++++-----
 drivers/nvme/host/multipath.c |  3 ++-
 drivers/nvme/host/nvme.h      |  2 +-
 drivers/nvme/host/zns.c       |  5 ++++-
 drivers/nvme/target/tcp.c     |  9 ++++++++-
 8 files changed, 40 insertions(+), 12 deletions(-)

-- 
Jens Axboe

