Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3FEEB64DC
	for <linux-block@archiver.kernel.org>; Thu, 20 Jul 2023 14:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjGTObW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jul 2023 10:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjGTObV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2023 10:31:21 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA701BF7
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 07:31:20 -0700 (PDT)
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1E4CA3F0F8
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 14:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689863478;
        bh=WyXPvm6GnRts3mVrmKERRd4ZFmqdxtmESBoZHU6EXmk=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=nSGu8EAc05FHsYyiLq8mn+c172Gm84v3u4B4o96KD257E+1yudyppS2IOYx0mPpfG
         o7e+Gyx7nfszyG7sq+ooS+rKyT5FrfIS6iSLpYM+UFEM3NGUxqsCcG6JcjV+ttzg/m
         q/7yR9O7NGn8NCCszBSrmCNwlq7LIF6VIiYpo/VwaTzr1jdKNqoqmOaZib30exzNsF
         UBqUUxGl2b/jgCVDbyiNDC1F9RgHZ3vIXalMvMKvmPwUGUn6ssl5jQw2aI7nYcVN8K
         1fktEPqlc6k34U0CvA2ustYuLU5A6+cSwZxoiPW4eBigBdegkxBqNg2Czt62IKM5ko
         cDJ0w/qMTA8FQ==
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-566ed76d87cso2768419eaf.0
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 07:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689863477; x=1690468277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WyXPvm6GnRts3mVrmKERRd4ZFmqdxtmESBoZHU6EXmk=;
        b=enhtKNfDWVYsYn0iEkXbvDBJhCah7nI2zxGIZwo5eYL1tBGNEp0Lz1dgXc/pXrXEOt
         YWC9WPqBpeDaqHGvNrTWRyj9huPUj8SRagAhJNwFekeibazrLsgIu80YMFh89dViqUa1
         U7ADVxJ0orI6GhIPYlz8On+h1ye+zgNSE9hsKRIN+xyObCyybKbaMQa9IS1l6UbvxuoF
         LfG29lWaQUF69h7si3CpyjeMdkHUa4bvJRk3SrjTfVUWaC86JUNX8V2p0nnqE0TXd1uM
         1UI/7ewMWPkqXx0v19u0AO5No8i5ghGC9nbLuBbntPTCE7PG19dof+Tv1NjWaGQfrphW
         BmTg==
X-Gm-Message-State: ABy/qLY4wDmXC1MlpFXZTpUfHjF1JX76CcGQWoN1DUJF9jZHwAObEJLJ
        06GtcOzLLz8/vpFC6YhxYc1AL2Kw2AQof66xFfmiN3H543uKAp82/cFWqAMfXbyTfUm4tacjOkA
        nH/mzp5yNy70tJYGbHaEDgQwfp4MjnubUQYZUQZW4
X-Received: by 2002:a05:6808:206:b0:38e:e0d2:6080 with SMTP id l6-20020a056808020600b0038ee0d26080mr1168834oie.19.1689863477044;
        Thu, 20 Jul 2023 07:31:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE4XWHFSWZJ8DMRWnbsPy+VQ0600AWJTXgC2vZJg8pxD66z5yJYEG/nEFZ5PCPgua3T6OoSrA==
X-Received: by 2002:a05:6808:206:b0:38e:e0d2:6080 with SMTP id l6-20020a056808020600b0038ee0d26080mr1168816oie.19.1689863476668;
        Thu, 20 Jul 2023 07:31:16 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4e1:8296:c121:4d01:95b0:7009])
        by smtp.gmail.com with ESMTPSA id bg28-20020a056808179c00b003a4646e0896sm415543oib.32.2023.07.20.07.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 07:31:16 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org
Cc:     "Isaac J. Manjarres" <isaacmanjarres@google.com>
Subject: [PATCH v2 0/2] loop: fix regression from max_loop default value change
Date:   Thu, 20 Jul 2023 11:30:31 -0300
Message-Id: <20230720143033.841001-1-mfo@canonical.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Apparently, there's an unintended consequence of the improvement for max_loop=0
in commit 85c50197716c ("loop: Fix the max_loop commandline argument treatment
when it is set to 0") which might break programs that handle /dev/loop devices.

The (deprecated) autoloading path fails (ENXIO) if the requested minor number
is greater than or equal to the (new) default (CONFIG_BLK_DEV_LOOP_MIN_COUNT),
when [loop.]max_loop is not specified.  This behavior used to work previously.

Patch 1/2 just notes the loop driver's autoloading path is deprecated/legacy.
Patch 2/2 detects whether or not max_loop is set to restore default behavior
as before the regression (and keeps the improvement done by the commit above).

Tested on v6.5-rc2.

v2:
 - 1/2: simpler change per Christoph's suggestion.
        same test results (specially the last one), as expected.
 - 2/2: added Reviewed-by: Christoph.

Thanks,
Mauricio

Mauricio Faria de Oliveira (2):
  loop: deprecate autoloading callback loop_probe()
  loop: do not enforce max_loop hard limit by (new) default

 drivers/block/loop.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

-- 
2.39.2

