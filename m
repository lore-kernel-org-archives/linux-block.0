Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593B4263C7F
	for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 03:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776915241; cv=none; b=m0gTYA4Zj+pfA3A04kp27a6nSDcLTnOzDvbhGeeGj3wtq5KvpcDA5xxP4Rmqk9leItMufUOYo52EnU3S8rehuNiy1eH7F5YgpcqfRHiD/ZHiPLjwDOVxXtqdArX+tFTjje+dOPUPUf5Paq2O1TQW05ret7uYw8T2Zq7w45uhF8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776915241; c=relaxed/simple;
	bh=4Mi5pvZ9k8mNNJE5H4f7/P/oe6f9B4eoCJGd/FmRJf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kiAXFYgeZ+jBUv8mCeQJAl5ODhEo6ntDL3C4ujEvWw/wTiaE2o8j15zNWhmn/jH6oa/B1LQG+jy/Yg7iSaUVtzLNEvrODojrHb85DkKhyRyfpRjHA/S/k5Y+Q2cDhqa6cs0Rv8bFbCFijs8GTPBAkfpp3nNGYxRCI6taqnOuRGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b9c603ec2dfso824082266b.1
        for <linux-block@vger.kernel.org>; Wed, 22 Apr 2026 20:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776915239; x=1777520039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+UoV8TJNU9d7JsyCvHY6ZqJ1hKcCCjuQv+G+AT1qn1Y=;
        b=TWcEtJT5ZSMPeiQ4DvRIUjAScGIpBEMPCKA/OpY3EXcjpN2U1s+LW7JJL8/v5zczl7
         hHZxQbp7tM4vJn9BITzwQR4kHjCm2Mdk//mMEXXXimwTsXrjV3V+Got7z1P9sbP1oTl+
         Cvrxnth7jHNdFrGiYyiOLXtDc3uu+fOIvL3zYl9qGcdBedoOf0JyCOejrhfY/dLlMwcT
         vBxYdH6pisxlqVZ/tU9CuaBppqnDMVs08vNE71iIEwm+AzN2k0+EK1ZWPSs1iIbAGfpW
         jGdNO9EUxkRv5arQhdtEmeTw7s1l5BP+n3QkGZ/Jnh7bNeW0ifeXQ5eIqW7mNi8bZ80A
         5Ipg==
X-Forwarded-Encrypted: i=1; AFNElJ/135LqNATPO6hAqETLt5NmEmT/U3x0TUtPaqEsnPaXvyFw7dP75NOmkNJFdV617sYegtSqKbSrYIG/8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwP3chd3y96HNu7hufynlCxmMgdCVT/WuOKcZVt/QXSYiWJSGqb
	J0Zf6R05zULc86j84rgb3XED9oOG8wApGxHhmUCu92rkoE7AMZwz0dWLsduNe1FO2PTiAA==
X-Gm-Gg: AeBDies2b9dPD89fdpZDzw77UhNuCNnfpn2tOsqAVjPoWeK7m0prHTobsNW3qqtDvWM
	/g4jtqWeoEu1OBMHrH6QLRaTCRtYGx21hC/V8S+leqf3VZkzALeW4LYU7yANLz0+mQq5sWhbCur
	9b994W39cBgLV1yhEJethlXGMluG/jSct/S/4I3S5hTNN1dJuZgwEz84BzdeoYzoYtX5mXHewIs
	tjyzlQTdtsBuEFUYYwduzATG3+avMXv6aPom+1gFJuZ1d3iwtE3YZgvXnOI5WA5R1TtNZT5cyVp
	KB0YsoUhtK7o3Eg/wosD/tPLZ28OQXSdjzPzqsDyd9UGqCec1YFcK94af2tzAG8kVN3ENUmRDyO
	v8OWmUUou2dxU2Er5j0nAnJIR7s3UaoCgWDnDYGw3ALpr6YWkkEP8iYadJJVY1wH2DGK4wU6lni
	wM/uCZ4BTyTCZDOMfPqFSDBiDMu8cZn+UiKfUoNq3FGM/L0f5FF539MnIOLIHRxscozw==
X-Received: by 2002:a17:906:4fc5:b0:b9b:ddb2:b1c1 with SMTP id a640c23a62f3a-ba418f7f625mr1133248566b.21.1776915238433;
        Wed, 22 Apr 2026 20:33:58 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba454d1b694sm623897166b.29.2026.04.22.20.33.57
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 20:33:58 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488d2079582so72096395e9.2
        for <linux-block@vger.kernel.org>; Wed, 22 Apr 2026 20:33:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/uZd1S0x2R1TDMCdIYJlgxANdWWf0YB1ahSCDO6X1+XCVQvcjIqoycPIqu8F33z8NheHH5H9EVKMfCCg==@vger.kernel.org
X-Received: by 2002:a05:600c:1f83:b0:488:8840:e5ae with SMTP id
 5b1f17b1804b1-488fb787afemr351824795e9.24.1776915237499; Wed, 22 Apr 2026
 20:33:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420020327.1667156-3-iam@sung-woo.kim>
In-Reply-To: <20260420020327.1667156-3-iam@sung-woo.kim>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Wed, 22 Apr 2026 23:33:41 -0400
X-Gmail-Original-Message-ID: <CAJNyHpKSu1eEbuhHsocu7gQ+TbSpk3PeAeeoCxuMPSDFW9iRXg@mail.gmail.com>
X-Gm-Features: AQROBzAIUDu24DQiw6CZUPNyZnNR9MVgpLfZgnYYANvJ0w5IEXf-9g3LMVc3T14
Message-ID: <CAJNyHpKSu1eEbuhHsocu7gQ+TbSpk3PeAeeoCxuMPSDFW9iRXg@mail.gmail.com>
Subject: Re: [PATCH v3] Fix null-ptr-deref in bio_integrity_map_user()
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Cc: Chao Shi <cshi008@fiu.edu>, Weidong Zhu <weizhu@fiu.edu>, Dave Tian <daveti@purdue.edu>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is a follow-up based on Sashiko's comments.
https://sashiko.dev/#/patchset/20260420020327.1667156-3-iam%40sung-woo.kim

On Sun, Apr 19, 2026 at 10:05=E2=80=AFPM Sungwoo Kim <iam@sung-woo.kim> wro=
te:
>

[snip]

> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index e79eaf047794..c8cfd15fb589 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -402,6 +402,20 @@ int bio_integrity_map_user(struct bio *bio, struct i=
ov_iter *iter)
>                                         extraction_flags, &offset);
>         if (unlikely(ret < 0))
>                 goto free_bvec;

It's pre-existing, though, free_bvec does not kvfree(pages), leading
to a memory leak.

> +       /* Handle partial pinning. This can happen when pin_user_pages_fa=
st()
> +        * returns fewer pages than requested
> +        */
> +       if (unlikely(ret !=3D bytes)) {
> +               int npinned =3D DIV_ROUND_UP(offset + ret, PAGE_SIZE);

If ret =3D=3D 0, npinned becomes 1, whereas there is no actually pinned mem=
ory

> +               int i;
> +
> +               for (i =3D 0; i < npinned; i++)
> +                       unpin_user_page(pages[i]);

... which results in invalid access here.

Also, pages[i] can be ITER_KVEC, ITER_BVEC, ITER_FOLIOQ, etc., which
do not pin memory.
Thus, calling unpin_user_page(pages[i]) unconditionally is incorrect.

To fix this, call unpin_user_page() when user_backed_iter(iter) is true.

> +               if (pages !=3D stack_pages)
> +                       kvfree(pages);
> +               ret =3D -EFAULT;
> +               goto free_bvec;
> +       }
>
>         nr_bvecs =3D bvec_from_pages(bvec, pages, nr_vecs, bytes, offset,
>                                    &is_p2p);
> --
> 2.47.3
>
