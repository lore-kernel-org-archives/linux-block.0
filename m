Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51092628C
	for <linux-block@vger.kernel.org>; Thu,  6 Jun 2024 03:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717643572; cv=none; b=OK02dZdG7UAVOyzhmsr/B7eLLbUgrUcENFA8ius2jHjdvtC2TLQqVjVEuUK8/6DUv+/ZdgUVpz59DdHY1qvKp5RUYf+4HJubK+NZqQjvpUOqSgXOqqxVq9QGSHUUWUc5EoK/MNBwgLO3XaRmG3k8Og8D9bXL1//W1rhZEJ5Mshw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717643572; c=relaxed/simple;
	bh=vbPR3Zgrgw1n6FfDaNzCH6s5DopgmqVYacwRROedYNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIRUdBxDImpfryh+UvaQmM9s/OoqhBPhl7QmTPZPMwEmxWlsXestwc0peCB5urguRfi4Ckbj2XENSXXu8D7C7T9US4c7zM2o8anUhXDDQ/ezXqWMA1EGaasYf1BEImbNYR9JeSXasdRPZ27pHNVqrusNC0X1IE6hI2WTI1MSLJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FmHtU289; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FmHtU289"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717643569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L4kwg3KfOwbjwH0/GdeCldIXMlZ7AfiTxkGXVrBulXc=;
	b=FmHtU289aZN2uMXx3BSYLUIBn2WKtWkZ0vyHhYLEVfA5twO3aXLPNyK8LX1ndidw0i4Wk1
	0yssjr07bB8wcNC7wZdZqJqK9r/RjCE9kbBFe4MjbACWilhYdgdxxtB84wnwH+hceYeH9/
	BFVLrhUNduNA5HJK/EuZ7dwo1HoKwlo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-fFX-6hB_PiqVMrxdjXOy6A-1; Wed, 05 Jun 2024 23:12:41 -0400
X-MC-Unique: fFX-6hB_PiqVMrxdjXOy6A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 53806800076;
	Thu,  6 Jun 2024 03:12:41 +0000 (UTC)
Received: from fedora (unknown [10.72.112.215])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A26E72166AFE;
	Thu,  6 Jun 2024 03:12:36 +0000 (UTC)
Date: Thu, 6 Jun 2024 11:12:32 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Yang Yang <yang.yang@vivo.com>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v2] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
Message-ID: <ZmEpIBL2Ot5cwRyv@fedora>
References: <20240604031124.2261-1-yang.yang@vivo.com>
 <CAFj5m9KV7OJ4_KjbSkpdtfrKamoLzV6EH-mJP3=y+VvoYOzC3w@mail.gmail.com>
 <aa7246f9-f7df-3054-077e-eb21c7f423ac@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa7246f9-f7df-3054-077e-eb21c7f423ac@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Tue, Jun 04, 2024 at 02:12:22PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2024/06/04 11:25, Ming Lei 写道:
> > On Tue, Jun 4, 2024 at 11:12 AM Yang Yang <yang.yang@vivo.com> wrote:
> > > 
> > > Configuration for sbq:
> > >    depth=64, wake_batch=6, shift=6, map_nr=1
> > > 
> > > 1. There are 64 requests in progress:
> > >    map->word = 0xFFFFFFFFFFFFFFFF
> > > 2. After all the 64 requests complete, and no more requests come:
> > >    map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
> > > 3. Now two tasks try to allocate requests:
> > >    T1:                                       T2:
> > >    __blk_mq_get_tag                          .
> > >    __sbitmap_queue_get                       .
> > >    sbitmap_get                               .
> > >    sbitmap_find_bit                          .
> > >    sbitmap_find_bit_in_word                  .
> > >    __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
> > >    sbitmap_deferred_clear                    __sbitmap_queue_get
> > >    /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
> > >      if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
> > >        return false;                         __sbitmap_get_word -> nr=-1
> > >      mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
> > >      atomic_long_andnot()                    /* map->cleared=0 */
> > >                                                if (!(map->cleared))
> > >                                                  return false;
> > >                                       /*
> > >                                        * map->cleared is cleared by T1
> > >                                        * T2 fail to acquire the tag
> > >                                        */
> > > 
> > > 4. T2 is the sole tag waiter. When T1 puts the tag, T2 cannot be woken
> > > up due to the wake_batch being set at 6. If no more requests come, T1
> > > will wait here indefinitely.
> > > 
> > > To fix this issue, simply revert commit 661d4f55a794 ("sbitmap:
> > > remove swap_lock"), which causes this issue.
> > 
> > I'd suggest to add the following words in commit log:
> > 
> > Check on ->cleared and update on both ->cleared and ->word need to be
> > done atomically, and using spinlock could be the simplest solution.
> > 
> > Otherwise, the patch looks fine for me.
> 
> Maybe I'm noob, but I'm confused how can this fix the problem, looks
> like the race condition doesn't change.
> 
> In sbitmap_find_bit_in_word:
> 
> 1) __sbitmap_get_word read word;
> 2) sbitmap_deferred_clear clear cleared;
> 3) sbitmap_deferred_clear update word;
> 
> 2) and 3) are done atomically while 1) can still concurrent with 3):

After 1) fails, sbitmap_deferred_clear() is called with spinlock,
then it is pretty easy to solve the race, such as, the following patch
against the revert patch.


diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index dee02a0266a6..c015ecd8e10e 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -63,13 +63,15 @@ static inline void update_alloc_hint_after_get(struct sbitmap *sb,
 static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
 {
 	unsigned long mask;
-	bool ret = false;
 	unsigned long flags;
+	bool ret;
 
 	spin_lock_irqsave(&map->swap_lock, flags);
 
-	if (!map->cleared)
+	if (!map->cleared) {
+		ret = !!map->word;
 		goto out_unlock;
+	}
 
 	/*
 	 * First get a stable cleared mask, setting the old mask to 0.


Thanks, 
Ming

