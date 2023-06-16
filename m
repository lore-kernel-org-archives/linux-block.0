Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CC2EB64D9
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 01:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjFPBTS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jun 2023 21:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFPBTR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jun 2023 21:19:17 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04842959;
        Thu, 15 Jun 2023 18:19:16 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-75d4b85b3ccso22886985a.2;
        Thu, 15 Jun 2023 18:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686878356; x=1689470356;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cAVdLOTJ1zYbui/212MXWSvsgY0dsdtWgvAXgi24g8=;
        b=lGYPOIJTK08LxTbAxFsXUk6XB8lH9xPZjchbpLyYtw6EYfnzo4BrmKSNuskVsCPg+z
         q/VBiYiXMr94/mDoVltSVYq/M1LOiSsHDF7YtLRd4GkFhz0EMI35+jioHMVdzYCU1QbP
         NQOeTw7p4ZIBDZi0NnkzJPiDuqCR2SnABSsLUe1txwPnYYv5KjZZp6h3tNSTNQfpMAe1
         hFH52UD+3qt7Gw0aQU4wlZ29Zpaw2VNzrr1CnAEz9x1aLPch1BPYiNoJPujkt5aI0Myx
         tEfZDb6IUhV0/dgnpRQ6WWOJk36IWaqrKC+rY4o+6V9PYMlkEXtTwYe1oEObBAAgJAiY
         SYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686878356; x=1689470356;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cAVdLOTJ1zYbui/212MXWSvsgY0dsdtWgvAXgi24g8=;
        b=GQaF5PS9DfabdWwK8to0CH/4qYnnH3gTA/0dvBvVzAcU0XHNUIEeNQ8AA95VF4smCU
         j0Jgc+3l7pqEAaYmR/uZo5qksnF9PsNWJal35D5OsovJIZHJ36QZRGJLHydgo+eW4Lo+
         2yEERLM0EDhoOeIXewnCpiEq3Yq+ISQvjstusgxXDTawZCOlv0+8wwKJt55GyrCrXSVE
         /+0kzEVL7fq9gcVUx+69YwatF7+qRxGb+MnOvN0fiMh7FTAmpbGoTxzBJgM5gsEWW2N9
         eSGypNKS8mMUW5KrL0PlR9jyKP0DlmabACdzr7yacuOxDF/sh0E0JO1giCDnxhLB8oHI
         K+vg==
X-Gm-Message-State: AC+VfDxL1meeA+JqzHbFeSBiZW7niaIzJN2spQ+tSl/sKE3Hw8lqA9U5
        aq1rLALuJn9+xlx4W+qokbwjIeUfZVI=
X-Google-Smtp-Source: ACHHUZ7/TCRCy/mO1ZLK6bwMnq2OQOt2O1qrsqi3Rl4SbmY1YM0iyVx3KLfbNyr2gzCidoDFJk5Ptw==
X-Received: by 2002:a05:620a:2b95:b0:75e:d513:ba3a with SMTP id dz21-20020a05620a2b9500b0075ed513ba3amr199788qkb.71.1686878355707;
        Thu, 15 Jun 2023 18:19:15 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-217-2-adsl.sparkbb.co.nz. [222.152.217.2])
        by smtp.gmail.com with ESMTPSA id x20-20020aa784d4000000b0064d566f658esm243691pfn.135.2023.06.15.18.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 18:19:15 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 70000360318; Fri, 16 Jun 2023 13:19:11 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        martin@lichtvoll.de, fthain@linux-m68k.org,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH v11 0/3] Amiga RDB partition support fixes
Date:   Fri, 16 Jun 2023 13:19:04 +1200
Message-Id: <20230616011907.26498-1-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Following up on Martin's enquiry, I am resubmitting the Amiga
partition support fixes again as v11, with changes addressing
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
patch, the second patch changes the annotation of all __u32
fields to __be32 (which is what these fields in the RDB
struct ought to have been in the first instance). 

Reviewed-by tags by Geert and Christoph added. Fixes and
prerequisites for stable backport also added. 

Patch 2 has been initially reviewed by Christoph and Geert
(but no Reviewed-by tags have been added). In my humble
opinion, patch 1 can be applied while we wait for further
review, as it does mostly fix this long standing bug (at
least when LBD is enabled). 

Only change in this version is to change all __u32 in the
affs_hardblocks.h header, not just the one that caused
the sparse warning.

Cheers,

        Michael

Michael Schmitz (3):
  block: fix signed int overflow in Amiga partition support
  block: change annotation of rdb_CylBlocks in affs_hardblocks.h
  block: add overflow checks for Amiga partition support

 block/partitions/amiga.c             | 102 ++++++++++++++++++++++-----
 include/uapi/linux/affs_hardblocks.h |  64 ++++++++---------
 2 files changed, 117 insertions(+), 49 deletions(-)

-- 
2.17.1

