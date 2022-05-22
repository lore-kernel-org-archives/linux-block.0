Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484DEC433F5
	for <linux-block@archiver.kernel.org>; Sun, 22 May 2022 21:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242909AbiEVVhf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 May 2022 17:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbiEVVhe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 May 2022 17:37:34 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D112837AB2
        for <linux-block@vger.kernel.org>; Sun, 22 May 2022 14:37:33 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id p8so12064234pfh.8
        for <linux-block@vger.kernel.org>; Sun, 22 May 2022 14:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=GurHasAsbiaQ+/lOSDOlH8oWmCklu23c1otjCJsynp0=;
        b=plSb+eWT/mgGPqFjnY2ORwDF6WGUR7caCXp2iF8KWYcFSvcUoJ41oPypw2Aql+PMxP
         8hWO95zDOlwuYrEUdKEnyGvqAzz7zBBqIQrzLl9YRGOGkPSem9mbPajCXboh/XguE+md
         Gdb5fyt3ib9Leiyvs4/Ol5XPFhMEjXPP8Q2iNo1peBSzaKivXvGwitBOWM+hAB/4dc0D
         f27EWEj4ilVjqzkefiiUai1wFEkKov4idk4Wasj1F4kgUe3zgWvFqEjVVl+FzMGUcNFd
         xg+RHOE64HN1k0n9FS8RAKGehpn30Cy3ymf3MPXE1iYvrExaCQjPRXWSx8FcNL+Hq5RV
         B+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=GurHasAsbiaQ+/lOSDOlH8oWmCklu23c1otjCJsynp0=;
        b=2Ng8H06kditRm3Oso6QuO+oHv4PhRT4iay/m8dfUUzPK8kEQHys1Uv5vR92qARl2bL
         Pc8n37pW0elABn9Oexi4As5JC22OIacoQSZp3lIuCmF19it4dAtDg+Ta0kQPn2ABSgS8
         3pyRfIdKIzaiBOn2NMqvgBhyOQtRNRQkv1lGMrBS6YkX/Dp1rG0KBI74U/h1ebfXWc0U
         JUcx791ums1dXV6JML3431NKQys6iGihSmgG8KTEC+IkV/Fa7rpa6cbk0WyX49ttroPb
         q8sJlzDKqcRoHYQowtxw5aW4pyaVf4Z6IsXmCggASKoNjd0QMfsgj+zeSD7wy9pf2XSc
         gmAw==
X-Gm-Message-State: AOAM530wad4knpsJAV2qVeBfCk628uUCYy4YfH736SOXDrfiaZpo7npH
        5IOnwyk2F65Mqf+21fMzh6UxqPK1oP2MWQ==
X-Google-Smtp-Source: ABdhPJwVtj0yeySggL5FajQs+KYBpjsUm/A7X3/p00dbxt8hFwke9qPnez4YkplOmmtwMuWi6dlznQ==
X-Received: by 2002:a63:2c97:0:b0:3f6:5b81:908d with SMTP id s145-20020a632c97000000b003f65b81908dmr14222253pgs.510.1653255453335;
        Sun, 22 May 2022 14:37:33 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s32-20020a056a0017a000b0050dc762814asm5780646pfg.36.2022.05.22.14.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 14:37:33 -0700 (PDT)
Message-ID: <f274c991-1e1d-e42a-5f03-59fc49113a25@kernel.dk>
Date:   Sun, 22 May 2022 15:37:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Phillip Potter <phil@philpotter.co.uk>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] cdrom updates for 5.19-rc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Removal of unused code and documentation updates. Please pull!


The following changes since commit c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a:

  Linux 5.18-rc6 (2022-05-08 13:54:17 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.19/cdrom-2022-05-22

for you to fetch changes up to 2e10a1d693b9f1c8921bd797838cff0be7cdd537:

  cdrom: remove obsolete TODO list (2022-05-15 18:31:28 -0600)

----------------------------------------------------------------
for-5.19/cdrom-2022-05-22

----------------------------------------------------------------
Enze Li (1):
      cdrom: make EXPORT_SYMBOL follow exported function

Paul Gortmaker (3):
      cdrom: remove the unused driver specific disc change ioctl
      cdrom: mark CDROMGETSPINDOWN/CDROMSETSPINDOWN obsolete
      block: remove last remaining traces of IDE documentation

Phillip Potter (1):
      cdrom: remove obsolete TODO list

 Documentation/cdrom/cdrom-standard.rst      | 10 ----
 Documentation/filesystems/proc.rst          | 92 +++--------------------------
 Documentation/userspace-api/ioctl/cdrom.rst |  6 ++
 drivers/block/pktcdvd.c                     |  2 +-
 drivers/cdrom/cdrom.c                       | 38 ++++--------
 include/linux/cdrom.h                       |  1 -
 include/uapi/linux/cdrom.h                  |  2 +-
 7 files changed, 25 insertions(+), 126 deletions(-)

-- 
Jens Axboe

