Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121BCC43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 06:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17182133F
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 06:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caGZDsEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbeLRGgF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 01:36:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40457 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbeLRGgF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 01:36:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id f188so823475wmf.5;
        Mon, 17 Dec 2018 22:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=KwCH+thL5U4lLkPa1gGp+cMWQO9zXv6eoQ2cbOuVf2I=;
        b=caGZDsEBQgJJip2UWAFk3qGOjMwg4UFI4ismBiiF/GI89hkC4G8wasmBzKj75Uzep0
         eknT4qLdUwkjpIpd7UrXkm2G9N8XYjjHMYVm9C+hQUWHX+uR1mX40147ce4y9aNF46/L
         US7DH4GKOrMlDGyaV2Lv+kcQOHvGAtDRYzUKiwBxpRDwlRSAWFRgkqVo4WJBG0Q54Ui4
         Hu0Bn8CKmJOLvrgu0Cy3Q9dkahSI0V1NDkyPsRAj5qzl1rI4ul72dTfpC2tm7UqlbuMQ
         wYsAK3W1sUVYRj4sf5aBYxOzwjeD7IVpHapC6RxMg4McUbaiVeFFVmby6erfVuGOtKm/
         y1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=KwCH+thL5U4lLkPa1gGp+cMWQO9zXv6eoQ2cbOuVf2I=;
        b=Ldd57UrVupbL60gHSJ5sZR1olC3SUYt6X8OYDaDyaMhZXoXNSk7hw6GiaNkawvHIo/
         tAj4cORdUcHUsSuUU/cQuh4Qnbat2fBnq5BjayASROIxWc0ypHF+POMYs+mWgTtgKiwG
         VktkmjpdvvBGpxcDJo5vuC64Dwb6a8krjNJX6AnbeWlIKSlKnB9tTXISEscCDmKywVcS
         K1+qsq/6uq6TkXz8ccDmO1qp6fbYfobpadQBUaQKT6P60+ws3xP9THo0bQ9RKzNxgK/2
         mgoKMamOa8MCQJTjTPM2JavMbG9b3sd6jhZfJzEeNmsxtyINXLXMjaaqak8EYfk6hdCA
         Q88g==
X-Gm-Message-State: AA+aEWYV4C83qY5Kg6cRRAEP/q87AJxZmdAkr28JbZsNbzbjlxquGuZ7
        cWFV1E34QkBZY0IXWNRIWdgce3zQn8MDrshIx5pSPKXA
X-Google-Smtp-Source: AFSGD/XK4RYb6WQade4WTFA3XRqfzlFF1hUhzoDbLlxnL10fi41tz1ulUdZ5xeK+8htSCoQDARaXM4P8e+T0UvJ8QTE=
X-Received: by 2002:a1c:4681:: with SMTP id t123mr1820368wma.24.1545114962145;
 Mon, 17 Dec 2018 22:36:02 -0800 (PST)
MIME-Version: 1.0
From:   Junhui Tang <tang.junhui.linux@gmail.com>
Date:   Tue, 18 Dec 2018 14:37:14 +0800
Message-ID: <CA+NNRhE8438XuoZ25kdCRjYvZv6nHJU+Yoyg6hacWuptjWWDfA@mail.gmail.com>
Subject: [PATCH] bcache: treat stale && dirty keys as bad keys
To:     colyli@suse.de
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From 8ca52771f1d3b83ff55dc80ba633901a081963bf Mon Sep 17 00:00:00 2001
From: Tang Junhui <tang.junhui.linux@gmail.com>
Date: Tue, 18 Dec 2018 10:38:26 +0800
Subject: [PATCH] bcache: treat stale && dirty keys as bad keys

Stale && dirty keys can be produced in the follow way:
After writeback in write_dirty_finish(), dirty keys k1 will
replace by clean keys k2
==>ret = bch_btree_insert(dc->disk.c, &keys, NULL, &w->key);
==>btree_insert_fn(struct btree_op *b_op, struct btree *b)
==>static int bch_btree_insert_node(struct btree *b,
       struct btree_op *op,
       struct keylist *insert_keys,
       atomic_t *journal_ref,
Then two steps:
A) update k1 to k2 in btree node memory;
   bch_btree_insert_keys(b, op, insert_keys, replace_key)
B) Write the bset(contains k2) to cache disk by a 30s delay work
   bch_btree_leaf_dirty(b, journal_ref).
But before the 30s delay work write the bset to cache device,
these things happend:
A) GC works, and reclaim the bucket k2 point to;
B) Allocator works, and invalidate the bucket k2 point to,
   and increase the gen of the bucket, and place it into free_inc
   fifo;
C) Until now, the 30s delay work still does not finish work,
   so in the disk, the key still is k1, it is dirty and stale
   (its gen is smaller than the gen of the bucket). and then the
   machine power off suddenly happens;
D) When the machine power on again, after the btree reconstruction,
   the stale dirty key appear.

In bch_extent_bad(), when expensive_debug_checks is off, it would
treat the dirty key as good even it is stale keys, and it would
cause bellow probelms:
A) In read_dirty() it would cause machine crash:
   BUG_ON(ptr_stale(dc->disk.c, &w->key, 0));
B) It could be worse when reads hits stale dirty keys, it would
   read old incorrect data.

This patch tolerate the existence of these stale && dirty keys,
and treat them as bad key in bch_extent_bad().

Signed-off-by: Tang Junhui <tang.junhui.linux@gmail.com>
---
 drivers/md/bcache/extents.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/md/bcache/extents.c b/drivers/md/bcache/extents.c
index 1d09674..f9eb03c 100644
--- a/drivers/md/bcache/extents.c
+++ b/drivers/md/bcache/extents.c
@@ -535,6 +535,7 @@ static bool bch_extent_bad(struct btree_keys *bk,
const struct bkey *k)
 {
  struct btree *b = container_of(bk, struct btree, keys);
  unsigned i, stale;
+ char buf[80];

  if (!KEY_PTRS(k) ||
      bch_extent_invalid(bk, k))
@@ -544,19 +545,20 @@ static bool bch_extent_bad(struct btree_keys
*bk, const struct bkey *k)
  if (!ptr_available(b->c, k, i))
  return true;

- if (!expensive_debug_checks(b->c) && KEY_DIRTY(k))
- return false;
-
  for (i = 0; i < KEY_PTRS(k); i++) {
  stale = ptr_stale(b->c, k, i);

+ if (stale && KEY_DIRTY(k)) {
+ bch_extent_to_text(buf, sizeof(buf), k);
+ pr_info("stale dirty pointer, stale %u, key: %s",
+     stale,
+     buf);
+ }
+
  btree_bug_on(stale > 96, b,
       "key too stale: %i, need_gc %u",
       stale, b->c->need_gc);

- btree_bug_on(stale && KEY_DIRTY(k) && KEY_SIZE(k),
-      b, "stale dirty pointer");
-
  if (stale)
  return true;

-- 
1.8.3.1
