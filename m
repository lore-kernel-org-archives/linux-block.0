Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADB931E859
	for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 08:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777536041; cv=pass; b=JwcF4nLMoMK0hSzoK5+SotTIyIYbCzuZUCMlue4o9AxQHDwXS1WIyusUvrKLHnttHrkfelUvuCZt2tORTnSf1xezPBB+4x5FvTLRS79arfjsQ1DMhuKmxqwzGBcM3EhrneMrbVfJktAm6zrfqIL72ZK3/a3as2S71zCl4nDO31E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777536041; c=relaxed/simple;
	bh=36PaWoPFs+txlUAiRjBZBo/BQkqat4bgSiOvPAcyWis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDPp1tgb8ETu9Yq7eZCUSHeQ6FBvUSN0nHVs+M7oVrRLNAg9qPpGZkDBGjZHEbTyIH1TJ8fFMx9NiVwCerXmbvVJLsqlb1BNneMT3aFTC8jfL+fIhHk2Lg06MsIRybDflP/FRMnguQpuG3srIibjqMRBC1nZdEY1syJLYnUgPSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBotcoJd; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBotcoJd"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-671c5eb7fb0so692251a12.3
        for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 01:00:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777536039; cv=none;
        d=google.com; s=arc-20240605;
        b=DjexmdvSFwOtEdWTb+7HKIyiGSBcv1xOY3+EhYP7QtQ4HfzIlyagp9fxyjQ2IiZDVv
         FOrMx6Ri5peNODjzj9bcsFm6YpV9y9515DNLWMKPMz79b5RwQ6XtF3VlYS5s/LrOEWX3
         3OV3/s4v51NM6L02Wm2aeUqGXcZOKmDumCfKzaUXnGX6nI26XSWBKTNIrANPGvJA+6qJ
         EQWcqvcYv2gNabOPyj0a7SWTnK7brFp7Uw2Ez46l8//5KfBiLVSUq9g9G6L20kmeqLR0
         Rr7U8N6fGDRkKFbP1+5SDVN0Tmt+8rmP0NFEagU8JTb+IoDKJh+LamksCV+P8MXyrO4M
         YtZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=395fctHYQWwzFa8cn8+ZgdKCuiD4fH+LQX11O5QnDXA=;
        fh=dslC+SQ8alkYEDyNNVIghKlJt8n9TqIHf4X2mxxHE7k=;
        b=N3PX5V3VJoF5dwLeQcNOgyzxuN/IHfLvBzoPS/Iye/vYHQlSDGMqVUQXfUXnSCaeGQ
         YdNMb8PtIN6QuXf1rRxA2TsztAfMFVn9QsuqrJ8s4vKliYQAJguFowgj6T77iidd+w+l
         B+uFU9jsnSbT54wH359EDQn2ZTONTlZXvFSWoiHRn38VpDCQeOTEZf3dY3B0Ycq8FR1U
         KDtH0vakR8IgagwVc3M+wPg+c6YNZ4ITtCSVMOwY9tWWVpPpcqmaCENBSA4/ZIyon/H1
         Hxe258iuk767I3KgbfQ2CAscsqAzKL2zMHl0WqFy8c37HrFdQ+gKln3RTindQdxpHfO9
         gufA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777536039; x=1778140839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=395fctHYQWwzFa8cn8+ZgdKCuiD4fH+LQX11O5QnDXA=;
        b=OBotcoJd/uFfRDIZMehJM4ARgtjSzZOPJNh41f+jzEWKWL/6m5BnVVcE65pGPnBAl+
         XsK0X38oAaghF4KTk5yHXVvxlaXjeNDSN1/5aPHkU2Wn9Je5IgTbLcw5FmiPDM8FDJwF
         Kr5VlpUY6JVBdPaSZgYbHd/alhxvbpWzdhjOC9h7YFnSH8aXD29S4uIQ1GPvbrPH18Qx
         2Kc9oa0hHYuFrI+CrVbJtHUf2RtZYEct8jVNeD6lW2OM6eCgkYVkv3bqhavXhEDHXtww
         TGwokhLm4WuRxbpuaXiCVz/hOEnf3n7e8SVlnz1UATYhwcvdkAHuo7ZkQEeicMV/OgZJ
         d4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777536039; x=1778140839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=395fctHYQWwzFa8cn8+ZgdKCuiD4fH+LQX11O5QnDXA=;
        b=rzuvrhzDcxdWzztAyGTpHH+cMQPBnMVTtzPpQ8rI+a6sWd6FAcgWb7rceRVrOKkFe5
         sUn1S/4rycDeCj0iX/cv5FQr00JSyypOaAV6jQeFe8YZkVlR94mIAVhien4kVqwkOtSs
         07RiYmpjiDFVR26Ul+VY63cAUuUteapBNn2h89RdWJPaQ6xTizUSG9Ckwb5jePvzlnYq
         0oSTZ90f7GcD3XQZfVChVcouplk7s2lKeFsZZ/UXBR0KiHP754kBX3ehkKkwuNlE9yMk
         ta/DipT7hR6be9phTawzATeqHKkJ9hD3B3J14ZrFVuxiS/1iLDWuC4WcrMG3doesuq5Q
         Kusw==
X-Forwarded-Encrypted: i=1; AFNElJ91HpvLe4WU3SU8FL6wz3kaXjyIpQ4+mdnHKJg5nO9uWp4diAxk89R+leERJ4WrGp0Ac+kibLHJyCtMcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsR0XPlV1qhV8Blrk6hbQJQvzn8bMOHWYY+Yu6oefcCVHv7MCl
	sWwQItXToN2EReRp4pRP7v8Xe95gHsAXZKC0FY5bDK3HqK8TdcLXdTaxW/HMOPmrH035kE3cUAJ
	TuB0LNeE84A52uNtndrZ2z2e5YALgwSg=
X-Gm-Gg: AeBDietS1MGmvoh9BkPpI2CGjXFVKJAztV5tT59NO9IphxdJPxhh5Twp2VlMCt9jKS2
	IJyoKfQxfz3e2s/tUpqgyHwYMqSq03nCq5NMVW3cj2NRn9dsnMLXEx9ZMtZgoWOvCClF/MP4ByY
	wZbmH1zdwOxmv9ad2ERSjr5C5mijmqSpY2THZ+5uIS10d1zoLhbsrIzse6p/2lwwBwCV+59zq1y
	nm4eFtN1KA2SPTYIxtJclceQmW3Itj5jPFS/UAYKDcC8Afe3onmzeZCTPzwctmEo2+gDmK+L9XT
	4Y9LtdFmmC+TvjrAg17qZGWcFns+lQ/gabdmLmg/UdoENz2BZvk=
X-Received: by 2002:a05:6402:43c9:b0:672:c1d6:6855 with SMTP id
 4fb4d7f45d1cf-67b5d7f0ffcmr904050a12.3.1777536038269; Thu, 30 Apr 2026
 01:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421121616.3298845-1-haowenchao@xiaomi.com>
 <CAOptpSPs-1UrEa8AHg19e590=SiV6bpnex7gCbif8=aY7BtpuA@mail.gmail.com>
 <CAO9r8zOjugCwWqHP3zxXPmjp8TwpoROCjCqTZ_uxOBQwVqCWqA@mail.gmail.com>
 <CAOptpSMQyyb+q-VJdJ0RzNkjaer1CTePM5WkwEj_7cAO4aUToQ@mail.gmail.com>
 <CAO9r8zPV=c9v4Ar7t+xPxyptSUPrs-shrumsz=hCaNa3anGgAA@mail.gmail.com> <CAOptpSMLLz0yzg99nkAp7rxO5RphTDU3Cdqd8020mysijN_Bvg@mail.gmail.com>
In-Reply-To: <CAOptpSMLLz0yzg99nkAp7rxO5RphTDU3Cdqd8020mysijN_Bvg@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 30 Apr 2026 16:00:00 +0800
X-Gm-Features: AVHnY4JUDXxYwGV4I-0DZLfShsE2CFdXite8U8qZjnWjSdYjgnJDy3B4Cqq7FUY
Message-ID: <CAMgjq7BTM1HKWwSTxkm7br+L2MDy7=OxEvF+yDRJfFfr24TiVA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] mm/zsmalloc: reduce zs_free() latency on swap
 release path
To: Wenchao Hao <haowenchao22@gmail.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Weiner <hannes@cmpxchg.org>, Minchan Kim <minchan@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>, Xueyuan Chen <xueyuan.chen21@gmail.com>, 
	Wenchao Hao <haowenchao@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 3:43=E2=80=AFPM Wenchao Hao <haowenchao22@gmail.com=
> wrote:
> The data I shared earlier was class_idx-in-obj only =E2=80=94 no
> deferred freeing at all.
>
> > I couldn't immediately tell by looking at this vs. the cover letter.  I=
 wonder
> > what portion of the improvement comes from the deferred freeing?
>
> On top of that, we added deferred freeing in the zsmalloc
> layer (per-cpu page-pool based buffer swap + WQ_UNBOUND
> drain worker). With both class_idx + deferred:
>
> Test 1: concurrent munmap (256MB/process, RPi 4B):
>
>   mode      Base       Deferred    Speedup
>   single    56.2ms     17.2ms      3.27x
>   multi 3p  153.2ms    51.5ms      2.97x
>
> Test 2: single process munmap (various sizes):
>
>   size      Base       Deferred    Speedup
>   64MB      15.0ms     4.3ms       3.47x
>   128MB     28.7ms     8.5ms       3.37x
>   192MB     43.2ms     13.0ms      3.32x
>   256MB     57.0ms     17.3ms      3.30x
>   512MB     114.4ms    38.5ms      2.97x

Hi Wenchao,

One concern here is that the total amount of work is unchanged. I mean
you observe speed up because you offloaded the work to an async
worker. But when under pressure these workers could be a larger
burden. Is it possible for you to measure that part too?
