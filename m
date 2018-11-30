Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC16DC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0A12146F
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="C93NMvnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0A12146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbeLADLJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:11:09 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:46839 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeLADLJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 22:11:09 -0500
Received: by mail-io1-f54.google.com with SMTP id v10so4894233ios.13
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 08:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=Jhw/goXRoGNiKSGgS6jv8hsRlLQKE4rhklx/gg7mdZs=;
        b=C93NMvnBQWcQM1/d7jwjauiPYiOmG5+McOBmA8M2sahqx5SLHPUxYNzdtZXy00qCQr
         EPnkPJT9ZjL1v/SlvOah7D3Ro6atm2siPZmRy1mDVXtvg66jax0B633x3oAM3y6iaoKN
         yE7lmZRj+9oLC6mp2qkMz9k0iUwFP8ei5siLUDqlWmQ0XLdu8UrrIHh9QS6XyXVSaOnM
         azU8DxvkFWHSa4KopCTfdBExdmZ65F3mHqun695EIYLCvki5zRf8abJ21nsFAf/lmr6P
         3xEaAYIGTTtMf9DlguViTcYJwthCm4RDKcShbAa4mGtZWmgBcPz86NhHuKyBpMWk7jNO
         6C9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=Jhw/goXRoGNiKSGgS6jv8hsRlLQKE4rhklx/gg7mdZs=;
        b=pdzK0ebp2UTeGV3wcy/GCqAd/xCpYpecqcXsXe7yBgqOJo/QH0KN3x6eA2Ay/Js0Nl
         01xtuGwuQ7n+oDOpbwhuwj1uHFbAmlKVklS9VQ8ebwjW5/5HD9O/MLm4WVWVXVoxT98P
         fI2cSFSFEJUE0ag/UqbdBhyUQ6xoS2tm/lIHL2+i3trmdXBxYMoC4dHcnlreq59IGBtK
         un/J6s5XP44zS2376jM69gsZv8yjGx5VGgmbJAtRw4ZxbJg/YMP+LAaDJP0wyAAB4E0T
         2CzbBB+M/DPXW8jQ3/fFMmkNUWGWgQpav6Zc33qKtaH08fYbkO1D4HQADaelrOklB/mh
         xVfA==
X-Gm-Message-State: AA+aEWaoznP5+vJcxhn2Au15HvdZjHu+ZApTd/JQmNCdFy5ZV3xP1vGd
        zHjgLQpUY9luohDOXRIRlfMPJJFba4c=
X-Google-Smtp-Source: AFSGD/Uwti1ud5LLJ5lvV0Qa/JrfoXPs62Rzc2xzDrCwcxp7flsSraD6iZ0LtRSrEU1lnOEp45IMBA==
X-Received: by 2002:a6b:92d6:: with SMTP id u205mr5411276iod.221.1543593681562;
        Fri, 30 Nov 2018 08:01:21 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m11sm2906784itb.24.2018.11.30.08.01.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:01:20 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, osandov@osandov.com
Subject: [PATCHSET v4] sbitmap optimizations
Date:   Fri, 30 Nov 2018 09:01:16 -0700
Message-Id: <20181130160118.24683-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This versions tests out solid, and we're still seeing the same
improvements.

Changes:

- Lock map index for the move. This eliminates the race completely,
  since it's now not possible to find ->cleared == 0 while swap of
  bits is in progress. The previous version was fine for users that
  re-check after having added themselves to the waitqueue, but we
  have users that don't re-check after getting failure. This works
  for both.

- Add the new states to the blk-mq debugfs output.

- Wrap the waitqueue in a sbitmap waitqueue, so we can ensure that
  we account it properly. This means that any kind of prep+finish
  on the waitqueue will work fine, just like before.

-- 
Jens Axboe


