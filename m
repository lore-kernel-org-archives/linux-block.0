Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D20F197552
	for <linux-block@vger.kernel.org>; Thu,  6 Jun 2024 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688915; cv=none; b=SopCOpMnER8vxqNz4zHo1dOSnGbRavgsC3U0cCKAGHNTwuYFMhq727+UodmoMbmOZf4LrNE3rHKGbRBNDnaqDXaYvCfV4qlbJ3TkczGZFaf8+PlOIVr2ocyy1TcFl6xJOo6Dmp7MJgs/F+pbZBu93ijaMT6cit1UtBt+pN6obMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688915; c=relaxed/simple;
	bh=doWsQdyexxue40lQkR/VOtRqkgva6Pral0cLJ+F9PKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaq7SCGl6DCdpzNdecp+vZd1NLjQ8/Eozt9pIcf78itnlysY26mR2OMIao5J5oGSOd9Sfh8fk9qjp1n92M84p/rMB+3zPVmlijCuCsdhY2DSkW3EKjTeqgJr4Fv890Xu8rvdWaoh6W2pRn8ifViSHTOc934i6i72OrPsCnPuPHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jGzGMB8A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGzGMB8A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717688913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMNS20tI+I6GwMX8GGwbuYmB/pEsZhh43zGq0WZmq7g=;
	b=jGzGMB8A+ihxZQRit81gxQtXpVU3oFfIqY4cR4UyhjpSsb+KIeVwZWufcrqRWN8pKI1gYO
	8hwtduhsFqDt0bx1yx+0heV/vfdVnY9KgUR0KQHG9gmpAclwM3cRCxydeCrMwGe8GY5Bal
	wbDxLzX9lJWZuCm+d/nZqlvsfE1DK2E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-jA9W0kF2O2CLIcWdhZXrbQ-1; Thu,
 06 Jun 2024 11:48:29 -0400
X-MC-Unique: jA9W0kF2O2CLIcWdhZXrbQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 04754193D88C;
	Thu,  6 Jun 2024 15:48:28 +0000 (UTC)
Received: from fedora (unknown [10.72.113.78])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 331A3195423C;
	Thu,  6 Jun 2024 15:48:21 +0000 (UTC)
Date: Thu, 6 Jun 2024 23:48:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: YangYang <yang.yang@vivo.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v2] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
Message-ID: <ZmHaQCOpje/6qQPZ@fedora>
References: <20240604031124.2261-1-yang.yang@vivo.com>
 <CAFj5m9KV7OJ4_KjbSkpdtfrKamoLzV6EH-mJP3=y+VvoYOzC3w@mail.gmail.com>
 <aa7246f9-f7df-3054-077e-eb21c7f423ac@huaweicloud.com>
 <35bd4fe6-5ed0-4446-8fab-f86909212e60@vivo.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35bd4fe6-5ed0-4446-8fab-f86909212e60@vivo.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Jun 06, 2024 at 04:55:17PM +0800, YangYang wrote:
> On 2024/6/4 14:12, Yu Kuai wrote:
> > Hi,
> > 
> > 在 2024/06/04 11:25, Ming Lei 写道:
> > > On Tue, Jun 4, 2024 at 11:12 AM Yang Yang <yang.yang@vivo.com> wrote:
> > > > 
> > > > Configuration for sbq:
> > > >    depth=64, wake_batch=6, shift=6, map_nr=1
> > > > 
> > > > 1. There are 64 requests in progress:
> > > >    map->word = 0xFFFFFFFFFFFFFFFF
> > > > 2. After all the 64 requests complete, and no more requests come:
> > > >    map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
> > > > 3. Now two tasks try to allocate requests:
> > > >    T1:                                       T2:
> > > >    __blk_mq_get_tag                          .
> > > >    __sbitmap_queue_get                       .
> > > >    sbitmap_get                               .
> > > >    sbitmap_find_bit                          .
> > > >    sbitmap_find_bit_in_word                  .
> > > >    __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
> > > >    sbitmap_deferred_clear                    __sbitmap_queue_get
> > > >    /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
> > > >      if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
> > > >        return false;                         __sbitmap_get_word -> nr=-1
> > > >      mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
> > > >      atomic_long_andnot()                    /* map->cleared=0 */
> > > >                                                if (!(map->cleared))
> > > >                                                  return false;
> > > >                                       /*
> > > >                                        * map->cleared is cleared by T1
> > > >                                        * T2 fail to acquire the tag
> > > >                                        */
> > > > 
> > > > 4. T2 is the sole tag waiter. When T1 puts the tag, T2 cannot be woken
> > > > up due to the wake_batch being set at 6. If no more requests come, T1
> > > > will wait here indefinitely.
> > > > 
> > > > To fix this issue, simply revert commit 661d4f55a794 ("sbitmap:
> > > > remove swap_lock"), which causes this issue.
> > > 
> > > I'd suggest to add the following words in commit log:
> > > 
> > > Check on ->cleared and update on both ->cleared and ->word need to be
> > > done atomically, and using spinlock could be the simplest solution.
> > > 
> > > Otherwise, the patch looks fine for me.
> > 
> > Maybe I'm noob, but I'm confused how can this fix the problem, looks
> > like the race condition doesn't change.
> > 
> > In sbitmap_find_bit_in_word:
> > 
> > 1) __sbitmap_get_word read word;
> > 2) sbitmap_deferred_clear clear cleared;
> > 3) sbitmap_deferred_clear update word;
> > 
> > 2) and 3) are done atomically while 1) can still concurrent with 3):
> > 
> > t1:
> > sbitmap_find_bit_in_word
> >   __sbitmap_get_word
> >   -> read old word, return -1
> >          t2:
> >          sbitmap_find_bit_in_word
> >           __sbitmap_get_word
> >           -> read old word, return -1
> >   sbitmap_deferred_clear
> >   -> clear cleared and update word
> >          sbitmap_deferred_clear
> >          -> cleared is cleared, fail
> > 
> > BYW, I still think it's fine to fix this problem by trying the
> > __sbitmap_get_word() at least one more time if __sbitmap_get_word()
> > failed.
> 
> How about this one:
> 1. Add extra check in sbitmap_find_bit_in_word() referenced from
>    Yu kuai's suggestion.
> 2. Change from atomic_long_andnot to atomic_long_fetch_andnot_release
> 
> ---
>  include/linux/sbitmap.h |  5 +++++
>  lib/sbitmap.c           | 23 ++++++++++++++++++-----
>  2 files changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> index d662cf136021..ec0b0e73c906 100644
> --- a/include/linux/sbitmap.h
> +++ b/include/linux/sbitmap.h
> @@ -36,6 +36,11 @@ struct sbitmap_word {
>      * @cleared: word holding cleared bits
>      */
>     unsigned long cleared ____cacheline_aligned_in_smp;
> +
> +   /**
> +    * @swap_lock: Held while swapping word <-> cleared
> +    */
> +   spinlock_t swap_lock;
>  } ____cacheline_aligned_in_smp;
> 
>  /**
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 1e453f825c05..63dadf91e40b 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -63,9 +63,13 @@ static inline void update_alloc_hint_after_get(struct sbitmap *sb,
>  static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
>  {
>     unsigned long mask;
> +   bool ret = false;
> +   unsigned long flags;
> 
> -   if (!READ_ONCE(map->cleared))
> -       return false;
> +   spin_lock_irqsave(&map->swap_lock, flags);
> +
> +   if (!map->cleared)
> +       goto out_unlock;
> 
>     /*
>      * First get a stable cleared mask, setting the old mask to 0.
> @@ -75,9 +79,12 @@ static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
>     /*
>      * Now clear the masked bits in our free word
>      */
> -   atomic_long_andnot(mask, (atomic_long_t *)&map->word);
> +   atomic_long_fetch_andnot_release(mask, (atomic_long_t *)&map->word);
>     BUILD_BUG_ON(sizeof(atomic_long_t) != sizeof(map->word));
> -   return true;
> +   ret = true;
> +out_unlock:
> +   spin_unlock_irqrestore(&map->swap_lock, flags);
> +   return ret;
>  }
> 
>  int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
> @@ -85,6 +92,7 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
>               bool alloc_hint)
>  {
>     unsigned int bits_per_word;
> +   int i;
> 
>     if (shift < 0)
>         shift = sbitmap_calculate_shift(depth);
> @@ -116,6 +124,9 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
>         return -ENOMEM;
>     }
> 
> +   for (i = 0; i < sb->map_nr; i++)
> +       spin_lock_init(&sb->map[i].swap_lock);
> +
>     return 0;
>  }
>  EXPORT_SYMBOL_GPL(sbitmap_init_node);
> @@ -175,11 +186,13 @@ static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
>     int nr;
> 
>     do {
> +       unsigned long cleared = READ_ONCE(map->cleared);
> +

->cleared is stored in standalone cacheline, the above line adds one extra l1
load, so I still prefer to check ->word & ->cleared in sbitmap_deferred_clear().

Thanks, 
Ming

