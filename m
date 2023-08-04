Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D010AC001DF
	for <linux-block@archiver.kernel.org>; Fri,  4 Aug 2023 11:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjHDLqS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Aug 2023 07:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjHDLqR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Aug 2023 07:46:17 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463D8126
        for <linux-block@vger.kernel.org>; Fri,  4 Aug 2023 04:46:13 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99c1f6f3884so278067266b.0
        for <linux-block@vger.kernel.org>; Fri, 04 Aug 2023 04:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1691149571; x=1691754371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BCoO+eXbLDZ6LS4ScYv1U/n5Fj5ZbQV1Lly5tQSedaA=;
        b=ex9GIswFD6wVaea7Y/G4QtiPWycco6WsxPzjVlDZM28jkmAO/OnGr/fV4XKKdftbK8
         1zQDeAEmYQCkpMOyKA7sMpERno8pfqUksnohPEa8CGTe5LapfSzvXgW+JDX077GTZm0v
         84XD0l+st2UuvHMCO93Zxfr57yTpaGp3x6/x8bXtMBgaqajL5liBrSR9/W+9+BcWKPjw
         U4bESYY7LvANqQ0IWgRzspnBMvPdGJqp9F/lZdoFPHdCebTMrZpTc3RqsTybMGdIHSI9
         z+mLeTLF03kMaThUjZNspToUWBsL4ko75dtibBAZmvY3PLxWpsKln6CYMLH0PEoIJFy/
         rX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691149571; x=1691754371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BCoO+eXbLDZ6LS4ScYv1U/n5Fj5ZbQV1Lly5tQSedaA=;
        b=QYfuq4MEcgadWPZoyIjqphXZJTCl4inoNoqjwfUeZn2mQeztaciUNNn8v29iPyED0V
         tZq7xPmTKe0S8rzYQVkiHYQhXX19hnPlC1cNCLZqMGKdiCYAzQ1IWKXOSQ9+qte9LbMg
         QF2BV96fWzI+zUHLR7/6ixkSdv/jBcLSEwVuPwkOtraruoyPx7RMrcUugGJBlPaxpZCL
         AYpDTm9lNyXOlAnAGGfYDA496bDpoWegcDNMUeUUK4xLZc4/D0TsiMVLJaYFgEPSW/Sq
         I30sX6d7SUMpbxA1JBHndq1CbGQjnYhvszR0CbloiLC0HM5DsLfbfDOi6YEM0P3grSE/
         sgxQ==
X-Gm-Message-State: AOJu0YxznMVaPAa/h9FCMwtOD7Q80MrQq+ASt0k9XNYzT8fYh8ndLx2b
        FynAQKP89Xn5zaMrNWR64+G3dA==
X-Google-Smtp-Source: AGHT+IGUtsnOFxbNePDUk61BtaBL6nP9F1OwCQHPVQy9YswjGkhl5WqyXbQ+Jh0ImRPtdFBOGVNBSQ==
X-Received: by 2002:a17:906:d8:b0:99b:ca5d:1466 with SMTP id 24-20020a17090600d800b0099bca5d1466mr1435276eji.66.1691149571637;
        Fri, 04 Aug 2023 04:46:11 -0700 (PDT)
Received: from localhost ([194.62.217.4])
        by smtp.gmail.com with ESMTPSA id lc15-20020a170906f90f00b0098ce63e36e9sm1210960ejb.16.2023.08.04.04.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 04:46:11 -0700 (PDT)
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Christoph Hellwig <hch@infradead.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER)
Subject: [PATCH v11 0/3] ublk: enable zoned storage support
Date:   Fri,  4 Aug 2023 13:46:07 +0200
Message-ID: <20230804114610.179530-1-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

Hi All,

This patch set adds zoned storage support to `ublk`. The first two patches do
some house cleaning in preparation for the last patch. The last patch adds
support for report_zones and the following operations:

 - REQ_OP_ZONE_OPEN
 - REQ_OP_ZONE_CLOSE
 - REQ_OP_ZONE_FINISH
 - REQ_OP_ZONE_RESET
 - REQ_OP_ZONE_APPEND

A user space component based on ubdsrv is available for testing [1] with the
"loop" target.

Read/write and zone operations are tested with zenfs [2].

The zone append path is tested with fio -> zonefs -> ublk -> null_blk.

The series is based on v6.5-rc4.

Changes for v11
 - Style fixes
 - Use `kvmalloc()` instead of `__vmalloc()`  for zone report buffer

[1] https://github.com/metaspace/ubdsrv/tree/2966e5f9637b5856d4a4273ae113e31b1c53ff98
[2] https://github.com/westerndigitalcorporation/zenfs
[3] https://git.kernel.dk/linux.git

Andreas Hindborg (3):
  ublk: add helper to check if device supports user copy
  ublk: move check for empty address field on command submission
  ublk: enable zoned storage support

 drivers/block/ublk_drv.c      | 348 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/ublk_cmd.h |  63 +++++-
 2 files changed, 383 insertions(+), 28 deletions(-)


base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
-- 
2.41.0

