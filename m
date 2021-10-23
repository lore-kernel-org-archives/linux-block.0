Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3251C433EF
	for <linux-block@archiver.kernel.org>; Sat, 23 Oct 2021 03:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA8206103D
	for <linux-block@archiver.kernel.org>; Sat, 23 Oct 2021 03:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbhJWD3M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Oct 2021 23:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbhJWD24 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Oct 2021 23:28:56 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8BEC061227
        for <linux-block@vger.kernel.org>; Fri, 22 Oct 2021 20:26:01 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id z5-20020a9d4685000000b005537cbe6e5aso15389ote.1
        for <linux-block@vger.kernel.org>; Fri, 22 Oct 2021 20:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=xunHUvSinXxFQFHpObiQdAcTIG9wS/Wzj/iNdA4FJ1M=;
        b=pU3zSiSFcbGo5P5YwDQYsGjxlaH2r/kxIdML23rxGQqrXqgCEWYQC2Vom3OWaT7h2c
         jBr3oZMxuhdbV0FBOfVjL0SYpMMQOjg/FcssFRzZ/suqUbbPLgE7GOaM84Y46dIBMXCZ
         Gp5g3Zp8d4bH6vNFtrG1m8jtDS5lzL88h2rPofOgHvDv6Qu5VLt3dynyUpvGXFAftlql
         Nu2Fnm4xNLmBKC2OfxH56wahWRpFBjBygU/V0kbDTzWKz0Bm4O96HYZU7eQyjv6KWRP8
         MMMkI+W4hvd/vBTYoIXWfSvDZWhu2nYVE22Vfb/LuB6w4FipKOArm8Ghjlqp/3n1Z6wA
         XfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=xunHUvSinXxFQFHpObiQdAcTIG9wS/Wzj/iNdA4FJ1M=;
        b=jfEqMhIdSedl7d5t6iPHgLtm6h0qxq2SL6CfZMPfIv8QMUW2oZID6SKWX4YI1yXdHR
         cj51w7JZK+8uhRkdVEBbecwoIlOjDy5oMJI7bX8ZStjMy8UJs9BYH1ggWcG/cosOrTII
         3PhFAl0ZtGMtaTc7GNjWy9rmBobRyxzlH7qB12fr4+2PZ22jgOEcQhT8bR9e7jxx1MPe
         uCzV+h17xp20ds1RpeOLMl97kMBwy41Trtq2MPLJcSBgpH4m9tsVCxpxfjo388bflAKP
         j14BrjaOyi0oEIUlNBj5PRZcGE4S97Pcb0FirZ3N1+g6ILgL9kld4YNVl0O/x+UW8XTE
         sANA==
X-Gm-Message-State: AOAM531MOq1OKdDTr3+9ZQUsVXOgzhhsmxMbQUtx6yHVxjxiM8MdRmfK
        1yNM50u84hLCVz/UUk9gJHE/FvgN5B5TO8BV
X-Google-Smtp-Source: ABdhPJwVX9o87iqc1KGT0U3Zzlr2TDF1UwUuWkh6uBV8aVu6zE6tChL/FBya3bClKOjw3E7ONCNccA==
X-Received: by 2002:a05:6830:35a:: with SMTP id h26mr2994549ote.369.1634959560311;
        Fri, 22 Oct 2021 20:26:00 -0700 (PDT)
Received: from ?IPv6:2600:380:7c6d:de21:1bf0:5458:9b5c:7a3d? ([2600:380:7c6d:de21:1bf0:5458:9b5c:7a3d])
        by smtp.gmail.com with ESMTPSA id y5sm2089004otg.52.2021.10.22.20.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 20:25:59 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.15-rc7
Message-ID: <e4f72489-1ca0-46c8-65dc-f04b31e337f7@kernel.dk>
Date:   Fri, 22 Oct 2021 21:25:59 -0600
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

Fix for the cgroup code not ussing irq safe stats updates, and one fix
for an error handling condition in add_partition().

Please pull!


The following changes since commit d29bd41428cfff9b582c248db14a47e2be8457a8:

  block, bfq: reset last_bfqq_created on group change (2021-10-17 07:03:02 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.15-2021-10-22

for you to fetch changes up to 9fbfabfda25d8774c5a08634fdd2da000a924890:

  block: fix incorrect references to disk objects (2021-10-18 11:20:38 -0600)

----------------------------------------------------------------
block-5.15-2021-10-22

----------------------------------------------------------------
Tejun Heo (1):
      blk-cgroup: blk_cgroup_bio_start() should use irq-safe operations on blkg->iostat_cpu

Zqiang (1):
      block: fix incorrect references to disk objects

 block/blk-cgroup.c      | 5 +++--
 block/partitions/core.c | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
Jens Axboe

