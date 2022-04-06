Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8F5C433EF
	for <linux-block@archiver.kernel.org>; Wed,  6 Apr 2022 20:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbiDFUtv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Apr 2022 16:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiDFUta (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Apr 2022 16:49:30 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F53A3221E3
        for <linux-block@vger.kernel.org>; Wed,  6 Apr 2022 12:05:05 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id n6so6156740ejc.13
        for <linux-block@vger.kernel.org>; Wed, 06 Apr 2022 12:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PVR1WiZiDN1kb7YdBQvF0QqeZSGem3zHMrQcF73X4Lc=;
        b=qLl81TqYj7KzL7UIqJKrovWynPv9i9YvrVVkvOnoxFVlUcwG/sjbdtihwTOe+I6x0J
         AvYqxznOHCH4/ucJ4CilN4lN5sdk71M9YhTMRg+MedHuhoY0VVWAkFK+M4DOw06geXcM
         OHeJE+ydwDEU9HQX4v/Maz5qOgnt62yz5qb28yyldCNFBOBg/sDSC6Jlff1PlnIk6Onq
         HQHiBU0Y2UgnZ80NhbgVgpMiw238blT+ZIj0vzf9cE8r4RoEd3BaaQTsRwFwpEpFz4X8
         1Vu2KbY/K3ByXSx8GQmQAcF1jWtUidYyxJkp5WRKP/G3WhzhZ7jPDJTmv96CcykdZkEI
         TjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PVR1WiZiDN1kb7YdBQvF0QqeZSGem3zHMrQcF73X4Lc=;
        b=IIiQ0YrrVHXbZbPL4VTMMg1pMqc3UoMniz96VFQ8Cc8CeQb0sQZcjfN4L40uw/S+Bj
         Dj88oLYqbfeudD1466hGwVUS2iUTB16T8bsHBVzAeYZKCpXPiy9sW+t+E4pDb/k9uV2j
         PAmNwlJFr4TAlmEe1TFZewlpqV1+SeL10v+wQUGQK+/JSxZRHXEOkVTfcR5XzEEExF5Z
         uexoBv8xSzYOuheFw9IxrkSIc87gc6w3lD8WGo5Haz/sXBcQh95Gv61LZLxPRWI1OYwY
         XNO/mAaIa0KR9/TqaHVgPPMVzUdbL8klpxgPOL/jMS3sZprQMX+pJW+u5TzWmbBd9hP2
         6rjg==
X-Gm-Message-State: AOAM5333hQswZ1BrkM0UCIUEn4SFpSUgkFBljnFXRug/NUjIrDPEUam8
        dGJ9J2J3ipH+wl9CjGZD2fO2gTgNbH9dh5fvbsI=
X-Google-Smtp-Source: ABdhPJzA8EL6/H38z0G1KGmEQjtYeR2zbJjBAKFQ3Wa+amzYg2FhNhCv8dTdSSlXd3LPMZPUAJa9/g==
X-Received: by 2002:a17:906:f85:b0:6d6:e97b:d276 with SMTP id q5-20020a1709060f8500b006d6e97bd276mr9525912ejj.431.1649271904122;
        Wed, 06 Apr 2022 12:05:04 -0700 (PDT)
Received: from localhost (85-127-190-169.dsl.dynamic.surfer.at. [85.127.190.169])
        by smtp.gmail.com with ESMTPSA id o5-20020a170906974500b006dfc781498dsm6919876ejy.37.2022.04.06.12.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 12:05:03 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 0/3] DRBD fixes for Linux 5.18
Date:   Wed,  6 Apr 2022 21:04:42 +0200
Message-Id: <20220406190445.1937206-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Assortment of more relevant fixes for DRBD to go into 5.18.

Christoph Böhmwalder (1):
  drbd: set QUEUE_FLAG_STABLE_WRITES

Lv Yunlong (1):
  drbd: Fix five use after free bugs in get_initial_state

Xiaomeng Tong (1):
  drbd: fix an invalid memory access caused by incorrect use of list
    iterator

 drivers/block/drbd/drbd_int.h          |  8 ++---
 drivers/block/drbd/drbd_main.c         |  7 ++---
 drivers/block/drbd/drbd_nl.c           | 41 ++++++++++++++++----------
 drivers/block/drbd/drbd_state.c        | 18 +++++------
 drivers/block/drbd/drbd_state_change.h |  8 ++---
 5 files changed, 45 insertions(+), 37 deletions(-)

-- 
2.35.1

