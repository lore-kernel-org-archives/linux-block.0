Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FACEB64DC
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 22:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjFPWgY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jun 2023 18:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjFPWgX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2023 18:36:23 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAFA30EA;
        Fri, 16 Jun 2023 15:36:22 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b512309c86so9666495ad.1;
        Fri, 16 Jun 2023 15:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686954982; x=1689546982;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2pM5g49GFy88WomX95Eva6SdQ52mHJEO5HDcQWqPak=;
        b=l5dETQh2WqkJonxwjs1rc/c917IadhA0jE01cdCabGTXR/H5KyUej7d0oi1DJgiSc8
         0xXmX9ryVLX2lxh7ub5oVFk+1tVXI1GW0P/Y7KHH/upgorvjQ05Oai9pfJR0ae/qQCBt
         FEx3I4+K2zqLCSZT8IhfempleR/mnDM+FzKrJWk8izW5D/L13i6YFx4O17FHWyIG5Y/N
         9vJ6a6QixbdymZEitM4xs8hTKRdQBNJKhhkAfRYom3+MKD3zqRjCmLDinzL/pa6uzThs
         ELaJLu4dcsQCNddKYk6Q5RMzGzhXoMIHKkEJN4xb+Gz8rmYdXJxUMRik35H4b2GvoEjR
         817A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686954982; x=1689546982;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2pM5g49GFy88WomX95Eva6SdQ52mHJEO5HDcQWqPak=;
        b=iUCnJEZGuXhPbJw4cDuoRWAj93K/bdfmNt4LekuSzRnkVxXsTLMnQTxZpLJqX3Wx5v
         15WqNQZQKXzodtF320c6ysy8ypvJaMmwtpHyiDETsIyiGhAbAdCziUXT1IZrubKAqoLq
         KI1Woxn5VmyP4Kv8M5ukqTE+8yavjdvGJDPk1KwbnEEzP/7OBMt+E63YtnNBTbRMRB5b
         uLC1djm1h2vvIRqLlkshvvFiAEfKHkQcCZQECx5xWx7K7NWeMuIzxXe0mA/AIzjjVWuf
         j2LpuJZQtAxxWRdj/My+t045mXQid8JLCJorFxrhkZyiLOciPgdWZA1oPfm4rtlcKjFb
         p5ow==
X-Gm-Message-State: AC+VfDztePi6h3wc70++I47nHzA/3b9kQyOIRXIUdzgl3TOGNX1Wiq8j
        NJaVHm2bkCQVlV8HakHwNf4=
X-Google-Smtp-Source: ACHHUZ6KEL5fPNlCEqv8uMFBQivgWcki1o7jlMoxOLoxGhUsDRhanGFTJc8oE6ZVS8KzJsehz45Wbw==
X-Received: by 2002:a17:902:e88b:b0:1b0:3d03:4179 with SMTP id w11-20020a170902e88b00b001b03d034179mr4482956plg.6.1686954982252;
        Fri, 16 Jun 2023 15:36:22 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-217-2-adsl.sparkbb.co.nz. [222.152.217.2])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902e89100b001adf6b21c77sm8244231plg.107.2023.06.16.15.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 15:36:21 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id E7F34360318; Sat, 17 Jun 2023 10:36:17 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        martin@lichtvoll.de, fthain@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v12 0/3] Amiga RDB partition support fixes
Date:   Sat, 17 Jun 2023 10:36:13 +1200
Message-Id: <20230616223616.6002-1-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

the hopefully last version of this patch series, only change
in this version is to change all 32 bit fields in the
affs_hardblocks.h header to __be32 following review comments
by Christoph and Geert.

The simple fix (patch 1) still leaves ample room for overflows in
calculating start address and size of a RDB partition, though
such overflows should only be seen in rather unusual cases.

To address these potential overflows, checks are added in the
third patch of this series. Comments by Geert have been
addressed in full. 

In order to avoid warnings about a cast to a restricted
type (__be32, inside be32_to_cpu()) introduced by the third
patch, the second patch changes the annotation of all 32 bit
fields to __be32 (which is what these fields in the RDB
struct ought to have been in the first instance). 

Reviewed-by tags by Geert and Christoph added. Fixes and
prerequisites for stable backport also added. 

Cheers,

        Michael

Michael Schmitz (3):
  block: fix signed int overflow in Amiga partition support
  block: change annotation of rdb_CylBlocks in affs_hardblocks.h
  block: add overflow checks for Amiga partition support

 block/partitions/amiga.c             | 102 ++++++++++++++++++++++-----
 include/uapi/linux/affs_hardblocks.h |  68 +++++++++---------
 2 files changed, 119 insertions(+), 51 deletions(-)

-- 
2.17.1

