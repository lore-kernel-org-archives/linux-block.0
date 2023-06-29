Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC262EB64D9
	for <linux-block@archiver.kernel.org>; Thu, 29 Jun 2023 21:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjF2VXo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jun 2023 17:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF2VXo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2023 17:23:44 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09882D4C
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2023 14:23:42 -0700 (PDT)
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6B7F13F171
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2023 21:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688073821;
        bh=RI4vrq5yGYsPdUmTvun8DtN4hoztwswwCj0aAlaqqY4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=PjhuNpNdr4DddW64oIYLuHdyDQRpI5vr5IH3AbbkFtgTkszXB+Re5FwkUJDu73Fv1
         ZERw6f+REilTTGAOLqxc645HVWDD4a+I1B1RiJRAOI+H/B5ON8d2Kh574sHQNkNPUh
         4ugtzgWfW5kFZkUEQPcdzuuHVJwJ518qA7l4DZc+kREnneYKmMUOfBeNYZ+PRkYpy3
         tyQf+3K9NI2EyskBwctd6Zfh5QuhnzEZrPCPCciItPdTqJj0VW1XZNv8JR7uPaDoXJ
         HKJ5ZF2eNoUxzWkBTwjZnk2wEMTYiRuc3PkvUKt6EnFJjnOogo755Q+BqElifhwiXR
         SSEILZ0pRcqfA==
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6b86d2075f0so1537628a34.0
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2023 14:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688073820; x=1690665820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RI4vrq5yGYsPdUmTvun8DtN4hoztwswwCj0aAlaqqY4=;
        b=cIG1zRDu6jRlw/2oVDCTan1VKfBA5f59BnbOoC1LjZjlzQZ6zqTcM+JRFXInvPorVg
         tfJd+R2NGmCVehWptQsKVFLo49j3LPNKUiNmbqgxLwG9lF6iiHkX9GRtJQ/m13+6TcYj
         kBLlUoVPqiEfU+13wml6W6d2o8WNLu32otR9zMNPTb7wVulSVR0aJnPexeQmaUEGWYXl
         xK3C6mdDfZ+XskUZ3jKCncaU7Q3f5sUQQtKjLJXed+TSbeXYXHnuuAVRlFOTUC6pw2vw
         g5tOxR7nWBUsGg4MJJ9P0okMpwyeZrETfiovaZm3SWs1CBYj8+eLAU7nOz+Qrmkxoiih
         Py/A==
X-Gm-Message-State: AC+VfDyJhm85w9pKopG/a1p6GGxLWZ3TA+wuA/w5yOKERS1zYvQ1mYb1
        GgIaQfm3DuxshztsQmi9WTtR08E0TQyst7MbovkIlrxdnLuD/cd3hd4Ld737u8k63zGjoA01sB8
        EPckQimIedOBOyzrGHNImNxxICne3YKhH+dieyy7K
X-Received: by 2002:a9d:66d9:0:b0:6b7:53df:1db3 with SMTP id t25-20020a9d66d9000000b006b753df1db3mr1324953otm.0.1688073820319;
        Thu, 29 Jun 2023 14:23:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4RJuKxP3PTOwPcoWYtMbpk2lOl27RytpNxFaqdrEnw8uaiA//2INIHK+RGmNiAgbwhY6lrvw==
X-Received: by 2002:a9d:66d9:0:b0:6b7:53df:1db3 with SMTP id t25-20020a9d66d9000000b006b753df1db3mr1324947otm.0.1688073820127;
        Thu, 29 Jun 2023 14:23:40 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4e1:83a2:7720:9030:a195:e622])
        by smtp.gmail.com with ESMTPSA id q6-20020a9d6646000000b006b871010cb1sm2711764otm.46.2023.06.29.14.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 14:23:39 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     "Isaac J. Manjarres" <isaacmanjarres@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] loop: fix regression from max_loop default value change
Date:   Thu, 29 Jun 2023 18:22:54 -0300
Message-Id: <20230629212256.918239-1-mfo@canonical.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Apparently, there's an unintended consequence of the improvement for max_loop=0
in commit 85c50197716c ("loop: Fix the max_loop commandline argument treatment
when it is set to 0") which might break programs that handle /dev/loop devices.

The (deprecated) autoloading path fails (ENXIO) if the requested minor number
is greater than or equal to the (new) default (CONFIG_BLK_DEV_LOOP_MIN_COUNT),
when [loop.]max_loop is not specified.  This behavior used to work previously.

Patch 1/2 just notes the loop driver's autoloading path is deprecated/legacy.
Patch 2/2 detects whether or not max_loop is set to restore default behavior
as before the regression (and keeps the improvement done by the commit above).

More details in the commit message. This does not seem to be urgent, as the
impact is to very specific/custom applications, and most users (eg, losetup)
should not be impacted, as the dynamic add ioctl() is used.

Thanks,
Mauricio

Mauricio Faria de Oliveira (2):
  loop: deprecate autoloading callback loop_probe()
  loop: do not enforce max_loop hard limit by (new) default

 drivers/block/loop.c | 43 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

-- 
2.39.2

