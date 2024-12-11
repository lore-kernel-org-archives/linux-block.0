Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13351ABEA5;
	Wed, 11 Dec 2024 02:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733884722; cv=none; b=dUmdP8UV5aN/rGXFiWKBodYD3X72o3vkkpBEnqdqMeHkJ9rFpJVq/WeOh1kvbTmyWuhhkTmf0TK7n1/UitY0kiHX1tkFtgiIDRJiPK+34Bsh1UKtTt2BTNqVD9O392x0Fe34yqAFzt1iMSDWmfoaUd1hyQQJPBMWcXR7cxmpPcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733884722; c=relaxed/simple;
	bh=4OLQwQO0LdwaulrgdF6TOJDcMwzUcT+bJ7H1QUHqX3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nhd3sMZTSpfLRLWhZNhssbxHzM1RIXV6/XYRV1NTr0YMspcq/dulZnXiHpDjrKhcFiPq2hiz7Lh+OuyjvcgawwLGFSP1dWcc2LZTOFaJvuDD6DhGisFib8fEQAZUJkLmVVDz2ibgI5b8JFZ6dKiPeOEXRrm5+NWa4GxsKHdd7Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEm3QReU; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEm3QReU"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3862f11a13dso449327f8f.2;
        Tue, 10 Dec 2024 18:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733884718; x=1734489518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eI+hPb6isny6xU/Mw22BE9CM1MN0WgOmna79UINL7uE=;
        b=kEm3QReU+eIh//SNf2o9MMDCWgSfpDCx59tMTHtrZlzZFsBUl5H4CefsmDQtdYc3qj
         r1UCKE+M4vFoHObaZL06eOzDT5K1odflNIpTT/Ti+Jex1YrZvbQCqR8E0baFOYILxApj
         qLaPofD+uU1yM8U58UN/MrkC8wS1Fxa6aj9B8mQQWdg+OOXq01FC4qqRq/bn1FRyVJXf
         Kqvzvz2WDaCR1I2GBDWqcDFOjoSOu8xYsf60T6Z1D5xvCuylehYRfeV6l12AlQAzaW1f
         pL8FtGMzV9gZOnsIp2H3qf1TU55sxW3NFSscu1Sn7docH7wclrBw1p3XIJM2tqUnMnZr
         n35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733884718; x=1734489518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eI+hPb6isny6xU/Mw22BE9CM1MN0WgOmna79UINL7uE=;
        b=D/zdOOIUNDeWuc1FiK6209eH4oESzowZ3T41mUP84WlElJGfgZPMX30SwucOw7kZ3d
         qVUONwYJX+49/zGpbpFIfmllonTN5wtnific7qWRmwPxGxMU9SruuKSQq98mUkXnH3n4
         S8nStx0ZRaflyXLMQp8uPSXzWKnXsHsM6K6P4lC7FZdztL4K0kWxjzu4R9S85tBEVsT2
         om/Hau5CP2D4GVLxSYf74JvH56P6/kZa/ZMtlceSrTukx/d9mFUR5Umy58Cj8SwrY/In
         3GYWJLopZpQWTuzJyLaMGnc+wdkCniqoABNY4gTFe9ICVx+ImuZy3KCsFkHG1iLjohEc
         fSxg==
X-Forwarded-Encrypted: i=1; AJvYcCV10E5mQl8Vetxiw0EpKcg8/SJmoWqjVfu8vX2NDbfNk9xUOUK2g8ziR7j3gzNmFsdB35OMoYu2WBJgQg==@vger.kernel.org, AJvYcCWoPUcMpYpcrJsVDxp+isJi67aJfBPLMKOku1mP44d2DuEQqp8BbSNk8Txh26v/ocYzYP8tFweK/d6YuHQy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4VGlCicTVId3thTy5QC3DMfkpJ0IeniBzwVfmzzmsiau1gk43
	WEWV+rADEwYd93OcDFp01LrhDxQM/kY8LP11hGJD6C4FqUhjueHF17Y/ZLf8fTq07wf01di0iim
	U54KoI2tMTJA3C807Vwm1h4I67Ds=
X-Gm-Gg: ASbGnct4jLazk/bIDUo5K0g0n/J2Kr9Z/0c/hE7VulMGmAmd38VbFvVKbHG9rJRElfe
	tRhXfmKXQGCuEDGF7CJcOcWUPnC70mqtX/LIx
X-Google-Smtp-Source: AGHT+IEXrBFHN2Zc2n+KTcO5hImGo+X0S04uITF8TJNMKxHmx8tnI06cHhfEH6FkFqf6i2PcWNNYECd772oeGVJ362I=
X-Received: by 2002:a05:600c:510e:b0:434:fecf:cb2f with SMTP id
 5b1f17b1804b1-4361c3af2bemr2303305e9.5.1733884717627; Tue, 10 Dec 2024
 18:38:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209115522.3741093-1-yukuai1@huaweicloud.com>
 <20241209115522.3741093-2-yukuai1@huaweicloud.com> <bef7b96c-a6cc-4b83-99b2-848cecb3d3b1@acm.org>
 <6e384b29-50d2-64bd-0d08-fc0f086c1cbd@huaweicloud.com> <7081765f-28d7-f594-1221-6034b9e88899@huaweicloud.com>
 <d9733af5-b16b-4644-9d6d-84fbacf334e0@acm.org>
In-Reply-To: <d9733af5-b16b-4644-9d6d-84fbacf334e0@acm.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 11 Dec 2024 10:38:26 +0800
Message-ID: <CAHJ8P3J-KwGU_ZffmSmoFkhUX1q=9Q7Dk15yPEXYME_JQHH5tA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] block/mq-deadline: Revert "block/mq-deadline: Fix
 the tag reservation code"
To: Bart Van Assche <bvanassche@acm.org>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, akpm@linux-foundation.org, 
	yang.yang@vivo.com, ming.lei@redhat.com, osandov@fb.com, 
	paolo.valente@linaro.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Bart Van Assche <bvanassche@acm.org> =E4=BA=8E2024=E5=B9=B412=E6=9C=8811=E6=
=97=A5=E5=91=A8=E4=B8=89 04:33=E5=86=99=E9=81=93=EF=BC=9A
>
> On 12/9/24 10:22 PM, Yu Kuai wrote:
> > First of all, are we in the agreement that it's not acceptable to
> > sacrifice performance in the default scenario just to make sure
> > functional correctness if async_depth is set to 1?
>
> How much does this affect performance? If this affects performance
> significantly I agree that this needs to be fixed.
>
> > If so, following are the options that I can think of to fix this:
> >
> > 1) make async_depth read-only, if 75% tags will hurt performance in som=
e
> > cases, user can increase nr_requests to prevent it.
> > 2) refactor elevator sysfs api, remove eq->sysfs_lock and replace it
> > with q->sysfs_lock, so deadline_async_depth_store() will be protected
> > against changing hctxs, and min_shallow_depth can be updated here.
> > 3) other options?
>
> Another option is to remove the ability to configure async_depth. If it
> is too much trouble to get the implementation right without causing
> regressions for existing workloads, one possibility is to remove support
> for restricting the number of asynchronous requests in flight.
Hi Bart,
I think it is very useful to restrict asynchronous requests when IO
loading is very heavy by aysnc_depth.
the following is my androidbench experiment in android device(sched_tag=3D1=
28):
1. setting heavy IO
while true; do fio -directory=3D/data -direct=3D0 -rw=3Dwrite -bs=3D64M
-size=3D1G -numjobs=3D5 -name=3Dfiotest
2. run androidbench  and results=EF=BC=9A
                orignial async_depth
async_depth=3Dnr_requests*3/4      delta
seq read             33.176                                216.49
                      183.314
seq write             28.57                                  62.152
                         33.582
radom read         1.518                                  1.648
                        0.13
radom write         3.546                                  4.27
                          0.724
and our customer also feedback there is optimization when they test
APP cold start and benchmark after tunning async_depth.
thanks=EF=BC=81
>
> Thanks,
>
> Bart.
>
