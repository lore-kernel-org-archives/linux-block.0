Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E01E743EC
	for <linux-block@archiver.kernel.org>; Fri, 29 Sep 2023 06:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjI2GGT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Sep 2023 02:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjI2GGS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Sep 2023 02:06:18 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A014C92
        for <linux-block@vger.kernel.org>; Thu, 28 Sep 2023 23:06:16 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-405e48d8e72so16251225e9.0
        for <linux-block@vger.kernel.org>; Thu, 28 Sep 2023 23:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1695967575; x=1696572375; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0ltJX6gGj0F+1CjAFpDF8jUjdmC2nVajuWt/R1eJec=;
        b=HU58OliDuGRE0asasm61EVZ6jgbDxY9SNvYInaHO6tbwk1ggSJ8GQBJCFcmU9UGTUn
         npcMIoG8LlnIybw11jmel3PI4ev0BW5tzYW5VA+/NrCDkg+i/36xaAQ4AC9Q/LbyJC1a
         v190leypP6JgYHorLTNyqcFQZmJZ1Req4jM3yofUi6XxNGZeQovlemeGLxQoWPoJmfeo
         Cd7f8ZhcfZuTADO6F+eLZrso6Jh0fS/q2CR4vxazx/p1KGs3LukPH9SgihTrt6uJN5Kb
         x/kHI4CbE2PcPFm5jUsXM/0U1+y7L53vINxcTKEd6ofNYONYPbOlf55e6yhTkguLdsb5
         3o6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695967575; x=1696572375;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T0ltJX6gGj0F+1CjAFpDF8jUjdmC2nVajuWt/R1eJec=;
        b=FMpPYhIJ0PXJ5/jvNMsqoHFg+MashmzOZt2E0K8qe32/zTEeR7DD8fHBJXZK5SgRVG
         c2ATL0G5/tsmz8M0VZHx7sKWwJ97HfBDUgMir5ihqhNLEbhIYuIEtSKaOuzjN8laV2iW
         LIGyUH31tjU5lv78KiDfLnqKvt1UdpB7UWcgmQq3Ya8SDQ6FHkeSHhg/85wwFTH4epL/
         dNScfPZOTTLvFcmsj7CqG8kcmxr+eipVDMx8bGEbjjprodZWenS+pjTnD4O6bAWOfNWI
         2dx6BWQYdU66I7mz3BZ5XxHe/cvJp14jn+UcQxikI5SWKYiXhNG/lOW47FaIHphD70TL
         KkBg==
X-Gm-Message-State: AOJu0Yyn5uqM4j+iI4l4aa7piBTvB4/yGTIEhieoADhFWiMM1kcMRY00
        VHFrpc52tPHpDpcD8jd5QFDhm62wLl1QfwK30Ik1Lk5u
X-Google-Smtp-Source: AGHT+IFwgbh//atUA3rG2IQxEaqbC49rLySFNY1U4rPIPlENcgzCPgBEA4g5w/MK2qupQ2oH3EjxvA==
X-Received: by 2002:a05:600c:1c9d:b0:404:74bf:fb3e with SMTP id k29-20020a05600c1c9d00b0040474bffb3emr3026779wms.2.1695967574906;
        Thu, 28 Sep 2023 23:06:14 -0700 (PDT)
Received: from [192.168.50.224] (ucpctl-mut-vip.hotspot.hub-one.net. [94.199.126.32])
        by smtp.gmail.com with ESMTPSA id b15-20020adfde0f000000b0031c6cc74882sm20900372wrm.107.2023.09.28.23.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 23:06:14 -0700 (PDT)
Message-ID: <4d46a68a-8810-442a-8f6e-249ba8283c98@kernel.dk>
Date:   Fri, 29 Sep 2023 00:06:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.6-rc4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Just two minor comment / documentation fixes for the block side. Please
pull!

The following changes since commit c266ae774effb858266e64b0dfd7018e58278523:

  Merge tag 'nvme-6.6-2023-09-14' of git://git.infradead.org/nvme into block-6.6 (2023-09-14 16:20:31 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.6-2023-09-28

for you to fetch changes up to a578a25339aca38e23bb5af6e3fc6c2c51f0215c:

  block: fix kernel-doc for disk_force_media_change() (2023-09-26 00:43:34 -0600)

----------------------------------------------------------------
block-6.6-2023-09-28

----------------------------------------------------------------
Kemeng Shi (1):
      block: correct stale comment in rq_qos_wait

Randy Dunlap (1):
      block: fix kernel-doc for disk_force_media_change()

 block/blk-rq-qos.c  | 2 +-
 block/disk-events.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

-- 
Jens Axboe

