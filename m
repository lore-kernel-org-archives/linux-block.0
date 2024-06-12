Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35511A47
	for <linux-block@vger.kernel.org>; Wed, 12 Jun 2024 00:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718153513; cv=none; b=nELGIotEbmwi2MJ+7VSjad0VNGkSA83AQuHYzklHZSkhfV5tRIZ6vGcx2ML9X4hwZyz4O/JJyrvaxS5AgkFEsq5VbVfxIjP6ODX/kA6AprfBqu3gfWhfF9v5g7DPnDJBfkrVClEwLiNluvdncQ6sl2Tpj1YWFW1gVO720E9OuT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718153513; c=relaxed/simple;
	bh=4BUd3gADcxPVhLJ7UT3ehfVLhvQyFL/fDHi1OnGfB3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDltZSI5CFpFo1A2Mi5lP0nWN8eCGxX+H3cWaVC9HP4fg2WPij7yOI3Fr6kuX0Tmlc7wp23hPQEIAIUWq/sDRczbqvqGWkgWLx5E192md15T9ntybYBjRTPtZ1wHUaZbetRwtxTyVp54KpKOVcVhYCAw3VPYV3GWeHzFdHwnsco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NYM9TAZV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYM9TAZV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718153510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+cbImfAE6LYVQTuajTns2CjgdcBogG9TUuWs4/d0Geo=;
	b=NYM9TAZV7n0LgFG9Si7ytZRe34Dav+67yj6nJbPyTPTdqcfAi4/4RU82cnF6br3tNt96mL
	aCudCMWjxZRLUv2mi/LhKfnyrpKwKkLwboR6ZUiKYGYDhpQZFRabkGeNH/guRnMAhhpFf6
	IqoWdcCGpbj3p0WSYPEw0JzaDN45kJ0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-fGvMPbaCMmChERhGluNRlA-1; Tue,
 11 Jun 2024 20:51:47 -0400
X-MC-Unique: fGvMPbaCMmChERhGluNRlA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45A91195609F;
	Wed, 12 Jun 2024 00:51:45 +0000 (UTC)
Received: from fedora (unknown [10.72.112.75])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5161F19560AB;
	Wed, 12 Jun 2024 00:51:38 +0000 (UTC)
Date: Wed, 12 Jun 2024 08:51:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: YangYang <yang.yang@vivo.com>, Yu Kuai <yukuai1@huaweicloud.com>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v2] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
Message-ID: <ZmjxFZ1Pt1CvNetL@fedora>
References: <20240604031124.2261-1-yang.yang@vivo.com>
 <CAFj5m9KV7OJ4_KjbSkpdtfrKamoLzV6EH-mJP3=y+VvoYOzC3w@mail.gmail.com>
 <aa7246f9-f7df-3054-077e-eb21c7f423ac@huaweicloud.com>
 <e1cdf579-007b-415f-9e4d-3fadd6f97b36@vivo.com>
 <cf8bb1db-b601-4f54-bafc-d6c58f6ce946@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf8bb1db-b601-4f54-bafc-d6c58f6ce946@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Jun 07, 2024 at 01:59:07PM +0100, Pavel Begunkov wrote:
> On 6/4/24 08:03, YangYang wrote:
> > On 2024/6/4 14:12, Yu Kuai wrote:
> > > Hi,
> > > 
> > > 在 2024/06/04 11:25, Ming Lei 写道:
> > > > On Tue, Jun 4, 2024 at 11:12 AM Yang Yang <yang.yang@vivo.com> wrote:
> > > > > 
> > > > > Configuration for sbq:
> > > > >    depth=64, wake_batch=6, shift=6, map_nr=1
> > > > > 
> > > > > 1. There are 64 requests in progress:
> > > > >    map->word = 0xFFFFFFFFFFFFFFFF
> > > > > 2. After all the 64 requests complete, and no more requests come:
> > > > >    map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
> > > > > 3. Now two tasks try to allocate requests:
> > > > >    T1:                                       T2:
> > > > >    __blk_mq_get_tag                          .
> > > > >    __sbitmap_queue_get                       .
> > > > >    sbitmap_get                               .
> > > > >    sbitmap_find_bit                          .
> > > > >    sbitmap_find_bit_in_word                  .
> > > > >    __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
> > > > >    sbitmap_deferred_clear                    __sbitmap_queue_get
> > > > >    /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
> > > > >      if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
> > > > >        return false;                         __sbitmap_get_word -> nr=-1
> > > > >      mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
> > > > >      atomic_long_andnot()                    /* map->cleared=0 */
> > > > >                                                if (!(map->cleared))
> > > > >                                                  return false;
> > > > >                                       /*
> > > > >                                        * map->cleared is cleared by T1
> > > > >                                        * T2 fail to acquire the tag
> > > > >                                        */
> > > > > 
> > > > > 4. T2 is the sole tag waiter. When T1 puts the tag, T2 cannot be woken
> > > > > up due to the wake_batch being set at 6. If no more requests come, T1
> > > > > will wait here indefinitely.
> > > > > 
> > > > > To fix this issue, simply revert commit 661d4f55a794 ("sbitmap:
> > > > > remove swap_lock"), which causes this issue.
> > > > 
> > > > I'd suggest to add the following words in commit log:
> > > > 
> > > > Check on ->cleared and update on both ->cleared and ->word need to be
> > > > done atomically, and using spinlock could be the simplest solution.
> > > > 
> > > > Otherwise, the patch looks fine for me.
> > > 
> > > Maybe I'm noob, but I'm confused how can this fix the problem, looks
> > > like the race condition doesn't change.
> > > 
> > > In sbitmap_find_bit_in_word:
> > > 
> > > 1) __sbitmap_get_word read word;
> > > 2) sbitmap_deferred_clear clear cleared;
> > > 3) sbitmap_deferred_clear update word;
> > > 
> > > 2) and 3) are done atomically while 1) can still concurrent with 3):
> > > 
> > > t1:
> > > sbitmap_find_bit_in_word
> > >   __sbitmap_get_word
> > >   -> read old word, return -1 >          t2:
> > >          sbitmap_find_bit_in_word
> > >           __sbitmap_get_word
> > >           -> read old word, return -1
> > >   sbitmap_deferred_clear
> > >   -> clear cleared and update word
> > >          sbitmap_deferred_clear
> > >          -> cleared is cleared, fail
> > 
> > Yes, you are right, this patch cannot fix this issue.
> 
> One other alternative is to kill ->cleared. It's not
> immediately clear how important it is. Do we have any
> numbers?

Please see commit ea86ea2cdced ("sbitmap: ammortize cost of clearing bits").

```
In a threaded poll test case, half the overhead of getting and clearing
tags is removed with this change.
```

Thanks, 
Ming

