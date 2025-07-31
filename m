Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9757CD515;
	Thu, 31 Jul 2025 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753976457; cv=none; b=Ss0FQOA9u46IbJ87Sb6snKg1q1nKKUDL73puPUnUiHItJVMskq2K/XuSU8t+cMB+X5LS661WRGCz/3yD8Xj+isdWLwNkmxbhC0gVjJdcG5UsE9dWakR5yd+BC29oXytEUHH3R3EGoRbsJYRActjVS2kOfft2JB0Tl4nSPIwNjWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753976457; c=relaxed/simple;
	bh=snpfnB2u0qDqMruJo552AP5LezEAdyTiUuMSNOlOYys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2XvCOdGGg3V8VpueoV5GWp/s4KuQF7w6lcbXiQ6ojd5NpbknXnqlGoHH6TpU3a8dpyT4MEwCCupIYFnUYbE0Oc0k86SU6NXlcK2T9vYm2NDQiNLTg82Hyvi1hLdH7KFUiaByb8xRxfxkDrTvcEUrMWC3AMtwv9YlvPks7dKacc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAKcuXDk; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAKcuXDk"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76b6422756fso911984b3a.2;
        Thu, 31 Jul 2025 08:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753976455; x=1754581255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnI/pC2FOUpLrTb2n3FGcI/c4+jS6eu9eY6xd6NHIOM=;
        b=FAKcuXDkgj9ciEZBRBkNSO55XFDNNqsnXyqHoh7jzvuGPDzfNn/N/Sij5ktehG6xFz
         acH4Xox/5ffTNoYCv+43Mmz0qrPzbfFd6tCnB3V9lAFkBPEchd7Y/4iIicp+q4kf9LZM
         EwNWChF6gAtb2bDGIPFlXRx52xAUoiEue4aHAWsZuweMOgjM4y02kivmaOunZvlnBXxu
         f1bt0ftKRUhi54gvcZs5f4Mc0a/p0/bZ9ViKaT1cX47w77OQ2/FoQiriBBxJhNwC5oxN
         oH6/qzh/o5qcTRBE3dezw5chJc8L80WlGiTtzOSOD9PxffMSSIGOedOk8WhA1opRk8lV
         x2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753976455; x=1754581255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnI/pC2FOUpLrTb2n3FGcI/c4+jS6eu9eY6xd6NHIOM=;
        b=aJhXA/i2ysD3VlH13iAVeS9wayJfpdJ9snCCbTUzc9DM3w1ZlhDQM2f8pnyp5t7oti
         uHV6LyQ5+eSxqsUBabsW08ePtzXx5uz/uQNITgCR4ktg2psKR5PZEExzJGCiyJhCrAZC
         yoZHRtsPOmaTxID7biDGSjtiqLSs7lQg6pbHZr+fQX6elGi4XKS3tbt9uAuKolazZ+6C
         9SL/kxrOSGVLIWroyohe5hVomNQ1wNOy/srQsX7EIxn+z06MnWhAE5Fknuok2CT8I6N/
         sk767IyzRc7kd5z255sb4i0SRbomuxAmbENLRsX8wu1RNKEv/8H7wJVVdtSf4q/9qLcG
         ScKw==
X-Forwarded-Encrypted: i=1; AJvYcCXsPdCdiczUulB5npIX2U6vvkyU39vJYjTLu2QnI0xBBdql+/54j7oN/besYjBi1NORyumzzyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8hB2oyLkAu1trWuupMEVs1zZXgA/wHXl1p0azpN9m4TavegxO
	LlcFeJXJNg0TUsSGwWNsW71rMoU6DrTHHXduUecLLsnWaOPev9toJav457rMy4NOXMDQGdnUglD
	HYIMeYRF4ILmjtxhkA+Kaiy8h4712Xk0=
X-Gm-Gg: ASbGncvS1e8TLAK8HtBbSvfH5iAJBUpoNIFrg7+vPn7R5b1O5rN97BYMCC9oXwqu1TT
	ZjBFUkXhBC1H/AM19jpreuZpJDjDIGjLWjx0fq/odkR2K3vMmBgLPZosGquGSO42v71PQ/SWxt5
	8Oyeaw/YkH+m/s2Nw11m8ThdCTBXXcn2GwMs0CmoBFi0hSTwcP5wyd8dUoH07IDfj8tlCJuplGO
	borsnY4euTpqM5z8ScWuhr0x7+7ftEko5a8+kDB
X-Google-Smtp-Source: AGHT+IFv7YNcQGxUy1B/6TDXI5tQDSKEhIH32T+Y8wS2g++R/BZ4t/pufUlMpUonepN8gUVM31bl6g37IEqPU2t1ShE=
X-Received: by 2002:a17:903:a8b:b0:235:eefe:68f4 with SMTP id
 d9443c01a7336-24096b23822mr124021265ad.29.1753976454739; Thu, 31 Jul 2025
 08:40:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731123319.1271527-1-sunjunchao@bytedance.com>
In-Reply-To: <20250731123319.1271527-1-sunjunchao@bytedance.com>
From: Yizhou Tang <tangyeechou@gmail.com>
Date: Thu, 31 Jul 2025 23:40:42 +0800
X-Gm-Features: Ac12FXzWBNVaaDJRff4TEzyPEHnvD51rDphiIy0QsXQ1hJ39M3JnxzvaSsyqxtI
Message-ID: <CAOB9oOZV5ObqvgNxr9m0ztm7ruM9N9RMi8QHmiG5WL4sNbLxuw@mail.gmail.com>
Subject: Re: [PATCH] blk-wbt: Fix io starvation in wbt_rqw_done()
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, stable@vger.kernel.org, 
	Julian Sun <sunjunchao@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Julian,

On Thu, Jul 31, 2025 at 8:33=E2=80=AFPM Julian Sun <sunjunchao2870@gmail.co=
m> wrote:
>
> Recently, we encountered the following hungtask:
>
> INFO: task kworker/11:2:2981147 blocked for more than 6266 seconds
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kworker/11:2    D    0 2981147      2 0x80004000
> Workqueue: cgroup_destroy css_free_rwork_fn
> Call Trace:
>  __schedule+0x934/0xe10
>  schedule+0x40/0xb0
>  wb_wait_for_completion+0x52/0x80

I don=E2=80=99t see __wbt_wait() or rq_qos_wait() here, so I suspect this c=
all
stack is not directly related to wbt.


>  ? finish_wait+0x80/0x80
>  mem_cgroup_css_free+0x3a/0x1b0
>  css_free_rwork_fn+0x42/0x380
>  process_one_work+0x1a2/0x360
>  worker_thread+0x30/0x390
>  ? create_worker+0x1a0/0x1a0
>  kthread+0x110/0x130
>  ? __kthread_cancel_work+0x40/0x40
>  ret_from_fork+0x1f/0x30
>
> This is because the writeback thread has been continuously and repeatedly
> throttled by wbt, but at the same time, the writes of another thread
> proceed quite smoothly.
> After debugging, I believe it is caused by the following reasons.
>
> When thread A is blocked by wbt, the I/O issued by thread B will
> use a deeper queue depth(rwb->rq_depth.max_depth) because it
> meets the conditions of wb_recent_wait(), thus allowing thread B's
> I/O to be issued smoothly and resulting in the inflight I/O of wbt
> remaining relatively high.
>
> However, when I/O completes, due to the high inflight I/O of wbt,
> the condition "limit - inflight >=3D rwb->wb_background / 2"
> in wbt_rqw_done() cannot be satisfied, causing thread A's I/O
> to remain unable to be woken up.

From your description above, it seems you're suggesting that if A is
throttled by wbt, then a writer B on the same device could
continuously starve A.
This situation is not possible =E2=80=94 please refer to rq_qos_wait(): if =
A
is already sleeping, then when B calls wq_has_sleeper(), it will
detect A=E2=80=99s presence, meaning B will also be throttled.

Thanks,
Yi

>
> Some on-site information:
>
> >>> rwb.rq_depth.max_depth
> (unsigned int)48
> >>> rqw.inflight.counter.value_()
> 44
> >>> rqw.inflight.counter.value_()
> 35
> >>> prog['jiffies'] - rwb.rqos.q.backing_dev_info.last_bdp_sleep
> (unsigned long)3
> >>> prog['jiffies'] - rwb.rqos.q.backing_dev_info.last_bdp_sleep
> (unsigned long)2
> >>> prog['jiffies'] - rwb.rqos.q.backing_dev_info.last_bdp_sleep
> (unsigned long)20
> >>> prog['jiffies'] - rwb.rqos.q.backing_dev_info.last_bdp_sleep
> (unsigned long)12
>
> cat wb_normal
> 24
> cat wb_background
> 12
>
> To fix this issue, we can use max_depth in wbt_rqw_done(), so that
> the handling of wb_recent_wait by wbt_rqw_done() and get_limit()
> will also be consistent, which is more reasonable.
>
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
> Fixes: e34cbd307477 ("blk-wbt: add general throttling mechanism")
> ---
>  block/blk-wbt.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index a50d4cd55f41..d6a2782d442f 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -210,6 +210,8 @@ static void wbt_rqw_done(struct rq_wb *rwb, struct rq=
_wait *rqw,
>         else if (blk_queue_write_cache(rwb->rqos.disk->queue) &&
>                  !wb_recent_wait(rwb))
>                 limit =3D 0;
> +       else if (wb_recent_wait(rwb))
> +               limit =3D rwb->rq_depth.max_depth;
>         else
>                 limit =3D rwb->wb_normal;
>
> --
> 2.20.1
>
>
