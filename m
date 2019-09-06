Return-Path: <SRS0=sY57=XB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44046C43331
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 14:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17FF8207FC
	for <linux-block@archiver.kernel.org>; Fri,  6 Sep 2019 14:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eR9grB12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405535AbfIFOmQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:42:16 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46420 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbfIFOmQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Sep 2019 10:42:16 -0400
Received: by mail-lj1-f193.google.com with SMTP id e17so6187925ljf.13;
        Fri, 06 Sep 2019 07:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gsLD90QQ2kfBi7SEjiUF7Lk3XMy3Rd3c6KDoYev3+Ck=;
        b=eR9grB12OmR+vvbmxLg3a64CtG4a95DWsaFHq1FQTzLLoTq7tqMHivszSYiDGnZSMC
         iMSUJnnc/RRdlmpTITtFAKHkLtqspRpo38q874TF+FHp25buJm50gne2LE6A2B0wW8p7
         haXf5iR7MMT28CBVyAcpF/28cH29UO5iorAxLAMsGAhrYEIo5eryofFhp4KAJ5Wdj2jf
         aKYv7goULDOQELlNrnnqWvR16sck5srMOuC5cNfMJR0eWVbMLZCx+h0P4sBwGJwo4Z6/
         98z7ej9VLOsIbLWLjy5DaJ8GRrcKI7xR8SC/chNXZYb95AkBn2SR5kxGhO1FqjoVjyyQ
         zfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gsLD90QQ2kfBi7SEjiUF7Lk3XMy3Rd3c6KDoYev3+Ck=;
        b=Kg+KjKBEZDtwOt3JTjrkCDKM3nxIsV2liHQK0JbwM8vnTtHBJMcl6axyHTbDBRvBGi
         3BeQsgEC/Cpd/8qr9wV6X+3ekEefGJV9XouLIwz2m7vkXCx4e57A+TZ4vEulUJWtjgDl
         S7pfAQNOPeKJEQbIsuHiGi3K1EDG7g/mSlNuis3AMBiaAvMvs6A6wDrjjahnOt6o5AAZ
         6JTC6BrCcW5LTsOCUb9KteaJz2m6J9v+/vyEXmlOKfEY2nyKDlMe+4nKt+X/ocleX7+C
         ZvX8LC5fQm8aDP32eeS0+DA42gdD663crotQAArnU+HHBXWuvxVOntlCpzhx9BX4BHGz
         2AgQ==
X-Gm-Message-State: APjAAAUPwa0gKwCmFAFYlnYHHnr0nxkrs+ePjGdeMR0n1zj3MyqycOZO
        I6IVPPOtpEEXbi4tTnmp6AtLynwX
X-Google-Smtp-Source: APXvYqzLBXIY8RmKyRDCfVgJOXx8XL55kA5VFNyBeZKF5quWQUlHvUux4Njr843frSuxsmG7O7T8JA==
X-Received: by 2002:a2e:9117:: with SMTP id m23mr6087948ljg.43.1567780933698;
        Fri, 06 Sep 2019 07:42:13 -0700 (PDT)
Received: from localhost.localdomain (mm-82-227-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.227.82])
        by smtp.gmail.com with ESMTPSA id z30sm1325077lfj.63.2019.09.06.07.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 07:42:13 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, josef@toxicpanda.com
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [RESEND][PATCH v2 0/2] Fix misuse of blk_rq_stats in blk-iolatency
Date:   Fri,  6 Sep 2019 17:42:02 +0300
Message-Id: <cover.1567780718.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

There are implicit assumptions about struct blk_rq_stats, which make
it's very easy to misuse. The first patch fixes a bug caused by that.
The second employs type-system to prevent recurrences.

v2: rebase + reformulate commit messages (no code changes)

Acked-by: Josef Bacik <josef@toxicpanda.com>

Pavel Begunkov (2):
  blk-iolatency: Fix zero mean in previous stats
  blk-stats: Introduce explicit stat staging buffers

 block/blk-iolatency.c     | 60 ++++++++++++++++++++++++++++++---------
 block/blk-stat.c          | 48 +++++++++++++++++++++++--------
 block/blk-stat.h          |  9 ++++--
 include/linux/blk_types.h |  6 ++++
 4 files changed, 94 insertions(+), 29 deletions(-)

-- 
2.22.0

