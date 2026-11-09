Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794222010;
	b=njZqeacBYOXRvH0b7qK9yJfvQU7WjNOaF/JS+SzprFhZ+d9QlUNOcnlyTYHMumDDhL/U
	 wDTHcBEQ8dk4exItVu4Ux9u+ZXS+PnBFuJz8Qd8Ydwl/XXTCh+T6BoIhy9My8PLLfAxky
	 /jHjPuwNYzUuUlNgeqiuJJ4Qp+Wfk5/0+m4JFwokyHUDD89O/gV6jlj8Z4qOOUXo2RXbt
	 BSKL8Fn7n8WnirrDi6brjZ1Zn7RrHoZE/N2/ejllGyTMYnXY2vpt/3QxQr4KUbVgT5f4V
	 EYeKlOtEGXMSodJj0iKWnp3NoNgF78nLwmwzE34Olw9roImzLOVYyS9Lcpd5EG8WxdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794222010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ElXE6Czu3kJtnBp4J8hepfVFWJpvs2+YyAeDoXoHd4Q=;
	b=lVB8+/kgSGTwmEwULfyxOnOIdZrCrafF6gx9AGAhwlv0rajUAzJnDZwEpjXdqXswhEt7
	 4bTr/3cZs5HFNrgEVPKgkLDzHXPWTx2OVfWV8ouAXWcfe4rt3tRPBZrh+X/ow6+yiTDfA
	 gfBeTjX21Ud5HP79cFa+J+uPcEvFpbAkNN0wnxxgrKFjNlJaqTvxVDbBWJ+kWIOefpJ+p
	 whxIepqFPOnF87jy/MNO/5FAFnziMKvCcY+8faGr7d4mwM/41aKf3xW6Q3hS3rlkXTP2c
	 c1YRA0rB4f04tAzxD9GRGgcgySz+B7GM5BBG0yiy722Zsoda1wM1457pCL3U67mFKBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oG7oDRzE;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2BD606A330
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 11:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F2BD606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oG7oDRzE
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so1492894eec.0
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 03:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794222009; x=1794826809; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ElXE6Czu3kJtnBp4J8hepfVFWJpvs2+YyAeDoXoHd4Q=;
        b=oG7oDRzEqlj9IqURnOyQtZsM7QJeODStDhyG2uQVdblnfvxu6nLFjyje5IHZeANfIj
         YrT33mX+0voC65lpjBYHCDwumyWa8uM6W588NL+gKtUSMwWeL+a9FIx/vrsqBWgSLsK3
         5G/GjFFcA/nGTrRe0AOqmca8DVVsNeVEcXaDex5wOXVtZvvlNWNZDh/BLUPoN0AaZqoF
         lcDbjw6JfpOu2zjphkQgzlWFa21BDidBGCD7Y48JwojeRIMrJzKBbQmVnobdBfHIdqjc
         lj/1pdkqVCUZ1jqZTMq0qCB99y/QytEKr7KSfEF4UKWTQVR0j65UnUE2ULpbcJOR+rtY
         /OiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794222009; x=1794826809;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ElXE6Czu3kJtnBp4J8hepfVFWJpvs2+YyAeDoXoHd4Q=;
        b=Gvtj+c2/CoNK96qzJpPNwiE6KeJbAPvBCGr7z5D0so6UYMliseG5LJZ8o940mc8U0+
         4dtbpdV10WHjVhbYLDS5kORn/2h71EjytuIcVPaQBcUqO7VXvO8WGK/bY+zPTeezG/CV
         GSxTE6IDIvw3CjTCPCF7BZbdMOU0uzi4eXAL6uAkgZwrsZW/o35tZW8ml72Qs1kWig84
         MBKGtwEdA7HqmC/UUbfGxtfl+UahEJM2bs23fv9BPcPyV1uNmc1EYHjhXYM+XAg9cUar
         pYAuDScx4M0MyfGtDOSs3dfQ+dvyBOK0hpZQu2mYIPkfovQxp1EPA4V+6cbV1bOxtUx4
         8eNw==
X-Forwarded-Encrypted: i=1; AL+hErErdKsZQvoqDc/qRdVQJL9lj/JqvWMBxlhuJUXC6iTR5hEuXrjUKY01sbe1HP1rPadmxrXuBZ2c9j8azQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9VKuy+fH7YRdqVS7R35sUaTQim9rgj6Us88bbQoUotoPKDFMdC
	0O6iNegZ5GAgB/mpj3pg6/vmbsfMKLBo/gHulVMHLRP8JKzliRnYlKsM
X-Gm-Gg: AYBFou0r3JF6I+wag7jn8YqxCZR3qgfhIVCd9BiVunTiFnFXJdeKTQymbGFyZpubv39
	SXU7Q39k6tynXToA0H538uIDq9KnIzHjPGC5rO2aRp5Iwf5M2u1jAJKNo1AwGN7/71aAoTGghOF
	C2ZoFkKqEj8pRFTdCy5reqM9+rMkQnbV6ANH4T+Z/miG1Jjkdxt/rSS4ClQVBCyGR/LhVebFHcr
	ZQfBPwUyviW1/y2HWwdiV41eOrhy1VKzUoSW8AJL9iJZ8VhCekXAdFHZmwaFcXbG+IbxKi49/rX
	IjzqPWumvc7QAkCqbMF06rT6kt3/94UnbWg+r0qaVw/rztwcWBGmlIWDzolB+qEnw1pdNPMk3eH
	hWs4ZgYnpHYtlFzdtFWn5nIcEmyoz4TXBNO3B/QkFzP+0bFX35i75Nz8p+4x59CpgX0nxtlARZE
	3vAwA2rKb8n0Yr8CUnIAJgZR4JB5nnMQIfOY+JhMaeX0suLyYPhXp/v9hqJf64wbDRmFZmMdZF7
	riC5DcuGNG9z9pwVRC7QTL5LfSpU1bX7dFWUrgx5khMCMGHZ/SUkliSZS1H4Hg9fo2g144BtfBM
	aAaNTcu+JIJhuri+ebQgX04NV6ph7BFnHlb7/USsjvGgIfzLzg==
X-Received: by 2002:a05:693c:8808:20b0:36c:9e26:88b6 with SMTP id 5a478bee46e88-37256613f82mr6129121eec.9.1794222009245;
        Mon, 09 Nov 2026 03:00:09 -0800 (PST)
Received: from hongfeng.mioffice.cn ([43.224.245.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37265c06c61sm11832518eec.14.2026.11.09.03.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 03:00:08 -0800 (PST)
From: Hongfeng Chen <chenhongfeng0212@gmail.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Hongfeng Chen <chenhongfeng0212@163.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <baohua@kernel.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Yosry Ahmed <yosry@kernel.org>,
	Wenchao Hao <haowenchao@xiaomi.com>,
	Wenchao Hao <haowenchao22@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Hongfeng Chen <hongfengchen@xiaomi.com>,
	Hongfeng Chen <chenhongfeng0212@gmail.com>
Subject: Re: [RFC PATCH v4 0/2] mm/zsmalloc: defer object free to per-cpu batches
Date: Mon,  9 Nov 2026 18:59:55 +0800
Message-ID: <20261109105957.2577351-1-chenhongfeng0212@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAKEwX=M4jTnxmq6cj115Gw4u5jdY7Ex65jPtVTEopW70jGzfuQ@mail.gmail.com>
References: <20261016120927.3191690-1-hongfengchen@xiaomi.com> <20261023123736.1542117-1-chenhongfeng0212@163.com> <CAKEwX=M4jTnxmq6cj115Gw4u5jdY7Ex65jPtVTEopW70jGzfuQ@mail.gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Hongfeng Chen <chenhongfeng0212@163.com>

On Fri, Oct 23, 2026 at 11:19 AM Nhat Pham <nphamcs@gmail.com> wrote:
> Is there any more juice we can squeeze from zsmalloc in that case?
>
> It would be nice if you can perf zsmalloc freeing. And yeah, maybe we
> can't optimize any further, but let's eliminate that first before we
> rely on offloading.

Here is the perf breakdown of the free path:

zram:

  __swap_cluster_free_entries        90.28%
    zram_slot_free_notify            86.01%
      slot_free                      74.15%
        zs_free                      56.01%
          __free_frozen_pages        19.85%
          kmem_cache_free            10.15%
          _raw_spin_lock              5.53%
          fix_fullness_group          3.31%
          dec_zone_page_state         2.43%
          obj_free                    2.17%
          trylock_zspage              2.12%

zswap:

  __swap_cluster_free_entries        94.30%
    zswap_invalidate                 93.49%
      zswap_entry_free               73.76%
        zs_free                      34.03%
          __free_frozen_pages        11.13%
          kmem_cache_free             5.57%
          fix_fullness_group          2.66%
          _raw_spin_lock              2.45%
          trylock_zspage              1.75%
          dec_zone_page_state         1.67%
          obj_free                    0.96%
        obj_cgroup_uncharge_zswap    13.90%
        list_lru_del                 11.73%
        kmem_cache_free               4.62%
      xa_erase                       19.27%

Most of zs_free() is returning memory: empty zspages, handles and
zspage slab objects. So returning memory cannot be avoided, it can
only be batched or deferred.

In zram, zs_free() is 56% of the time, so deferring only zs_free()
can speed up munmap() by at most about 2.3x. In zswap, zs_free() is
34% of the time, so the speed up limit is about 1.5x.

That leaves two places to go further.

1. Async freeing at or above __swap_cluster_free_entries()

Deferring at or above __swap_cluster_free_entries() covers zram and
zswap with one mechanism.

2. Optimizing zram alone

For zram I would rather go back to v1 [1], which defers in zram. v1
also uses a single gc_work per device to offer a best-effort service,
which greatly reduces the impact of the unbound worker on other
tenants.


[1] https://lore.kernel.org/linux-mm/20260412060450.15813-1-baohua@kernel.org/

Thanks,
Hongfeng
