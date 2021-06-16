Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2580C48BE5
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 16:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C21C1613BD
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 16:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhFPQm4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 12:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhFPQmz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 12:42:55 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CDFC0617AD
        for <linux-block@vger.kernel.org>; Wed, 16 Jun 2021 09:40:47 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id a127so2631342pfa.10
        for <linux-block@vger.kernel.org>; Wed, 16 Jun 2021 09:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=epXDcsa+iB2IdU4Gd981bdI+VgdMiEH3uS5c66pfdMk=;
        b=GkLCmFh/vzfPIF7v1q7mJc1wazpBYwrpHlrK8VamLK/tdnFXUDt3Jqpo/4zhnIgkB8
         w2Pa4tHYHF/iTjxBxw7knQzMcGPxxObyF5+9fqOM24ruxemJU2JYyJ4aKfJ6/wO0ElHe
         T6vfoZDbGX45mQjwQTttWWusehKNnlTA3+E6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=epXDcsa+iB2IdU4Gd981bdI+VgdMiEH3uS5c66pfdMk=;
        b=P0W4uxkK1NiTlGiP/LQREI7rgKem+p7h489Uybhtyo8OQzHPwLikhUru2VTs/vm2h6
         zICEJ5QyUhHxjO5gpZhV1VzJgv86OIpVTK5xmsa0z8fB+daTrvAw+7JCXiKOBz1j3KRW
         dr3L9K8WA2h5oSVrnRoeWuAcfW2iEtZY0GAj2bR/WRFaMLyeAfdG+hBkv4+fJ+4T6j6s
         7DREcoBhJH6xs04MfJf2TIy724jkOgHPkkkZLFZd9RdOy6ONzsyBGHV2/sLfBdCwIvz3
         IqLI7GOX33Si4ZweQEUG03+oc7YBkObgb5/ptVa4yPE/9kkUs7SILSJHyhIDsci6Zny7
         ZKIQ==
X-Gm-Message-State: AOAM530INWALuP+pxgh4bXE6dZaabcU9U1PUNLFvtXC6Ju7Vuk43N1tf
        veFurgnt/LsbbtUtiGxnyncYbw==
X-Google-Smtp-Source: ABdhPJwSppm5irPLhD/8UhbktXBLwwAA5AGV8driRal8NYsxUQyf0Pz+CGSw19WrD/+6GFIZo7Qt8Q==
X-Received: by 2002:a63:5c04:: with SMTP id q4mr453285pgb.127.1623861647276;
        Wed, 16 Jun 2021 09:40:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c5sm2840547pfn.144.2021.06.16.09.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 09:40:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, gmpy.liaowx@gmail.com,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-doc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 0/5] Use the normal block device I/O path
Date:   Wed, 16 Jun 2021 09:40:38 -0700
Message-Id: <20210616164043.1221861-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This fixes up pstore/blk to avoid touching block internals, and includes
additional fixes and clean-ups.

-Kees

v3:
- split verify_size move into a separate patch
- several changes suggested by hch from the v2 thread
- add reviewed-bys
v2: https://lore.kernel.org/lkml/20210615212121.1200820-1-keescook@chromium.org
v1: https://lore.kernel.org/lkml/20210614200421.2702002-1-keescook@chromium.org

Kees Cook (5):
  pstore/blk: Improve failure reporting
  pstore/blk: Move verify_size() macro out of function
  pstore/blk: Use the normal block device I/O path
  pstore/blk: Fix kerndoc and redundancy on blkdev param
  pstore/blk: Include zone in pstore_device_info

 Documentation/admin-guide/pstore-blk.rst |  14 +-
 drivers/mtd/mtdpstore.c                  |  10 +-
 fs/pstore/blk.c                          | 403 +++++++++--------------
 include/linux/pstore_blk.h               |  27 +-
 4 files changed, 171 insertions(+), 283 deletions(-)

-- 
2.25.1

