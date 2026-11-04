Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793785141;
	b=JnpUYhpxI5LbZu8x2B4lAUGr5D0nsORGxb/L7xsVh2UQKurjIp2ECfoLdeCMSyn7SlhT
	 /ywkMH35QMTn30/1LU7kS+xqJqkJSjgXLwn1KtpWjLlXM07KmtwYy2u66DiwC2ckyvMRP
	 icOKKqefO8fY0mMOpJyZbza46uRlEwJtJl6QyP088BqQVUetFMn2NcGbHyQo10FyIq3AN
	 7X8TbciSdJFogsV+h3IMtfPgYWmgYQOijAWMOgBAHnrkGnH1oW0xt4KKb6ppK8yOP8G6/
	 3esxpj1j/ETo+7o7XTAjduTa1bbY2uqDzwDkUZNGY7iZdMDnz29ofAQa8JEJzkDU3CA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785141;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wyMFhiKAtvEArgIfEIeRhVp7bZV2wi7+c/PirP/xKIQ=;
	b=czT0hII2/dz44VJnIoodMEkveh4rCDPoS+7/2D9JYRAr5iqZKwW3wgR2W3SNmNOnlgg8
	 3veI10BKENvjCIteM2GDos0zzYz1EwegD9YpRucdT/FHZ9/ethPN4oWsuEQU5/KNk8wDX
	 xSg2+LZdyDcH7ZEpn0vDXXOyuIzHIdBDUPryN/wQlXzitZwdekWUbwPIb+dnd8VcysH/l
	 f3wlociE8ocS9UVq2kAgtSfWoLm06zLBPS4DW7ua82XTWdmCLdlCZA0qeQzLAK2EpX8ic
	 DR987b5UKhfnoGYrPX7VhOaTWA1dJ7LwfJOPav78aAPVd7GEKuXdYU1MWWmFLYA12LQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MWcuwFVU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E3A606A31B
	for <linux-block@vger.kernel.org>; Wed,  4 Nov 2026 09:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1E3A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MWcuwFVU
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-82109f51565so210153a34.2
        for <linux-block@vger.kernel.org>; Wed, 04 Nov 2026 01:39:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793785140; cv=none;
        d=google.com; s=arc-20260327;
        b=HKgYS4x34NnFIJLgUm9BlFk4Yv8DVszV77egOehluOWUlnxcjKSZVEV/j9ZpyYdTlF
         Tg8jK5NnunyZjwlLf5E8oKHbW4gWDL07gywJxpa0E+vvUCqBv8epDn/Vv4UNwZ0Bycty
         aXqE4YN0d8rqIIR8ApvjM2ttlkXWELB32TsJ/MlsYsjxBx5YuG+ImzK1glbClm2OlFSF
         /ahuFlMPDr7F21Ksf3ApHdLPxtGOf3JCdHwTaDxyW1X2PQ7tlVHby/SIh/2AKd/i7N5t
         pwnxz7+XZ6V25LaAWlVZv+vTnjohRQ8nVQjpR91DeRi3tPm8YoBCaGQeDtu0OSr8KE5F
         D48Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wyMFhiKAtvEArgIfEIeRhVp7bZV2wi7+c/PirP/xKIQ=;
        fh=U9Z1nDmqhQ9Mf2e/Ryez/3D0U4WrXLUJE1KEQfF6j0c=;
        b=kDUDLIXjHcmpduk2eqYYmn66UkXGMFezo6bZuh5WGRNq9bNJPyqBCj5jlL8exq+U2q
         Nhyk/ObwR+SUTrFSt0cIUjxsQqaMK9JiZO893Y+2N3HfVdx7HCr+JggHE0m/RtF+tRmV
         14dxf+rLJ2mdE9aDyCAvOMwUQZJaO/6wXODfJYDLaoTGkH0sdPP/+abRNXlZk823BnZR
         w0H8Euw2nr0XNQ1GXINI70x8sJal04Ult567MC6SGssOgizrRCk+e8u/hlDzjYLyN+Ry
         xD4V3zg+b247kV+XoCr4aDbDEPlugchwMdhH0DSw20M+wAlgH4ziaYzD7irxJQEYrAjz
         WpmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793785140; x=1794389940; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wyMFhiKAtvEArgIfEIeRhVp7bZV2wi7+c/PirP/xKIQ=;
        b=MWcuwFVU34g06UlUcqUa5sYEJmikRLRjgphlE29xhKOD4TvHCz42xKRoY64u6NKHes
         xjt2Kmn/+YdToNLJkWPcGxIGbaaJ0wY1ZJbTTTZQD3IF/wRS+fSSROUlI3wyd+yxnKYc
         GQPSHj1gm3g/8wCHIXZ3oe5us6mBgP1dC2jQP5aBVk8OhZCVs1sZkIcMVJMecAjJXasI
         Og2OaHXi7Q0Zb2oFPTlydcj73h3lDupKulNOH88sy8HBskjJam3fsiYqJeYOxJqCxyVJ
         TnTTf5Y7SydEjaXW/BvIYuv/FteX8czVREzaVxsDiMkx0vrx0ASemIuFyUYLSKPjT3Bg
         Bkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793785140; x=1794389940;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wyMFhiKAtvEArgIfEIeRhVp7bZV2wi7+c/PirP/xKIQ=;
        b=pqGeygzFYINp3UHZuZjoBZfqMuqKgcrsKM8LR+/Kr/rYIAHbnmhXA3uZBfpGguNbqX
         r5EDEg+dYT4Y6QXKkAhVnNQ8T+SlzNpumgJ3KILLZRivD/RwGlrWP8hJWnIGRjrlrIJj
         uk1kCgV7FBRL/zYRroKiKYmlFZ3o0bEjRWqK50X1qz2uBlFh+xlVVGYpZJDuUNMal2aD
         2V9dg8kFF1VMBQ+jEBIeKzErwr6b42039lZIirwEcPhIfHVv8ZVo/YdecK3DXWwWf1as
         XpgJePaIC2K7AEf+wfNPIZPeimaIHPmb1SXV3Eje2WMw5RWWSISf3BILH0BORCtIl7WH
         vr7w==
X-Forwarded-Encrypted: i=1; AKwUvBye5sIX2lEb7qLnuD08GT70Zt2y+F/zs8/zTQYwnMOysksvsQSBuolUB4NGLBoufa1+g5b4il6cV3BU6g==@vger.kernel.org
X-Gm-Message-State: APuU4Z+Ld+evl0wtMgvNA1FXAR5GBXF6q7652/ErCygQwxRYF44qXwwP
	6EIKGfT4Iq/EgsKp6NSVxQ7YbVAnQDB4AQy1aLQTOLud5oSWguXbu2uF7aXyqJI7trFuMD+wJlk
	dKBV/OorZt5aKhrkw5y612UOBOZB61xw0ZrT1mGQ=
X-Gm-Gg: AYBFou25WCDU4ZXd93BlBEPBOGgvS2J5iCAM/Fno1LvSxec6PPbazIjSFIVrCdvXENf
	g3aozudC4N6+8VMcIvli3oJp2N26CVLeS7XK63FMEkmVEJLnL76S2tLEuULaulABrJodM023Xxv
	Si8SQzIe3v95eBr81BPQAnKvXceGIUwdRZ+kofrnuKZ1nwQbARII91i66K4vwyDlr5wwGbvIF0G
	c5NZ2CzjOJtUf64BSkLUkqRfyruGyq627iiV9BeV78HbzuoBsbztClAKQIheDG9x1XJaUsad/Zb
	s1zrRt20ZR8Sv+S6UEs9MmZklN2jr//iDmbILBzSwsIKba5X7kb378ozu8a6jzxoXU4Y6LGN3kF
	isDjRlQaDZ1S3mleKAFwiYxxelufdPOKL2gEcpsqO3392jiGeIS6BzTiGu77P/hQTcfi6rcdqZI
	nXN7Vdk9WOOX21fjGiiBnZVtNpNA/NV+n2heYy
X-Received: by 2002:a05:6808:16a7:b0:4d6:92b3:5c85 with SMTP id
 5614622812f47-5640de991f8mr9890887b6e.66.1793785139973; Wed, 04 Nov 2026
 01:38:59 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103163928.641519-1-sashal@kernel.org>
In-Reply-To: <20261103163928.641519-1-sashal@kernel.org>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 4 Nov 2026 03:38:47 -0600
X-Gm-Features: AclHuK-ajlXUEOlDoBUIXIcZPeq0dPA_3c3hkn84_pIOTF1sCe9cDuF4iuz_gxU
Message-ID: <CACVXFVNJp-aWqLDR+Vy=VyNzHzPjGiTppYBYYGb=bGs5CvNRZQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: ublk: fix the build and file offsets on 32-bit
To: Sasha Levin <sashal@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 10:39=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> kublk puts pointers into 64-bit UAPI and SQE fields with a plain (__u64)
> cast. ublk builds with -Werror, so it fails to build on 32-bit
> architectures:
>
>   batch.c:379:42: error: cast from pointer to integer of different size [=
-Werror=3Dpointer-to-int-cast]
>
> Cast through uintptr_t. kublk also passes 64-bit user copy offsets,
> which start at UBLKSRV_IO_BUF_OFFSET (2 GB), to pread() and pwrite(),
> and with glibc those are truncated to a 32-bit off_t there. Build with
> -D_FILE_OFFSET_BITS=3D64 as well.
>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
> Found with 32-bit builds of the selftests (gcc 16 and clang 21 with
> -m32, with and without -D_TIME_BITS=3D64 -D_FILE_OFFSET_BITS=3D64);
> KernelCI's 32-bit arm builds show the same warnings. The changed files
> build without them now, and the x86_64 builds don't change.
>

 Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
