Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728EAC43334
	for <linux-block@archiver.kernel.org>; Thu,  7 Jul 2022 14:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbiGGOcI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Jul 2022 10:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbiGGOcH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Jul 2022 10:32:07 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129E22F659
        for <linux-block@vger.kernel.org>; Thu,  7 Jul 2022 07:32:07 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z41so23427146ede.1
        for <linux-block@vger.kernel.org>; Thu, 07 Jul 2022 07:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UjJsFctAYmJNYGb3k1akz7q+YpVVMY/DbTzo9lKBOsw=;
        b=OI3DxmJt9NVtLDAUixVCPZUK+YxHgpFJYSIlcUjgFOlj2VNxabjx7pHIRXyWoOx7tD
         BjYlw2jar10wVORvWENhJhwbNE3w4ecoyJWHYRV5Ve/LEKXYW6bYvIsBPSgjFtwPm6h3
         2C6/4ueAllYzzdPr/NT+9MXl1m+UaBxJIjX/I2HNCkH1ReGSBD9r6oZugQM2ZrZjBby1
         wOD5MKbKh9j8xzCcVFVPalLCCYukx5KoxiJQrFGNCAPQ6gmbPHF3npW6jC5m9SVhaRaL
         BirLdWjH1E0XIa7wtUpeHNxnXS9o8A+2rL3b2L2bKDLwNEStiFXY4g1s2KlkAO4kZEoJ
         4m3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UjJsFctAYmJNYGb3k1akz7q+YpVVMY/DbTzo9lKBOsw=;
        b=Fxs+zM6pdzGJoAvBPhDAL0kTnhrHVcM0dS5Qjv5oUDeRWIxKkYUWOtFA1RJOVx3LzQ
         D9vpZz3tFqQ5qrxH9laSoOygccaxM0fTjjYIUyv73Z0Rn1kk2kZkF8EVeDaxoH2iHYzQ
         Tk9Una5Zssz0E8Fji59ByaFBnQpLrWwiyej39dnYSfXvuNKJaBXu9KxXIVYaiCrlVFgP
         qib61yLu3138stBqHJLm5u5c0Rlluesjpi9A9PILH9R8utypZXYnJkaTJNb5A5ezu5hn
         E+pNvkJ8y0i4JhKvtsW5C4Zd5nmhCbnrDhkJ2DbH2XEuWLBbmyyPe7A9aDWqeUcjWxgJ
         jJqg==
X-Gm-Message-State: AJIora+bTDpAcgddF8F1l7F4Q3rF7reuy6O9AeLREdERrMekgyYf39Rj
        7lGCMSIXFhLa6u+7H5Y61p2pDrT+eXPK+Q==
X-Google-Smtp-Source: AGRyM1ubHVCHsgIKKwLkcP1tGNP5zKhTBXilv1gGch4jxdPxDSikHD+QO/zCvtd1xELnhieov/VgjA==
X-Received: by 2002:a05:6402:3284:b0:43a:7fb4:ad8d with SMTP id f4-20020a056402328400b0043a7fb4ad8dmr17052459eda.28.1657204326624;
        Thu, 07 Jul 2022 07:32:06 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id i11-20020aa7c70b000000b0043a5004e714sm9970896edq.64.2022.07.07.07.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 07:32:05 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCH for-next 0/2] Misc RNBD update
Date:   Thu,  7 Jul 2022 16:31:20 +0200
Message-Id: <20220707143122.460362-1-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Please consider to include following change for next merge window.
 - Fixes a minor bug
 - Removes a list, and replaces its use with an existing xarray

Md Haris Iqbal (2):
  block/rnbd-srv: Set keep_id to true after mutex_trylock
  block/rnbd-srv: Replace sess_dev_list with index_idr

 drivers/block/rnbd/rnbd-srv.c | 20 +++++++++-----------
 drivers/block/rnbd/rnbd-srv.h |  4 ----
 2 files changed, 9 insertions(+), 15 deletions(-)

-- 
2.25.1

