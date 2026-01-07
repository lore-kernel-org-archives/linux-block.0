Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6786365A0A
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802912; cv=none; b=g3MojCM5R16UxMHpFDBVcmwbMlbNqBS9KcL/tm98r7AQ5IjGkDTG3dspd9xE66bNU0sD6fCv6kJPMjFt2Uc4pg872/FKgG+hpupYQ+IsSPz16tYlDPnReNZERVip6webeDxlzPzI7b/VePL9ZVgvLmwPHzI9D11dCkpHw6HDPPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802912; c=relaxed/simple;
	bh=B9pAsVdOshxg/UeXDrjL8KK7Kf5c9vGq1ci5vjH9hrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dTH7IW7A5CzIzGEj5HIkfD9CTPkWThexljcCXn8T/cT/6WOb++KjIWSMalQ8G7bKkKzo/8N5pjx8M4NJy7YxoMtLxZFTjCDjkySvkwpNjPd7LpZM9NOLgErEpnMWfWGgsnKwnsI0/MbO340cWECCqfU/vqn79gacDEAeqJIjT3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdfAIEGu; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdfAIEGu"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5dbddd71c46so800494137.2
        for <linux-block@vger.kernel.org>; Wed, 07 Jan 2026 08:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767802900; x=1768407700; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B9pAsVdOshxg/UeXDrjL8KK7Kf5c9vGq1ci5vjH9hrY=;
        b=NdfAIEGuipO8x2i2FZaKuiwczJdfFt2DCD/QqENSjpVy/1nI12TissMDvHg040/OsB
         42wB6rW8cnU6CattonH6zFauzeQon3zX0G5v9i09WMWmNibhreHSj0yHdyLmAe4H/e9V
         8ZCGXzRWb3dI6yN/PFS4wFuZl2xVy26+Nmv4LTfr7ljHIRFWT0o4JgKGtdmRVAWj1ifN
         UA76+MFv6hlBYua9Zf+yOXkQEv9mxPqbUo+KtRlH8KTbldcjfx2Cduaf/FZVHVIkM2DL
         XTQQX3reZ4+xU03FbpMuCqjG/N9QlZbuzEc+ZrT0LqzE9NAyKXti+Fg5DUFqYPkh72+j
         bccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767802900; x=1768407700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9pAsVdOshxg/UeXDrjL8KK7Kf5c9vGq1ci5vjH9hrY=;
        b=J4UG06UDKosEzTJAY8woDhca9Ke2V8vb/KWvtBDdn/j4O7MWCcjBx6AX5MeNJmv3XY
         blczWNUSsaUx1J9Xj+oj9YBUI6BExsTTiAqia3mBrlOvwxQ8pPBeB/39pCj9zz/iz+nz
         wsrVQtA9tf5mPIiYAtheacjHtvIo1EiiNBoLGxz5Ugbub8cSP36IEVi6cjLd/kmQF4AP
         iQPTXtSDkzKuJXCYxSaFRzkv5T8kXjxv6/wGA0mVDB5pfCaFKjVjfu5rG2fgMJu3+hTp
         EyWZudIHDllP0XZNrFr6/q1Cbn//JodieeXLUMLCU3cY8r+j44g1BOXxikqBP2ctJOOC
         p3tw==
X-Gm-Message-State: AOJu0YzAuHxqq6E1e11W76YveYo9E7O82jWQ6DyK3FEnb+wKg4ncugLe
	JXZntjyFbexaum1hQM1QVvb4KChR8gC/f3Dc14GvjDjDq896VGw3n8WuM+0mQFtjUWKEvjOsw6Y
	a1eJuQu3/aXTbi3KLuKOPwCpaQeH6O/4=
X-Gm-Gg: AY/fxX41N4ZSWbzyyRYf5YKuRPaJ7wtJhTdCyEAYw4gZvLAUoeuVQ9mPYK0nvzM6LMP
	YCIWjLgDowlUU8TnFVqHWwJ2C7+BGRGG71Ujjoz8hOUMPeowmMRWaLCXo01YW+XYXrPcW9b9Wqj
	6YYGS+d6WGHi+keTOzdUlh13Nz8LLpScjz1c+VfQ9W04w6eHQdTH9zNtQixYy8OFwPQ4r01mxfZ
	EcI1Ymb48FcoZo20eCYUfGRr03ScIEEab16yI2wRApjYHZRK8oBGx/X5nBjfUrv4wIa71r9L3dQ
	OR7Fq98LMr4z0daPfIS77HQpi9P27e5qoPdT5js=
X-Google-Smtp-Source: AGHT+IGxbu5trMeA+bbczjoGPXEJxl0y5C2nnwMIra3RoM/ysryOPmMUaafKF3MGWC+Mlo0zy/QE8hqC9UWzjs48l10=
X-Received: by 2002:a05:6102:4412:b0:5de:8933:9d0f with SMTP id
 ada2fe7eead31-5ecb5cba9dbmr1165795137.9.1767802899668; Wed, 07 Jan 2026
 08:21:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224115312.27036-1-vitalifster@gmail.com> <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
 <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com>
 <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com> <CAPqjcqpPQMhTOd3hHTsZxKuLwZB-QJdHqOyac2vyZ+AeDYWC6g@mail.gmail.com>
 <6cd50989-2cae-4535-9581-63b6a297d183@oracle.com> <CAPqjcqo=A45mK01h+o3avOUaSSSX6g_y3FfvCFLRoO7YEwUddw@mail.gmail.com>
 <58a89dc4-1bc9-4b38-a8cc-d0097ee74b29@oracle.com> <CAPqjcqq+DFc4TwAPDZodZ61b5pRrt4i+moy3K1dkzGhH9r-2Rw@mail.gmail.com>
 <704e5d2a-1b37-43c5-8ad6-bda47a4e7fc6@oracle.com> <CAPqjcqqhFWz0eNGJRW-_PoJhdM7f-yxr=pWN2_AfGSP=-VpyMg@mail.gmail.com>
 <02c255b8-2ddb-43bd-9bfd-4946ef065463@oracle.com>
In-Reply-To: <02c255b8-2ddb-43bd-9bfd-4946ef065463@oracle.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Wed, 7 Jan 2026 19:21:28 +0300
X-Gm-Features: AQt7F2pv0c-1qcRtTOwSATyr9cBPwXJeCV-fecbO2zRlGG6igeybP32a0NVn8OA
Message-ID: <CAPqjcqrjNCmnV2JP1Mdezwr0ij0ic4KxH=MVUisHt12QkBNmYQ@mail.gmail.com>
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Note that the alignment rule is not just for atomic HW boundaries. We
> also support atomic writes on stacked devices, where this is relevant -
> specifically striped devices, like raid0. Doing an unaligned atomic
> write on a striped device may result in trying to issue an atomic write
> which straddles 2x separate devices, which would obviously be broken.

Ok, then I'd also add atomic boundary checks and
atomic_write_boundary_bytes = stripe size to /sys/block/**/queue for
md devices. Not 2^N and length-alignment checks, just the boundary.

> It seems that you just want to take advantage of the block layer code to
> handle submission of an atomic write bio, i.e. reject anything which
> cannot be atomically written. In essence, that would be to just set
> REQ_ATOMIC. Maybe that could be done as a passthrough command, I'm not sure.

Of course. I thought it was the whole point of RWF_ATOMIC - REQ_ATOMIC
for userspace.

I don't want passthrough commands, I want to use normal kernel I/O.
