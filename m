Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B56C00454
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 18:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22A3222C4
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 18:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y79caoQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbfLKSKi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:10:38 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45978 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfLKSKh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 13:10:37 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so2173839pfg.12;
        Wed, 11 Dec 2019 10:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mc5ORNKDsv0ygGReB4brTZGP+nxF11a/con+3NutTy4=;
        b=Y79caoQ+lf7odw5APsp3kG+n/VzcsE2Qqxe+syQlgY/qPzHq6ZuRTkiyKhd6DRW3Ux
         f4D/PUQOZcZY+iqmcLRNz3NnTUHT7PfjJQBcLCnI2aqkwYC64sKRpzJdOHX7b974Fy+x
         vxhGhp7bD2wQgNDZqFK9859BBc+84xXdvvvgdiGw6b5OUf1XDwn5eIUu3Nd+OLcaHVXu
         eRQr7P/kICKCCL5Wa5S4U2wDcXekrBpZXOQ4jN149MsLmob8X+xfSLm6HCI8UNCzgpZ7
         XA23ImjbBjjHw/kDa///ygXqgIGoJ+g+oRi7pYN8mJ16gu5Nfl1yCDGyEiwtZ/QuogJT
         hYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mc5ORNKDsv0ygGReB4brTZGP+nxF11a/con+3NutTy4=;
        b=Yb5Qt1zwc71JBvCIcXWiuhba23v8PuD/fxoM74wJDETM017CFXD2CSaBmPYxoXxGNM
         AdUv6Di7ZzWBJv/tT+hhPblHYnVkD0vBIsenvuK+rfanJBVcKrNUWl8myeK21P/dqp1U
         VINJ7V20EXdU4EisYc3mEDtXTgh6hNjUlspBnr7FSsvNGFPnD9SF8fW9z8E00PjioHdP
         Jr0g72ss4mRr/Vs6Qp9qUk7c27zwLddkOf7zTiHF7ZWZEufthhd6uApTgGeKhW+AP0AO
         fNDn3p8gM51buRPE0I3PUZhOGgpK1VGV10yOkbg97N5ahsAOvA+5rTWveVo/WEgXCNjw
         l6DQ==
X-Gm-Message-State: APjAAAXUEcjA0v9UMbok9YLbomlUX0clnUVZhCVz0su++tQFUf66oMM9
        eeZ/UrAGU01rWRq+GQG4Okk=
X-Google-Smtp-Source: APXvYqxtH9H0dIabNUHI+R3GKkz0i7Pm3NwtvvVOQDnlczdsWX81V7kBBojdi2NWi9DqBPYpZqFihA==
X-Received: by 2002:a63:4723:: with SMTP id u35mr5415175pga.194.1576087836383;
        Wed, 11 Dec 2019 10:10:36 -0800 (PST)
Received: from localhost.localdomain (campus-094-212.ucdavis.edu. [168.150.94.212])
        by smtp.gmail.com with ESMTPSA id x33sm3552651pga.86.2019.12.11.10.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 10:10:35 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     jgross@suse.com, axboe@kernel.dk, konrad.wilk@oracle.com,
        roger.pau@citrix.com
Cc:     SeongJae Park <sjpark@amazon.de>, pdurrant@amazon.com,
        sjpark@amazon.com, sj38.park@gmail.com,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/2] xenbus/backend: Add a memory pressure handler callback
Date:   Wed, 11 Dec 2019 18:10:13 +0000
Message-Id: <20191211181016.14366-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Granting pages consumes backend system memory.  In systems configured
with insufficient spare memory for those pages, it can cause a memory
pressure situation.  However, finding the optimal amount of the spare
memory is challenging for large systems having dynamic resource
utilization patterns.  Also, such a static configuration might lack
flexibility.

To mitigate such problems, this patchset adds a memory reclaim callback
to 'xenbus_driver' (patch 1) and use it to mitigate the problem in
'xen-blkback' (patch 2).  The third patch is a trivial cleanup of
variable names.

Base Version
------------

This patch is based on v5.4.  A complete tree is also available at my
public git repo:
https://github.com/sjp38/linux/tree/blkback_squeezing_v7


Patch History
-------------

Changes from v6
(https://lore.kernel.org/linux-block/20191211042428.5961-1-sjpark@amazon.de/)
 - Remove more unnecessary prefixes (suggested by Roger Pau Monné)
 - Constify a variable (suggested by Roger Pau Monné)
 - Rename 'reclaim' into 'reclaim_memory' (suggested by Roger Pau Monné)
 - More wordsmith of the commit message (suggested by Roger Pau Monné)

Changes from v5
(https://lore.kernel.org/linux-block/20191210080628.5264-1-sjpark@amazon.de/)
 - Wordsmith the commit messages (suggested by Roger Pau Monné)
 - Change the reclaim callback return type (suggested by Roger Pau Monné)
 - Change the type of the blkback squeeze duration variable
   (suggested by Roger Pau Monné)
 - Add a patch for removal of unnecessary static variable name prefixes
   (suggested by Roger Pau Monné)
 - Fix checkpatch.pl warnings

Changes from v4
(https://lore.kernel.org/xen-devel/20191209194305.20828-1-sjpark@amazon.com/)
 - Remove domain id parameter from the callback (suggested by Juergen Gross)
 - Rename xen-blkback module parameter (suggested by Stefan Nuernburger)

Changes from v3
(https://lore.kernel.org/xen-devel/20191209085839.21215-1-sjpark@amazon.com/)
 - Add general callback in xen_driver and use it (suggested by Juergen Gross)

Changes from v2
(https://lore.kernel.org/linux-block/af195033-23d5-38ed-b73b-f6e2e3b34541@amazon.com)
 - Rename the module parameter and variables for brevity
   (aggressive shrinking -> squeezing)

Changes from v1
(https://lore.kernel.org/xen-devel/20191204113419.2298-1-sjpark@amazon.com/)
 - Adjust the description to not use the term, `arbitrarily`
   (suggested by Paul Durrant)
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

