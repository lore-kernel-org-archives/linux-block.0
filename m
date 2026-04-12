Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A63431715D
	for <linux-block@vger.kernel.org>; Sun, 12 Apr 2026 11:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775994538; cv=none; b=VAPBs2qJYK1KitEsfwV+vGa4D29SpfIRfAZVK6znJ3oTJq1tfflYZGCJLb82Ef8iJuECNvtMr7OL87dNlem5f8ALz7mP5mTb5eT3jgxtIu8ZmUAt4SdTuDVD028XDPvYwtA3CbWX8JxGfhVJy0uZ7ypsHJ0SXUiaJSbzIVs21sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775994538; c=relaxed/simple;
	bh=iqiiD1m5gkKzn1PtUYdjuO5yF++wrVIFDd8+oZKJnHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWTLdMvndFU0nAm8rFZixMlgMAm4ExeOU6sVS2VldraPd7fKR6adlWTpoKBrCJFK03yY7oqbVczXPdNdOhHvDeDDoqwLKSIn8/wdbDOLm5nsvM4QBn+Deg9vcIWxfmRY+Xaz8znDuRdPjAS1LjkvVBB57QhltLoyeKjO05YYB3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ge5W/G8x; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ge5W/G8x"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cfd44fa075so424868185a.0
        for <linux-block@vger.kernel.org>; Sun, 12 Apr 2026 04:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775994536; x=1776599336; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZK+9H0h/ffIWkub4XEdg6OwjOH1xxZYH9X5x/fllBLE=;
        b=ge5W/G8xo9JyBmjQAPq8RP/zxf0WKguXv1JGYEj0rAWEsqeWZf/8zrU8U5bsEOjXFg
         UhC8NUCoozurycp8Z5tbot33Opdievm4vQmMSiqY4EMjsH1+O9/nf5ZXPCnFO/R7AE/7
         B/sS+H0yDox1ScadMy7u/uTO2vziKkhUg1tYBuMmo59l7I3OimVPet8QV/+7brB9pp0D
         AXv+sC/UPFo4bbln7BN5oUxyWAywFOIjboOx5R+F9QB8XzdK4tTWhlLFS9Q5T0xkNGZl
         Fv+z8WsvS8oNqPWjv1rq+Eo8ogJJBG/+u+EI7vTLpQCim9waW67h96VIJR+69EjMuvAz
         Vudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775994536; x=1776599336;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZK+9H0h/ffIWkub4XEdg6OwjOH1xxZYH9X5x/fllBLE=;
        b=BazpTXWoAwXT9czmBd/RMlQLZabkiH+Tm4ZOk1tM2jCZWeZj4p2wUWmUkGgOwFdQ79
         AyddaPwZaE4CjPup5TPsSpzco0f+dxuOAxUMSNpaHSCZWD0xRZxPaFvf0TuZ/Mv7aVUt
         fZCQubmMusR/w7NbWws99cHIuMSADKvuCAI3no5nZeLM+L0K/hZkZKSxtWIZwR4VDA82
         7xzaOHuzbCK5nHOgeloQ5DgHRjlSh78qypNoeKiy2EH0AFol7NU3noXO1w1AZ2KgqKV5
         6TlhuffBmrS0RZ2B0RktvCzlOFJ/uBgb5Wzl0AVOH1yec8vAYD0vrNKb3PncpX+/Omt/
         sV0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXswIKDxwRcEmqVExiG819cnXMhXDoR1KfyWAcOtHEnv+f2U8/2VZfaZ6Zf/UQ/SpGWJg0ZdJaTB9N7nA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfyiGc+F9BEXuQyA7gRsk21QH+yvKN8UsU8w3HaSkFMmEUE8+e
	c4qOFNjghnOtAq4YkftGEIhlOTqi5W3hf+57Zv+ldICW+EaBLjc/JYZs
X-Gm-Gg: AeBDieuvKOjz7/jc/evFhBW/QgUCe/mc7lr5Yd6BEMQy4ZZ+J96JwzB8zykEsryBg8f
	2WkC3xvGlKVX6HWQBmxLxEZViq09WAr/is9WtO209IEChFzsnbMNkNs1nu1rF9JXaYStc0KF2pi
	bCjST6KH7CFxgl1/TnCRYeFPwOaEmq83hUQrYg6MUptFSSxa6gUhyXK6XeltHPDYbhFaQ2AgDQQ
	QwVDKWq+P+icUgm4yXXMOAk5gleicwU1QSEvWN93l2pQko+FY+n1kCfwPo3srP6XZWgqkGy0vq9
	s05V6D6KKXE3zKjrwWdOed50Lam5a7CIemNRAGVYz3ymhAPsmq60MkRaMalI/uvYA0xVu4D/873
	3eZoF8A9GmCQsi/kF03KA4cfLMEiY+Ebbqj+bDXV8O2Qqj0ACLv3rHvJAzTatzxtYeDXq3pMfb6
	m7UvetRUH67z+RnILrKzVOlxKa8Y+f8p5vqhSZtnNVNi8+/7JWmndnSTbqYg4=
X-Received: by 2002:a05:620a:1990:b0:8cb:baea:89cd with SMTP id af79cd13be357-8ddccb294ffmr1411096585a.8.1775994535808;
        Sun, 12 Apr 2026 04:48:55 -0700 (PDT)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb66587e4sm647529685a.19.2026.04.12.04.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 04:48:55 -0700 (PDT)
Date: Sun, 12 Apr 2026 19:48:48 +0800
From: Kairui Song <ryncsn@gmail.com>
To: "Barry Song (Xiaomi)" <baohua@kernel.org>
Cc: minchan@kernel.org, senozhatsky@chromium.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org, axboe@kernel.dk, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kasong@tencent.com, chrisl@kernel.org, justinjiang@vivo.com, 
	liulei.rjpt@vivo.com, Xueyuan Chen <xueyuan.chen21@gmail.com>
Subject: Re: [RFC PATCH] zram: support asynchronous GC for lazy slot freeing
Message-ID: <adt3Q_SRToF6fb3W@KASONG-MC4>
References: <20260412060450.15813-1-baohua@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260412060450.15813-1-baohua@kernel.org>

On Sun, Apr 12, 2026 at 02:04:50PM +0800, Barry Song (Xiaomi) wrote:
> Swap freeing can be expensive when unmapping a VMA containing
> many swap entries. This has been reported to significantly
> delay memory reclamation during Android’s low-memory killing,
> especially when multiple processes are terminated to free
> memory, with slot_free() accounting for more than 80% of
> the total cost of freeing swap entries.
> 
> Two earlier attempts by Lei and Zhiguo added a new thread in the mm core
> to asynchronously collect and free swap entries [1][2], but the
> design itself is fairly complex.
> 
> When anon folios and swap entries are mixed within a
> process, reclaiming anon folios from killed processes
> helps return memory to the system as quickly as possible,
> so that newly launched applications can satisfy their
> memory demands. It is not ideal for swap freeing to block
> anon folio freeing. On the other hand, swap freeing can
> still return memory to the system, although at a slower
> rate due to memory compression.
> 
> Therefore, in zram, we introduce a GC worker to allow anon
> folio freeing and slot_free to run in parallel, since
> slot_free is performed asynchronously, maximizing the rate at
> which memory is returned to the system.
> 
> Xueyuan’s test on RK3588 shows that unmapping a 256MB swap-filled
> VMA becomes 3.4× faster when pinning tasks to CPU2, reducing the
> execution time from 63,102,982 ns to 18,570,726 ns.
> 
> A positive side effect is that async GC also slightly improves
> do_swap_page() performance, as it no longer has to wait for
> slot_free() to complete.
> 
> Xueyuan’s test shows that swapping in 256MB of data (each page
> filled with repeating patterns such as “1024 one”, “1024 two”,
> “1024 three”, and “1024 four”) reduces execution time from
> 1,358,133,886 ns to 1,104,315,986 ns, achieving a 1.22× speedup.
> 
> [1] https://lore.kernel.org/all/20240805153639.1057-1-justinjiang@vivo.com/
> [2] https://lore.kernel.org/all/20250909065349.574894-1-liulei.rjpt@vivo.com/
> 
> Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
> Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>

Hi Barry

This looks an interesting idea to me.

> ---
>  drivers/block/zram/zram_drv.c | 56 ++++++++++++++++++++++++++++++++++-
>  drivers/block/zram/zram_drv.h |  3 ++
>  2 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index c2afd1c34f4a..f5c07eb997a8 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1958,6 +1958,23 @@ static ssize_t debug_stat_show(struct device *dev,
>  	return ret;
>  }
>  
> +static void gc_slots_free(struct zram *zram)
> +{
> +	size_t num_pages = zram->disksize >> PAGE_SHIFT;
> +	unsigned long index;
> +
> +	index = find_next_bit(zram->gc_map, num_pages, 0);
> +	while (index < num_pages) {
> +		if (slot_trylock(zram, index)) {
> +			if (test_bit(index, zram->gc_map))
> +				slot_free(zram, index);
> +			slot_unlock(zram, index);
> +			cond_resched();
> +		}
> +		index = find_next_bit(zram->gc_map, num_pages, index + 1);
> +	}
> +}
> +

The ideas looks interesting but the implementation looks not that
optimal to me. find_next_bit does a O(n) looks up for every gc call
looks really expensive if the pending slot is at tail.

Perhaps a percpu stack can be used, something like the folio batch?

> -	slot_free(zram, index);
> +	if (!try_slot_lazy_free(zram, index))
> +		slot_free(zram, index);

What is making this slot_free so costly? zs_free?

>  	slot_unlock(zram, index);
>  }
>  
> diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
> index 08d1774c15db..1f3ffd79fcb1 100644
> --- a/drivers/block/zram/zram_drv.h
> +++ b/drivers/block/zram/zram_drv.h
> @@ -88,6 +88,7 @@ struct zram_stats {
>  	atomic64_t pages_stored;	/* no. of pages currently stored */
>  	atomic_long_t max_used_pages;	/* no. of maximum pages stored */
>  	atomic64_t miss_free;		/* no. of missed free */
> +	atomic64_t gc_slots;		/* no. of queued for lazy free by gc */

Maybe we want to track the size of content being delayed instead
of slots number? I saw there is a 30000 hard limit for that.

Perhaps it will make more sense if we have a "buffer size"
(e.g. 64M), seems more intuitive to me. e.g. the ZRAM module can occupy
at most 64M of memory, so the delayed free won't cause a significant
global pressure.

Also I think this patch is batching the memory free operations, so the
workqueue or design can also be further optimized for batching, for
example if the zs_free is the expensive part then maybe we shall just
clear the handler for the freeing slot and leave the handler in a
percpu stack, then batch free these handlers. zsmalloc might make
use some batch optimization based on that too, something like
kmem_cache_free_bulk but for zsmalloc?

if zs_free is not all the expensive part, I took a look at slot_free
maybe a lot of read / write of slot data can be merged.

This patch currently doesn't reduce the total amount of work, but
if above idea works, a lot of redundant operations might be be dropped,
result in better performance in every case.

Just my two cents and ideas, not sure if I got everything correct.
Looking forward for more disscussion on this :)
