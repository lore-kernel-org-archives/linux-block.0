Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mxhk.zte.com.cn ([63.217.80.70]:38616 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752446AbeDMJEo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Apr 2018 05:04:44 -0400
From: tang.junhui@zte.com.cn
To: colyli@suse.de
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        tang.junhui@zte.com.cn
Subject: Re: [PATCH 1/2] bcache: remove unncessary code in bch_btree_keys_init()
Date: Fri, 13 Apr 2018 17:04:52 +0800
Message-Id: <1523610292-8800-1-git-send-email-tang.junhui@zte.com.cn>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Coly,

>Function bch_btree_keys_init() initializes b->set[].size and
>b->set[].data to zero. As the code comments indicates, these code indeed
>is unncessary, because both struct btree_keys and struct bset_tree are
>nested embedded into struct btree, when struct btree is filled with 0
>bits by kzalloc() in mca_bucket_alloc(), b->set[].size and
>b->set[].data are initialized to 0 (a.k.a NULL) already.
>
Eh, you need to pay attention to mca_alloc()==>mca_reap(),
which get btree node memory from list btree_cache_freeable
or btree_cache_freed, that merory were used as btree node before,
and may be not fill with 0.
>This patch removes the redundant code, and add comments in
>bch_btree_keys_init() and mca_bucket_alloc() to explain why it's safe.
>
>Signed-off-by: Coly Li <colyli@suse.de>
>---
> drivers/md/bcache/bset.c  | 13 ++++++-------
> drivers/md/bcache/btree.c |  4 ++++
> 2 files changed, 10 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/md/bcache/bset.c b/drivers/md/bcache/bset.c
>index 579c696a5fe0..343f4e9428e0 100644
>--- a/drivers/md/bcache/bset.c
>+++ b/drivers/md/bcache/bset.c
>@@ -352,15 +352,14 @@ void bch_btree_keys_init(struct btree_keys *b, const struct btree_keys_ops *ops,
>     b->nsets = 0;
>     b->last_set_unwritten = 0;
> 
>-    /* XXX: shouldn't be needed */
>-    for (i = 0; i < MAX_BSETS; i++)
>-        b->set[i].size = 0;
>     /*
>-     * Second loop starts at 1 because b->keys[0]->data is the memory we
>-     * allocated
>+     * struct btree_keys in embedded in struct btree, and struct
>+     * bset_tree is embedded into struct btree_keys. They are all
>+     * initialized as 0 by kzalloc() in mca_bucket_alloc(), and
>+     * b->set[0].data is allocated in bch_btree_keys_alloc(), so we
>+     * don't have to initiate b->set[].size and b->set[].data here
>+     * any more.
>      */
>-    for (i = 1; i < MAX_BSETS; i++)
>-        b->set[i].data = NULL;
> }
> EXPORT_SYMBOL(bch_btree_keys_init);
> 
>diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
>index 17936b2dc7d6..344641e23415 100644
>--- a/drivers/md/bcache/btree.c
>+++ b/drivers/md/bcache/btree.c
>@@ -600,6 +600,10 @@ static void mca_data_alloc(struct btree *b, struct bkey *k, gfp_t gfp)
> static struct btree *mca_bucket_alloc(struct cache_set *c,
>                       struct bkey *k, gfp_t gfp)
> {
>+    /*
>+     * kzalloc() is necessary here for initialization,
>+     * see code comments in bch_btree_keys_init().
>+     */
>     struct btree *b = kzalloc(sizeof(struct btree), gfp);
>     if (!b)
>         return NULL;
>-- 
>2.16.2


Thanks.
Tang Junhui
