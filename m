Received: from mail-ej2-f3.google.com (mail-ej2-f3.google.com [74.125.228.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B2D2BDC23
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 03:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785296049; cv=pass; b=HhoT4xpPBc3u6V/dtmEVcM7Wc58863JV/iDAXHuTazp+XP0SnF4nPUV6QiEuQlfkjI0BfmNWuWBvh5E8zTTIjbNc1ZTW0St7mBIJLWk76xAHi2gFVfFARCmSStZ8CZSNnPcnMolkzKTi7vM7crdB+q0b3/XDfqaLQj+6l1nwycU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785296049; c=relaxed/simple;
	bh=0s+j3lblO1U9XoVYgY8stOfcsuFW26JqpQZJni600n8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AU9nV92EV3JUM2ykLGPNIXmXJNTuj11Y6Pe3X2s0Lr8q5pu/IZR+xpKUI3kou2Uv7B8ePEW9MDqUeEXU5K37Hlo8+e/T7MqPSA7V1Hi4EPeqW1CV2hv64xaMnIROfQ408fqROdBOJK4sAnwZPBnF6HS1QBnZ7lm/5z2BG7lCOuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adHqTCcO; arc=pass smtp.client-ip=74.125.228.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adHqTCcO"
Received: by mail-ej2-f3.google.com with SMTP id a640c23a62f3a-c160cba3944so30222366b.0
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 20:34:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785296046; cv=none;
        d=google.com; s=arc-20260327;
        b=qlCxa8qQEWrdxzow0CzcT8+9M8HY96x6yr+p0tD6wJ5aVP2zO9mPyrPPK4j36GlXzt
         rEEUBnZSi+g+na4KMffK3lwESsELUzJX/BXoh6134zIJKCidVEIt7Hq2zfP5VSvwbaHd
         7gJYrruQpPfGPRQBrV1TAlzQeXhWwSJ6ScxDPJO4ebdXVBf+g6r+kGXWa/RLVAGaxZc3
         aBQB/sssl2TbNpYe1O2xR2fAWHJJ+7TbSxWPNquSSxTUYFiicoVeVTb7uoLOSnTW9yeh
         KNnI2/J+5fIAvII8Pn8/1Q/XOMtbtFauDsHEzE+HRXqfJFI+MHInd4lS4os19sgNR/g/
         caCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C+k4d1aFHZKiH+rtQpUSdfUObyBh02E8rc+gRXFpmOM=;
        fh=FMM0tj0JQUUdHkshI1yRGHop0J6EsHjxIgGYIXe1dyE=;
        b=PDZP3snSnIU/JlcGVpKxEzYTeLOkRzfqYztz8piWC6I4zPFpamKQQ+B6rU64Ts/YfK
         P8mkGv40spJlbn9nkjgi9Sg4hG/V3YoT5L4DTesw1FRYKXsF7yr9y4GyMNND7Ij02LgQ
         oCwFvlsAJDYplA1N5yxW500VBr7k85eRx8qXbJZj4EmDDLHviZtlzJp6KVWHg9Zq+zPU
         Pppb/AY7vv9+4Ko7pYoTohj2qXBH5t2qqBC6VLKtKVYuwfKL/FAPmZYlaNRUJNPbQbud
         YJEHbORBFWTWYfAX5Rjl5POZgZoYGGrmghcxgbww4zUu4HHqd8JJYiV1JpzXeS7KVvsg
         q9OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785296046; x=1785900846; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C+k4d1aFHZKiH+rtQpUSdfUObyBh02E8rc+gRXFpmOM=;
        b=adHqTCcOtjsrnsfT2VnCuJfsCB/48FqLzxs+WV6kJMQojqs4to2T8nsI2OkJ09SbzJ
         6rgMJgRWU4T0yLGCOJntdsF3CsPp+oYG97oWSHDcAzBk1gqxy+6dbzkMDrLqO81Hkigw
         y8vQ0hk6Zvb2hU3dcH/Q3lrbFg5GRfyo7kiNKPHKKgjb3vV1H7IHwl+uyd//xnEz5C/h
         /zwVmOpnkSzCK0zhYOspp1TxKmHP1vLsp9JOXx83pCCuCTnz2/O0ij3TXiSSnum+tGrn
         i0+Mj13Ws//3e6R0Zqpxi5zbsE8IFn/AL/86OuQzXw8GrkpVVJjbIOx0VCc2qps38euE
         CVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785296046; x=1785900846;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C+k4d1aFHZKiH+rtQpUSdfUObyBh02E8rc+gRXFpmOM=;
        b=Q3C/uh9XkmehclB1jxlKEKMYylslw8IuJrD2plclJE3Ipf5+TZyN+RU3lA8u31Ncj7
         g7/hPEfsFxIF+3cZcVTk30YeFhXlTHMAOZTe6NjYXWPT4ORaokBI2lLyKokBDBXJToi1
         M1U1/lLfdjeey/ytvL04agpcuymOhxKMIzo9LP6FHIGA23TttTaIFqRu5pqDJBuxh933
         +SoBxls+OIO/t1rDM2Yr9zJPBAPHoO91pvuKgk/Psc9feXUMvUatGdJMf6igszTtFFkE
         es7NZhZe+CAl05BjLbTaHiS0/bLeACJK/sPxqieTA+buR2Qtmk91hQyNZVFyXE5sKMdt
         NKvw==
X-Forwarded-Encrypted: i=1; AHgh+Rqcw4fmnH1+FdnTRQQqCdbre9pcW2bXNi/yDKnIedIiZjQ5sHD8eV+r/9uA86DY6Jdfhv8yeiRBwKE72w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXF8IVwj1goYjIeZ9iAR4C+3A5RYJEDEHYzHFAqtnhxi3/BPTO
	/8Na/VzMNFBkT8iZ64rKOqwMEC0QketoEuWEt6c2RJKyRdhNnt/a1sP6Qo84EEv6Dy/wkk5h+Y2
	ULPkghsy8U1p/y7T4DZlQ1IjElNrUpdU=
X-Gm-Gg: AR+sD13W+hjqpTPqe7bL0tA7MTbwQtcpCgvuYyHj9V7ZTP09BXB1DOIDx/XVWX7iXmk
	oZdYZD88XBWVqOLdhjPntL85X4ywxhtgM3xi0FVWnd1HQkWeXqR1CcFy2qgPW5FnsZoa02h3ZP7
	h7z4s5v67bcONeg/h89n1+aKacuAUurzMs56brVGNd0FsDXyyPx2JbvI5UtlMW9ll87bSAbCRcW
	+G3IKfE5Yg/NzXT7DWFwp1EPIvcTqEg0Tatb47qvhnDXdEcAMc4Z25jQEaIAkFbfZcuLned/7yK
	ajiDS4iOHp1e7sRHLOyZEDIiOqssdX8L0uGczpHJmHboYw==
X-Received: by 2002:a17:906:fd8d:b0:c16:e69:d2c3 with SMTP id
 a640c23a62f3a-c1f7222467emr290706666b.35.1785296045782; Tue, 28 Jul 2026
 20:34:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
 <20260728092935.31139-1-haoqinhuang7@gmail.com> <20260728173411.b2cb2d88147fe768cd6497aa@linux-foundation.org>
In-Reply-To: <20260728173411.b2cb2d88147fe768cd6497aa@linux-foundation.org>
From: haoqin huang <haoqinhuang7@gmail.com>
Date: Wed, 29 Jul 2026 11:33:54 +0800
X-Gm-Features: AUfX_myJstdVJX_B30SskyR8EXkFRcpa56bOpg7vVh9pcG6u0Ramw87agomVXyA
Message-ID: <CAEjiKSn6EFQOM5hzz-ZcZrXHhM-qYAC9siZFuOeA8RORUqpmPg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] zram: fix early release of global cdict/ddict in
 per-CPU error path
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>, Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Haoqin Huang <haoqinhuang@tencent.com>, Rongwei Wang <zigiwang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 8:34=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 28 Jul 2026 17:29:31 +0800 Haoqin Huang <haoqinhuang7@gmail.com> =
wrote:
>
> > zstd_setup_params() creates global cdict and ddict stored in
> > params->drv_data, shared across all per-CPU contexts. The per-CPU
> > zstd_create() error path called zstd_release_params(), which freed
> > those globally-shared objects. While the drv_data=3DNULL guard in
> > zstd_release_params() prevents a double-free on the init failure
> > path, this is still a layering violation: a per-CPU callback should
> > only clean up its own context, not release resources owned by the
> > compression lifecycle (zcomp_init / zcomp_destroy).
> >
> > Fix by removing zstd_release_params() from the per-CPU error path
> > and replacing it with only zstd_destroy(), which properly cleans
> > up the per-CPU context without touching the global params->drv_data.
>
> Thanks.  A [0/N] cover letter would be appropriate.
>
>
> Do any of these changes have userspace-visible runtime effects?  If so,
> please changelog these in full detail.  If not, a statement (in the
> [0/N]!) telling us this would be helpful.
>

That's fair, these are fairly small changes so I skipped the cover
letter.  I'll add one with a changelog in v3.

The changes don't have any userspace-visible runtime effects.

>
> AI review might have found a few things, about half of them
> pre-existing (zram/zcomp):
>
>         https://sashiko.dev/#/patchset/20260728092935.31139-1-haoqinhuang=
7@gmail.com
>
>

I took a look at the AI review and there are a few things I can clean
up in the next version =E2=80=94 I'll fold those into v3 as well.

Thanks.
