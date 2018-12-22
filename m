Return-Path: <SRS0=4yxV=O7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBDDC43387
	for <linux-block@archiver.kernel.org>; Sat, 22 Dec 2018 17:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7785221974
	for <linux-block@archiver.kernel.org>; Sat, 22 Dec 2018 17:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389420AbeLVRXr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:23:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:38564 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727680AbeLVRXn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Dec 2018 12:23:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3C6FDACD7;
        Sat, 22 Dec 2018 13:03:40 +0000 (UTC)
Subject: Re: [PATCH] bcache: treat stale && dirty keys as bad keys
To:     Junhui Tang <tang.junhui.linux@gmail.com>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <CA+NNRhE8438XuoZ25kdCRjYvZv6nHJU+Yoyg6hacWuptjWWDfA@mail.gmail.com>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=colyli@suse.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <30ce3cb6-aea0-6556-bbf7-a969e8489da5@suse.de>
Date:   Sat, 22 Dec 2018 21:02:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CA+NNRhE8438XuoZ25kdCRjYvZv6nHJU+Yoyg6hacWuptjWWDfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/18/18 2:37 下午, Junhui Tang wrote:
> From 8ca52771f1d3b83ff55dc80ba633901a081963bf Mon Sep 17 00:00:00 2001
> From: Tang Junhui <tang.junhui.linux@gmail.com>
> Date: Tue, 18 Dec 2018 10:38:26 +0800
> Subject: [PATCH] bcache: treat stale && dirty keys as bad keys
> 
> Stale && dirty keys can be produced in the follow way:
> After writeback in write_dirty_finish(), dirty keys k1 will
> replace by clean keys k2
> ==>ret = bch_btree_insert(dc->disk.c, &keys, NULL, &w->key);
> ==>btree_insert_fn(struct btree_op *b_op, struct btree *b)
> ==>static int bch_btree_insert_node(struct btree *b,
>        struct btree_op *op,
>        struct keylist *insert_keys,
>        atomic_t *journal_ref,
> Then two steps:
> A) update k1 to k2 in btree node memory;
>    bch_btree_insert_keys(b, op, insert_keys, replace_key)
> B) Write the bset(contains k2) to cache disk by a 30s delay work
>    bch_btree_leaf_dirty(b, journal_ref).
> But before the 30s delay work write the bset to cache device,
> these things happend:
> A) GC works, and reclaim the bucket k2 point to;
> B) Allocator works, and invalidate the bucket k2 point to,
>    and increase the gen of the bucket, and place it into free_inc
>    fifo;
> C) Until now, the 30s delay work still does not finish work,
>    so in the disk, the key still is k1, it is dirty and stale
>    (its gen is smaller than the gen of the bucket). and then the
>    machine power off suddenly happens;
> D) When the machine power on again, after the btree reconstruction,
>    the stale dirty key appear.
> 
> In bch_extent_bad(), when expensive_debug_checks is off, it would
> treat the dirty key as good even it is stale keys, and it would
> cause bellow probelms:
> A) In read_dirty() it would cause machine crash:
>    BUG_ON(ptr_stale(dc->disk.c, &w->key, 0));
> B) It could be worse when reads hits stale dirty keys, it would
>    read old incorrect data.
> 
> This patch tolerate the existence of these stale && dirty keys,
> and treat them as bad key in bch_extent_bad().
> 
> Signed-off-by: Tang Junhui <tang.junhui.linux@gmail.com>

Hi Junhui,

As a quick fix, this patch is good to me. Although there is indent issue
in this patch, I will fix it, don't worry.

Now I am also testing this patch on my hardware, if the addressed
problem does not reproduce next Monday, I will submit it to Jens in 4.21
wave.

Thanks.

Coly Li


> ---
>  drivers/md/bcache/extents.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/md/bcache/extents.c b/drivers/md/bcache/extents.c
> index 1d09674..f9eb03c 100644
> --- a/drivers/md/bcache/extents.c
> +++ b/drivers/md/bcache/extents.c
> @@ -535,6 +535,7 @@ static bool bch_extent_bad(struct btree_keys *bk,
> const struct bkey *k)
>  {
>   struct btree *b = container_of(bk, struct btree, keys);
>   unsigned i, stale;
> + char buf[80];
> 
>   if (!KEY_PTRS(k) ||
>       bch_extent_invalid(bk, k))
> @@ -544,19 +545,20 @@ static bool bch_extent_bad(struct btree_keys
> *bk, const struct bkey *k)
>   if (!ptr_available(b->c, k, i))
>   return true;
> 
> - if (!expensive_debug_checks(b->c) && KEY_DIRTY(k))
> - return false;
> -
>   for (i = 0; i < KEY_PTRS(k); i++) {
>   stale = ptr_stale(b->c, k, i);
> 
> + if (stale && KEY_DIRTY(k)) {
> + bch_extent_to_text(buf, sizeof(buf), k);
> + pr_info("stale dirty pointer, stale %u, key: %s",
> +     stale,
> +     buf);
> + }
> +
>   btree_bug_on(stale > 96, b,
>        "key too stale: %i, need_gc %u",
>        stale, b->c->need_gc);
> 
> - btree_bug_on(stale && KEY_DIRTY(k) && KEY_SIZE(k),
> -      b, "stale dirty pointer");
> -
>   if (stale)
>   return true;
> 

