Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3DCC19F2D
	for <linux-block@archiver.kernel.org>; Sat,  6 Aug 2022 15:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiHFPUK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Aug 2022 11:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiHFPUJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Aug 2022 11:20:09 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F6911A11
        for <linux-block@vger.kernel.org>; Sat,  6 Aug 2022 08:20:08 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id t2so5043850ply.2
        for <linux-block@vger.kernel.org>; Sat, 06 Aug 2022 08:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=zQVFHtso7Wxh1NUmCkM1fxCnfA8C4qJXSMja8MlYi8E=;
        b=L9QbA3njQ8lv5wdJ0bf7aonCU+q58kHiDOBBBDhKhCL+4Ur7EQbSJw6PfbyvyQ3Phw
         isPWe48jNbE2PIx+H/Qvg5TCjWLBhE96htu4zjzDUqi4/hhjcieOWkr0rIWP6NxLbgeB
         zQvmpQG3Z7GJaw24qJxR+er10LgNCfkKqT+FkijGWhHBcG5hZPGa5GyMbJAUpuEzh7yQ
         H+k4Gjh5TkUFcqmkSGRaBRs5atRrqs3ip0/dM2c5+TI6LbubGxIoXdPkRuLFtuRgSrgt
         AKT0hbUKxfH/PECTGe/e4X/TSYavBZFOdMlw70Pta1zThaFKtgJX76m89R02NKIG26Le
         WzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=zQVFHtso7Wxh1NUmCkM1fxCnfA8C4qJXSMja8MlYi8E=;
        b=36unruEpTjmM8AiIGfe9Lu6DatyE4MQkTUnpjThvJg3l8q2rplJVfzBjQKu7RrThkL
         vJA9l0KXIbUvg911RFn0pMCFBxI5txHLHAMuilgVQNI9AJX/trDZ6rqrNeMHVR7KwENH
         AQg4GFmDTALWzRe+OQSDA477XIhOaHlLc1mRhEfM57piEUnaDKRvjulL73l+6Q5rf+nA
         OM0tF9hcZSzIvR4yvsZDTXqSk90KWKmDffaeDXnh4QRgOolQvegn0YDyyVk7mRoLc6bx
         CJXsz2EfCHYKTPADqlnLBOm2Xqe1crwgJ9ohiYmZSXaAGv/pZNr78QEmqBMEZU3/z5g1
         AcFg==
X-Gm-Message-State: ACgBeo1vt8BTWwh6OxPWaptyoI/LX8s4sT+aTw1pCIdRrKu9KgyltWVd
        ZkExySFQLOq8J+9Yk02fTludKMXB8bu3Kw==
X-Google-Smtp-Source: AA6agR7ATNqiNF0kLMCPG2zHi7T3Z2xw3k55YDoyVFj+vnzEyjL+rKmICijacfPGZ3wbDlnhFkcFOA==
X-Received: by 2002:a17:903:28c:b0:16d:cf30:3b71 with SMTP id j12-20020a170903028c00b0016dcf303b71mr11623180plr.165.1659799207901;
        Sat, 06 Aug 2022 08:20:07 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f7c600b0016d1f6d1b99sm5158661plw.49.2022.08.06.08.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 08:20:07 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     joshi.k@samsung.com, kbusch@kernel.org
Subject: [PATCHSET 0/3] passthru block optimizations
Date:   Sat,  6 Aug 2022 09:20:01 -0600
Message-Id: <20220806152004.382170-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Currently passthru IO is slower than bdev O_DIRECT. One of the reasons
is that we do two allocations for each IO:

- One alloc+free for the page array for mapping the data
- One alloc+free of the bio

Let passthru IO dip into the bio cache to eliminate that one, and use
UIO_FASTIOV to gate whether we need to alloc+free the page array for
mapping purposes.

This closes about half of the gap between passthru and bdev dio for me.
If we can sanely wire up completion batching for passthru, then that
would almost fully close the gap. Outside of that, the main missing
feature for passthru is the ability to use registered buffers with
io_uring, as the per-io get_user_pages() is a large cycle consumer as
well.

-- 
Jens Axboe


