Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38936C001B3
	for <linux-block@archiver.kernel.org>; Tue, 20 Jun 2023 20:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjFTUST (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jun 2023 16:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjFTUSF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jun 2023 16:18:05 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83918173F;
        Tue, 20 Jun 2023 13:17:34 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b55fc3a71cso15926185ad.2;
        Tue, 20 Jun 2023 13:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687292252; x=1689884252;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzjcN4zIA1V2ehcQK1PVht6LD6f28L3/r8aTUxQsKkQ=;
        b=QrYf/kA3FYas8oTG/VKN5PFcOq/JOJcwBoQM9kLiDK2C8uOs/gbeLH3RrZpxNXA9z/
         HjD7zNqif4b4Dy5HC7WoVX/eNQ3Y8W6jpv2YUz6J7yodJitZ3MtOVKBN6cujUq03l71+
         llTy2194b3QcvKcRdfdDXUQIL3LgpXlwJLNpyELvhAgsfU/eAgHAWVUSSIaD8Qv9KARh
         wB2ae6k7HwxK5akLOGeK6Fei6p25fv9B9qKurrx+Qk/w8vOeaILNsRzmNxAkmoEiNgHE
         1lpltNulsNaDoNq5UNBQ4X1nqoVZYR16tPaqY2ektnbxpbiDRRFED+XYkeJ3nNb5fYoc
         4bQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687292252; x=1689884252;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzjcN4zIA1V2ehcQK1PVht6LD6f28L3/r8aTUxQsKkQ=;
        b=i7dDRMSgaKDQMb7D9RzCVh0eu4JfLirt9Yl5lJNBhBnOpn9qOvvEU9HqIoKIu0n8XT
         jcSbauBZySN1Ud3auT1rZb5WRIADn2+bO1p5AI1c9zF9+Rxv2rpnm/hl9+PiDUCH8vLj
         JvRa/QOF2VkQncMFhL+Wn9b2tu9LfhNx7CghJTdUjAoVPxaa9Ti3cPDYrM9y28jF0hkh
         MtSeyskRGOrtZSFuTaDG7L5U8Vxgrt34OBGqIl7W1g5C6A86ZzFX0Fm+2KDaj6g3A9EK
         VUzjGzVo3wFO6hPZhMs+FtAFtmwRFj5GkNAKD+Ul+ttTe1uohFBW3PceHsuo/pzdvlXO
         +IPg==
X-Gm-Message-State: AC+VfDxpbcCbVYIvpap1UasAckG+Mu4SCJkIG8izgX/vBSv2VBMuVkBd
        4Fmq7lbnuTjLsfeiW9WUEgkLrsu9Ob8=
X-Google-Smtp-Source: ACHHUZ61dR1bzhSlTEqg819mG8cF7uj+uQl1F4coYicgJdT7700UpTI4bQf0+9Fq9KpGK5d6MClU6w==
X-Received: by 2002:a17:902:db02:b0:1b6:80e6:7168 with SMTP id m2-20020a170902db0200b001b680e67168mr2516869plx.61.1687292252414;
        Tue, 20 Jun 2023 13:17:32 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-217-2-adsl.sparkbb.co.nz. [222.152.217.2])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b001a64851087bsm1965012ple.272.2023.06.20.13.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:17:31 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 016F0360312; Wed, 21 Jun 2023 08:17:27 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        martin@lichtvoll.de, fthain@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v13 0/3] Amiga RDB partition support fixes
Date:   Wed, 21 Jun 2023 08:17:22 +1200
Message-Id: <20230620201725.7020-1-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

another last version of this patch series, only change
in this version is in the patch 2 subject (to better
reflect what it's about), and adding Geert's review
tag to said patch. 

I hope I've crossed all i's and dotted all t's now...

Cheers,

    Michael

Michael Schmitz (3):
  block: fix signed int overflow in Amiga partition support
  block: change all __u32 annotations to __be32 in affs_hardblocks.h
  block: add overflow checks for Amiga partition support

 block/partitions/amiga.c             | 102 ++++++++++++++++++++++-----
 include/uapi/linux/affs_hardblocks.h |  68 +++++++++---------
 2 files changed, 119 insertions(+), 51 deletions(-)

-- 
2.17.1

