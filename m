Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6684CC43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 14:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2825321852
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 14:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOQyVCQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbeLROCG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:02:06 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50731 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeLROCG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 09:02:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id n190so2792362wmd.0;
        Tue, 18 Dec 2018 06:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4KQKhUbX5TJiBq1TdpEHrq/z97C51j0XmKyjV6Tu9+4=;
        b=jOQyVCQqjsi8xVz5uBMIj1w+Ml1S2rXdTrZEDF5jwq3U1R6ADHougnJIZlPfFNp6IM
         ylQuNQPWwxNXPH/metGP7UJNS+oiOvmulALXJsQUhT50Ax/h6mAmQc+pBPWPrUIjW8qX
         6DqS/xhtkpuyQHo+7I3MAtTt+wTzbBrX9HZMxp9LNvk/VTS3QMtXthmoFF3F/8dtFgAo
         E794GvVutkMjTB2a3XRS7b/Go8bAYmI8gqQNbDbntoJYROuzXF+oUN9FQkOAcyoc17ZE
         oVXCHHmH/I5wZ6nEXZG60QivCkYbP6wQv+hhWqLYfCliCvuI3ddzx8CB84Y7Tgdtg2qW
         P0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4KQKhUbX5TJiBq1TdpEHrq/z97C51j0XmKyjV6Tu9+4=;
        b=JVtvkJ+vWmNq/WL4VpG0pHm/5UzBBPgqkJW3h0qN/c6t145e9BezBO4dXDbkAF6Qpz
         wDHaw6wQPFDbo/Vlnnhbt6m5pmQJY3HACTMz5lDp/D/7QmM8L2i2oLcqPorD2gDyeZyX
         CCVU+zclabQB46RCqtnvQj7G7LHV4G78+x8580YJT0yx5LD+BjC998AfV7CfwxRrRQkc
         869BVLNUhAXLc4pU9d9m1iPj/y6KtBrWI4nEvywFamSvLh0O4w2gEQaswP172eIYx3D3
         wFNXzWW445zGpSj5+EJVFv0QTakubxk6VCXdEXP5XQSSCBKoNueXZGJ5Hc/bCczR+t9T
         jDUQ==
X-Gm-Message-State: AA+aEWZqqH1NAhBn0iRWu2O3F5UwScZbwyw7+tnKdBGPljVtlLzn011f
        F8NhazeE3H5U8DiNmGHdBw==
X-Google-Smtp-Source: AFSGD/VW6HaychVzdcenJIGEwvnMwHZQbrJFnes0TphwX10GIRctcYkM6Pj91vlEhl/NNPtb6rAsKQ==
X-Received: by 2002:a1c:44d6:: with SMTP id r205mr3515470wma.50.1545141723481;
        Tue, 18 Dec 2018 06:02:03 -0800 (PST)
Received: from kmo-pixel ([93.240.4.121])
        by smtp.gmail.com with ESMTPSA id f192sm2897576wmd.12.2018.12.18.06.02.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 06:02:02 -0800 (PST)
Date:   Tue, 18 Dec 2018 09:01:57 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Junhui Tang <tang.junhui.linux@gmail.com>
Cc:     colyli@suse.de, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] bcache: treat stale && dirty keys as bad keys
Message-ID: <20181218140157.GB7144@kmo-pixel>
References: <CA+NNRhE8438XuoZ25kdCRjYvZv6nHJU+Yoyg6hacWuptjWWDfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+NNRhE8438XuoZ25kdCRjYvZv6nHJU+Yoyg6hacWuptjWWDfA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 18, 2018 at 02:37:14PM +0800, Junhui Tang wrote:
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

Only prior to journal replay, right? Or did you uncover something more severe?

> In bch_extent_bad(), when expensive_debug_checks is off, it would
> treat the dirty key as good even it is stale keys, and it would
> cause bellow probelms:
> A) In read_dirty() it would cause machine crash:
>    BUG_ON(ptr_stale(dc->disk.c, &w->key, 0));
> B) It could be worse when reads hits stale dirty keys, it would
>    read old incorrect data.

Neither of these can happen until after journal replay is finished. Prior to
journal replay we expect to find stale dirty keys - if we find any after journal
replay then it's indicative of a real bug.

> 
> This patch tolerate the existence of these stale && dirty keys,
> and treat them as bad key in bch_extent_bad().
> 
> Signed-off-by: Tang Junhui <tang.junhui.linux@gmail.com>
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
> -- 
> 1.8.3.1
