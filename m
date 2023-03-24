Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00001C6FD1C
	for <linux-block@archiver.kernel.org>; Fri, 24 Mar 2023 19:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjCXTeG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Mar 2023 15:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCXTeF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2023 15:34:05 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B95F5B87
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 12:34:04 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id ix20so2794279plb.3
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 12:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679686443; x=1682278443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tYrfAQikbBmkLE7eU5XiXBh3MQ6TnxCe16WKSEluc3w=;
        b=BRFu+8ypjhSn+BZtqSUHes7SmaNriDJgUIow3yL9KRCMzU/Iu1GflA/oJSg6lVIEBA
         BEF/DSOHTtP07URbSf3m3La3DYGNjt6rbQ938zFGSSEmDVRlDU5GBfE8IqvtBLGG43A8
         MLA+4oyhIao3d5JYULIbagNmgcZcAkvvT1A4L3RZzz9vTRcGxp+Qo02Notl+gzRBFwe7
         7rUlqsa4CFgVLsumf9KzfHW+2+AiPnBp+H9N8gLTeO8uJG0x1RQSuvAkRIiMcCI8AJ6U
         yiz325Sh/xbUsxq24aso+LQDK+4GTu3ekywhtRhj6jN+tMkDxkcqT6KUcsXYVMO6wVZL
         xq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679686443; x=1682278443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tYrfAQikbBmkLE7eU5XiXBh3MQ6TnxCe16WKSEluc3w=;
        b=O5aU8gKAcEqEMkyHgBURqcq/j5MWINfLeR7FboNW816BwKm6TOQvdHzAEiU/SAUH3f
         Wt6QVzU0RqmVjmnhq73yDNoIT8zlunbZs7hW3M8pgs3wrTwBeFR2JDktY/vLgbbBDTDA
         YYS+CgLSl2Gcq9WS/sryKrZQtfDOpMIlWAyCH+ijMl0Vfo/Ht9n/DIe3J0LtEawQjE81
         5tlUC7yLI6HeBUXzCXH3A9RqJxYnyU1xWGOwJ9l6+c1HQeYbD71UWxnyqsSu4YNlUWzk
         rEpFXYz7CI0h3mB9/7YfHxb91BmBac3cWwOxmuXEI/5V7LJEAcR0tUyGYn5pdWjlCb2L
         9+yQ==
X-Gm-Message-State: AO0yUKU+1L94dLTLtfUa3iV9ufhQrv3dtSWwz3KbJkBfqZg7zIbPKA8c
        xTeiO1X9lLk1lSUDm4GHa1Kh5+73N4egRLg7geqy7Q==
X-Google-Smtp-Source: AK7set8YGYKAmMwEkZNOvgX1mYxJ077W31nLG9NORYPv3TdPjKxZaFqN8bvsHIKCn/brw5jfKGoxqg==
X-Received: by 2002:a05:6a20:914b:b0:dc:e387:566b with SMTP id x11-20020a056a20914b00b000dce387566bmr3332058pzc.1.1679686443371;
        Fri, 24 Mar 2023 12:34:03 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v19-20020aa78513000000b0062a575b1497sm2767740pfn.26.2023.03.24.12.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 12:34:02 -0700 (PDT)
Message-ID: <a1b8ceb8-0a67-86a1-2222-1625f6ebbe33@kernel.dk>
Date:   Fri, 24 Mar 2023 13:34:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [dm-6.4 PATCH v2 3/9] dm bufio: improve concurrent IO performance
To:     Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, ejt@redhat.com, mpatocka@redhat.com,
        heinzm@redhat.com, nhuck@google.com, ebiggers@kernel.org,
        keescook@chromium.org, luomeng12@huawei.com
References: <20230324175656.85082-1-snitzer@kernel.org>
 <20230324175656.85082-4-snitzer@kernel.org>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230324175656.85082-4-snitzer@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just some random drive-by comments.

> diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
> index 1de1bdcda1ce..a58f8ac3ba75 100644
> --- a/drivers/md/dm-bufio.c
> +++ b/drivers/md/dm-bufio.c
> +static void lru_destroy(struct lru *lru)
> +{
> +	BUG_ON(lru->cursor);
> +	BUG_ON(!list_empty(&lru->iterators));
> +}

Ehm no, WARN_ON_ONCE() for these presumably.

> +/*
> + * Insert a new entry into the lru.
> + */
> +static void lru_insert(struct lru *lru, struct lru_entry *le)
> +{
> +	/*
> +	 * Don't be tempted to set to 1, makes the lru aspect
> +	 * perform poorly.
> +	 */
> +	atomic_set(&le->referenced, 0);
> +
> +	if (lru->cursor)
> +		list_add_tail(&le->list, lru->cursor);
> +
> +	else {
> +		INIT_LIST_HEAD(&le->list);
> +		lru->cursor = &le->list;
> +	}

Extra empty line, and missing braces on the first line.

> +static inline struct lru_entry *to_le(struct list_head *l)
> +{
> +	return container_of(l, struct lru_entry, list);
> +}

Useless helper.

> +/*
> + * Remove an lru_iter from the list of cursors in the lru.
> + */
> +static void lru_iter_end(struct lru_iter *it)
> +{
> +	list_del(&it->list);
> +}

Ditto

> +/*
> + * Remove a specific entry from the lru.
> + */
> +static void lru_remove(struct lru *lru, struct lru_entry *le)
> +{
> +	lru_iter_invalidate(lru, le);
> +	if (lru->count == 1)
> +		lru->cursor = NULL;
> +	else {
> +		if (lru->cursor == &le->list)
> +			lru->cursor = lru->cursor->next;
> +		list_del(&le->list);
> +	}
> +	lru->count--;
> +}

Style again, be consistent with braces.

> +static struct lru_entry *lru_evict(struct lru *lru, le_predicate pred, void *context)
> +{
> +	unsigned long tested = 0;
> +	struct list_head *h = lru->cursor;
> +	struct lru_entry *le;
> +
> +	if (!h)
> +		return NULL;
> +	/*
> +	 * In the worst case we have to loop around twice. Once to clear
> +	 * the reference flags, and then again to discover the predicate
> +	 * fails for all entries.
> +	 */
> +	while (tested < lru->count) {
> +		le = container_of(h, struct lru_entry, list);
> +
> +		if (atomic_read(&le->referenced))
> +			atomic_set(&le->referenced, 0);
> +		else {
> +			tested++;
> +			switch (pred(le, context)) {
> +			case ER_EVICT:
> +				/*
> +				 * Adjust the cursor, so we start the next
> +				 * search from here.
> +				 */
> +				lru->cursor = le->list.next;
> +				lru_remove(lru, le);
> +				return le;
> +
> +			case ER_DONT_EVICT:
> +				break;
> +
> +			case ER_STOP:
> +				lru->cursor = le->list.next;
> +				return NULL;
> +			}
> +		}

Again bad bracing.

> @@ -116,9 +366,579 @@ struct dm_buffer {
>  #endif
>  };
>  
> +/*--------------------------------------------------------------*/
> +
> +/*
> + * The buffer cache manages buffers, particularly:
> + *  - inc/dec of holder count
> + *  - setting the last_accessed field
> + *  - maintains clean/dirty state along with lru
> + *  - selecting buffers that match predicates
> + *
> + * It does *not* handle:
> + *  - allocation/freeing of buffers.
> + *  - IO
> + *  - Eviction or cache sizing.
> + *
> + * cache_get() and cache_put() are threadsafe, you do not need to
> + * protect these calls with a surrounding mutex.  All the other
> + * methods are not threadsafe; they do use locking primitives, but
> + * only enough to ensure get/put are threadsafe.
> + */
> +
> +#define NR_LOCKS 64
> +#define LOCKS_MASK (NR_LOCKS - 1)
> +
> +struct tree_lock {
> +	struct rw_semaphore lock;
> +} ____cacheline_aligned_in_smp;
> +
> +struct dm_buffer_cache {
> +	/*
> +	 * We spread entries across multiple trees to reduce contention
> +	 * on the locks.
> +	 */
> +	struct tree_lock locks[NR_LOCKS];
> +	struct rb_root roots[NR_LOCKS];
> +	struct lru lru[LIST_SIZE];
> +};

This:

struct foo_tree {
	struct rw_semaphore lock;
	struct rb_root root;
	struct lru lru;
} ____cacheline_aligned_in_smp;

would be a lot better.

And where does this NR_LOCKS come from? Don't make up magic values out
of thin air. Should this be per-cpu? per-node? N per node? I'll bet you
that 64 is way too much for most use cases, and too little for others.

> +static bool cache_insert(struct dm_buffer_cache *bc, struct dm_buffer *b)
> +{
> +	bool r;
> +
> +	BUG_ON(b->list_mode >= LIST_SIZE);
> +
> +	cache_write_lock(bc, b->block);
> +	BUG_ON(atomic_read(&b->hold_count) != 1);
> +	r = __cache_insert(&bc->roots[cache_index(b->block)], b);
> +	if (r)
> +		lru_insert(&bc->lru[b->list_mode], &b->lru);
> +	cache_write_unlock(bc, b->block);
> +
> +	return r;
> +}

Again, not BUG_ON's.

> +/*
> + * Removes buffer from cache, ownership of the buffer passes back to the caller.
> + * Fails if the hold_count is not one (ie. the caller holds the only reference).
> + *
> + * Not threadsafe.
> + */
> +static bool cache_remove(struct dm_buffer_cache *bc, struct dm_buffer *b)
> +{
> +	bool r;
> +
> +	cache_write_lock(bc, b->block);
> +
> +	if (atomic_read(&b->hold_count) != 1)
> +		r = false;
> +
> +	else {
> +		r = true;
> +		rb_erase(&b->node, &bc->roots[cache_index(b->block)]);
> +		lru_remove(&bc->lru[b->list_mode], &b->lru);
> +	}
> +
> +	cache_write_unlock(bc, b->block);
> +
> +	return r;
> +}

Braces again.

> +static struct dm_buffer *__find_next(struct rb_root *root, sector_t block)
> +{
> +	struct rb_node *n = root->rb_node;
> +	struct dm_buffer *b;
> +	struct dm_buffer *best = NULL;
> +
> +	while (n) {
> +		b = container_of(n, struct dm_buffer, node);
> +
> +		if (b->block == block)
> +			return b;
> +
> +		if (block <= b->block) {
> +			n = n->rb_left;
> +			best = b;
> +		} else
> +			n = n->rb_right;
> +	}

And again.

> @@ -1141,7 +1904,6 @@ static void *new_read(struct dm_bufio_client *c, sector_t block,
>  	}
>  
>  	*bp = b;
> -
>  	return b->data;
>  }
>  

Unrelated change. There are a bunch of these.

I stopped reading here, the patch is just too long. Surely this could be
split up?

 1 file changed, 1292 insertions(+), 477 deletions(-)

That's not a patch, that's a patch series.

-- 
Jens Axboe

