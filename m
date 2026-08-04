Received: from mail-ej2-f3.google.com (mail-ej2-f3.google.com [74.125.228.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47A3353EDF
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827771; cv=pass; b=BBuNXHvtfHx98X/ezakPKlTz8CrLwX7dMGwPG1SLK3RohEVIVCMNCUBTMS12s1sYYEUtt2DMhDSUKmwr3lw8DAH0zwgv7Z0lozKS/I6aWrQJ8owRpLHRw8y1oEDEC/1frnUjgtIpZpsYkoDLUbYKUJ+L/IHAEf0oQA5Mo+xYBmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827771; c=relaxed/simple;
	bh=tTzPrUry5IGzotmZfDFxxBUYvLMZOgIPH5TS8QRdYPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RUvl87XOeEI5MFm/IeBU9dEb+RwyiVFF8BWJ2OXE4jq3OHS4P3srjwhALlt+a5lFqBMovfAweqiDLHdH6H8JoogJTu7VoY7L3C6pqDRb7UZN0xjdnru5BKxo8C6gEDrmZJiCtsEk0JqO1bbDBftIbr0HYH85NaE4hzUj6/Yu4Ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzDegfON; arc=pass smtp.client-ip=74.125.228.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzDegfON"
Received: by mail-ej2-f3.google.com with SMTP id a640c23a62f3a-c15e9a2f51aso234934066b.0
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2026 00:16:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785827768; cv=none;
        d=google.com; s=arc-20260327;
        b=JwERfA5tsqhaw9w84S+ZoxDNxpzBX4j07wXLvW83tl7LYbgvB5UDMCM4DSWAMd7WZ1
         TyCydg4TUQ3ekC88rILaBrPWP3zCfIJqL0zA5rHg8zJpg5D8QfyfG+eA8qtRbIYhA3i1
         kCZO6AVYMAq6gi1HEiyoCrErA/SoNolD+47uB3LxreW0NWfd5y08cXn+ldPqAZi//QeS
         ey3Ky2xWufgHGMIl3BRLL6ft0lZJxz9V/9INlkiSuBh1PLT9LZ9FwQd1mausE0MEzc8b
         BHmzlmlgz8j2ggaTftd94g5ogTE9a8P/5wa1aXd4TRHP9JOzbyORdOpvwGwRqgBwfm/I
         veYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K/bnHR74RIuJoZ4/iE4Zw1Cub3IO3OZ6HeJ8V4YWjSg=;
        fh=E3Qj3mUdVpLhmuM7Zy/QxvBv/wfxCTXmMZa3aYFT2SU=;
        b=OJVuRAewYJflDgPISkAoTnHaAJHe/5a08s+ht7n5M1DEJmPG0l8GImGwBNsdz0OG97
         NvvXWMSStWiy16IoyXxLOLS3t0G0YeMCDbNm471g3QjIfw8678jq0QVKNpEJRza4mCTe
         K8+Tq4nImG1vVusH7RogbgB+pnh8JUXGknSfKDDMRYEIS8CTNQkrWlUq4DPtQYLnXDTN
         UnMQlICWqUzjehaOEi/+rukkYEZFU7W28fXJFGe4bQjtxJIcrASjbO/Tds93sInn4gzz
         Di0dXXa4FPhzB0k2wxJCpL9DjKnakeM3UFjDtWogEdRz20X8tkT2cNM8fLGJf5PYvst8
         5NXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785827768; x=1786432568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K/bnHR74RIuJoZ4/iE4Zw1Cub3IO3OZ6HeJ8V4YWjSg=;
        b=IzDegfONN8jbhTMG8vVjqrK0LGpJyYIR5sAz0SP02NG5kwt2jAe7vZycwDPeilNuqo
         xztZUHfVIdLGOpDD1GuT+MkJSQaGPWmqdl4DGpMueAFsnDDS/0qeG3MrZeNzNDDssQ6e
         PAuqfKSZ2dUTedTv+qq7AWY4RJGyQjYOEwhP/xmpsUWQ3bIUahJr8Yi5f9bF02mwgwur
         FSfscYrym9xJ6p6xvRvUokhJWqW/Bo4L2XyktBgrf/pBbnHPgqLaADsn4fdqOQPfgbJy
         H/+CPw8KcYHF/5wHcnyEtTarpfabIiZtaufJ5OSLcbQ5FVEBC/TEVd9hBaO0bR01UNps
         ARZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785827768; x=1786432568;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K/bnHR74RIuJoZ4/iE4Zw1Cub3IO3OZ6HeJ8V4YWjSg=;
        b=fpiMVlJ0P+5N/7ZZVHaGGpwXv5it+4kMTWYYMOcYwDB8nk3uTKKSmeM5e/z41KEGKa
         KavrgJnFzz2N/8Z9C6qsd+KREsMjQRYD3i6EB9oCNnfFu4CmmILgHK0pdP/Ax2skumZs
         AjNxUQyQ8AyRnxpgQu0NF4h1WLwo47P5tbEvRNEIg/izlUe2qJ8UbUzLwqIkYfJ2b1bZ
         i0me+42ntvUJPUWrNwhmNJbDsIG4JepsPmkMxDAdqzDV6HMM9ejgs3E/F2sktFS6c7xz
         mWNtVxB9D4ctkkbMRsVwkK0MfpiVQHoqyyuxTvDo4Z2FPTdTh1X6YE4ilMVvkgT3swGy
         jWWA==
X-Forwarded-Encrypted: i=1; AHgh+RpaWABDvscxoFqd19AFPthxetN8Xh7aLIX6pSH/WHH4UKiCfVyKnpBZ4U3TU2ati0fCne5UbrIJx/uMTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkAISCjpFQ77Gd4MMmmCkqkHcHBusJLmtuiUHkL/HrPxWXGlY+
	MVsPATXRRPgDuRot4JSFHA7WGiZk535kvNdi4Uu17GPxe2Muy9GjcwrqL/PPZigxsZoS9eKwyA4
	tqQWg8NRSIkJDYcFihZ1GfaMcbWQbSpE=
X-Gm-Gg: AR+sD11g/46aojf/bzYXY10cmZ7h75b8/iIlNxMj4Ybj3523QWUYPRTi3CuchCC7max
	3U2M96CNfKazgDPUNAqBX5fcKLD2vNqiSdWe1anYVvgy57/oBJ7LxWfNxV9B345L8SzGPr7lqJd
	jJsrE96UKlvvZNER2mAXiyzv9XV2pS0Q2im69FfSK4dtIB/h70Tg04tWmUusKoo+LRreBXM0osr
	34hPd7J3F4kHMk+gBX9olV/s4eTHL9+J9AtQs2nextMOQNmVujTS4uxrIFGFpx0Ix+vHbcqcKOD
	Ykxu1Zc8HTRfsgSEX652Bp4ov9OPD91GWRUrtGYpDixse9b8E3cclMvPKOyiUJNE+L5k
X-Received: by 2002:a17:906:fe4a:b0:c16:7097:4708 with SMTP id
 a640c23a62f3a-c1fe8167babmr1257493766b.3.1785827767919; Tue, 04 Aug 2026
 00:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730060133.80233-1-haoqinhuang7@gmail.com>
 <20260803141256.60599-1-haoqinhuang7@gmail.com> <20260803141256.60599-3-haoqinhuang7@gmail.com>
 <anF4sw4jTDu5xUd9@google.com>
In-Reply-To: <anF4sw4jTDu5xUd9@google.com>
From: haoqin huang <haoqinhuang7@gmail.com>
Date: Tue, 4 Aug 2026 15:15:56 +0800
X-Gm-Features: AUfX_mwg8akhIy_U3ReIxoYURI9EnmFsl3JbPowfaAwXlube1yYkaQLkxBknfNo
Message-ID: <CAEjiKSkWPM3viBXNnFniukc9-OxXPgbmCbmxy-+7vrwVcog7yg@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] zram: reject zero-size dictionary
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 1:32=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (26/08/03 22:12), Haoqin Huang wrote:
> [..]
> > @@ -1700,8 +1700,12 @@ static int comp_params_store(struct zram *zram, =
u32 prio, s32 level,
> >                                               INT_MAX,
> >                                               NULL,
> >                                               READING_POLICY);
> > -             if (sz < 0)
> > +             if (sz <=3D 0) {
> > +                     pr_err("failed to load dictionary %s (err=3D%zd)\=
n",
> > +                            dict_path, sz);
>
> So for empty file this will read
>
>         "failed to load dictionary foo-bar (err=3D0)"
>
> which might be confusing.  I wonder if we want to separate these two:
>
>         if (sz < 0) {
>                 pr_err("failed to load dictionary %s (err=3D%zd)\n",
>                        dict_path, sz);
>                 return sz;
>         }
>         if (sz =3D=3D 0) {
>                 pr_err("failed to load dictionary %s (empty file)\n",
>                        dict_path);
>                 return -EINVAL;
>         }

Good idea, much clearer. I will split them in v6. Thanks.
