Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606213B3893
	for <linux-block@vger.kernel.org>; Mon, 15 Jun 2026 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781529565; cv=pass; b=W32fXtnG8eyohXAUu/KVoxryWigA/L8Za/o7EKCBr/Q5maUFzX0CqoTKukS8HfIiIyZLXIMHrZW3M0E2jq4eU4tysWza1dlvrlLxoznbDxuQv1sPEMvr7VmqZyF2lJxPU6R7GfHkhVhbsLsl0suKOdr86yPHrWJvqqlrL8yOZWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781529565; c=relaxed/simple;
	bh=aylr0jSHqZiMcYssPunDBwm1K7Kn5m2/H5slQ8rRPTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=usXonkmzf8rGgrrKgQ7dN3BXRce24GZqITpQ6cO2uebNN+hrrQ+mTFsvTIE4Sqsb/aNrX4xNFbzX/HcfqZSw2v8Md32QIt3+qCCY+yFc+rBqnxas+7kbC7KL9Lrx8sFj92yNudsi/C1XnWhtcZG8DyAfUmcx/m7GrMmrtalyvmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmNGpbs1; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmNGpbs1"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-396bed274b9so29167941fa.0
        for <linux-block@vger.kernel.org>; Mon, 15 Jun 2026 06:19:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781529563; cv=none;
        d=google.com; s=arc-20240605;
        b=h6OhcZIteEPVxe0Xi+azgK+SQSQawxa4hKEhkgsJja/3ukOr8vhkA8X50wYv9fJTIf
         MTx3hT7hlv0fxkerWfM//pSYb7RfX3MEFNlX+Ct2dyTHAJwUiQE3sLpay8OnXli8UNhf
         unPQ2wJtxuNOMaPjcLjIdbbqkdCb63BD4TZnLFvDdYoZTLpgLWJwtR5x4/JnpV2Pehbi
         cmSnZSBNV+6K/raxowJLa6SIfrJjIR47EjwweK3dQC/hK7SqURz24f1kAVFeQ84HBSpb
         OCf4i8uTQSZBeohOMraMpaiNafDdacowQNHX3xUvUnfnF/Wa1wF2W5hJHqv3ZlbHoxKo
         5pKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wpR91dRVrjqKzmtraov7aI7NzeTafl2vyksF7BlIurg=;
        fh=bEFuKOW0tCIaKuPe98y5Dl419okc83e0FrdYYnAImY4=;
        b=FBG3v5lD17pKTUpZM4LlJ1JkKXtI1Z+UZv0Gzn7K+XC/PHDnyJorp0RAUoiSXXerpL
         6aEO746kjyweskMVdahGUiw/6fob6JKbyfSM0SPR49rOdasAuVOkcRpfKS1SXK3QcvKL
         TbKs1kqmH4eqc2gjzk4vHPKDlEixq6NKkgi4ulHOEka3csZwoCYblWsTSg9N2bJEoUZF
         dpHJsaw3QLcS/U4ms9dH1Ude81Ow6FCs22lwUULxVD/XOWtR/2rZlmfmF01I+9JMrSTb
         NTbNKMYgdfl0lQyVZc97Hw+hpt1TDMvxvd9Dsi8ZQQ5SjI8s0eeomL6GxkIC/f5TOXon
         EQRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781529563; x=1782134363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpR91dRVrjqKzmtraov7aI7NzeTafl2vyksF7BlIurg=;
        b=BmNGpbs1LFf3K7FAnrO+0OAG8IA9PpOyCXIvamv3tiJkzv9+7Q0K7SPL+VloO4gWJc
         WlPIG8fXf+WyS0ouObn786ni7702z5ztV/EGO9fkb27QquP/A7KvZW2XePzFZ9fzybNe
         uSNuR4FeL0EKG1GseLtU0O75bz7FILQAnL8oOH1nqpi4KRil6S6ES1a7PaI9tJ7rzz4d
         zOrYz6kVpu5L2sVLX3rrfivkwVVKNHWXjAUOHqJyaa+XAY6He/hi+NEtdBAo7XGF9B1v
         NefB/xAJLf/2DUQJDpUWW2iK7bJpExYhb0xwC01ZSuVzPMLwfpAUHA37jYR5Xxx5jq6T
         mbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781529563; x=1782134363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wpR91dRVrjqKzmtraov7aI7NzeTafl2vyksF7BlIurg=;
        b=MWMvoPaBm+3WGa4oD5XB+LfL4IirflhvvTgJHj2rX/l6cYpjX1t0JpfalJK5DIkbZl
         m+tDiNrHc9NaOw2KQ8Dp8zQVal3Bi7mIFuqd25C+kwDn3ANbPQFM1LG5mL4+o8Y0Cloh
         IST1/bJ4Yqz49VPCBYz309btv3k8zpRHWiUCI6aY2sAvJ875JpeWMQZKfyFeAg+Ag1K6
         pPPy9t6aWhsSEcjXKjqb2Dd6TbnLdIkmgtQ3vwZ4Z64bxbozbdm5gGbG8fJF5dQ5spOX
         lLfj9lMr2rJAJv+s/Cl+HjxieG3FXtrKtoegG9uQf2ZSOwZr5NRV7fq8Fs7fnF24Yg08
         MMoQ==
X-Forwarded-Encrypted: i=1; AFNElJ8GrN/udOtfnO4JKGUe3hf6NG9my51RlkUSdHUmWxCBHr/kG60MvCTBQ+U2h7w6X0yZgyVKR3Q4KzpfBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzua5oucbJfDK7fBgnhd+MkcrK9eD6P5VyXTPBqbnllVoW6MH05
	hq1Tn+EmiZKflDj0J8vo6JeZyEJjKWY7TpR2jwSu6cv/ykepK+Ah/QInZuqUDfPoOFnOXoYKbI6
	mICCeSlDRpHBRk7gorcgzHxgeTfbJDqg=
X-Gm-Gg: Acq92OEnTMgxGpsfJ8I1UqXYlRo1qQOcW4UwpjoyPcA2+iv+lkYcb0Y38TJT+mQOXi2
	T7L7z8vF2+U9OoBppJzZ0AdmVa7YJWAKV1jpZSF67QrYVuhbON3Q5U1cS0pL4FGvfhRrjO77T8W
	2f8h8IagfyqgwuseDits4QzIKWjqPOtR1tjMbqSGwAWfVkT3VFZORIaB/m0iIswh53+t4kZ37NX
	YtfJeAyrfq4lKSK4b8OAZZVNTgTQlqvM2JOfZ5e+sxJBVPjcRJ6kjxrOFn8RJYQswMOQK4V4wSA
	n1g/uiyiIXMDTRODJTEMo6Jt8HFSMqMu20jT
X-Received: by 2002:a05:6512:1545:10b0:5aa:7129:5d43 with SMTP id
 2adb3069b0e04-5ad30dc0c0cmr2154191e87.26.1781529562348; Mon, 15 Jun 2026
 06:19:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614-zram-swap-ops-block-register-v1-0-6c1a6639c222@gmail.com>
 <20260614-zram-swap-ops-block-register-v1-2-6c1a6639c222@gmail.com> <ai+eG9sFYTn/vTq5@yjaykim-PowerEdge-T330>
In-Reply-To: <ai+eG9sFYTn/vTq5@yjaykim-PowerEdge-T330>
From: Jianyue Wu <wujianyue000@gmail.com>
Date: Mon, 15 Jun 2026 21:19:08 +0800
X-Gm-Features: AVVi8CcAQj4nbtsy1_GpWkuEBI_5mux4WS8Z_3cRBb-C2eJG0MtZGHlouDRiWCk
Message-ID: <CAJxJ_jhTPr2P83SpmFwKoWVKEKX_jBv3UJLC4WirdHqTYdckpg@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/zram: handle swap read/write via swap_ops
To: YoungJun Park <youngjun.park@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 2:39=E2=80=AFPM YoungJun Park <youngjun.park@lge.co=
m> wrote:
>
> On Sun, Jun 14, 2026 at 11:35:30PM +0800, Jianyue Wu wrote:
>
> Hello!
>
> > +static void zram_swap_submit_read(struct swap_io_ctx *ctx)
> > +{
> > +     struct zram *zram =3D ctx->sis->bdev->bd_disk->private_data;
>
> A passing thought. accessing `zram` here is too indirect. We might
> need a `private_data` in the swap device struct someday?
>
> (And If there is a real value like some swap-side only private data reall=
y needed.)
>
> > +     struct swap_iocb *sio =3D ctx->sio;
> > +     int nr =3D swap_iocb_nr_folios(sio);
> > +     bool failed =3D false;
> > +     int i, j;
> > +                     /*
> > +                      * read_from_zspool() and mark_slot_accessed() mu=
st run
> > +                      * under the same slot_lock.  zram_read_page() un=
locks
> > +                      * before returning, which leaves a window where
> > +                      * writeback can pick an idle slot we just read.
> > +                      */
>
> Regarding the comment about the "window" where writeback can pick an
> idle slot. I think this reasoning is a bit of a gray area. Writeback
> could just as easily pick the slot right before entering this routine,
> so the race condition seems fundamentally the same.
>
> Isn't the actual justification here to separate the non-backend logic
> and ensure mark_slot_accessed() is called under the lock, given that
> zram_read_page() can call the backend device?
>
> If the "window" mentioned in the comment is indeed a valid issue, then
> zram_read_page() has the exact same problem and needs to be fixed as
> well?
>
> If not, IMHO I suggest revising or removing this comment to clarify
> the true(?) intention. :)
>
> > +                     slot_lock(zram, idx);
> > +                     ret =3D read_from_zspool(zram, page, idx);
> > +                     if (!ret)
> > +                             mark_slot_accessed(zram, idx);
> > +                     slot_unlock(zram, idx);
>

Hello Youngjun,

Agree. Walking ctx->sis->bdev->bd_disk->private_data
from every swap_ops callback is too indirect. I will add an opaque
private_data field to struct swap_info_struct, set it from
->swap_activate() when the swap area is set up, and clear it on
swapoff. The zram callbacks will then use ctx->sis->private_data directly.

You are right. The writeback "window" reasoning was overstated.
Writeback could already have picked the slot before we enter the swap
read path, we have ZRAM_PP_SLOT to ensure it.
0. // condition 1 write pick the slot before the lock.
1. lock =E2=86=92 read_from_zspool =E2=86=92 unlock
2. // condition 2 write pick the slot inside the lock.
3. lock =E2=86=92 mark_slot_accessed() =E2=86=92 unlock // clear ZRAM_IDLE =
and ZRAM_PP_SLOT flag

I think simply removing this comment is good.

Thanks,
Jianyue
