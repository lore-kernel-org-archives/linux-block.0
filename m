Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8630ECAAA1
	for <linux-block@archiver.kernel.org>; Thu, 27 Oct 2022 22:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbiJ0WPf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Oct 2022 18:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbiJ0WPd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2022 18:15:33 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBF986F95
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 15:15:29 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j15so4505143wrq.3
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 15:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R4Tmf0UJ3dVj/Ly2lTIkQszLlPtVNLjljG6UCb3/RMI=;
        b=nJLdtxkTrsoljgHn4oB4mEu9RkDPdCG89qhR9U8sTSFdW0wE7LQbgLmokXTcwwHfBs
         s3w9PJVbx17C1q+VYvhIM1Bx3vMgzp1SE2IiTh1Q94dvkna9ziphh8bIt0e79WwjrdQB
         3fj7CguAbOHZhQ1Xn3n4xAs4XnB8CaYoYfZfK0+1bmHp+07kKR1uGGJnPgi2Eg2LlgnJ
         VpT+eEli9htC6pS2SZatnkf+fBOZv3+midvHVxYc6M/j3Uifx52D9zKCSfg4cAj5uvJz
         xIr+KSCIKDAKRVJr6JRW771rcTcIo6A37PogJU5T34AyXTpiC2b7E+awWIsu6iSzjec1
         8HOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R4Tmf0UJ3dVj/Ly2lTIkQszLlPtVNLjljG6UCb3/RMI=;
        b=johSAxqrPaHBWtQto/TLplU7RR5XbnLZx9mjJ8qrR+6oo0XvlZ+mPqx8LipUtMr722
         6/S6Fr38aUA2toqTuQpHkWM2qVmO8Glu+khkoYH8jF0fa53fJYLWt6nwXrU5HRcScqhW
         ZXZNcSgAOEyWN3NyEdekQbDg/FaTbd07t9I6jBqkR2gkvxKMDNdjgH73ZqITMPW/tJal
         mEs0ZUaGZXynMU2REKCco74Nx2aP/2c6FuDSSBbjUF0hwIjyx0Qff8sHjyaRRxsDZ0UP
         RumfPs8fbTRpZST5kQLz6qHJIZ3VtbOGo4ddIekt4DZfOJrlS4PBmDnCQTjTGvXwWhzq
         oZOQ==
X-Gm-Message-State: ACrzQf1NOQJN3GwTUbIzE3YMAXNfWlVHT9nS4lJKeWYzpKasoPjgkV/3
        snwhYM5uwYylcqPG85ihO/z9uXvCOJHAQw==
X-Google-Smtp-Source: AMsMyM7t9c02P8PTv8WQGU7khgAFG5Gz+335z6zhnRnftt731L7joosMVL1+S4B9LgJTjwfAiSQ1Jg==
X-Received: by 2002:a05:6000:184c:b0:22f:edd8:821f with SMTP id c12-20020a056000184c00b0022fedd8821fmr32006553wri.363.1666908928396;
        Thu, 27 Oct 2022 15:15:28 -0700 (PDT)
Received: from 127.0.0.1localhost (213-205-70-130.net.novis.pt. [213.205.70.130])
        by smtp.gmail.com with ESMTPSA id bs5-20020a056000070500b00236674840e9sm2085460wrb.59.2022.10.27.15.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 15:15:27 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH for-6.1 0/2] iopoll bio pcpu cache fix
Date:   Thu, 27 Oct 2022 23:14:20 +0100
Message-Id: <cover.1666886282.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There are ways to deprive bioset mempool of requests using pcpu caches
and never return them back, which breaks forward progress guarantees bioset
tried to provide. Fix it.

Pavel Begunkov (2):
  mempool: introduce mempool_is_saturated
  bio: don't rob bios from starving bioset

 block/bio.c             | 2 ++
 include/linux/mempool.h | 5 +++++
 2 files changed, 7 insertions(+)

-- 
2.38.0

