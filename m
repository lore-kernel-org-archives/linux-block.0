Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D00C433FE
	for <linux-block@archiver.kernel.org>; Sat, 12 Dec 2020 02:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47F1A20754
	for <linux-block@archiver.kernel.org>; Sat, 12 Dec 2020 02:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436572AbgLLC6j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Dec 2020 21:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbgLLC6e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Dec 2020 21:58:34 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF545C0613CF
        for <linux-block@vger.kernel.org>; Fri, 11 Dec 2020 18:57:54 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id m5so3381203pjv.5
        for <linux-block@vger.kernel.org>; Fri, 11 Dec 2020 18:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=nwtmzjPwtZH0puY6U8oMGQnKk5b1/eFkub7XNEzMrCg=;
        b=dIlUZ45reEl9zi+l70bMKyZ6FYZHtsPideXa1KvnJSjVfepPN95BwIsB7uTC8/id1q
         U/DZbVfMHJ1PyA3boiQY1/2/Lu4Loap8dOcPr6ftBzmuBOc07+kK5G8k503FY0cRpFDl
         9nNIDxg/rti92bt45NhfefHYhd+66eCCtd6XO14+k7CgbbBBHQlJufv6VFBiAqtsW8M4
         gnzGvcMnY8jcw2PiSI6oNe392HKw8aP4eFjVdBiyOHGsyH8FdN3BsuVhXwFaGdAEd3tj
         MMelzTpktQEzJc+nlVFXtiyRN30WesG6Cm6zOuVyXvzNS0GqdabKfuJLsCuCInX3+B8C
         i3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=nwtmzjPwtZH0puY6U8oMGQnKk5b1/eFkub7XNEzMrCg=;
        b=q1QG+cL4ye8d42C85twvm0xBjhVSq3Beplx/ceCbls2jDix656vGIKjjsl1BNc+E6Y
         mTCWvLalgAfOGEjC/jTtxEndgem0IxAFCqs4+M/3BAykQGgybUdeeC7AGFfkga1bhNCi
         og0s4N8W9l/qa8MwtDN7qymlxTsxZKwua59TyQSnW/B2CskApRlIDEe2saDnTGhPEyZg
         vyF+ypqP/KMm94EcrrIka18k/PxgVJYQSRLM3q+Qy+6lOk2v5OGSNQTzE1kBGfRHyeEK
         HKydf6laFSNNW1F6S2r76zo8hHezp7Hdc81cc+m7hNw+QTIRx5gnPm7exQo0Ejyocd8U
         6qEw==
X-Gm-Message-State: AOAM53365XRUFPCJxz84ib/AmpGGGJCd574FnY2TeSFgnVk19vR5XvEJ
        BgWB0oquqdIBDmDJdOOdlx9jOhZ+mkI4sw==
X-Google-Smtp-Source: ABdhPJwPY1JnU+8I+gERd3PwepDTd3qOkNbnY9dyKsmh0zTcrY/D0thpVWR8Dr8A3atqc6fcRuCqcA==
X-Received: by 2002:a17:902:ee11:b029:db:c0d6:581a with SMTP id z17-20020a170902ee11b02900dbc0d6581amr13656241plb.54.1607741874070;
        Fri, 11 Dec 2020 18:57:54 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id q26sm11732949pfl.219.2020.12.11.18.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 18:57:53 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.10 final
Message-ID: <6f7f4ba2-2de2-b6e7-cbf9-cbad3eaf72db@kernel.dk>
Date:   Fri, 11 Dec 2020 19:57:52 -0700
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

A set of reverts for md/raid10 discard changes in this merge window,
which have been proved to cause corruption in distro kernels. Please
pull!


The following changes since commit 7e7986f9d3ba69a7375a41080a1f8c8012cb0923:

  block: use gcd() to fix chunk_sectors limit stacking (2020-12-01 11:02:55 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.10-2020-12-11

for you to fetch changes up to 4223a5be80b8998d717c6b0e1000070e0e336bf3:

  Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.10 (2020-12-10 07:08:22 -0700)

----------------------------------------------------------------
block-5.10-2020-12-11

----------------------------------------------------------------
Jens Axboe (1):
      Merge branch 'md-fixes' of https://git.kernel.org/.../song/md into block-5.10

Song Liu (6):
      Revert "dm raid: remove unnecessary discard limits for raid10"
      Revert "md/raid10: improve discard request for far layout"
      Revert "md/raid10: improve raid10 discard request"
      Revert "md/raid10: pull codes that wait for blocked dev into one function"
      Revert "md/raid10: extend r10bio devs to raid disks"
      Revert "md: add md_submit_discard_bio() for submitting discard bio"

 drivers/md/dm-raid.c |  11 ++
 drivers/md/md.c      |  20 ---
 drivers/md/md.h      |   2 -
 drivers/md/raid0.c   |  14 +-
 drivers/md/raid10.c  | 423 +++++++--------------------------------------------
 drivers/md/raid10.h  |   1 -
 6 files changed, 80 insertions(+), 391 deletions(-)

-- 
Jens Axboe

