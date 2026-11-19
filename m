Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795066518;
	b=YC7vQQBiAs+tmXsYG+BiOL+UFrYrJitw+cQmF4jtyD0o/8ANBxT1+P/gVlw6fdnNPVgQ
	 G5sWEFFLDw8Yr7QqMF7FrSMpP2BZiniNHGeOhXc5XSn2Kn8w33fh3bNEObyHDh1KyzWx/
	 cGdXH1VWI+FNIlocL3f+oXLmta3kX+2HtxNal/EfZHLqhaN5r4k61zc+UGKw4LldVLCyt
	 xEgqRDs1jsflf7IWJbslvEU9qqIL37C61FCYiEWJs8Dc3bqO16wivESmL3tC0DtaPOf0y
	 31TcbmjcHuUxDWONeOEqZIsvGp+zGHT6RERNd7C5uL2wgVFSPonIF8MLFmSTHknGgHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795066518;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=oSA9twBPbKzxpC9yFC1nd7ceP7zJ811GD8sMG8gtFe8=;
	b=SU0bb7jTcAUg7G4CHQ7UdLqI5lLauq9I5YOcy/Q4Z29loak0EwN5rUqBIZU0cPROThjZ
	 Dk1Pq3nnUgtS85Ke3IpC1mUOAwIl7Fs2Cxo1b/OlWV7+k36rh6JbrdDoDUaMVHs2QP1Z4
	 b2PdEp3ptY9zGCAvfFiht5Nr3zRvbYwurFHtVkQgXMwPDN2gjmgv33hQnEMBUsZAzLMFF
	 vDgd5wlLaIqQtwtuO5YWtmyMNk/Hpbm5Bk3csyzQJl3p8EWS87DUghZe+qAoEQhedeXnf
	 mgiPwQW8CEf8xnT4wUDol0Z3vKoZ8F4NMuUHbsK5t2WjP2L6xDpzjkxy4D2bxPjYD4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=n3B7X119;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7841606A320
	for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 05:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7841606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=n3B7X119
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso463075a91.0
        for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 21:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795066517; x=1795671317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oSA9twBPbKzxpC9yFC1nd7ceP7zJ811GD8sMG8gtFe8=;
        b=n3B7X119304Lmb0WoiA2oXzi52VRjMnHw5oLi783dUdR6HUHkItCRlEojD6g6tFx3w
         V+7pZM4vSiozIzrCJJOGfLxjt/xDHpCF7Skow7YYZhmBQfqyuL8JwWajlnMSOXdmkPbP
         mjylZutqwCkNp9xAtBFFHg96pRSGmSNRBAhgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795066517; x=1795671317;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oSA9twBPbKzxpC9yFC1nd7ceP7zJ811GD8sMG8gtFe8=;
        b=ODrzn7d05TCLnXAL80i4v9DGL8fC6wvWCYYp8n8PeRcFQtUZl/m6MYe+qyWq2iGPG2
         xjhiP7FUSlcsrXnXId6j+VETbfCSGduSPqVnDSe8oEs9zgCl8I27nZnw0igdaLK42YD5
         d4NofPnbDtUAYJiS6Kqi4TV7qza90bYPQf9AK2LrCGx5591MKq2vf+k9rs7evMD974gM
         Tvt36UDjThi4KaoLn6xsWDls+b6G54rnab9CRLCtVqoQcmNTqVzYHdm5KQjFJoYzWI3I
         rw3ev2p56DnQJcPzsn3TGZvJQ0ykveUHfqcuL3iHaZGER13cK1snjQW+JRzGZox2pCFF
         6/qg==
X-Forwarded-Encrypted: i=1; AL+hErFVnNJ6b6e+erLk0A/PnVSsfVLAtDxRI9fP0gDxvsTqDpHiuYzg1tOnFLjptCHe/S2TaGBTG7iTyOFqiQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z93VM6Y/Rts6yu7QGTDmnTb/Hu2kpaExwtAJZqRjTLKY92b+2Qn
	2vr3l0vhr3Ak6GWk+SG2RTKIWe/JZZ3ChvQUoUTFJrQ8qSISsa889sy2erYeCdfyGQ==
X-Gm-Gg: AZFdTZddrxn481jnfTiQVyMZciqfdqG34uWVCoIneIoFR45mfvts9e9vh8/18g1+VWS
	+tpu3eS0v2iOJgRggUKmvVfduAkodv1MXJjWA5/ayfTg7VzuqiJXHZ3CyhxC6u+ohsMpl3MLUu3
	149PHxPjBLwYdLShTMlV8C9s5lE7IzNpKqJ0nfmbkts/cxtdNusXK2VDPP2NO8m8jfiidt4lDvF
	gzRKQFzGxLKJyePs13OqwWuwS80WeWRWdevCed1OeiDRkTFjAbIYq5OYzt5Vq3OkUec8F6fT8oi
	2GdWsiM+O6BZvqSp//nIuYK9Q0nxbueCI2iDJt3FTVlM1hINYxz8tzKVQPVx1ch//A/Pyl+w2uU
	UkfHQAbeqKGqBeEGLYnFpQTJ24IoBQJqmqROxPETvQmxudWjfJEDqLKlZX9dsnn28t5io/bxmAY
	Fnz+QL3XkaHjy9Z1HCZ1bEFEf9rGtYE8qGnhLL+OoyZC04MMdl+qQXWnZnVZqm5PlNQ/rF/HOQv
	KdDX51AuaLY0pPwzdjZOZGIBhCapPnOcUVoA6ysNyuUhpjPNAFxI5DjPBHAru4gfHVKs7RjFW8V
	Q4R87Y8cnDMAyCCqHBXiL/rpvnYrrAha8X26p/8JhN7T2WXUnpnWcZkPUCKRb27I3Iq0tA==
X-Received: by 2002:a17:90b:4f4a:b0:3ac:84b8:c0d0 with SMTP id 98e67ed59e1d1-3b40a62dc20mr36559a91.47.1795066517234;
        Wed, 18 Nov 2026 21:35:17 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:9297:4989:4c44:dad6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde534aec9bsm1050833a12.22.2026.11.18.21.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 21:35:16 -0800 (PST)
Date: Thu, 19 Nov 2026 14:35:11 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Hongfeng Chen <chenhongfeng0212@gmail.com>
Cc: Nhat Pham <nphamcs@gmail.com>, 
	Hongfeng Chen <chenhongfeng0212@163.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Barry Song <baohua@kernel.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed <yosry@kernel.org>, 
	Wenchao Hao <haowenchao@xiaomi.com>, Wenchao Hao <haowenchao22@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Hongfeng Chen <hongfengchen@xiaomi.com>
Subject: Re: [RFC PATCH v4 0/2] mm/zsmalloc: defer object free to per-cpu
 batches
Message-ID: <av6JvaCh358eSMCw@google.com>
References: <20261016120927.3191690-1-hongfengchen@xiaomi.com>
 <20261023123736.1542117-1-chenhongfeng0212@163.com>
 <CAKEwX=M4jTnxmq6cj115Gw4u5jdY7Ex65jPtVTEopW70jGzfuQ@mail.gmail.com>
 <20261109105957.2577351-1-chenhongfeng0212@gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109105957.2577351-1-chenhongfeng0212@gmail.com>

Somehow your emails landed in the SPAM folder.

On (26/11/09 18:59), Hongfeng Chen wrote:
> On Fri, Oct 23, 2026 at 11:19 AM Nhat Pham <nphamcs@gmail.com> wrote:
> > Is there any more juice we can squeeze from zsmalloc in that case?
> >
> > It would be nice if you can perf zsmalloc freeing. And yeah, maybe we
> > can't optimize any further, but let's eliminate that first before we
> > rely on offloading.
> 
> Here is the perf breakdown of the free path:
> 
> zram:
> 
>   __swap_cluster_free_entries        90.28%
>     zram_slot_free_notify            86.01%
>       slot_free                      74.15%
>         zs_free                      56.01%
>           __free_frozen_pages        19.85%
>           kmem_cache_free            10.15%
>           _raw_spin_lock              5.53%
>           fix_fullness_group          3.31%
>           dec_zone_page_state         2.43%
>           obj_free                    2.17%
>           trylock_zspage              2.12%

We removed one of kmem_cache_free() from zs_free() [1].

[1] https://lore.kernel.org/linux-kernel/20261110054836.1515030-1-senozhatsky@chromium.org
