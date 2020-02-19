Return-Path: <SRS0=ya0H=4H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE24C34022
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 06:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209FA208C4
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 06:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hzru1pus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgBSGcZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 01:32:25 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35780 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgBSGcZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 01:32:25 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so9141014plt.2
        for <linux-block@vger.kernel.org>; Tue, 18 Feb 2020 22:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Qgy6aIuitVSVRLUgnkmkswnIF5SNQ7J4oIPeyJTRMkA=;
        b=Hzru1pusUyGdeV8M6RRcjDJxg2YxJAjf0qtGNjxsY8CpSmP+3yfog4haYzLBPulCK1
         5LXLvLgbLGzXT5ZFqflTQWGZgiT522Cr/YWNm4EI3Om6rfoLEojGad6Pz8Plu22YQGRk
         NbuXYKfdLMzEu55MFm+QlJmkfnRYkR2H+HU7lpkW8Em9QqiUmF74qnKaMUtNe+q2z2tf
         zN+f9NZwezqAVHCD4zsFYa2MvjlN3IFLvjoEM9HjFoCkLVKweND5Q/I6UFk1eDDSgkoT
         QmteUHhQUVQULUYy2VuW2dCR6MMOe/8u7FM7eRpzFW5OnQELnhhEzFuCropOTMppEXpU
         rJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Qgy6aIuitVSVRLUgnkmkswnIF5SNQ7J4oIPeyJTRMkA=;
        b=H7Wak+ACDJ+c9JebhwvCZGJnATuj6hTZsixHYvcQPVOsmnXk79j8lp+DUd6fF97emw
         3vd9FKva9lqMCC3fDnbzVcZ3sUXkaMQchOLHXFhLL6I+8SjpEJ13EhG+46ECzaVvDMFp
         03Fd2ptKg8DlRDxKoSVncXEb2ILfJmtpoFnAvoHSqz+Wjp9H27P15lZuV2aqVj7fnVe9
         WY5Zu4aclwfk9mfpW/bD6IQpcNSDMNibGWXPUo4AiCq6sO9/V7X0tRWHeXGGDBlBRGVr
         0x8Cm/OOPT4vxrrI/6mXSnyZBX3Ni7XDitUxRbaKMESNt25Da61THXA8HNGTrhCHK3UQ
         C7Iw==
X-Gm-Message-State: APjAAAV7QjOiuNWQ79od9I51NtZpCFZycgrhRt6gZ/wX6JXRl3aeKgb1
        PId7/SsgBXezocVUZ4zdy10=
X-Google-Smtp-Source: APXvYqzIJksnqer7CyInqvYmguad+0IFUcRA20InqN28rnJ/x6iNawGUGLuStBLSgnApI1Gl09UsMg==
X-Received: by 2002:a17:902:223:: with SMTP id 32mr24842193plc.167.1582093944724;
        Tue, 18 Feb 2020 22:32:24 -0800 (PST)
Received: from debian.lc ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id e7sm1184487pfj.114.2020.02.18.22.32.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 22:32:24 -0800 (PST)
From:   Hou Pu <houpu.main@gmail.com>
X-Google-Original-From: Hou Pu <houpu@bytedance.com>
To:     josef@toxicpanda.com, axboe@kernel.dk, mchristi@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Pu <houpu@bytedance.com>
Subject: [PATCH 0/2] requeue request if only one connection is configured
Date:   Wed, 19 Feb 2020 01:31:05 -0500
Message-Id: <20200219063107.25550-1-houpu@bytedance.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

NBD server could be upgraded if we have multiple connections.
But if we have only one connection, after we take down NBD server,
all inflight IO could finally timeout and return error. These
patches fix this using current reconfiguration framework.

I noticed that Mike has following patchset

nbd: local daemon restart support
https://lore.kernel.org/linux-block/5DD41C49.3080209@redhat.com/

It add another netlink interface (NBD_ATTR_SWAP_SOCKETS) and requeue
request immediately after recongirure/swap socket. It do not need to
wait for timeout to fire and requeue in timeout handler, which seems more
like an improvement. Let fix this in current framework first.

Hou Pu (2):
  nbd: enable replace socket if only one connection is configured
  nbd: requeue command if the soecket is changed

 drivers/block/nbd.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

-- 
2.11.0

