Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795219683;
	b=Zny9VRqjtNh2tJmz6GuUbv6Kt9jGXddMeCfIUyrMKJrOzR+SobJPi1guT14n4IeCz1ha
	 nZ2V7sZCAigpj9uWR7WuDRt9mWtVj+hihHevLusmUYMwmJ0G1GFuEE9NStqaj/KZxnrG8
	 pJwAP972j3gbYm81uQCTOpkmqAsfo8P+zWdhaAuuxcCEt/LNUN2sHIi2tPAcMedQCRDMl
	 UJnkufZd7iPSE2XTTTWow0ZcYVQNEEHqPWW8K1Adt6S7GbQwHSpyoBHCtHX73i2LjDMwA
	 6erRNZdwGevsXKcTHoqz9miPzlu2Nj6AroWQ8gns/yrpOtSmJ2eGdYIEVk5WORtz/vA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795219683;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FsYdnJMQiXGx+l4wB1iS5+Tppoq3uO18Wl9vnGYexkM=;
	b=blshuXMc6ZnC9Eyw+r8CaoYcF30kUTWCMVcTtQzvkB5WKYhNwQ9MypfPsHNhTa3n72f9
	 WrQV1OIDlBODxqcF86KaXP78Si+fQi7U83jcKF5wWMJGbv/FGPfjYmawQQOj8URyiWg+a
	 6HH7sxHy7BCBT78Diik9HYSe7jnemwKzMsDnUGtd47vfpHr8R/IJLj7XfUWjvtEKMCBhB
	 Jfe8pYfqmiVE1odlj9CAWd5zH9PVKbVhXlOMO76kPSrHtd5mTBTEHgQfclB1XgKOYdqkf
	 qhxnJV2V0dwZCBZ+aoBMeS4DrDrbD2O1TahD+gmefXmb4Ex8Gh76v4hHUJh3xjVLbGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=Ed2U7PXw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C88606A69C
	for <linux-block@vger.kernel.org>; Sat, 21 Nov 2026 00:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94C88606A69C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=Ed2U7PXw
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-716f259f52eso32163eaf.1
        for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 16:08:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795219679; cv=none;
        d=google.com; s=arc-20260327;
        b=VXWZEPth25HUVf5HEg+zRGNfReJ4I8X7ExJmeLDtXksyGOlIXduGvzd8ojayl1G3zz
         v+OwSQ1WF6ez9Tkd9BQL4fIWJHkEZJk4hwYVLY2rTjaaK8MCoUYiDCdxYCRZmDlS+ORV
         +8hnLdcEoEbyiaPwXxdHpM7ksreuQQwljTFJrNrKmOrM7ciuh+3YGgv1z4ie1eUwD0Vx
         hyz82cEYSO01x5PnCLDxY+1OWCOke89Rf4rdPKBhPbhgm7fd9L4dx/FLT3CdcotHQ9BW
         xSZh1vNXtRcCqwdsJAiymv2+6HEkgG8rNV06xkrUxiiFjmXZwwVsHS+f1BH27uKQutpG
         Ce6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FsYdnJMQiXGx+l4wB1iS5+Tppoq3uO18Wl9vnGYexkM=;
        fh=8WcqJMa5oi67G99qCGQsms9Nllzvkotq1+9SJfbKQkY=;
        b=rjvWo0TcvJV3lMc0eZQ1G8Xcmru+ZVa/ERH6LpXlonaPqM5717d1Th3HsLE9oRUkBk
         GSRajVH0Rc6Ql63ekm0UutLLU8Z9JwH+D6PKt3Du481cC5qsIo5EY8StUMqB7yX/7n1O
         WMiaWiF2ZaaWUIXQVF975gnFtlCoQQfEd57D8PRw8a5JJSCouAds318XldNP2d/T1Jgy
         eeErTIS2bUNV+/2Dn+CPD2SeQBARItJtmyOj5HYWFRBkR4oS1a8N/jj2k6ozwQjYmf/w
         dA4zHbAqegy0O8H7B/MKxSK70Vaemj8dI5iN+KiL+018Gh97qJeDvahwHrIb7T26mBCi
         FmJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1795219679; x=1795824479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FsYdnJMQiXGx+l4wB1iS5+Tppoq3uO18Wl9vnGYexkM=;
        b=Ed2U7PXw6MISwxBLMOCl+VIadm1US5dV+Ir45yownslIgxA8LVqntjLWpYBc0Eb3ih
         tuBOgHGJlmEiI9IG+4enilv0JZqtryrgJcEVls4oyensXmdxdLCdhEsS3QK/PE9GQYfo
         T2TzLop2IOwT5Jby8AZJEsKqgLn3uEyIqaFon2Z3Yflw8KuvdMwC3+rKEd30ADiTiTX8
         q8Er/iHZm8vsSNpRI83WDVEisA4kjGFtAVn5fRR90a3gt+aqgUjEz2nuRqJGZjQZIQfV
         +OL6nEUtDY8rqjdJgMBZfgMSfq+kpalrgBtVkNl/77i04XJ3j/kEpoeh01v18xUtW/ge
         RCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795219679; x=1795824479;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FsYdnJMQiXGx+l4wB1iS5+Tppoq3uO18Wl9vnGYexkM=;
        b=qjlPbeX0x3IkUxDjAxw7WoH1LrJ2Kq09rghJyIjW2WqctHiFISXIdZTg90wl8HrVEp
         MURIY3/xFGEHddzu4tvMkaKBqS59hhL46yF0L9uB6jJg2gdwPSergRmxzTW6vjvp2nEB
         6k8YogynT6F06xZtiyiR5HZArcBnbHUJvFEjrJhNfBNXIaa1xQsxLOchAYo5vq7c//03
         89Ap3EfGVY6A5nVcs+Ln9JaJKU44zhEuvnTFSLtmGTfl4/Q07Dc2sI/0+8jFxvMAETLk
         kfsQgWNiq84nSMuL8476ZIDjTFXRaRHvoQBA48QDZ6020pqUNGeAG/AdFl3v4qJ0MnWO
         z+WA==
X-Forwarded-Encrypted: i=1; AL+hErH+ygldOfYUmwQnhrR9aMjUcVNcFom1vCWGtZNd6Vzg+aju/GlWp1XSTpR/ljzeWz+60PI/CNPJ1/sEvg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+9WRJmADzASu89ymg64RhyFxaCumhrPvJ3rHzXSpSeEgGAQ4CL
	s6ovaEEdXSUMqrHMnPbXLYzkIu0XBRiy8ahHplb8/HZnLCxn1SjdSE+1EWd3rhVom1x8EXYB3o3
	e3Egvj0TKaGHVJIDO1m9+JnxOQZHhJuvoBXZcY+k5EA==
X-Gm-Gg: AYBFou2Hy+shu7SPCWbRC02WC4L7V6OJs/W9Fn5swqWEkWnESMOwPmfPZon1GCwupXr
	y6T0xf0+wqk18g2Zb3Rsy3Bp5V4TtS+KSF4EiDf7uW2HIpZQnvkTEAUp0crwoaOgifcsASJVyMo
	X5u0a5f4bHDXCvhTZnkZzPQBe1UYwhiGD34jOMNHBGt3RoJG5J69DIUE7rvzppLQsVNw4uKhHoG
	SRzHewgAe+Bn61c/k+6p1IQZNxBIpXAw/IS81TKeBWzZ6cLIz2lonW5voyFW17z1VQI/+LjSltR
	SSqTeiLPCpw4lzcAaBKZ4MTaOgJNmaJrvSLD8zQ3s0viXVg8utErlGPtqlAH/6tXTDNxXgUNXoT
	piBm+rdtfhlnjgunm6Zk9WGYDikR20sRIdgdN
X-Received: by 2002:a05:6820:8599:10b0:70d:73e2:ff02 with SMTP id
 006d021491bc7-71b3932ca28mr4872166eaf.1.1795219679399; Fri, 20 Nov 2026
 16:07:59 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120195644.19511-1-zakaria.belkadi@inria.fr>
In-Reply-To: <20261120195644.19511-1-zakaria.belkadi@inria.fr>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 20 Nov 2026 16:07:48 -0800
X-Gm-Features: Aa3M54rN4fU2kZ1g3VyH3yN2HzL0XDhjtM9rK5s54_qMhP3uUFFQ5hk9tg3rtPg
Message-ID: <CADUfDZpvgi5t_iy2AOhUTfQ9p9XNC_xosdKkMsQ-D11KntK-Yg@mail.gmail.com>
Subject: Re: [PATCH v2] block: bounce user PI when writes may remap reference tags
To: Zakaria Belkadi <zakaria.belkadi@inria.fr>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>, 
	Anuj Gupta <anuj20.g@samsung.com>, florence.schadle@ssi.gouv.fr, 
	frederic.tronel@centralesupelec.fr, louis.rilling@irisa.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 11:56=E2=80=AFAM Zakaria Belkadi
<zakaria.belkadi@inria.fr> wrote:
>
> On an io_uring O_DIRECT write, bio_integrity_map_user() can attach the
> caller's protection information (PI) buffer directly to the bio. The
> block layer pins the pages for reading, but reference-tag remapping can
> write to those same pages.
>
> A caller with write access to a block device whose integrity profile
> enables reference-tag remapping can therefore modify a page it can
> only map for reading. In testing, remapping changed a tag in the page
> cache of a read-only file. With a PI buffer backed by the shared zero
> page, the kernel faulted during remapping.
>
> Use the existing bounce-buffer path for REQ_OP_WRITE when the queue's
> integrity profile has BLK_INTEGRITY_REF_TAG set. This copies the PI
> buffer into kernel memory before remapping, so the caller's buffer
> retains its original reference tags.
>
> I found this issue during a source review assisted by an LLM.
>
> Fixes: 3d8b5a22d404 ("block: add support to pass user meta buffer")
> Cc: stable@vger.kernel.org
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Zakaria Belkadi <zakaria.belkadi@inria.fr>

This approach also looks good, thanks.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> ---
> v2:
> - Bounce the user PI buffer instead of pinning it for writing (Christoph)=
.
> - Dropped Caleb's Reviewed-by, since the patch changed.
> - Corrected what the caller controls (Caleb): it chooses the address of
>   the PI buffer, the seed and the device offset, so both where the tag
>   is stored and its value.
>
> v1: https://lore.kernel.org/linux-block/20261118154053.13218-1-zakaria.be=
lkadi@inria.fr/
>
> Open question on stacked devices: the test uses the profile of the
> top-level queue. By my reading of the source, a device-mapper target
> with members of different profiles can get a top-level profile without
> BLK_INTEGRITY_REF_TAG while a member has it, because
> dm_set_device_limits() ignores a stacking mismatch. This condition
> would then not force a bounce. I have not tested whether such a
> configuration can accept user PI and reach reference-tag remapping on
> the underlying device.
>
> Would you prefer bouncing all user PI buffers on writes to cover this
> case?
>
> Tested on v7.4-rc3 in a QEMU guest, emulated NVMe namespace with
> T10-DIF type 1, as an unprivileged user who owns only the device node:
> - PI buffer =3D read-only mapping of a root-owned file: without the patch
>   the reference tag in the file changes; with it the write succeeds and
>   the file is unchanged.
> - PI buffer =3D shared zero page: without the patch the kernel oopses in
>   blk_integrity_remap(); with it the write succeeds with no fault.
> - Writable PI buffers still work, and the kernel no longer modifies
>   them.
> - Stored tags (as root): a write with a seed different from the block
>   number succeeds with reference-tag checking enabled. A subsequent
>   read using the block number as the seed returns the expected remapped
>   tags, with identical results before and after the patch.
>
>  block/bio-integrity.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index d3df726e0..aaea5802e 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -394,6 +394,11 @@ int bio_integrity_map_user(struct bio *bio, struct i=
ov_iter *iter)
>         copy =3D iov_iter_alignment(iter) &
>                         blk_lim_dma_alignment_and_pad(&q->limits);
>
> +       /* Reference-tag remapping must operate on a private copy of user=
 PI. */
> +       if (bio_op(bio) =3D=3D REQ_OP_WRITE &&
> +           (q->limits.integrity.flags & BLK_INTEGRITY_REF_TAG))
> +               copy =3D true;
> +
>         if (blk_queue_pci_p2pdma(q))
>                 extraction_flags |=3D ITER_ALLOW_P2PDMA;
>
>
> base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
> --
> 2.39.5
>
