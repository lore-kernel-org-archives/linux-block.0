Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E876C433B4
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 21:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC76D61458
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 21:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244007AbhDWVHA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Apr 2021 17:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243797AbhDWVGv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Apr 2021 17:06:51 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DE5C061574
        for <linux-block@vger.kernel.org>; Fri, 23 Apr 2021 14:06:09 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id f11-20020a17090a638bb02901524d3a3d48so1843499pjj.3
        for <linux-block@vger.kernel.org>; Fri, 23 Apr 2021 14:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=V5D+p222T/zK5864HEQWmph+aNch/cBa7RytUNGeFgA=;
        b=CSHXW6HUZ8klURgMsd1us5IqEdjTUSET8cRFukzl6aSx4f/UGOB8lgvku0wrs6Iks8
         Kq9D48fU3ZZjNG3x5v0U4nT/iww+BsH6uRUoYFST+Kf2qb6XS3NvNQ2Wmsn6BDjZ+hhw
         EVZJiE9QNEy8C0tNcS1T2fkftlT5c+UeZ5iZfUe0fCx+/7G4yzU2FFPwz1CqRQ0fnmSO
         aifnCrCONWUFuisT7wT0AfOuCDjYKG/h/xN8AGP0VuMj1+WFpTjJ1tXRryNnDaqg5fBg
         sJqUsRAW/OvrsrjZjWiL8xhnI/MAcm2eRbKDwE/MVh5jD6PEpikducXHm2maZf8V6yD4
         amxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=V5D+p222T/zK5864HEQWmph+aNch/cBa7RytUNGeFgA=;
        b=O8kjv9C41RmuGn4tYObJqm9upRqBzRuZu3zGFOGwN9GFxFJssVGhk1IOaMCGcIza/+
         2nD8WMQRe92xru/fjvwjB+q4ZIoPPxWjwwUZRBAgdb7omVa6TmTiYvsfXoISbmCWe8QE
         6Olt8HihcqPBmQhaG6wlQPQE4+cSRy7qj8ff3mSKOLEHYxNLNG0rPnYiNs4t41etxl34
         /0x5U39OB9niq7Z93CplTeq58kQCcBLthSfSCCgVwvFzV38f8Yhjg3M3048cdv2lWYAe
         /tOtlBqMu3IlCR+MhpyYrfbB4lKR4+5z/DMnFk/FRE1sUoEWiHYGiufoZdC7GXPhj8bE
         bRYQ==
X-Gm-Message-State: AOAM533XAh0RPXKTt2B9b8ii/Ak5vgqfDqw+uZA4/+C0JFttOvaEurvj
        ZLJRG+hQYVQtYA1AO3fZq45C1ArnHzvZtg==
X-Google-Smtp-Source: ABdhPJzXmxEjehaxiSe8yZUjWcMDWCRY03g0O8tDn3I/zVIFmiOGPgF+fZv9eVUnkVKgnbRUq6JQfQ==
X-Received: by 2002:a17:902:d645:b029:e8:ec90:d097 with SMTP id y5-20020a170902d645b02900e8ec90d097mr5878936plh.47.1619211968949;
        Fri, 23 Apr 2021 14:06:08 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id w124sm5219631pfb.73.2021.04.23.14.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 14:06:08 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 5.12 final
Message-ID: <c657100e-aef5-0710-2760-1d02f193cab6@kernel.dk>
Date:   Fri, 23 Apr 2021 15:06:07 -0600
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

A single fix for a behavioral regression in this series, when re-reading
the partition table with partitions open. Please pull!


The following changes since commit f06c609645ecd043c79380fac94145926603fb33:

  block: remove the unused RQF_ALLOCED flag (2021-04-02 11:18:31 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.12-2021-04-23

for you to fetch changes up to 68e6582e8f2dc32fd2458b9926564faa1fb4560e:

  block: return -EBUSY when there are open partitions in blkdev_reread_part (2021-04-21 10:49:37 -0600)

----------------------------------------------------------------
block-5.12-2021-04-23

----------------------------------------------------------------
Christoph Hellwig (1):
      block: return -EBUSY when there are open partitions in blkdev_reread_part

 block/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
Jens Axboe

