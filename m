Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B296C43470
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 07:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 251EF60FE9
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 07:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbhDSHiV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 03:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237870AbhDSHiU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 03:38:20 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50E8C061763
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 00:37:50 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h10so39398614edt.13
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 00:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kipd4FaBQ5PXB3dpojcZn5niu7bqNibIYxBeruWL79Q=;
        b=HgY0j0ha4IQEbIMeD9Jl48Vj45hJ4hoD/OU1s1L/4qjVu40ZRRM+j/PhoOkDT72RGh
         nipew/w97g5MPmGHjZiCi0WqU893BLWIXQIv2wi8yfScayy8jYkf54Pr5rvKYbTu1H6a
         P+1X3W5hiXxKlCiLRsN1CG0vrQfaaNaMGiYd3RwK0yx0+y8i8DS5onooeNmV+aIEGnTr
         d6Yb0iUBCD1E7seTllm2S4LdrHnfP4Q5nMRQREO3tRUNEiyaV14wnYVScgFd+0tUMMLz
         ZVSccZMvl3008dKEpojweGcCdWfRCOibARopscS/p+W1CgCLMuAWYpU66O18WW4Lf6Yw
         FODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kipd4FaBQ5PXB3dpojcZn5niu7bqNibIYxBeruWL79Q=;
        b=WUlFzxeaTg+ZJM32PEfQPoEfuaLb2OL8RwHnxsVExcMYIGJ47jf57+FYUe0DN/G3vu
         brNcYinnreqDwulpeSlJykhXNWzk+VwYVQxn7FH1ue6o48rlZ2IkXsFd/IIv4bauz7AS
         cKkLgeRHFxd35bKUKu41hU6je3lDnrBWEYBpOBcbEcgwI+FaiE7VeYwpqh3r77V7FqY0
         cuUaIRhtG0I3R5HzW0ISmtzRFsD6PERJEUuPVXQ6ewkigz93Qr0B56ctyVrln8BcxakF
         w96nOaA22CPEhCaMeBW8FB9i1+WjjRY5wOsrplECFck/4E9Jg2wA6vH6hbwTNla4UKBo
         sPrw==
X-Gm-Message-State: AOAM533VtrDiWPfL+RuxuR0p2/V/4OO3gvM5n+pmaVokh76A6S+ZNDK2
        Ey7XMh8yPqLkV/b70DdQg722zNT4d0gOVQ==
X-Google-Smtp-Source: ABdhPJwio9uJB3Uc4HMRjvrjpbjH/azmfAkxVmWp1DsH7TlNNfhzbFcIKbUImJGSbhTYOUnhUi0ldQ==
X-Received: by 2002:a05:6402:440d:: with SMTP id y13mr24222456eda.316.1618817869619;
        Mon, 19 Apr 2021 00:37:49 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id g22sm8701833ejz.46.2021.04.19.00.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 00:37:49 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     axboe@kernel.dk, akinobu.mita@gmail.com, corbet@lwn.net,
        hch@infradead.org, sagi@grimberg.me, bvanassche@acm.org,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCHv5 for-next 02/19] Documentation/sysfs-block-rnbd: Add descriptions for remap_device and resize
Date:   Mon, 19 Apr 2021 09:37:05 +0200
Message-Id: <20210419073722.15351-3-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210419073722.15351-1-gi-oh.kim@ionos.com>
References: <20210419073722.15351-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

Two sysfs entries, remap_device and resize, are missing.

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 Documentation/ABI/testing/sysfs-block-rnbd | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block-rnbd b/Documentation/ABI/testing/sysfs-block-rnbd
index 14a6fe9422b3..ec716e1c31a8 100644
--- a/Documentation/ABI/testing/sysfs-block-rnbd
+++ b/Documentation/ABI/testing/sysfs-block-rnbd
@@ -44,3 +44,15 @@ Date:		Feb 2020
 KernelVersion:	5.7
 Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
 Description:	Contains the device access mode: ro, rw or migration.
+
+What:		/sys/block/rnbd<N>/rnbd/resize
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	Write the number of sectors to change the size of the disk.
+
+What:		/sys/block/rnbd<N>/rnbd/remap_device
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	Remap the disconnected device if the session is not destroyed yet.
-- 
2.25.1

