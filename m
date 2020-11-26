Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEA1C64E7B
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 10:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8AB920DD4
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 10:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Lc+W67Hr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388341AbgKZKrc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 05:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388340AbgKZKrb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 05:47:31 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931E7C0613D4
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2020 02:47:31 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id d17so342826ejy.9
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2020 02:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LoZdjc+EEym8aqHt4kiTDOTP1U08c51WASyvgO99dkc=;
        b=Lc+W67HrjUAN0y+dJrInUdaNYqCoXPhcTUhclxy+/ViGaYNNngChrEjXO95JusyQv1
         sPJVf9qE33z55eRoWLsWuEns7IKH8vt4dEZ+sCGrc8PYcN2qthVlYblS8U2BgKI72s3i
         ptWW0938fgaMl8l6jBEpQHBirw5XLpSJw6xVEgq59pP3FMrXh8DtJG3G+46wXitpC5mz
         btijiA5URyhDVdxJuBnBRDZ0Tq2vZhCSfyGEkW3/LJVT9ESuWRRVVJz0nkJkHCDXH4IK
         zv0xhgag+uYx2OkS32EjhTT+Niv82o8eglzi29ieiaNfqu1mLPBixx2BYeITfQ7EG4It
         JiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LoZdjc+EEym8aqHt4kiTDOTP1U08c51WASyvgO99dkc=;
        b=RNUXDOCjo5xGYdfUidnZMv3pwABAWQmX2WibbU6ZN9G+m9En7DNLTE44vBzTYf/hpR
         hFyKHrJGofp4EGN621Dj8HYOodpyszwYFi4D4gN1ZSkLlhTlladpp7/+4wD7WjOwHCia
         GtOQ9ayPcmi0AhV6rT+jVRsT3UXrKd7V3NZosLJkjq4FMEKJjYyI8syIL85cyEWaMylU
         hdfjAawe/+Rvs9imk5l22BVDSUU2lWK/IIPZHL6jClJhYonWRttoexJ+EHOts6UZbUj2
         MuGGnHuXiuMaotYLtCumhorzCFkC2giUbcCoowuRhy4Dx+zB8GiaBVlk4mya83RFBgkP
         6EKA==
X-Gm-Message-State: AOAM5320RZPMOctKkoRYB2quAbLZjXb4b/2hfja0Nyem0BlFOIMGuxU7
        WJ6jhkrxSH4d+R3BQXUzcw0oh7V/l94X4A==
X-Google-Smtp-Source: ABdhPJxmJ/4CVN+23ANkNxVHaDnY1UrCMVspZBvkJbWgZ5JZHq0+rr55ym5yzjmcCUMvqDwUk3r6vw==
X-Received: by 2002:a17:906:604e:: with SMTP id p14mr2126458ejj.515.1606387650148;
        Thu, 26 Nov 2020 02:47:30 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4961:8400:6960:35a2:747a:e0ad])
        by smtp.gmail.com with ESMTPSA id f19sm2910053edm.70.2020.11.26.02.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 02:47:29 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, danil.kipnis@cloud.ionos.com
Subject: [PATCH for-next 6/8] Documentation/ABI/rnbd-srv: add document for force_close
Date:   Thu, 26 Nov 2020 11:47:21 +0100
Message-Id: <20201126104723.150674-7-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126104723.150674-1-jinpu.wang@cloud.ionos.com>
References: <20201126104723.150674-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

describe force_close of device

Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 Documentation/ABI/testing/sysfs-class-rnbd-server | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-rnbd-server b/Documentation/ABI/testing/sysfs-class-rnbd-server
index ba60a90c0e45..6c5996cd7cfb 100644
--- a/Documentation/ABI/testing/sysfs-class-rnbd-server
+++ b/Documentation/ABI/testing/sysfs-class-rnbd-server
@@ -48,3 +48,11 @@ Date:		Feb 2020
 KernelVersion:	5.7
 Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
 Description:	Contains the device access mode: ro, rw or migration.
+
+What:		/sys/class/rnbd-server/ctl/devices/<device_name>/sessions/<session-name>/force_close
+Date:		Nov 2020
+KernelVersion:	5.10
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	Write "1" to the file to close the device on server side. Please
+		note that the client side device will not be closed, read or
+		write to the device will get -ENOTCONN.
-- 
2.25.1

