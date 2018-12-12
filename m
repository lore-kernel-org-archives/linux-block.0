Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C22C65BAF
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 19:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F1B2086D
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 19:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="nxx/1mPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F1B2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbeLLTLn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 14:11:43 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38453 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbeLLTLm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 14:11:42 -0500
Received: by mail-yw1-f66.google.com with SMTP id i20so7429228ywc.5
        for <linux-block@vger.kernel.org>; Wed, 12 Dec 2018 11:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=7SqXI9j3W8GC7HZcYf+fR4SkY0cLU1xlU3PRGcMc2HY=;
        b=nxx/1mPSNiRMuo7PU/5g2JScDnkUlnAMObm6qNP6Qs2Na+bnkgEL6d+UBY/TuEv1TP
         nWdzAbC8Gu9yAhjP78sDOe4tWprOWt1b0C7lNDWCJaotbRWM6bWz/el/K+ZjBl+RYRtd
         x26bXOh1vbDnx0JTLfuUV9nSI4uZXc5S+wO8k6gQ6pyPE87I5axu7RgVMPMPj1XsFwi+
         NVnlJbirlQGrubd/Snhxa6vIt4ZXuiqQI6xrdEcHUXdXhOmnmgV65pmOQPlIcC1i+sk9
         ml/2ZQAc/IGGrwL6bx8z0LH26dNcO/EOL0U3V4c9kLY18DNlUtJmjrQCXLkEIkwX2mJa
         ZErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=7SqXI9j3W8GC7HZcYf+fR4SkY0cLU1xlU3PRGcMc2HY=;
        b=QcQKCuLXe73XcGKkC8xj5B1J4ScaRel3XJYASrnY8e2sPf/QdUghoZoZwirPgma+JE
         iRYaAsVYEWyXYsfADW77Umgesx9oKKt1SAvkOR0vooWi8Ud4VRZcmfHMnH2QiL9qQXaC
         MCqyslrI4vQVQwoq5wnHof7Bzg+NeNNV6yfphfC+IsWtXdnFG/y6uwJ8w5uLTSt/c1A2
         cTZvqXRoQNf6TRE82Q5DhJMN+IO0tdSym6BLbdNBGZujqHK0qhEnEIePsf0ankBgzAd0
         H6TjICBXgf5nZ53AaSz/UThB6OeJsQcwVL9EvZwlZXUdhV7J6mRDEpb5AGnDACL7HVdN
         sO9g==
X-Gm-Message-State: AA+aEWZPidJ82MZVVGMM9crMC5TIH0OyrGap95OZm87avpx6hg20nKPi
        qvOcG5rUmP2iptqFfxAdSen+LgRg6gw=
X-Google-Smtp-Source: AFSGD/VAyoqOKhUCtp1BNBtkw91sWZ4THFuITeBvgMwGgM9OV49iTAb16tAMXQv/bXs65Ddzzi381A==
X-Received: by 2002:a81:a943:: with SMTP id g64mr22685439ywh.374.1544641901684;
        Wed, 12 Dec 2018 11:11:41 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p71sm6122073ywg.98.2018.12.12.11.11.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 11:11:40 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-block@vger.kernel.org, osandov@fb.com
Subject: [PATCH] blktests: include cgroup in rc
Date:   Wed, 12 Dec 2018 14:11:39 -0500
Message-Id: <20181212191139.15400-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I added the cgroup cleanup code to the main loop, but didn't test any
other test so I didn't notice it'll error out if we haven't included the
cgroup helpers.  Do this so the cleanup can happen appropriately.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 common/rc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/rc b/common/rc
index 723b5b02a065..153a32358519 100644
--- a/common/rc
+++ b/common/rc
@@ -9,6 +9,7 @@ shopt -s extglob
 . common/shellcheck
 # Include fio helpers by default.
 . common/fio
+. common/cgroup
 
 # If a test runs multiple "subtests", then each subtest should typically run
 # for TIMEOUT / number of subtests.
-- 
2.14.3

