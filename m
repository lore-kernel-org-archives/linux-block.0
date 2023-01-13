Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61380C54EBE
	for <linux-block@archiver.kernel.org>; Fri, 13 Jan 2023 12:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241558AbjAMMpO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Jan 2023 07:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241862AbjAMMnw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2023 07:43:52 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF3A1C106
        for <linux-block@vger.kernel.org>; Fri, 13 Jan 2023 04:36:20 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id u9so52054742ejo.0
        for <linux-block@vger.kernel.org>; Fri, 13 Jan 2023 04:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQNKuz5965naByKUS4y1VIo8yUx5dsUc2Lu+3dW2kE8=;
        b=Te252XxFJERmj6gsHMX2Ubll+K8vuDQpcz/sz6kK4szts0nTB0oktTg5ouLmIRjLKF
         Zi4O4udWR6to0zU4y5FjIy+WfgYAdAPl/2WYiHxedaBhxqSCXFiCDixV/CsaA31qm7tJ
         ynai0z9jDaha4KBuIJosdtZwVtdFA6yn4MgEsFOm13UnwoMG0wOCFyS+xo2g9Pv0Teh6
         WsGFI9coLfTp7oEzWszSuZfc5ZARh1nXay20UzR7Bb9SWH4hfzkPfXpmbuyAEHS59PNz
         RA6E4YaegtTU5Gcec8wZ9mxcOV4lpje8yFY4O9dpV0y5TGYlrWuVKTrkZ8jCRbdEyE3U
         woPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQNKuz5965naByKUS4y1VIo8yUx5dsUc2Lu+3dW2kE8=;
        b=YmyM+4vJ6QtYYn57QkwegRUh1TFjCgJSJLDABRu4DCvR2JIZqgudDG24uWUOUbb8Le
         v1dcYpd0O2UqKRu6QoATo1TsLHcG0yM/ZNhTVoPQKEWKoJadajO9RymtF6z5TSFqTqIN
         iOzQ9eIYvgamcLZKBNLNW0YtBESXWiUPCpRKxZwdPUi4ku3weLQS9LuLl0TAwjtcCtbA
         FGWbyZFXzyMOXHzqk3c846ZQd7LZEIuAj3up1AYf5VdC9SS+MhUgNiA3g5AgI6NIU77p
         tqOiHkSb8zRrz4/3BXoNjWVEHmSp/64Z1cBjgdEnVvYeYbQpcXATu+aWfCqGIJtyUOt+
         6rBQ==
X-Gm-Message-State: AFqh2kp+Nt83T14Ar1CRG29+0ICMzKxe0rQx1p+HmOMhkpREyB2ocUxG
        4vfc76aRljhs4bkfTY6QBKvPug==
X-Google-Smtp-Source: AMrXdXsHyV5uZaN+B0+k4sLOMGxS6gsjp2oFHq2cCYXc3gkoDk1zoyE97qfqOiUlKxtclhZSmKgEPg==
X-Received: by 2002:a17:907:1710:b0:7c0:c36d:f5df with SMTP id le16-20020a170907171000b007c0c36df5dfmr83242439ejc.70.1673613343347;
        Fri, 13 Jan 2023 04:35:43 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906329100b007c0bb571da5sm8402496ejw.41.2023.01.13.04.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 04:35:42 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Joel Colledge <joel.colledge@linbit.com>
Subject: [PATCH 1/8] drbd: adjust drbd_limits license header
Date:   Fri, 13 Jan 2023 13:35:31 +0100
Message-Id: <20230113123538.144276-2-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
References: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

See also commit 93c68cc46a07 ("drbd: use consistent license"). We only
want to license drbd under GPL-2.0, so use the corresponding SPDX header
consistently.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
---
 include/linux/drbd_limits.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/drbd_limits.h b/include/linux/drbd_limits.h
index 9e33f7038bea..d64271ccece4 100644
--- a/include/linux/drbd_limits.h
+++ b/include/linux/drbd_limits.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
   drbd_limits.h
   This file is part of DRBD by Philipp Reisner and Lars Ellenberg.
-- 
2.38.1

