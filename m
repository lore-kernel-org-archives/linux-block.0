Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16068C38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 22:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD5BB21974
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 22:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="IaPO7e8h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgEHWAX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 18:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727095AbgEHWAW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 May 2020 18:00:22 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62747C05BD43
        for <linux-block@vger.kernel.org>; Fri,  8 May 2020 15:00:21 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y24so12327347wma.4
        for <linux-block@vger.kernel.org>; Fri, 08 May 2020 15:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HJaSGZ1p1+2gTGleg/polxs+Iy4GGrNGzSb8aVDGzrQ=;
        b=IaPO7e8heLcfhT9bkoaHzPo555GzJw1+LYpUUo0zXxp4egYkIo8uKH2hJ12Gf60np7
         6ThjNHhMdYtWeGtQ+yVnic8OSNXCdGjK1zQbTpFLQTCWUwFjUVW+F9PW+u3ohqNYIVDv
         4ryJk5yYm5OV9PVscfngBf44Qc+EJWGxjQI4lgGJ5f0Tf+UlZs3H+iK1ZX4x0ZO0ghfE
         dcmCNmAKY5bQs3/rA/aOm8iIOQ67grMUEvIYLLFIO2VnxdUs2VL7ERL+yM6M7YZo8KwA
         AuByX002gvPWVYrIud5jWNMQbrHgHcvgTMKrg0tvYmEfqaMjftdBCj11iZVHhw+zemO4
         +GIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HJaSGZ1p1+2gTGleg/polxs+Iy4GGrNGzSb8aVDGzrQ=;
        b=A362jzeBFGGXpWqjUl7KFzeUo666UISHv7zQP4F1mHkt5l+hIm20n20xOTVdZXp4EE
         5+x37dLZ0ZXA2cSh+zwqoAVCZ1vPoW7JHivebySgrYT4/lNRD6LhPl5gDiX+GcXbvePz
         /00N1/1C8L0nni8Rt4eAHs0s0nKxV1HtMS5NUr7xQ1TdF3v17A6OjLcW/S/91NBvf3Tr
         eEwtcVIGSuRONl4Y4zoBxjGP0xhHwWDeDNQX+NUTUqAxjpfgYRzi6LC8DsMwAqiPUO4V
         ZuI3cQlCyXdsN8i+jvIQYUZHnrasibQibd6EzrUkXGk/C5r7QGjZa8TJpYazbhZnmu90
         /Dow==
X-Gm-Message-State: AGi0PuazbEfC0PxJ3Appo/McJirupB0gXsiLRVJJfPjC5Z9cKC0vriFN
        j8MO7hRUWzIu3d8O3+b1PNDS6Q==
X-Google-Smtp-Source: APiQypJLnh6LtTckOQfEbPKkVnV4ntXLy1KkxIyL4FBqg3edpvuCqixk6f15YHj2QiF0QmhrVzmjuA==
X-Received: by 2002:a7b:cf25:: with SMTP id m5mr19492194wmg.65.1588975219937;
        Fri, 08 May 2020 15:00:19 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:7d6e:af57:ffe:3087])
        by smtp.gmail.com with ESMTPSA id h6sm14646878wmf.31.2020.05.08.15.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 15:00:19 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 0/4] cleanup for blk-wbt and blk-throttle
Date:   Sat,  9 May 2020 00:00:11 +0200
Message-Id: <20200508220015.11528-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Find some functions can be removed since there is no caller of them when
read the code.

Thanks,
Guoqing   

Guoqing Jiang (4):
  blk-throttle: remove blk_throtl_drain
  blk-throttle: remove tg_drain_bios
  blk-wbt: remove wbt_update_limits
  blk-wbt: rename __wbt_update_limits to wbt_update_limits

 block/blk-throttle.c | 63 --------------------------------------------
 block/blk-wbt.c      | 16 +++--------
 block/blk-wbt.h      |  4 ---
 block/blk.h          |  2 --
 4 files changed, 4 insertions(+), 81 deletions(-)

-- 
2.17.1

