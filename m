Return-Path: <SRS0=EWGC=2A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F5CC43603
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 08:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD09220836
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 08:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWtyrFvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfLJIGp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:06:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32769 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfLJIGo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Dec 2019 03:06:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so18919605wrq.0;
        Tue, 10 Dec 2019 00:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TrPkwEXfKMcmBJRMNstq7uxjKx3WNx+bbydVyI6MWHE=;
        b=nWtyrFvDAYkYyZJFWyDb04U2iRVuCXLIWSsQVgMM5vtBaveIFSiKAZTL6II3BjWL/9
         Uuhx1xzzjRAmkyflJ9d5X1fHwm6+s+DnJqvbNCWUFhjLVOYjica5dgr2OHwnQHJuneIT
         9JpF05dCR+CcHLB1XhsCcYIITeIZWH2vSgx0KeUxqcOSg24KVR5nVx+ZZnFP3aLm9lkB
         dCdKYSznWWUsHPwyT7P6FRTyJ7sh7Ob+v7m+z0kh4s8feYBndiWNz6QvofqcfnI6LCnT
         LO4cZYp9ZGbyGVmxEy21FYfBEdDxSs197KtaSInF/iHLC2qPnc5hu2krrTf2Tz4w9Udk
         CSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TrPkwEXfKMcmBJRMNstq7uxjKx3WNx+bbydVyI6MWHE=;
        b=lVqcy9EkBgdpcIdO7lpM3lJVN3+1UPbjnQtuYoZ16SGsy7olW92m/i5S32eSwLweJ8
         bQV43n5Qp0sORwyHTIAqTNiXaBH0cJ4v1h7/sU/0AeQP/1lTgkcASg32ONSkJemrqsae
         +5IsfDiEjL1cDu1XE8iGkzqLXyt1xjE40/GkliumN580TPeNWIyI+VH6f+Rjrp2UuxLE
         EtfHLaJpsA3uYokDkc+6Ta1PX2euAAdFmKlUZPoqcxmI2FSFj/5N/aKx6IQ4XA76tHqS
         WvOQZifPUSGFAwZHiIr/PQ+eEhwr5OdAIL9n8jy8YwqSzFKC/z4FyPuTEEmXP2OoBeDG
         9D8Q==
X-Gm-Message-State: APjAAAUnNU308O9xnlKK4eX2gZzLHcEMGUxvtv+dx2wNL4NB2aMLQQwQ
        7ZRsBa5hlUyb2zWc7MHQYUg=
X-Google-Smtp-Source: APXvYqwvF9vb1Pg/03dTB9bQnN2IbN1gpJnIMJTJQB2WBT2IvDLxvGQ+qQaE01Fk2ySzFRrDqJNniQ==
X-Received: by 2002:adf:ef92:: with SMTP id d18mr1570233wro.234.1575965202797;
        Tue, 10 Dec 2019 00:06:42 -0800 (PST)
Received: from localhost.localdomain (x2f7fae7.dyn.telefonica.de. [2.247.250.231])
        by smtp.gmail.com with ESMTPSA id a16sm2342587wrt.37.2019.12.10.00.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 00:06:42 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     sjpark@amazon.com
Cc:     axboe@kernel.dk, konrad.wilk@oracle.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        pdurrant@amazon.com, roger.pau@citrix.com, sj38.park@gmail.com,
        xen-devel@lists.xenproject.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v5 0/2] xenbus/backend: Add a memory pressure handler callback
Date:   Tue, 10 Dec 2019 08:06:26 +0000
Message-Id: <20191210080628.5264-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Granting pages consumes backend system memory.  In systems configured
with insufficient spare memory for those pages, it can cause a memory
pressure situation.  However, finding the optimal amount of the spare
memory is challenging for large systems having dynamic resource
utilization patterns.  Also, such a static configuration might lack a
flexibility.

To mitigate such problems, this patchset adds a memory reclaim callback
to 'xenbus_driver' (patch 1) and use it to mitigate the problem in
'xen-blkback' (patch 2).

Base Version
------------

This patch is based on v5.4.  A complete tree is also available at my
public git repo:
https://github.com/sjp38/linux/tree/blkback_squeezing_v5


Patch History
-------------

Changes from v4
(https://lore.kernel.org/xen-devel/20191209194305.20828-1-sjpark@amazon.com/)
 - Remove domain id parameter from the callback (suggested by Jergen Gross)

Changes from v3
(https://lore.kernel.org/xen-devel/20191209085839.21215-1-sjpark@amazon.com/)
 - Add general callback in xen_driver and use it (suggested by Juergen
   Gross)

Changes from v2
(https://lore.kernel.org/linux-block/af195033-23d5-38ed-b73b-f6e2e3b34541@amazon.com)
 - Rename the module parameter and variables for brevity (aggressive
   shrinking -> squeezing)

Changes from v1
(https://lore.kernel.org/xen-devel/20191204113419.2298-1-sjpark@amazon.com/)
 - Adjust the description to not use the term, `arbitrarily` (suggested
   by Paul Durrant)
 - Specify time unit of the duration in the parameter description,
   (suggested by Maximilian Heyne)
 - Change default aggressive shrinking duration from 1ms to 10ms
 - Merge two patches into one single patch

SeongJae Park (2):
  xenbus/backend: Add memory pressure handler callback
  xen/blkback: Squeeze page pools if a memory pressure is detected

 drivers/block/xen-blkback/blkback.c       | 23 +++++++++++++++--
 drivers/block/xen-blkback/common.h        |  1 +
 drivers/block/xen-blkback/xenbus.c        |  3 ++-
 drivers/xen/xenbus/xenbus_probe_backend.c | 31 +++++++++++++++++++++++
 include/xen/xenbus.h                      |  1 +
 5 files changed, 56 insertions(+), 3 deletions(-)

-- 
2.17.1

