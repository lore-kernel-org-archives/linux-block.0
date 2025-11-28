Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6421333734
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764359100; cv=none; b=tnhAvn/OamgrB2YGsFIGx1hl8VCKfrS8Oc9leWotBD7oTEIVKfw6vemiTNryjvpnC5+M27rybGonFozZRniN0zrXF3FhweQxJ4AgsF4AGcyAhlUfG+Xat98V7uNwQ3v7usqfaGD7nrFfR9Fjuc/IfGINRI0d3m76Y1fLknuCVsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764359100; c=relaxed/simple;
	bh=Bj3AP+5QeibKDhdHKJOIKyIGtMszqSOZbOkDUOZlHKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PzcXXWqNBH8NFuf+l90yXT/ez6GKnlIudgFGiCs1hH0s+2kpGebWxeE3zIzNjL3969bp4fofqTElRMMuaRbobZ4e5we6QffF7cPhYREgtV5I9CWKR98hqf1KtxvS369CWJzdaJCjPpFUhE1OhVpBzP4eyGrOwTFS7eezG8vY7c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=el59bO9j; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="el59bO9j"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7ae1c96ece1so160254b3a.0
        for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 11:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764359098; x=1764963898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EL5lnQB6ArvqmktVf7HK0TGQSj04Cghit8sLG5wYDU0=;
        b=el59bO9jJMLyO96OLuSFBH9W3kcxAcyqEkait77EQx9Az/+wt4rx8HvikHsM9tMhx/
         C4agcYQr/61bgLiBvO03xMwUb1D7MyukgjO5pi9bjx8nk5cgT5e5iruwVf7oZvCGHecq
         NKi3FBScD9t7ergYvrO5N5wAkuB0B9iOVp9PNekyyWkhfTE2bD994FfIVI/itMmYc9Ar
         zkWZal4nSzzpvWaj4ra1Ydnu2WWqaBGjzxf/zVONBv6icacw2KKopTmN9M3kmSjj22y7
         T07Zta5oWLLDCtOK17IPmMoIFJC6s10lxpu1M+LebEnu3iCILK8gnie8yD8CZ+gJbfgT
         WcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764359098; x=1764963898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EL5lnQB6ArvqmktVf7HK0TGQSj04Cghit8sLG5wYDU0=;
        b=DZuGIR4LiaXUJBOIKZg4l2Qn8nCwsIy59cSt2ywqsq3FFCi25xOYXrVDew9zsXC3wo
         IbKIzHbOg/jq5Zj4LMeqdf7ShCGAUQ1iyNH6iCb88J3awEjodzIzSGZIifEAt9VEEyWT
         1yYmCPE/pubIgZ1HHMGc2gayPWxofdBsxdTDDRPpjvtj0ytibKxhuygFXbamcLfRVYMP
         w+x9wkff2qSytvmAv3LNA8vg2eWxNKF4IBj4klw6HEJYOZTGiw/AB5oqXqofTxvFH759
         gXp0/DYCaWYqKpCobVzN63HSjLA/wPynxhfKiG0fD8SAnXMVcnelrQnoHMX1QM5+lXlt
         2k6A==
X-Forwarded-Encrypted: i=1; AJvYcCXhpWnmoTnsRbFid6DhhtyCvAby57wlb7sx/WSoEk0m3zkVR5OGEE28syoIkqptBeXsgcwNVpxPs5N7dw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5mTP87aEa9RnKpgYwrR28SdcEFdRdVi7CnZoteeMmdp5QyOvG
	IjKa9AHp2E5zKZCgVuD0XlIlrQC2fKbpxt5kIVAd/CC10pPvYoNTKXp5LvybvRs3gP0k2Z1g9HU
	e9LOadgMf3GrH+coAo7Q6UH0My38UQILG2RFdm5dFsw==
X-Gm-Gg: ASbGncvlb/a1Q+skoogLoSqyZ5NmlKqkokND5ThSxW3sTFJt0WKeWkaZFcZ3d/aE7yH
	cBwz2mp8y3GZI+Y7EwRo04VkI2N32AyKb/5Iabh91TM773GKulmdiS1LFCzEIEU6CSfT9MgMFli
	jlAX4h+ojCyoQZIUBF5909EQ9pBgNU7pmgK1pNsG55h/fUMc1WH581J2vIjmMGeAvhGHdMBHAnn
	242mkIV7QYNC37rIN1NlcXH8gccGXJLzm3DBTjg3bTgX0rAlfE4LNH/aabVTR6vSLeAkwq8nf47
	5Uo2GLU=
X-Google-Smtp-Source: AGHT+IGrCksmBbxz9v6OODWXw3jg5JUAuqr2uXfNM+p+AOqeGW6UtPYXkYo+cITOMsNqpMT81gOSwHim2ngfe4fkcew=
X-Received: by 2002:a05:7022:69a9:b0:119:e56a:4ffb with SMTP id
 a92af1059eb24-11c9d5538e8mr18207898c88.0.1764359097859; Fri, 28 Nov 2025
 11:44:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn> <20251128083219.2332407-3-zhangshida@kylinos.cn>
In-Reply-To: <20251128083219.2332407-3-zhangshida@kylinos.cn>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 28 Nov 2025 11:44:46 -0800
X-Gm-Features: AWmQ_bnZzeizOKu2WLPi5AEBKsrxZhyOw3plwI8tIQrc3qIRhB_hMon5zXQE3Nw
Message-ID: <CADUfDZqBYdygou9BSgpC+Mg+6+vaE2q-K=i1WJB1+KAeBkS1dg@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] block: prevent race condition on bi_status in __bio_chain_endio
To: zhangshida <starzhangzsd@gmail.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, gruenba@redhat.com, 
	ming.lei@redhat.com, siangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn, 
	Andreas Gruenbacher <agruenba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 12:34=E2=80=AFAM zhangshida <starzhangzsd@gmail.com=
> wrote:
>
> From: Shida Zhang <zhangshida@kylinos.cn>
>
> Andreas point out that multiple completions can race setting
> bi_status.
>
> The check (parent->bi_status) and the subsequent write are not an
> atomic operation. The value of parent->bi_status could have changed
> between the time you read it for the if check and the time you write
> to it. So we use cmpxchg to fix the race, as suggested by Christoph.
>
> Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  block/bio.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/block/bio.c b/block/bio.c
> index 55c2c1a0020..aa43435c15f 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -313,9 +313,12 @@ EXPORT_SYMBOL(bio_reset);
>  static struct bio *__bio_chain_endio(struct bio *bio)
>  {
>         struct bio *parent =3D bio->bi_private;
> +       blk_status_t *status =3D &parent->bi_status;

nit: this variable seems unnecessary, just use &parent->bi_status
directly in the one place it's needed?

Best,
Caleb

> +       blk_status_t new_status =3D bio->bi_status;
> +
> +       if (new_status !=3D BLK_STS_OK)
> +               cmpxchg(status, BLK_STS_OK, new_status);
>
> -       if (bio->bi_status && !parent->bi_status)
> -               parent->bi_status =3D bio->bi_status;
>         bio_put(bio);
>         return parent;
>  }
> --
> 2.34.1
>
>
