Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029CA366559
	for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 16:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656597; cv=none; b=X1/8lHNiGJzFLxUWrKCrm2jwNI6BxrKfCmjXLiHIEEYHt0HBEUfwu96n2FWTRbvSj1X8M/iBnvA+6BqXrZ1l3wya0olhJbX3hFvryUkWt8aWvzWc7nSC9FIk9d5OqjprCcW3LGMzliZ7yPdXwKFpa62U51ujdDgAek/mtul4CGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656597; c=relaxed/simple;
	bh=GInbIS5G+JZq7IipI+78v+dnRpDfqWLXzSuGDRs23JA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2lUdg9b8K30+M9PSOUcZ7W91h2/YZ+pGkAPLD2AaFSa33HIS+o+k3Ug8tmjzM5PUfA+VBQ7KT3Z/lQ84L9gYsrBCS+KKSeZ8t2AzkNV/kdFDXbRfzD3JSMwZ/l+NtfMba5pbA84ZH2RoWwPs20VcPH64B/HYVJFLJ+o/2Hhn7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JLj38qxh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JLj38qxh"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-297e13bf404so234705ad.0
        for <linux-block@vger.kernel.org>; Thu, 20 Nov 2025 08:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763656595; x=1764261395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MI69GlEKOdT6dKGc/fqL6NZfHR0DisLkriIWy/ff1KU=;
        b=JLj38qxhkNSeqSYwfrpoDZI3B8Dw3zHB42AUU4rPWH+jygEISmiY2pB0mnxdPn16wb
         pr9Pky7EVVwA2Wvk8b88NMTuXF8rTy5/r8ddFPvvZxf6xqEBL4AClPUvyzIVZD5Ko8fc
         MbliGDGP4YShBsj2LJ0zDCyI+XI4iHnVvx6i34N2Q+8t8H4EgaJBtT9eD623l6hoZqXA
         37LhaqGLSMDhssqqn6FDCyqacdGu4x6pS2GulV8uLQ8Wod0xIrN+RtC6/a4HYeM1W9ji
         P3iti/VfPuRFtJw7RTpLnDiRThND31moR40wAdNNHxKIllEsXGN0cOtLNw8rH7ETWHWw
         KZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763656595; x=1764261395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MI69GlEKOdT6dKGc/fqL6NZfHR0DisLkriIWy/ff1KU=;
        b=MSeIZ3k01YPF87LNQmOHjfIoLFbhTePAZrcgBmBGmG9PZkMzeWmYPAX7Qkaa+F7AQJ
         QEgO9nauZfrPX3Xhb8//cHXG6SjQHaMQZ2fOe2XhRDiBOLA5Yq/92/pnQI8cP/6LjrOv
         ZSkWenEK8HKEo521BgRCszXpzLWLpKP++d3Y6FjmKby29M2n0PQDWj6k/93BTac53/5o
         2eyxWazFk5IbmmgYENlCAaOa3njs0nR16oPkzxoMhI3GV1mnNwyT5RBrJGknYnL+n0Yu
         QuR21kr33JbI6mQu2g/4QE6ZjweG/+3oUTF3Ph7RzyUGEe3Wu8rLSQrDrXc6HLXaXp+b
         Kzlg==
X-Forwarded-Encrypted: i=1; AJvYcCUupPxbdvlE+M0AIoSulRB2ahzDwTeirq1cbAKqYoQk4O1/4kJr6rdQ0x2cCJd4XD0rxQwB5lCLlg37gA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHG2NPOTewe42N24421wJsytRp9nmfV3DTdBxP/9iLZnpYr41q
	/lMpfDFWTo+sJwTX5zFl8f2v0OJKZFplOESlv9dMSsJ9BOhcQemzkXHMOEsFWmHJX/zz6SEZhw3
	wubWKwYiawyoT3wlmkU2wJmm9FoGqwpw7pMQBANTx
X-Gm-Gg: ASbGncuqwhtq2DxHtGzp0v4RxaXFctRUw3TFYPcTh8cDpZoKSs1kO9XjaY8ZFQSJZsI
	ebm3yEdhrTL8Qey/KV6cYs2AcRpMYUllOGAfkqmm2PQ+1ALZ0BEwW+vJMNhhzykHAXjSfQOpXCe
	e/3YAFZED+1Fs64bSh7K8e7SfoqbqjLdlM2Tc4PUdR4NZFWc/FCGC3UG2AuTxT8P+jDNJS3GYrl
	k3AWDmJXL3OFGvXdR5eWQCc/nncHx5QO40698H+dzUrMurdKHFutCmavv6FAdhpYzXVM3QclcM9
	Q45kCYeWGHS9FSUsvQPptrR6xL50+psuBWhSYoHuo5xI3iPd/UB9eL8=
X-Google-Smtp-Source: AGHT+IHwbZhiTefJHOcoxsF0WPPJxsxN9tQq29Zp/xNBgglgSM1gNp7NoJsF7O880AqiUsYvqO+T4BOUMSNMohb/Nbs=
X-Received: by 2002:a17:902:e54b:b0:299:c367:9e04 with SMTP id
 d9443c01a7336-29b5dc5dcf8mr3271095ad.19.1763656594872; Thu, 20 Nov 2025
 08:36:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120152126.3126298-1-senozhatsky@chromium.org> <20251120152126.3126298-6-senozhatsky@chromium.org>
In-Reply-To: <20251120152126.3126298-6-senozhatsky@chromium.org>
From: Brian Geffon <bgeffon@google.com>
Date: Thu, 20 Nov 2025 11:35:58 -0500
X-Gm-Features: AWmQ_bm7DruXduZIQpRB_jSdesTnBG2UEkernRi3vrpgktZOUbhhguQOJZM17i8
Message-ID: <CADyq12xHEQ4aFRdVDMkmuA1-r+FU7N4O7-8UUTpD9ACFo3tuZA@mail.gmail.com>
Subject: Re: [RFC PATCHv5 5/6] zram: rework bdev block allocation
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	Yuwen Chen <ywen.chen@foxmail.com>, Richard Chang <richardycc@google.com>, 
	Fengyu Lian <licayy@outlook.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 10:22=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> First, writeback bdev ->bitmap bits are set only from one
> context, as we can have only one single task performing
> writeback, so we cannot race with anything else.  Remove
> retry path.
>
> Second, we always check ZRAM_WB flag to distinguish writtenback
> slots, so we should not confuse 0 bdev block index and 0 handle.
> We can use first bdev block (0 bit) for writeback as well.
>
> While at it, give functions slightly more accurate names, as
> we don't alloc/free anything there, we reserve a block for
> async writeback or release the block.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Reviewed-by: Brian Geffon <bgeffon@google.com>

> ---
>  drivers/block/zram/zram_drv.c | 37 +++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
> index 671ef2ec9b11..ecbd9b25dfed 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -500,6 +500,8 @@ static ssize_t idle_store(struct device *dev,
>  }
>
>  #ifdef CONFIG_ZRAM_WRITEBACK
> +#define INVALID_BDEV_BLOCK             (~0UL)
> +
>  struct zram_wb_ctl {
>         struct list_head idle_reqs;
>         struct list_head done_reqs;
> @@ -746,23 +748,20 @@ static ssize_t backing_dev_store(struct device *dev=
,
>         return err;
>  }
>
> -static unsigned long alloc_block_bdev(struct zram *zram)
> +static unsigned long zram_reserve_bdev_block(struct zram *zram)
>  {
> -       unsigned long blk_idx =3D 1;
> -retry:
> -       /* skip 0 bit to confuse zram.handle =3D 0 */
> -       blk_idx =3D find_next_zero_bit(zram->bitmap, zram->nr_pages, blk_=
idx);
> -       if (blk_idx =3D=3D zram->nr_pages)
> -               return 0;
> +       unsigned long blk_idx;
>
> -       if (test_and_set_bit(blk_idx, zram->bitmap))
> -               goto retry;
> +       blk_idx =3D find_next_zero_bit(zram->bitmap, zram->nr_pages, 0);
> +       if (blk_idx =3D=3D zram->nr_pages)
> +               return INVALID_BDEV_BLOCK;
>
> +       set_bit(blk_idx, zram->bitmap);
>         atomic64_inc(&zram->stats.bd_count);
>         return blk_idx;
>  }
>
> -static void free_block_bdev(struct zram *zram, unsigned long blk_idx)
> +static void zram_release_bdev_block(struct zram *zram, unsigned long blk=
_idx)
>  {
>         int was_set;
>
> @@ -887,7 +886,7 @@ static int zram_writeback_complete(struct zram *zram,=
 struct zram_wb_req *req)
>                  * (if enabled).
>                  */
>                 zram_account_writeback_rollback(zram);
> -               free_block_bdev(zram, req->blk_idx);
> +               zram_release_bdev_block(zram, req->blk_idx);
>                 return err;
>         }
>
> @@ -901,7 +900,7 @@ static int zram_writeback_complete(struct zram *zram,=
 struct zram_wb_req *req)
>          * finishes.
>          */
>         if (!zram_test_flag(zram, index, ZRAM_PP_SLOT)) {
> -               free_block_bdev(zram, req->blk_idx);
> +               zram_release_bdev_block(zram, req->blk_idx);
>                 goto out;
>         }
>
> @@ -989,8 +988,8 @@ static int zram_writeback_slots(struct zram *zram,
>                                 struct zram_pp_ctl *ctl,
>                                 struct zram_wb_ctl *wb_ctl)
>  {
> +       unsigned long blk_idx =3D INVALID_BDEV_BLOCK;
>         struct zram_wb_req *req =3D NULL;
> -       unsigned long blk_idx =3D 0;
>         struct zram_pp_slot *pps;
>         int ret =3D 0, err =3D 0;
>         u32 index =3D 0;
> @@ -1022,9 +1021,9 @@ static int zram_writeback_slots(struct zram *zram,
>                                 ret =3D err;
>                 }
>
> -               if (!blk_idx) {
> -                       blk_idx =3D alloc_block_bdev(zram);
> -                       if (!blk_idx) {
> +               if (blk_idx =3D=3D INVALID_BDEV_BLOCK) {
> +                       blk_idx =3D zram_reserve_bdev_block(zram);
> +                       if (blk_idx =3D=3D INVALID_BDEV_BLOCK) {
>                                 ret =3D -ENOSPC;
>                                 break;
>                         }
> @@ -1058,7 +1057,7 @@ static int zram_writeback_slots(struct zram *zram,
>                 __bio_add_page(&req->bio, req->page, PAGE_SIZE, 0);
>
>                 zram_submit_wb_request(zram, wb_ctl, req);
> -               blk_idx =3D 0;
> +               blk_idx =3D INVALID_BDEV_BLOCK;
>                 req =3D NULL;
>                 cond_resched();
>                 continue;
> @@ -1365,7 +1364,7 @@ static int read_from_bdev(struct zram *zram, struct=
 page *page,
>         return -EIO;
>  }
>
> -static void free_block_bdev(struct zram *zram, unsigned long blk_idx)
> +static void zram_release_bdev_block(struct zram *zram, unsigned long blk=
_idx)
>  {
>  }
>  #endif
> @@ -1889,7 +1888,7 @@ static void zram_free_page(struct zram *zram, size_=
t index)
>
>         if (zram_test_flag(zram, index, ZRAM_WB)) {
>                 zram_clear_flag(zram, index, ZRAM_WB);
> -               free_block_bdev(zram, zram_get_handle(zram, index));
> +               zram_release_bdev_block(zram, zram_get_handle(zram, index=
));
>                 goto out;
>         }
>
> --
> 2.52.0.rc1.455.g30608eb744-goog
>
