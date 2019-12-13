Return-Path: <SRS0=J0ZO=2D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9818EC3B1A9
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA53A246D0
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWjJ6SPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfLMPgD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Dec 2019 10:36:03 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33882 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbfLMPgD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Dec 2019 10:36:03 -0500
Received: by mail-pf1-f195.google.com with SMTP id l127so1668292pfl.1;
        Fri, 13 Dec 2019 07:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z8JrPILmBNkuXmgh0CCRqTuGd1v6Ben6NRIYOOVYH2k=;
        b=oWjJ6SPormw/9aWlYAqMt0mWZxPQ/qNu7pEFrAaJhnWJ+GoTw/ZcIvbNrmZyihzCkf
         piyjbLAzqCzZKol0+U+KNPcroPZ39r1GHMH+f84jFUBfEzbNdiiaR3bhB23LiITOp/Zf
         AKE4VWpiRGOngO9qA8lIgvW8cYCVzJi27ripb4euNsHN1DOwI/z2o7Xj7zT7fneiHAFD
         v1V8PSNnVohEa3zIrzCxJKvCd6RZ6hQZ3D+GxfbL7sMVYjh7vC95x+PavfXmAoMDbDAX
         CCodyR5SRkgXQE75t9YNsiD6x+XGUAZCBU3QX892DfRtwjphqSqr73jl6lC42jabK3Jo
         +BRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z8JrPILmBNkuXmgh0CCRqTuGd1v6Ben6NRIYOOVYH2k=;
        b=BeOPaKLwfND8mVpvkKSacor29mefTLFHVmxgtmh3uvyn5UH0eW9c8x0z4dBYrwVhEw
         jZy7KUwvxqRRUfLCw8TPXTqYvmQdAzqAY7Cr2SSNV3fJ9V4l75NuZEtsFRORd2UlPfn4
         zcvgaCYQBBZYaxFkPqVCCga7sQZSal9d0cFSkBhZNeFE8f0CFKlrlY78e8vPqFh8lOPL
         9CmRGlc3Efa1xvKu3k/iBGEXuQE2MQd6GW0qlDwRXhc+i67WFXJ0TtjVV+tUA/qHZXUj
         CJMUJk2Dnd8HETLkRjONITSKgNc/TWY8XuEix82uYAQBwllWvGKh01TQ7fYoyVykmkUA
         6kbA==
X-Gm-Message-State: APjAAAXW97EQTjBHgJuKN12AuXItzj+Pruch0n6dumJa3/MlV7CszTuu
        qIIvhILdVmKvlhl3auzINsI=
X-Google-Smtp-Source: APXvYqy2mR1RAyt47UgDW+/8fahahEZ/8xauJw9MRhkmZdtownWeUeLWxCGXBe/tAu3OBjOgx2U/Hw==
X-Received: by 2002:a65:590f:: with SMTP id f15mr17211719pgu.381.1576251361836;
        Fri, 13 Dec 2019 07:36:01 -0800 (PST)
Received: from localhost.localdomain ([12.176.148.120])
        by smtp.gmail.com with ESMTPSA id w131sm12039217pfc.16.2019.12.13.07.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 07:36:01 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     jgross@suse.com, axboe@kernel.dk, konrad.wilk@oracle.com,
        roger.pau@citrix.com
Cc:     SeongJae Park <sjpark@amazon.de>, pdurrant@amazon.com,
        sjpark@amazon.com, sj38.park@gmail.com,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/4] xenbus/backend: Add a memory pressure handler callback
Date:   Fri, 13 Dec 2019 15:35:42 +0000
Message-Id: <20191213153546.17425-1-sjpark@amazon.de>
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
https://github.com/sjp38/linux/tree/blkback_squeezing_v9


Patch History
-------------

Changes from v8
(https://lore.kernel.org/xen-devel/20191213130211.24011-1-sjpark@amazon.de/)
 - Drop 'Reviewed-by: Juergen' from the second patch
   (suggested by Roger Pau Monné)
 - Update contact of the new module param to SeongJae Park <sjpark@amazon.de>
   (suggested by Roger Pau Monné)
 - Wordsmith the description of the parameter
   (suggested by Roger Pau Monné)
 - Fix dumb bugs
   (suggested by Roger Pau Monné)
 - Move module param definition to xenbus.c and reduce the number of
   lines for this change
   (suggested by Roger Pau Monné)
 - Add a comment for the new callback, reclaim_memory, as other
   callbacks also have
 - Add another trivial cleanup of xenbus.c file (4th patch)

Changes from v7
(https://lore.kernel.org/xen-devel/20191211181016.14366-1-sjpark@amazon.de/)
 - Update sysfs-driver-xen-blkback for new parameter
   (suggested by Roger Pau Monné)
 - Use per-xen_blkif buffer_squeeze_end instead of global variable
   (suggested by Roger Pau Monné)

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

SeongJae Park (4):
  xenbus/backend: Add memory pressure handler callback
  xen/blkback: Squeeze page pools if a memory pressure is detected
  xen/blkback: Remove unnecessary static variable name prefixes
  xen/blkback: Consistently insert one empty line between functions

 .../ABI/testing/sysfs-driver-xen-blkback      | 10 +++++
 drivers/block/xen-blkback/blkback.c           | 42 +++++++++----------
 drivers/block/xen-blkback/common.h            |  1 +
 drivers/block/xen-blkback/xenbus.c            | 26 +++++++++---
 drivers/xen/xenbus/xenbus_probe_backend.c     | 32 ++++++++++++++
 include/xen/xenbus.h                          |  1 +
 6 files changed, 86 insertions(+), 26 deletions(-)

-- 
2.17.1

