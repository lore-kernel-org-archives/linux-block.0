Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4678EB64D9
	for <linux-block@archiver.kernel.org>; Thu, 15 Jun 2023 03:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242677AbjFODIr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jun 2023 23:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjFODIq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2023 23:08:46 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FB426A9;
        Wed, 14 Jun 2023 20:08:45 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-75d4dd6f012so277365085a.2;
        Wed, 14 Jun 2023 20:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686798524; x=1689390524;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXhRZblGyVMtvtJ0pQfx5ADPdvrkqYGTFGhpU5ex4x4=;
        b=oLKpZj0NdHuiem25PBDppKlQTkr4il/D0OdBQfHNWsnq2olgjajB9S+EvA70YOpOGs
         tTC22hmrLvmDjVjOghYYR3ZVgOZsxyJZNYqqAvIc+bBiTx+NTS/5+YtijI+MEqeuyyeF
         D9G+EcgV0O30B76/4yULl3d5CwHrLRVYkYYooMs8823Zj0I68adFVCndVnuvBsAkvU1i
         fqvEp6v5fubaYKs073lFv2LW/XBRhVwqz3WYYbYuZuXG0XUiAwYJ2+COErJjImh5lA1x
         V3+Ipb/Lx5SrKFNUB9nAjZr0V4nrNIXwPCtLAovaAALBdcKmB8VWpwFr5zVXe8wMAegK
         KABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686798524; x=1689390524;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXhRZblGyVMtvtJ0pQfx5ADPdvrkqYGTFGhpU5ex4x4=;
        b=F3Pu+c3U8amj6eBfbSYdlruGJ+BAzycLr8M0Ea8fUE/6KRdradm31VgKaUFf1tY5GG
         IbmDjBWSMau2ZC00FcbhSou9o37vrFAsbdc5m/kUIRQmEOaiVjCJ6lV9BNwXGmHXjT8j
         +QembIylrLmSBrLb2AWqOWI8rfFquPWCZNC+P+iZHaAbO24le0Ad9wTSI92uaKKxNuEz
         htJXhm4ZRKMdgNsZVTT/8ZTNZ2c4pT/sBXoDNsFRms2jvvoKnN9uDs3VEzat/C83zr3C
         wyU4+dwNtj3fRdFFgl2QTlP+xA3YntcLB+knGbWUEop6nW9SXWPA7lPcAO8acsUxqw7e
         5TtQ==
X-Gm-Message-State: AC+VfDzbav8k99854G8E+QHEtraAVK2JPFEz2v2YaydDjQ4aTPzF4r5V
        jyh7It8TXBQgUAf6tB3n+/xtbFB6gcc=
X-Google-Smtp-Source: ACHHUZ5uMnQSSe95TOijWLy910oD4SBSmAb3lO9Z8s0/1aUxuJRS6iZF7CFhP0EGnL234WsjknGFVw==
X-Received: by 2002:a05:620a:3f4b:b0:75e:14f3:5da1 with SMTP id ty11-20020a05620a3f4b00b0075e14f35da1mr15504759qkn.42.1686798524374;
        Wed, 14 Jun 2023 20:08:44 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-217-2-adsl.sparkbb.co.nz. [222.152.217.2])
        by smtp.gmail.com with ESMTPSA id 26-20020aa7911a000000b0065440a07294sm11276206pfh.95.2023.06.14.20.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 20:08:43 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 0043E360316; Thu, 15 Jun 2023 15:08:39 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        martin@lichtvoll.de, fthain@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v10 0/3] Amiga RDB partition support fixes
Date:   Thu, 15 Jun 2023 15:08:34 +1200
Message-Id: <20230615030837.8518-1-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Following up on Martin's enquiry, I am resubmitting the Amiga
partition support fixes again as v10, with changes addressing
your comments on v8, and a fix for warnings I saw from sparse
checking on v8 and v9. 

The simple fix (patch 1) still leaves ample room for overflows in
calculating start address and size of a RDB partition, though
such overflows should only be seen in rather unusual cases.

To address these potential overflows, checks are added in the
third patch of this series. Comments by Geert have been
addressed in full. 

In order to avoid warnings about a cast to a restricted
type (__be32, inside be32_to_cpu()) introduced by the third
patch, the second patch changes the annotation of the
rdb_CylBlocks field to __be3, which is what all of the 32 bit
fields in the RDB struct really ought to be. 

Reviewed-by tags by Geert and Christoph added. Fixes and
prerequisites for stable backport also added. 

Patch 2 still needs formal review. In my humble opinion, patch 1
can be applied while we wait for that, as it does mostly fix
this long standing bug (at least when LBD is enabled). 

Cheers,

        Michael

Michael Schmitz (3):
  block: fix signed int overflow in Amiga partition support
  block: change annotation of rdb_CylBlocks in affs_hardblocks.h
  block: add overflow checks for Amiga partition support

 block/partitions/amiga.c             | 102 ++++++++++++++++++++++-----
 include/uapi/linux/affs_hardblocks.h |   7 +-
 2 files changed, 91 insertions(+), 18 deletions(-)

-- 
2.17.1

