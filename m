Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038F0352C58
	for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149524; cv=pass; b=LUuQvR1pCL/NLMkiUU6ApAb1008cF0d7NhlgQpU8sDJF3mq2HVLp2ShHNMuJrMOpZ5lBAxTjgGLpHpCIHrH6kH/oEtcqgBVgfXgFZDzOxVfgblprcZ3gHd0B9yhw5WArdIkyYsZnG4I4M18jD2jgJEoPWZgoo5fSxoLIoceQsUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149524; c=relaxed/simple;
	bh=oR7yZ7p110w4YDqSp6iwoHTcaw6N6KC0iH+SbjywiYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kV/OqSm7Z8poQseRbkyrijXFrbOgsRMRkfRQZsRsyEYic3D4gv3z5skCRn69Cg6a4mm92Zf9m17hYWDe0dLda9oUUEZRhYVz2Aduat5TgKTH6tWDLSQzDTcIG9S44kosRiD5eMAuXRhBvFdQIZkOStXmFz+xMc/rrG3ENVKbFc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dibsIwD8; arc=pass smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dibsIwD8"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d744540081so1375297a34.0
        for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 06:32:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773149522; cv=none;
        d=google.com; s=arc-20240605;
        b=erVUf5KU8AXOutss4ed4rzx3CXLCE/mEctGS8c+fXwbXAP1O1rGcu2CnZaHX9ocAFt
         hH/R07D58Ta9vCBY4EYZqRLmdwlp+EJm045RA2eVKzIafbUuBaRiYQkDdC67hV9AtWDy
         m7LeU/csBCutoQixPw7/RgONfN4T3wBw+Wx49fFO8ereaP3lwdfhJ+1/1DEmbQVlChmx
         keL9xgOBFbEj6lGZtTNbq85bVdGEuBRUlZ4DctUaSQ+5SzZkDk88Upc2nvKFPk46f/Zy
         lqWH4YR9dgm0tI0uPEgmgvXnUXwiFd8EtjJxyEwDtSsId6cwej3Nfn69nyxtDtqdKCCy
         ChwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oR7yZ7p110w4YDqSp6iwoHTcaw6N6KC0iH+SbjywiYc=;
        fh=kVTcKfiIvbFDQRu11A8SWBJmMjdbgpEXxtA3GQTvqNs=;
        b=bSYZFW0eFXzIm0wSgQV9EIIOo5T26sZoSEZQIiy5hecbUKI1fFrfLX2i59vddKd+wz
         EMTNngTyIpSH5as9fLWv/6sJreTpC5OpMOBzCkKTyE2Jjn9Ay6JmQkshXfsYlAX6uc4V
         hyUi0OZSB28iiWd/XmrMixhOwYYbfoGzoQgZtlcfVdbPXQ5T4vdaxbOaVle6u/9smMCr
         u2Z6O48rxufxRhGts+tb1tbctFSpMdjSudLPr992bfFPoTZAqQDFd0OpQVmbKpGIvC75
         PsY48hmcN4QKF9SDwtRnp/drayFhYsiw9oIprCgkYE1FI7smhBgWOvd42nAZOGvuuBrj
         swEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773149522; x=1773754322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oR7yZ7p110w4YDqSp6iwoHTcaw6N6KC0iH+SbjywiYc=;
        b=dibsIwD8ooZobgDH9iiaeP6aoBdN2jwYk0zkmxgLcxnt/0mkIi5a1Ip5OmD4u8jwNc
         6i/Ns5Ovn38T4Ip0JwbzBtwS0eYXZwlb76sOBUkBb2Oc+Jl2/YBLZKqesi0Jn4DXytp/
         LhjCRF8az2XyGWpc+Y2z2ca+1WwEvkdwwc0ZG74+gq7Eg0DlAtYdnmXbQYnU03ldJ3UO
         K0Zu0sVlWIPg16BAQSqWGjnEvXySfvpYSqkajSdrfQ3/RhAs09zdRHt96dWbK+CLR5op
         Hx0IV0Mv0jUylCL1ujbvUMMu/K3O38KssqU/5OE2LwbTdgivFgJF77eUKmHb6Do5kPNt
         awgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773149522; x=1773754322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oR7yZ7p110w4YDqSp6iwoHTcaw6N6KC0iH+SbjywiYc=;
        b=mxeSdKxgyoi1G+r9VFsyo4QjgNlDZJMLGLGCDHtU8FU5nmisW203lJmtXIYLXmQ6mZ
         rokTdyvWLiOCBhBuBWCFWfCYuGk5kXLVEryMvHs1cooLn1bXwLUKqZE5ZHrCxtpF0Jmr
         B+3iyf4y9MuYLMezQpJfv2nxz7qx1SgmQVaR619VTjaxv51th0AILQ2FI+18BGJfC7Eg
         TGRiUJP71M1kznSCI0y581OJunPYGtNNpn/3FiX7JpGW8wmm9cgNqnadxkM0Mv9RycQH
         vVKarwLNq+gGjz5VaTHechKiQkttQB4n7ZCuMDe1qJgRLKz/rWDGfg8LDfWstvIwcgvK
         QPLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNf8zop4Z5KDBdy3hwSxBdpsnU9yT6Dm189Dq0SV9x2ZiL4+Zqw8cHn9MQgzeyYYeI8RaaTnQF/RQ10w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjaC2ZESoF3z6MTSiZJtgVe15aSVqPzpg2BfNvARNM7EhHdY3Z
	MJfb2OLiJe3RmcW+X4H2hDkkB7Pk4Dhv2hcDZWdueV9+o9QvebqgToV6NaT/CAadxChsz28WJ5B
	GZh/oXtEEYeOZ0IV+0lo0Pb+g1ufJtPZoO9CpZ3CppqFn
X-Gm-Gg: ATEYQzy1ixhCdTs+nV+MlED4eFZn+pxO5vvVebn3LeBQnjSiErs//owPJ4G3OVNteZK
	/u07U1yo4PfK/YX6xEWaJ36fac++mq2v741Pdr+AWzq83hzbf7hsredlmgVZXDd6oRhpAnZCpMF
	8o7bvgdsQCjmOre8CiFB0BtiG0yCGkJSDB4o2yfltX2cRo2cx7ATv1S3G0MEU80UlH6A/gl9GPQ
	Zs+SeFhodxHqvZsdLWNux7CXH/PXK9SXWfgVg/sbw0PT4k2BjTbgFyGFP24FurrbH2+TAMu9j/E
	hGe1Yio7uA==
X-Received: by 2002:a05:6820:1688:b0:67b:ba7d:442a with SMTP id
 006d021491bc7-67bbc961213mr2190834eaf.39.1773149521735; Tue, 10 Mar 2026
 06:32:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-b4_zcomp_stream-v2-0-7148622326eb@gmail.com>
 <20260309-b4_zcomp_stream-v2-3-7148622326eb@gmail.com> <aa9tz-EIh7kOF3RM@google.com>
In-Reply-To: <aa9tz-EIh7kOF3RM@google.com>
From: Jihan LIN <linjh22s@gmail.com>
Date: Tue, 10 Mar 2026 21:31:49 +0800
X-Gm-Features: AaiRm53sXnY0nHNz7eZ6IbvcBHm_vxYaDTsrkKCZX6ADUPUcCdM0iEHTOA0igVg
Message-ID: <CALmCz4rfM3graGfnrMjXwg+5W5gUrq2g0ycPwRbkcRKsL8woyw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/5] zram: Introduce zcomp-managed streams
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On Tue, Mar 10, 2026 at 9:05=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
> zcomp doesn't support hardware-accelerated compression, and that's
> why we plan to delete zcomp API sometime this year and switch to a
> acomp crypto API instead.

Thanks for the note.

Yes, the acomp crypto API can cover my user case. However, per-cpu
streams can still limit concurrency to num_online_cpus() even with acomp
as in mm/zswap.c. And simply replacing them with a global idle stream
list leads to a significant lock contention regression, as tested by
Kairui[1].

Would it make sense to try using per-CPU stream first and fallback to a
global idle stream pool only when the per-cpu stream is busy? Happy to
help with the migration effort.

Best Regards,
Jihan

[1]: https://lore.kernel.org/all/CAMgjq7BFUrUY5Xq5Eks4ibqbWgJcca1vqB4kq=3Do=
tQVyG=3D23FRw@mail.gmail.com/
