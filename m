Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2980C39657A
	for <linux-block@vger.kernel.org>; Tue,  6 Oct 2026 06:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791267122; cv=pass; b=FwMdIWBOkxnbrlvtOAiIyBE67T/yWSQUAahPosO9rOGodNp1C+HDfzUR1iJ+z+8X7grl4G6joS16sFz/IA5910GqGan5eiYomITNcHGMlBIFmsQCupaKMu4yLA86g2hReze4k5EXrlTzRK7CquZWlWrVZnhTm7fzPNlDsGhtgKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791267122; c=relaxed/simple;
	bh=qqCMB4Vc+PEpwfp51MydCJj9S9ec4+6lAOGZH5tEKrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7JcPPkLBhH7fFxt8WF57O0kNwtpssHtALO6EAJyaHSGOfvyGHrW7cJCLn4vqFtuVd8QjBgzG3LBtNXZFOvQOZ9bM+VaF9O8jvx2QgJNnqY/u0JAF462ouVadBQHvVbJNQnbXAtWVvhRqzu0Kab4U9rSb0xK4GhfCnwyFVx7Kuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=byBlYjD/; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="byBlYjD/"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5337fa12431so129851cf.1
        for <linux-block@vger.kernel.org>; Mon, 05 Oct 2026 23:12:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791267120; cv=none;
        d=google.com; s=arc-20260327;
        b=qq9nOMEi3Y2abIIb3FbhMmUG59ayDNO6exrx6RKHRKMT2hQQYr3GqZUX+HR1cty7XM
         gDuNU/SoA8EO8i57j7Qhd2QdKjBUns7zsXhWAfaDGEMwArsucUwkzuN3l/KLvMEhKukv
         RnmojdgDNfoka3pWV2rjX5c07HQelMX+BVCXoFcYhQRy8FjEYdpEwIu0LBmwMCsMsvGE
         I/pFsoo3FfghVkRNEHSmFQdUeKSbfFQCoKUEeCpUhOj78dhA/Tm56OWQ+DFCHDoHX0LE
         uMewi60hKH7trzwmIBHbwetGEt0euWCtg6VBB4zHs0b3Vj4ZvDpULkq15W0IJkWGQ8a6
         7zIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gj6RHy/jbDQ7XvW3Qfyv/IMf5W2R8V0RhoVCA/GC8SQ=;
        fh=179SGUHpQlnu3zRY4d+yhfQriyR8UyeTbeBku92OK+I=;
        b=MV0CG/Bmt91rOu0Mcbt0ZFpB2lT9Kb57xgiv2monG3o2eQ2ccND+7D91b5U2Hp7O01
         Q2+lNIPsMUknqctuja5nWF+rzcHXfS2E+TXRsq7AYNhhZuFcwEJ/oXUGQjV+32sXCYuO
         Xpj+RTS+aU0q+zw16AZcquIrf6GzIExiUKKzQuPylmc/XHdqXoK96G1qRYBDV93hFcvl
         NjhMcL74tvnVULBDfWj8kfv72FM3lU/EZldaB+MhcifKa60cJhUM274pPb+hDyJ4+PNs
         N43vPhewobkVqJL3d/oLd/ggur68k+JI02Z5FSOhCCQyvYf7b7E6INjfd1+7fDRZS4FC
         Nt0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791267120; x=1791871920; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gj6RHy/jbDQ7XvW3Qfyv/IMf5W2R8V0RhoVCA/GC8SQ=;
        b=byBlYjD/CjMwNjfCFwlKIBBL5PchWHh8pDpPYITpzu6Jizq3RtR2JjQyBCJOIBMwTH
         bmEnLnURzUY8oLSqKdi14cSdV5miXaioVH2yejY5Td8nMBCbgKdlQuwuJtc5yQhFn+iY
         vjRklKW7vNm+uw7W3mRqYvgvSRYykFJq/S7TcJD+0LOTqBZoXlSiVgbuZ44P1Kl3uA4g
         zP2WK+VJJbc9SzlRnut5P4XsnoNCuKsXMmKUH4MQJv9b9rhKBppAvT38XMncYRb5s1wz
         34nLJBFTkhXypkNmwyLO6MZCP3S52/tvk3d8z6RIUeIF1SkdGpyjONQ3PuFQ7YP02AKL
         wrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791267120; x=1791871920;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gj6RHy/jbDQ7XvW3Qfyv/IMf5W2R8V0RhoVCA/GC8SQ=;
        b=QNRcp3GoKZqJM+2qmTsagnjnjC+USq0ojwvH7cjR4FQWhJEA5QLrD/kj6+aFcFmt8f
         PF65k84idFZlIPeCs0oWtPw2Fk+kpr1eSfSfH1Nz3ssiOit94f8xTjpcnHhz/5xg2tQ9
         f1Pb3tCpdj7oTGxN7zHVDqwM7h1SD/V92f66VjMOhzaZaxxmoqo8bwFXReGMSkFnDOB3
         ig7HAFo2LchGxjxjqxKw++Q9biKEKgerS4sT/Ylqn6IrZ4qINss069pwOlW3V/0Da6cb
         a+JpUj+qZYX/C3lIihJDVSzuSTPoLw/keXLlWu7Il6xb4HuRc1f/ix5v1TAQs8NSCBQa
         jVYA==
X-Forwarded-Encrypted: i=1; AKwUvBz1FhXobiOj6Xu90HLzv8+7NpkqLelodJ9QG6l6KzeoD6xJyAIztr/Cthn1DTkGMKo2KNRnUQ4eXDJx3w==@vger.kernel.org
X-Gm-Message-State: AFuF++kVnMnzqbdMSC8Yv3xRcTO2ONQNGK/6f5TcGnu49BAKxyhhbeS9
	KVVyJLJcLNpNM73/Ca2AY72Jms+mDqgQs39LDHZ0UoaELOHopoVhxJ8vMbCBo3lVFpc7/AEpzTC
	JdBNWWVhwTqMvP7NIs7bF/YxRCWmCOGZyfKMyKpqx
X-Gm-Gg: AYBFou1/7Czmx11igGE9Hqc4gsaj8VNSkq7AlsP2fqLO7tB1Ue8rnEDal0RnBn+PTfU
	lT/YhWwYKyMmbhs1aurhbBfOzeyVJ2ZVudnK4fC1u6D0Pl0/aipTw3SatXS9wDsJZzLhtaIFTzs
	9L0YKGj6ekU0GLjvgFnrQR3Cn0lIdGjodlMSiM31wcRVgLgmdFk9d7cGKILZ+l25JYGS4CkMxD0
	CJXAdc84HZWq7AVSC1+mOx+4TOR4phobgr3dK3AOh3S8rOKmTgU31OILkZMQpV+w0LYaFZGSL2g
	5KgCtzpfcJRfWvVXke6go57gTN/wb8oDDeoANN0MMTARRl6MkyBgt8uCRNpk0NTInWPTVam737s
	IgZr6I+/81Jl5tdEHHwPCv5A1EOEpcIh2f0pL5MmQKd8cgDLBdXL+ogs+weby5gxTYGUKqUYhbC
	IjwsV0mTi/q/cE2YKTMRKsyx4pACtq
X-Received: by 2002:a05:622a:5a13:b0:532:d36c:7094 with SMTP id
 d75a77b69052e-535406c5437mr11354271cf.4.1791267119345; Mon, 05 Oct 2026
 23:11:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005122036.718976-1-senozhatsky@chromium.org> <20261005122036.718976-9-senozhatsky@chromium.org>
In-Reply-To: <20261005122036.718976-9-senozhatsky@chromium.org>
From: Brian Geffon <bgeffon@google.com>
Date: Tue, 6 Oct 2026 15:11:22 +0900
X-Gm-Features: AclHuK-hA3u42-jLX2PTceoOBTEETCWnRCw_Pvipfp3U7_-ms2srhkS8B0C_EQE
Message-ID: <CADyq12yNeSK-JW9QvrceqBRhrhRWRRA=byPSRC7482JgpodGHQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] zram: reset writeback state in zram_reset_device()
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	Richard Chang <richardycc@google.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 9:21=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Reset all writeback state to its initial defaults on device reset.
> We used to keep writeback related data in zram->stats, which
> zram_reset_device() clears, but commit 1d69a3f8ae77 ("zram: idle
> writeback fixes and cleanup") moved it (along with the newly added
> wb_limit_enable) to struct zram, after which neither of them was
> reset anymore.  wb_batch_size and compressed_wb, which were added
> later, are not reset either.
>
> Fixes: 1d69a3f8ae77 ("zram: idle writeback fixes and cleanup")
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Acked-by: Brian Geffon <bgeffon@google.com>

> ---
>  drivers/block/zram/zram_drv.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
> index 593fa4ae47c4..0e1aa0da11aa 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -694,6 +694,7 @@ static void reset_bdev(struct zram *zram)
>         zram->disk->fops =3D &zram_devops;
>         kvfree(zram->bitmap);
>         zram->bitmap =3D NULL;
> +       zram->nr_pages =3D 0;
>  }
>
>  static ssize_t backing_dev_show(struct device *dev,
> @@ -2881,6 +2882,12 @@ static void zram_reset_device(struct zram *zram)
>         zram_destroy_comps(zram);
>         memset(&zram->stats, 0, sizeof(zram->stats));
>         reset_bdev(zram);
> +#ifdef CONFIG_ZRAM_WRITEBACK
> +       zram->wb_limit_enable =3D false;
> +       zram->bd_wb_limit =3D 0;
> +       zram->wb_batch_size =3D 32;
> +       zram->compressed_wb =3D false;
> +#endif
>  }
>
>  static ssize_t disksize_store(struct device *dev, struct device_attribut=
e *attr,
> --
> 2.56.0.rc1.315.gc6ed9934b7-goog
>
