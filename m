Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912242FF669
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 17:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976506; cv=pass; b=ndmMH8tAQ2y+JhtJyCDm9i7EsxzthzzLojuAPTe7DN/yp++/WDgq/mEnDGXh0PMp1WtigEOvnzWSO8CI5vMnouAmYAT/Goi0stJ34dX8m5dgrUNXr2gfqJ4pDqTxlvASBgQpm6TVJqP/DG2TcQGNNa6EBrzooNGrlT283LInPjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976506; c=relaxed/simple;
	bh=Sf457Uog04A2wbdJfRkGVXUbpPpLNsrBCURdmZQ2jJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B5i0vXvDsu/awEHQO0m8fUtRevPTc2QM6kPQGA+Gc3p5u1LMSMrCSJs2u9vDRgKLU5ZY6gOyCoR0mzvKXd0wbx2EmNR+iKB/53VkzjPC0FQ0MEGJZi/SiIhi8BqLOtRu+n6tNB3TSbCRnbe/fLz+0/Qxq6IHoFwl2kADJ3TPFic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DsFhMAWb; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DsFhMAWb"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-509069a7a7fso714981cf.0
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 10:01:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774976503; cv=none;
        d=google.com; s=arc-20240605;
        b=Wlel59T80jVlVoywZVq9+3QzFkrRoVgXyBdqenje80g+JKCyO1SM+IV/mf6jbLTw0N
         IsRjpt/gvqJLgMkjzOUR9wsDwWMB3KvcocFngDU551QjR7T9p7//EVx5fHcukAur9K8A
         OuHuVQnbXeByoGYpiZY/GITW2Ylrp2QgmS2sHTMj23G6P5zgqOFpjaNOH1/Spade0uXw
         v8sYVHYG7O452HdkaHrRK1Aj2auiABXew5qpOXr7CGb7/dFYuQxe33SgHGi4kY8lQT5P
         BJTfXULAvWid6iNLErUX+vsodi4xwEnLQoDuQCAWjcmpNaARbAnOfTZKV+g085JjPVJF
         noEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ham5ev+UebYvvEaY28poSjgTGYZxX5cFNpBczGAP7zU=;
        fh=hlv5UMtlG8EkAzav4jCsRFt8hBNzzwSo8TdminCSUkU=;
        b=cez4pppVU2ITymw/2NjMwPII88Fcln0OUEP9LvJUM0CaIWCM9caDj9jY4IrneL9tI4
         MUIsoEjgzbX/f9+qer91ujxbI9Y05yHn4Y5rxnXXcNmz+F0iyN7z9zmGF3afUucIEXJ2
         MeE1SjNGw0Yw0CpglN8Q1ODiN5HKmGHdFccBuMdsDJE/hO+WGpNiugOYGjF6PomTwdCi
         nR5bQ8G2voKbFfw9a+8E4LDkNalV9XPlCKUpc9mWcDOVkk7UIUzXOCdot3azH/mTKE74
         UBWGzSvKPv8f6zbosHGPIE3rYyiDdAH5PQrDLZoi+E1tFPgmDg0S+DUt8I81cgMnWrab
         ueSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774976503; x=1775581303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ham5ev+UebYvvEaY28poSjgTGYZxX5cFNpBczGAP7zU=;
        b=DsFhMAWbVQr54iSHE88Gas7R96HB2MiQFVf2cL4N+rb4DEAl83HfTxLF9pUYZwN+mi
         ZgM8hEiDjOWPRnWqYb5TFIqR8588DS0PqIeayxiTgoYtgMNPCiluPp39yPdRyG0jOgCl
         KDyoJGmfAdyq+Img/MaVqe3BGqn2rw/gIzsT1NvaMRY+FMHquvepYQO9878L7zFBA0yN
         04R8+e2FHCmejlJN0N28UGe/oBJJFDDRDs0H1N2h7NsFVtKRDjiiOVPVrobR5sCThF+R
         f+4XXT7nN+4Zsk5b0i9cKO4z6BFWAuI3WnZTlnBIpEg4p8Gs2YMZBUw2qEGelqpn/u0R
         +ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774976503; x=1775581303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ham5ev+UebYvvEaY28poSjgTGYZxX5cFNpBczGAP7zU=;
        b=hfAgCrAfcJxmXm/m0N7ygrRWe0wMkDKBldDOe/EWKBJYX9Du1gizSCdrtgBayJbD6/
         1RfZ+l7mwfm9B4h2yGr+i/FwRmQA3yvaA4rnsu9ukYOhZISjgZe52qyM/84V0Msd+4Or
         CV7G0Y1rlla6HcexPPJwLmqjQqCSFlbE5//ffyk4qeWf+3vdGr43bRAPUVIx5TGkhlRO
         1cf2rwkr0LjdDXpE+hdHPBmfAurMsS21mNR9tQchzwisO5eYWwT+CJ8On634BZ8DfAsY
         yDOF/alU8/V+JnVRrZ1S4jp0Y0vorGjWb8Z3FWgVV6Fq8XITuRhX5q8YEkBJY6DHu/ew
         /nig==
X-Forwarded-Encrypted: i=1; AJvYcCUNu6b+mWu6lkt5VCVlhy8YAJHzrdLS8oeCE+7CMCdoldJn4V7ztpRLe6ha5g1Fz0HOFnbf0s4KlnMRyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMPgYWf4QH6xR5f4/O3rOsFN2Ejbqon6vTxLUfzREZ7sZTbGqE
	uKGAuqfDFOmgTZEyS+XuTp4vqT1/34g+R4hyyKrvWleSPZIRP9fm6S9ugzsG2OtUWB5pxSCMEX8
	Yf7Fyj5TPirRTwzVlElTiVIrYk/bB9jykG2M2bVmW
X-Gm-Gg: ATEYQzz2lv61T1daoMH8Veb8SSRRNtlkvy+uRTRrOXPUBrlyM11sM/SBm7UEtZmTDJ0
	FYfTDDXRgHBfAHTAUdEqsJ2hfwwmDkj/aNbzkymeY2QLGOkkG43Pb9HEIIVQfD5GWHGSl2fY2G8
	32CxdhBEaq63DZ3ltcPla8Ek1RlkKpVFalEzPrcv5i0iQtXlXDh0GDhcAfeMTU3POX/uZySXaF0
	/cmEHCcwfH6CVCvZhCocmXg9TY06vYK9I7DZmufe7hvr/C1IZ4qnWGGaZ0D0EOWDwKZxFCoJtHT
	3Gwtwtslj2wnyK/IOUs7J/Vr0XECa3bKgDpLYrkaLmW+53+o7XlLHkCVeuMuIu1fb7m9K7XEjL+
	0U7t8Ofm4jjEbP1Py+iDJzf+4
X-Received: by 2002:a05:622a:aa05:20b0:4fb:e3b0:aae6 with SMTP id
 d75a77b69052e-50d3b7238eemr1956911cf.1.1774976501176; Tue, 31 Mar 2026
 10:01:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331062648.596077-1-senozhatsky@chromium.org>
In-Reply-To: <20260331062648.596077-1-senozhatsky@chromium.org>
From: Brian Geffon <bgeffon@google.com>
Date: Tue, 31 Mar 2026 13:01:02 -0400
X-Gm-Features: AQROBzD0u_5CmV7Kfe03IQ8eGCjuAdzCH9_TPr0t8uU79dqySJTdhvGybaYcyPg
Message-ID: <CADyq12yGuOg-Q9MbakWtsevLTDxvk-bSbVyCm9igAmVBA-Po5A@mail.gmail.com>
Subject: Re: [RFC PATCH] zram: update ac_time of written back slots
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	Richard Chang <richardycc@google.com>, linux-block@vger.kernel.org, linux-mm@kvack.org, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 2:27=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> This makes it possible to tell how long each particular
> ZRAM_WB slot stays on the disk and, basically, to monitor
> writeback efficiency.
>
> Note that the patch factors out a small update_slot_ac_time()
> helper, which we call on writeback completion, instead of
> calling mark_slot_accessed().  The reasons being is that
> mark_slot_accessed() clears ZRAM_PP_SLOT flag ahead of time,
> while we want to keep that flag set as long as the slot is on
> the post-processing list (unless the slot is freed concurrently).
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Suggested-by: Brian Geffon <bgeffon@google.com>

Acked-by: Brian Geffon <bgeffon@google.com>

>
> ---
>  drivers/block/zram/zram_drv.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
> index 5ecc4ba40e9d..dcea703a6766 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -185,15 +185,20 @@ static inline u32 get_slot_comp_priority(struct zra=
m *zram, u32 index)
>         return prio & ZRAM_COMP_PRIORITY_MASK;
>  }
>
> -static void mark_slot_accessed(struct zram *zram, u32 index)
> +static void update_slot_ac_time(struct zram *zram, u32 index)
>  {
> -       clear_slot_flag(zram, index, ZRAM_IDLE);
> -       clear_slot_flag(zram, index, ZRAM_PP_SLOT);
>  #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
>         zram->table[index].attr.ac_time =3D (u32)ktime_get_boottime_secon=
ds();
>  #endif
>  }
>
> +static void mark_slot_accessed(struct zram *zram, u32 index)
> +{
> +       clear_slot_flag(zram, index, ZRAM_IDLE);
> +       clear_slot_flag(zram, index, ZRAM_PP_SLOT);
> +       update_slot_ac_time(zram, index);
> +}
> +
>  static inline void update_used_max(struct zram *zram, const unsigned lon=
g pages)
>  {
>         unsigned long cur_max =3D atomic_long_read(&zram->stats.max_used_=
pages);
> @@ -952,6 +957,7 @@ static int zram_writeback_complete(struct zram *zram,=
 struct zram_wb_req *req)
>         zs_free(zram->mem_pool, get_slot_handle(zram, index));
>         set_slot_handle(zram, index, req->blk_idx);
>         set_slot_flag(zram, index, ZRAM_WB);
> +       update_slot_ac_time(zram, index);
>
>  out:
>         slot_unlock(zram, index);
> --
> 2.53.0.1018.g2bb0e51243-goog
>
