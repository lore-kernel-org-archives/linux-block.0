Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEE63A9DB6
	for <linux-block@vger.kernel.org>; Thu,  3 Sep 2026 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439849; cv=pass; b=uMA1JPYdYYdfYuto7hsH+U1eBsrGvSMppZjp2YTu36h+arIT6I6D+9m2caBSoeEpQPuw+42fZyPkcIbdWJ3DbZr629NgH1jLy7AZiZ3hq+eSvOmqZv3zldA+PO2xgUvhqvftIjWvrA8QBFGHgAPfztypcp8kRpcu8a0nKzyEjRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439849; c=relaxed/simple;
	bh=rbQQPig/cvMjOBJqfjq9BsewA7Z12czq5T5hrwRiWak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmWStauf5H/PK2yhms6hOYrb9CN9v5/ZF25ZX1RLy+D36reuA+HQ5TfucqlzThlbvAT+ZonCU581yO5gHDWyQlktOrBnJ+pVOGFbu1eSXHQEwA7c1twVsPaGwJxKABKALHE+3cYZpwtTftHXcvm/BYBm0rrEnEYRmwgyL6FXJiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bH2rFXzI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=raPltn3B; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bH2rFXzI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="raPltn3B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788439846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rbQQPig/cvMjOBJqfjq9BsewA7Z12czq5T5hrwRiWak=;
	b=bH2rFXzIVJFyNCe79CAz+l4z+PsGCRWZEUjOH2hj3aeY4BRLFG3hg0QCwXFVRQosBc6Jt8
	QHFsl6jbDmDxdUHFlNkmMLzgRO9wdZpQ1C6l4fRbM7Chd61vn6bHX9TeFUw4/1KMmjHJPZ
	JHfwsWFq8GqmAiaWKkCzd14sN5qkHT4=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-mW2u6sm8NW66fPiGtP2c4g-1; Thu, 03 Sep 2026 08:50:45 -0400
X-MC-Unique: mW2u6sm8NW66fPiGtP2c4g-1
X-Mimecast-MFC-AGG-ID: mW2u6sm8NW66fPiGtP2c4g_1788439844
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8648f12d52aso2749237b3.0
        for <linux-block@vger.kernel.org>; Thu, 03 Sep 2026 05:50:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788439844; cv=none;
        d=google.com; s=arc-20260327;
        b=neuRyJ9xjGwE5goHv7TDTmmQWAhnnXHdxScinbw+ahca/4dcZOmTk8nIlZ5kfF8oyj
         ECWnP16Mi1yILAJGAvFwcuhvs6gIQ14vjG+Tjq5SZ+2kD8YBg3Oxg5jVJmVG2lXWuDMp
         yPIjGudYSMjKCygLjqr3xVyLS1mVmcBazEONGpD2QOsfU3mRHiXDexkLj0h2wCCtK81y
         QVlqUQbih42Y2I2iLqa5zFbjJZ1YXZbCXdjWM3y9j8f23UWRuosgF0hfDRshzJY+qR/U
         TaePkDHMNX5+2Js5QWZFPzBGyRubDbPsJZlxWOMjtta/t8aXA1Nu/hzVws8VIl0lO2s/
         vlUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rbQQPig/cvMjOBJqfjq9BsewA7Z12czq5T5hrwRiWak=;
        fh=R6u1X0ACH067eCq/L7hDZbSu5qM5nRI0J4KQCaP5mKM=;
        b=i1nypNCvTc3s/mAGc+imK98OgXac3DGnpnzYK49uqQ7f0iVDozxhFld9JG+0YBs0bK
         LpUB7G8hhUfUr6+bp8Vl0P1Ty7LQBtrweahI+zrKa9DdUbCzTd21W2puI/7hE8njOPk2
         Bvwbkzn3Qd+U7KdrX4vKDuDJ7NKRVHAAZ6UrznUs90tTa7oHsXEd80BK2Oy+OlFP6fgX
         hyRr4SqSnB1EgIZLJpX7e3QnxCDZaqt/4NnDfX3m/UZN7dgTLIxBa8VmY2+pq33MztDX
         7iQDq0bmKC+j3xcRv21Ls6vry6euJj45rWg0LfxnTPp4Mzi/VyUrkplvzT6GS5MzGmTP
         zz/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788439844; x=1789044644; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rbQQPig/cvMjOBJqfjq9BsewA7Z12czq5T5hrwRiWak=;
        b=raPltn3Bd4tdFXwyyGMRsTt0DE7IKp5OcO2PWWamUy3VCnIhTaWx6DC8qLwkXOdu13
         rW1Q8MN6mS/+LatNI24cF1eTfdOUbXtwKOnKYmLXLI0YxA7SOYONnjSx5ySqjYYD/1Aw
         Lwk7TwJ99zpQQjvocXvaTLPqH1B0BILaUnX7M8GOYiyQQfsi2ssminLhMFLhe0Br7wj0
         VNllhNpKjsu+llAV1vDtQZcMxnaQ33pcONScJ1pxEkk+reeJuRJidNtmZ8JSdoOa+RGy
         J/EFMPmVF4p5BoNWZgABVAOvwVaGvdy964kQYYb85sX9FUKg6UVQlENr7JczvtImMXAJ
         Yx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788439844; x=1789044644;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rbQQPig/cvMjOBJqfjq9BsewA7Z12czq5T5hrwRiWak=;
        b=CqzWYfeKpq/LDcJ4l0YorNOh0V5Hl4k+Mh/218PLe5Tv8d1SgpL/vPO27UCh8gvaMp
         pgdTGGWncVdRYgsdSKkv9MGdx7DBcZp8dXlw/+nvDEUHNWp91pK/b2GckWzEwJJL2SX8
         qOgvJ86IMMqsvINF6KxHsv6x+gGS6ulR7WTovh1wDyTpQ2UX10WhnXNVAso5CQmFJKeZ
         DndCTw1VQj96ZiBoOgbIiKTGxnt8cMld+/Ku5VTpSizStrc38BLdf4wmrpJ30o2/lxJF
         pLLeLvG1Eh5A3i8X/Ey+j5GMXMv1yQp/eWox/dgQMfiNdPKJnJI2SM5VJC+38Xe/SbWm
         bxMg==
X-Gm-Message-State: AFuF++nreJRywIsLx2JjHVxuidMxLNAof9K4nlrjDZ4tKb/GLreOXjKW
	OMfInmbbBpa+v4YHtCpNqkySH66IMKbPpljuwPckXI3cSVQNYNenwd0hHUbAR5Bnn0RZsJvmsoU
	KrOKIR+hBwqeibogeK0Qcx8+dpzVxDsNUnCtB+TjN40GeIz3g97ki3gtM9L4Yb0r48ytojrcF7I
	kXCJLIzEtsIny09jfNMvH8MO7CJFBO0s6Qlvs+Fc4=
X-Gm-Gg: AYBFou10mHaeHpljtn7rPtk83tyrpxafXPQu81gDwSRivMN0ziw8KPL+57REoFo9sWI
	gh04/LvYhfQDZjcI4e/XW+GEzJz9y2yBDqajp1ELTDVRxxbSpTXSn6bXwkl6RKfKRSknNeYlUOX
	C8yfNxG+hxPvwrbCLs9FlGzGtXvulajxsMKATVp8TPhQczpkx83uOcBymOod1KcjkSNMUVtu8xx
	Tfsd/JHttyTkDM0jqm1AzNj/2DZnPxbY8MfDuuyBx1vfa1NhA==
X-Received: by 2002:a05:690e:2d0:b0:66f:868b:a106 with SMTP id 956f58d0204a3-66fa921e5e8mr1373843d50.24.1788439844405;
        Thu, 03 Sep 2026 05:50:44 -0700 (PDT)
X-Received: by 2002:a05:690e:2d0:b0:66f:868b:a106 with SMTP id
 956f58d0204a3-66fa921e5e8mr1373827d50.24.1788439843926; Thu, 03 Sep 2026
 05:50:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821105539.794679-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20260821105539.794679-1-shinichiro.kawasaki@wdc.com>
From: John Pittman <jpittman@redhat.com>
Date: Thu, 3 Sep 2026 08:50:07 -0400
X-Gm-Features: AcwNN1UJuZk7pIm_y1nnl6iAfBiiWvAvDRdi4v4KKE7kJl_v4f8-rMu1ko6aV0k
Message-ID: <CA+RJvhw=1jS7qHOiT=c1emT84DiZV9cDSmA+-H-ssuSotYvu8Q@mail.gmail.com>
Subject: Re: [PATCH blktests] block/042,043, src/dio-offsets.c: relicense from
 GPL-2.0 to GPL-3.0+
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>, 
	Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 6:56=E2=80=AFAM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> Most blktests code, including check and common/rc, is licensed under
> GPL-3.0+. However, tests/block/042, 043 and src/dio-offsets.c are
> licensed under GPL-2.0 only. These test scripts source GPL-3.0+ shell
> code, but GPL-2.0-only code is incompatible with GPL-3.0 code [1]. The C
> source file provides the helper executable used by block/042.
Reviewed-by: John Pittman <jpittman@redhat.com>

