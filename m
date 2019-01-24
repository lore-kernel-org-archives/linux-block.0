Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C045C282C5
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 08:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E149217D4
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 08:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDeKbjVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfAXIJN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:09:13 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55292 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfAXIJK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 03:09:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so2061371wmh.4;
        Thu, 24 Jan 2019 00:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=wx55x7j9ceb9ZEBbRAw5JEOo3SduS28fkSTFbd3uTb0=;
        b=qDeKbjVOr4en4LOi8w1DXN63fkKnUAfbl2kESFqrQ9y/MPEd+LAy5+1RrJuJuzHcUO
         tWIOhH3j1ac3EL+Y34BIMupq0pOeX5Us3Cl4SsigodLcY+sSjTU922NVqgAsAcQRXl0X
         ldl3VET6NBsqTuCHc//onFZBscDcrQo/qxTMSZMYdgNUXoGqJaPMFypYZkebvHWkCY/f
         /DOsknGRPoIT9uvJxqb60C5jIwp4XsKTKjrjyd51cZa0DBcR+4OUAaGCOpJAgbhGp0s1
         5mRzxyOsotO7vawbhXrSw2MKO4ek4SCXxmWOci5gEPuwJEbDI+tP5c8CrSBCEIheOYKK
         Nt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=wx55x7j9ceb9ZEBbRAw5JEOo3SduS28fkSTFbd3uTb0=;
        b=thhqyCFCgwpjmBtyhAETHZKo8wbzrt36HO0d6FzMMUnhe7W12kpLVxn4CLWMNhSpJb
         ZPmbegld+xJKPf46MnRfQNPYHh6VvnAo8nrK4DPsmiMil39VYTxWX1oI49gJg+RcGywt
         f17BaStISblAY+MvJZeKgmlcbaqcemUpWrGaNgrcQFHpAkPpOWwGe4ur+XYPqBW3kCeo
         G7FI+5dqWD+8ESv4ozf6DgB0dmU9RYlZQ2MSrnFq3LaqnHe9udn5kYOtg0MpUqhG4cLB
         mD4IzzcCR3r8k3R70g6Uds0pL46LQi0EE1C44K8hROYNzHoBPKR3oBWD+Q8FGjKeDZCn
         qYUA==
X-Gm-Message-State: AJcUukdzqdWMQiUShyGE2vKCoCSjEpq6/NbG11kjarntAkdltbaILE8/
        lbnb1gbwAVBi311jeTguPJznqUtol9c5ZSv/db/T/JV7xSM=
X-Google-Smtp-Source: ALg8bN7zyoPhO/cNcf0U68sOeIrDMCQmDh7U/mExHuSiTe6qWv5jm/yiOK043Q5MJ2Db+91xMREyudWskN/xIRoGAAM=
X-Received: by 2002:a1c:2856:: with SMTP id o83mr1607586wmo.45.1548317348165;
 Thu, 24 Jan 2019 00:09:08 -0800 (PST)
MIME-Version: 1.0
From:   Junhui Tang <tang.junhui.linux@gmail.com>
Date:   Thu, 24 Jan 2019 16:09:07 +0800
Message-ID: <CA+NNRhHC=uCwPgjec2JyE-BcFARFsDc9mX28Qxke_b3=eZ76Gg@mail.gmail.com>
Subject: [PATCH] bcache: fix a race between register and allocator thread
To:     colyli@suse.de
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From d75d1b51aeedcc9349571be084c5f51d8f7e7612 Mon Sep 17 00:00:00 2001
From: Tang Junhui <tang.junhui.linux@gmail.com>
Date: Thu, 24 Jan 2019 16:01:35 +0800
Subject: [PATCH] bcache: fix a race between register and allocator thread

when register a new cache device, allocator get stucked,
the call trace is bellow:
Sangfor:EDS/eds-fe5192de /sf # cat /proc/3642/task/*/stack
[<ffffffffa02b01c8>] bch_bucket_alloc+0x178/0x2b0 [bcache]
[<ffffffffa02c737d>] bch_prio_write+0x18d/0x320 [bcache]
[<ffffffffa02b0042>] bch_allocator_thread+0x432/0x440 [bcache]
[<ffffffff810a1430>] kthread+0xc0/0xd0
[<ffffffff8173def7>] ret_from_fork+0x77/0xb0
[<ffffffffffffffff>] 0xffffffffffffffff

There is a race between register and allocator thread:
register thread                       allocator thread
run_cache_set
=>bch_initial_gc_finish
  alloc prio buckets
=>bch_cache_allocator_start
  start allocator thread             bch_allocator_thread
=>bch_prio_write                     =>invalidate_buckets
  write prio using prio buckets        fill bucket into ca->free_inc
=>SET_CACHE_SYNC
  set cache sync mode                 =>bch_prio_write
                                        since cache sync mode is set,
                                        write prio to bucket, and the
                                        prio bucket has been used in
                                        register thread, no bucket can
                                        used. so the allocator thread
                                        stuck here.
In this patch, register thread wait for the allocator thread to finish
work, then write prio to buckets and set cache to sync mode.

Signed-off-by: Tang Junhui <tang.junhui.linux@gmail.com>
---
 drivers/md/bcache/super.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index fa4058e..818d2f1 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1852,13 +1852,28 @@ static void run_cache_set(struct cache_set *c)
  bch_initial_gc_finish(c);

  err = "error starting allocator thread";
- for_each_cache(ca, c, i)
- if (bch_cache_allocator_start(ca))
- goto err;
-
  mutex_lock(&c->bucket_lock);
- for_each_cache(ca, c, i)
+ for_each_cache(ca, c, i) {
+ DEFINE_WAIT(wait);
+
+ if (bch_cache_allocator_start(ca)) {
+ mutex_unlock(&c->bucket_lock);
+ goto err;
+ }
+
+ for (;;) {
+ prepare_to_wait(&c->bucket_wait, &wait,
+ TASK_UNINTERRUPTIBLE);
+ if (!fifo_empty(&ca->free_inc))
+ break;
+ mutex_unlock(&c->bucket_lock);
+ schedule();
+ mutex_lock(&c->bucket_lock);
+ }
+
+ finish_wait(&c->bucket_wait, &wait);
  bch_prio_write(ca);
+ }
  mutex_unlock(&c->bucket_lock);

  err = "cannot allocate new UUID bucket";
-- 
1.8.3.1
