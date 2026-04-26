Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE4F26ED41
	for <linux-block@vger.kernel.org>; Sun, 26 Apr 2026 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777193431; cv=none; b=BRfTkqxksyaP0WssYuPdIQK6kIKfNjVdzfrHZvdFyC9LWcAt3jGTOqS2sdHF1LhuLqb7mw4SW+q6Xb5c6m39tuDw7l7a6cc+ytz1ZXLKBDHGSS3meepgaSH8DI3qY7X5rytvRsEGq/xHaGUPs6QSfcjh6vGnYvEXXqNs5fOW4IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777193431; c=relaxed/simple;
	bh=G+PJnzDgVRxYWYgflvUDT90jkcn/zpIo+GLsfi5NM8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J+K+4mG+qfVYMBAEmkrOAEZzDqvgFYgLTQ4q0jwbr7CTjRvnwM3Lc71sMp204Pt9xFpLJM1TjzwGlJofXqIsf/ooyzzjm5Pxkwuko5Dvc0Z6s2QSDHUCpCmyMRMKGCrvT0SqISvJ3Nh9djoqrhDcrr/9DzDBGFIxM48FBDp+i2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bURS+Avc; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bURS+Avc"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35fb262f92cso2147114a91.2
        for <linux-block@vger.kernel.org>; Sun, 26 Apr 2026 01:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777193430; x=1777798230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLLuhKCVEEOrdD6a//CB/S5jW1JUUt0Uq70rgzaEoyg=;
        b=bURS+AvcjeJvEqWY3+WAziVvUTkvBk5JRsceS6eRlQ5RqY/PTM0TKi6yYMKfbxG/ag
         UUMAMooGw6wdmY0R8QwULaL0eMn4cLTLMoC5quec2cvVPIaSm709+LwYQt/jSnMbPUWI
         0oKIzwgX/sjpFjcA21d4LJRcNwnAYTQG51gj94GmKYwZkg2AHNYE8hUJF9QvwDvW1l+4
         KBK0Pd9b9/pDtYAbRdNR9bDMhnOENNW3BTkYrYLmcCuNhCG9n/1zKOzMxHO6CaV5ik/g
         z/suGeu6MrhTLexzhU6EbJMqrTlB+ovb4mPYqTbSfOFaAnoJGzNYmzVXYdGohCg8CB9j
         Tcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777193430; x=1777798230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hLLuhKCVEEOrdD6a//CB/S5jW1JUUt0Uq70rgzaEoyg=;
        b=WvpaJkzNW+b6v7zIdD0mtRa6r7sZA4uhMf/i594OHfRs+vlr6nX5B2CjOtKpqX9Ejp
         8JYbObyz4Q4XifEfqBfXDzZsk7JweBYNqW2U3UjY6RHfAxmnrYqw2Jc/knaeh1xGONq9
         3FkA5+WaJjK8GMthxcllvKCLOwNyVpQevfQ8tSUBFN0fGQjXSBZ6SM88Rh0zT7pJOZwY
         XXhrcrHFD17BkKcuy72uHiBL5xNkdIRuwLPmlgsq9nDktlpMd1iEn2G6VlS2MFVQINRk
         LaATq0Y2MHmOqZ9Vr/C/AcdSgC+TtboCnbEOg04VMUvt5u2b7NO+ZFsz8LNUvn/c3TN+
         PwPg==
X-Forwarded-Encrypted: i=1; AFNElJ9GxoVioi99RTlMrQoFGC8WLhHGeBmqWbKyhYJcAoULomG0VFzMrEms8scaCRaLBfjX1qE7bwFnGdxFqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ/tmrJi3CKAoG+0xhAJO4dZr2d+IMiQ5NlYBO9hoofrbNJKJp
	bDcwZ3bKFUGy6csRCsM7NPUWti3RQJrwRsw+/33EMs003tDOw2SDKejn
X-Gm-Gg: AeBDievjyCd9V+wq0Erp8UQDh5sV8Y5eU73B6hVzNbOJJnLitx3dECqDct1G1AdKfn1
	fl/MBg0kbhwradTR7NPG5yvtELKoE0ZiSrgtcEqbH7vZHc0EQb84/noCD2KquEaeT0rZGU9QRw4
	bI5W3JnL6wwwbBKi12rOrGNs/BzHooWM1F2SWhPIRQRZ0VqWIr3SlFCumK51wXquHa3gfC0QS4S
	GgZCOBtPq9IfWTGHByCbCzlwbxX5CSmiY27shX2FOfeD6daHlxFiQyHGJLnqxqsz9CPapZeW5ea
	kIkGQLvYnRoh1rJpdh3/e4WIMA6N1Qr5tTbffnCCai0nY2feX4UHYZN/fcKI/iNXxlWQeTcSgiB
	Hbj/XtcCzIwSU+11QQT9CsbSLrRCI8vO3TRM2YGp/TMSWk/AZqTMqNuF9wk/uOADjPbuyUhKCG1
	bYhO3jxiiiLKi9d78iMznljfhaMxujsPNn4BEZ4TB05XRyKivSqjmRsbWxoUDLMns6bdCf4/wac
	S+pwIdZCXkSDqdoNPVlZh8=
X-Received: by 2002:a17:902:d60d:b0:2b0:4d17:4d6e with SMTP id d9443c01a7336-2b5f9f2d4aemr208572205ad.3.1777193429349;
        Sun, 26 Apr 2026 01:50:29 -0700 (PDT)
Received: from fedora ([38.244.149.186])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa16e72sm272426235ad.19.2026.04.26.01.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 01:50:28 -0700 (PDT)
From: Xueyuan Chen <xueyuan.chen21@gmail.com>
To: haowenchao22@gmail.com
Cc: akpm@linux-foundation.org,
	chengming.zhou@linux.dev,
	axboe@kernel.dk,
	hannes@cmpxchg.org,
	minchan@kernel.org,
	nphamcs@gmail.com,
	senozhatsky@chromium.org,
	yosry@kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	baohua@kernel.org,
	xueyuan.chen21@gmail.com,
	haowenchao@xiaomi.com
Subject: Re: [RFC PATCH v2 0/4] mm/zsmalloc: reduce zs_free() latency on swap release path
Date: Sun, 26 Apr 2026 16:50:17 +0800
Message-ID: <20260426085017.166935-1-xueyuan.chen21@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAOptpSPs-1UrEa8AHg19e590=SiV6bpnex7gCbif8=aY7BtpuA@mail.gmail.com>
References: <CAOptpSPs-1UrEa8AHg19e590=SiV6bpnex7gCbif8=aY7BtpuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Sun, Apr 26, 2026 at 12:13:02PM +0800, Wenchao Hao wrote:

[...]

>2. Per-cpu deferred free with lockless buffer swap
>
>Defer zs_free() to per-cpu dynamically-allocated buffers (~2048 entries).
>Enqueue: one array write + WRITE_ONCE under preempt_disable — no lock,
>no atomic. When buffers full, schedule a drain worker; overflow falls back
>to sync zs_free().
>
>Drain: allocate a fresh buffer, swap it in, reset count. Since
>the producer stops writing at count==SIZE, the handoff is
>race-free without any lock.
>
>Pseudo-code:
>
>    /* enqueue - hot path */
>    def = get_cpu_ptr(pool->deferred);
>    if (def->count < SIZE) {
>        def->handles[def->count] = handle;
>        WRITE_ONCE(def->count, def->count + 1);
>        if (def->count == SIZE)
>            schedule_work(&pool->drain_work);
>    } else {
>        zs_free(pool, handle);  /* fallback */
>    }
>    put_cpu_ptr(pool->deferred);
>
>    /* drain - worker */
>    for_each_possible_cpu(cpu) {
>        def = per_cpu_ptr(pool->deferred, cpu);
>        if (def->count < SIZE)
>            continue;
>        new_buf = kvmalloc_array(SIZE, sizeof(long));
>        old_buf = def->handles;
>        old_count = def->count;
>        def->handles = new_buf;
>        WRITE_ONCE(def->count, 0);
>        /* now drain old_buf[0..old_count-1] */
>        ...
>        kvfree(old_buf);
>    }
>

Hi Wenchao,

I suspect there is a memory ordering issue here:

def->handles = new_buf;
WRITE_ONCE(def->count, 0);

Since there are no explicit memory barriers, we cannot guarantee the 
order of these stores. If def->count is cleared to 0 first, an enqueue 
might end up operating on the old_buf.

This race condition is more likely to be triggered when the size is
smaller. Perhaps we should consider using smp_store_release() to enforce
the ordering?

Thanks
Xueyuan
