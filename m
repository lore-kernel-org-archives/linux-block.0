Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92E9C433EF
	for <linux-block@archiver.kernel.org>; Thu, 24 Mar 2022 20:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244145AbiCXUhE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Mar 2022 16:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344269AbiCXUhD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 16:37:03 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4482A8EDE
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 13:35:28 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id jo24so4685275qvb.5
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 13:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/DA2QpPVPr3enZ27mGPd7ho97R+A7tobG2oweYbaoNA=;
        b=ybl30GJaSunAZfDwmu/B66FccoUJ9/OgTc6L70wpj3HnhZsHTa3Vu+ZQt+bTEUWtlL
         zs++BszOpf2aQomYZ9AGTnWbv/QTa0s9UfXW0Ah+qBSpessbTAiodGrejjXN6RnNNamv
         Ma2Q77fPPyymVzl7/yWvMz9NCKSwR6ZsCfjhUyyMEBtqON4U7tfxUNi/oZpQGt69amUC
         oCw5psdlpI6ImloFCG3n1LOm7NqGtAOanY0PPunSCnxRgyuPZeBzd7oHfs+aK8O1But7
         HuUHHAxQMHStRV357IkBs4Aae2g12ScJGyaFeDzqcFVNTnHV/C5HBk1xah9FrxJ3u5/V
         fkjA==
X-Gm-Message-State: AOAM530iXGNXEUqc+Q+N7HpExTytrUxVLpAoHrfQIQ9gD3EWaNlLzvuh
        e30gDT2xHHPw29kw8ac+4e5NSzt4Mb8s
X-Google-Smtp-Source: ABdhPJyGBdmnolpgAFuBdwe78chN1I2/ElrtcKyGcbdJw04vnJanHfFxqWQMoGpNfYfYLSKcO7xQdw==
X-Received: by 2002:ad4:5f4b:0:b0:441:4d40:f8d2 with SMTP id p11-20020ad45f4b000000b004414d40f8d2mr6070094qvg.33.1648154127897;
        Thu, 24 Mar 2022 13:35:27 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id o21-20020ac85a55000000b002e16389b501sm3174633qta.96.2022.03.24.13.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 13:35:26 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH v3 0/3] block/dm: use BIOSET_PERCPU_CACHE from bio_alloc_bioset
Date:   Thu, 24 Mar 2022 16:35:23 -0400
Message-Id: <20220324203526.62306-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.15.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This v3 is a rebase of the previous v2 series ontop of the revised v2
patch that Christoph provided.

Linus hasn't pulled the for-5.18/dm-changes branch yet, so the 3rd DM
patch cannot be applied yet.  But feel free to pickup the first 2
block patches for 5.19 and I'll rebase dm-5.19 on block accordingly.

Thanks,
Mike

v3: tweaked some code comments, refined patch headers and folded DM
    patches so only one DM patch now.
v2: add REQ_ALLOC_CACHE and move use of bio_alloc_percpu_cache to
    bio_alloc_bioset

Mike Snitzer (3):
  block: allow using the per-cpu bio cache from bio_alloc_bioset
  block: allow use of per-cpu bio alloc cache by block drivers
  dm: conditionally enable BIOSET_PERCPU_CACHE for dm_io bioset

 block/bio.c               | 88 +++++++++++++++++++++++------------------------
 block/blk.h               |  7 ----
 block/fops.c              | 11 ++++--
 drivers/md/dm-table.c     | 11 ++++--
 drivers/md/dm.c           |  8 ++---
 drivers/md/dm.h           |  4 +--
 include/linux/bio.h       |  8 +++--
 include/linux/blk_types.h |  3 +-
 8 files changed, 73 insertions(+), 67 deletions(-)

-- 
2.15.0

