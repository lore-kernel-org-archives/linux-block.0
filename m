Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03C2C04EB9
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 02:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0A5213A2
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 02:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gObrUVcP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C0A5213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeK3NQu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 08:16:50 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:34312 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeK3NQu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 08:16:50 -0500
Received: by mail-pl1-f176.google.com with SMTP id w4so1999184plz.1
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 18:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=555eL3rH2Rs5LL95BpZM8W5Nb4UooReqLbegr7C4tO0=;
        b=gObrUVcPShzsFoLkTM+KiFqjYefUCVTEnt1MyeohbgBV/Q8SGmq0T1lzcyRTOKoG4x
         u3+l/5G9B6ywY5uI40+kn3KML46SsEr5T8EvJhsMH8Efurb2DDsFN73wHrdgcwTDxQLV
         Z9JXHxFx8eViT6Hijfad4TIZT5A/qmIlwBqJL29BGwaxqTl8dOiatv9nV2EHs59L04Yf
         n5gggFRwFnnDdzpBwYidrGHfPVRooKjfcLLagcC1p4xQlpyGiPVQ+tIim+LL4gE0V+Xo
         ENSdlEZixm/WS7wxUfT4j5k6ebOnJPCLI88hTF4QfTM8Dwe+MCGKLRHemdsxOGJYbfHB
         /R3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=555eL3rH2Rs5LL95BpZM8W5Nb4UooReqLbegr7C4tO0=;
        b=jW2hsbpI/dIc2shAtCzuRF3dVJDSwX2O4dzfr822cnWdkgRX/SiupKvF7JRF7L/pDO
         ppCB4ZsUcw8Arf1W7/aYAJubK56cSpH6fI9h4eL5xLB0DmJ+JlQXQQqLaDfA3247MxCM
         qzaJJGngPjchogJGDfUpbKcrBHaa7SJDJ5fEoKzYn9WcmKQE3K2gKaWfszGmJKLqt8KG
         Lqj7TOQDlQPU1h9c38FkChpd5q0NRSllohcKZYa3JuxQWPkT4m4aeDo8hIe+xOkqXwUm
         T0PwUQHP2FwCX7udb21z44DDzR+LKigDubJez0963W4Nq3kpECOZH5Bz4fajyJ8dU1DK
         /OrA==
X-Gm-Message-State: AA+aEWZ7QsfnGKHNqWFcmcKeLa8MlnZIkZubaPQwJ9zLTEompDGSMt+S
        lTvFmHL1BJT+0k/Mj/zUwVkT5NgyMkU=
X-Google-Smtp-Source: AFSGD/VKgNqWFrBD+tTLNKslC05zSCJyTC022U0dQkd6roYrSm3+FAwhl43w4wBXFhOOsxkBfn8Yyw==
X-Received: by 2002:a17:902:d697:: with SMTP id v23mr3747727ply.261.1543543752507;
        Thu, 29 Nov 2018 18:09:12 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id d16sm3711612pgj.21.2018.11.29.18.09.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 18:09:11 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, osandov@osandov.com
Subject: [PATCHSET v3] sbitmap optimizations
Date:   Thu, 29 Nov 2018 19:09:06 -0700
Message-Id: <20181130020908.7325-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The v2 posting got screwed up somehow, sending a v3 just to make
sure things are sane.

Changes:

- Dropped the alignment patch, it should not be needed unless we have
  debugging enabled of some sort.

- Fumbled the optimized wakeup, it's important we match prep + finish
  with that interface.

-- 
Jens Axboe


