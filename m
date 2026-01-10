Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D4128852E
	for <linux-block@vger.kernel.org>; Sat, 10 Jan 2026 20:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768075526; cv=pass; b=PUfUN9VuBi4FsLm+7KQ/BiSGe05u0/L/c+a7o554bkRavi45C9CUW03lOqxtYsfrNVoeYCB7XuTLdk5UEFmD+7RDLg2nzUV/IdJOpQQjEJnYJrbDVwuQnXe4owFYvkxBiIPrb1JoqHEzjpQ0dIwmTj8H7JTSyoYEYU8RB1H9bkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768075526; c=relaxed/simple;
	bh=xNLFUGTyVvCzdM0Lg23E1hHoOhAz2/4srJMuQIdQsRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=keHT3k0RVNfX2IsRSR5jyfZ/ZZU+JJaYlb/VcJSCC3cew4USSY4pE+kMrgH6yRc1vC06w629/b9LGmDddFKM/pDx0ZDmjSMAEEaBuD4sEp1HTJrsl5n5OZ20+86g0ThoJxr5reXrVecIpfk0hiq6YBSN+OyZKXFvrT+jkQbBucA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=X1/q3x6h; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="X1/q3x6h"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-11f450147cfso409289c88.1
        for <linux-block@vger.kernel.org>; Sat, 10 Jan 2026 12:05:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768075524; cv=none;
        d=google.com; s=arc-20240605;
        b=CF3+y38btjJHjd8FGgVCmUq9VxQObmCwrwo5o+MeId/+/OC6S/vc3amQ6dJv/4JGD/
         4ajCA57PdVV+gQE+MkhbH3zOTbMPsQlyJHK8/Y9eDQCNudBlk3ksMU6d5ACtRePEoz72
         z9sVJaZ8ih2XZQIhdwg3xZ4DiLzDy4deffv8fKtXwGokaGJ9PhTaGnmXbNxO71ycSi+V
         ST9yyzknqyOjnqbWqpaVMeq8KHU3NdwkItWy+z9qrr5z6SktxUsW+MKWiMZHRpJaeZHp
         ZtWrMirS62lL9b9MIyt8aYc6lReBOXeSWYkkQlJvH6OWcFJzlVKVi8+/JfSLKLFcYWOY
         VDyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LgOtTn8tJ3rZiKBvX6QVD1MIHtcv/J5gUjDbVV8Z8pI=;
        fh=JPbg8m0EnrK5C8BkeFAgOqRafMKUl/xgpreWnMmuPnA=;
        b=RZaombQvew3xqbo9E7kz2PAOHiuGlm2gvgsJk4WnhYtQsi2PKqILaIyahcWGgesxOW
         zndDvGKCNCzrjAIqgNaGPZILyPXkE/DiOBQKwsQab3KRIt+pDV+PKSuTit3/9yuExIgf
         3KcQafE4VaJtRD//swM0/918gK0z+QwOroVcHEB8811u9A9KcbYFU+AHQgzoqzEs2/ej
         ESdo3j2S8pjDgWwf2NmW+HJfuRQQulwJ6sR7eI0wWK6i6uSXiHDkqL3EuMyTcJfbYEsE
         xrO8vbI9GOiszMyjAlsOmvCKJFP95x3HELxVWoy6h2gkpArDvxFzEixmrVrtNyoquaiA
         S5ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1768075524; x=1768680324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgOtTn8tJ3rZiKBvX6QVD1MIHtcv/J5gUjDbVV8Z8pI=;
        b=X1/q3x6hy9hzMDAxcVC9jgTkSJXKNcy3qsxWv+XhBOhRcF23BSv71rBghI8P18ghH+
         rGNbah9WthW4W0zdBhB2+zBpdGHd6tqctf7OXxW8BwNG4Cy8mUnlN7rx+mJcDjkUKdQy
         CQM+yT5hi+YMlOVSkOFY3ktSBpGBPpd3CdAdPNOxNKR5mr2Jm0iERIl47u3T9I23Yjd9
         OhXGePSiVpNXXHd4QPdr3WyzEEVsgszqYLNmgc0IE2u4ES25euu87ChWB2DD48tw4UyI
         bShf4pLM0mQm9uYooPEY2Re/OzcoOY/2Hzv1hApQxvx1kPVyJXlb5bYkYu6h6BEXUdH4
         dfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768075524; x=1768680324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LgOtTn8tJ3rZiKBvX6QVD1MIHtcv/J5gUjDbVV8Z8pI=;
        b=kywVrEzX5wpUliS3/sdRlxQQtX4W+ixny+p4J7mBpyn2xnKAdfwzap4B/g9xi2/t8w
         UDjBG1pLisIE1TW3wswNkWOZOho6fiI3BFfskwVaaYP+Fgtf6BelUR92UOMEwMeepzTR
         SvU/wLu5IB9erL3UpLPHMuoZb06aBbjfgFJE5pdIFWiR30uL4Qa5gZXyuoRZd2aIyoo0
         bi2E8obRZQEQIsIK2oV+RpdbEIcx/NtSN1rsNpVCozISmhpFKXUG3lm6tvhuyt8NAJLw
         63we6RN0w1mdEKZsEf2a1m5Nc70AWXZBK7PyCWX4W+3t6EjZ7cshaXa/6dnx5c3WhBcW
         NE6Q==
X-Gm-Message-State: AOJu0YziudxlOvBFEQq4U2AggHb64ZVmaN6/RRDzbBqQAV8eNJyEZESf
	tbFFk/xugrAhaDbATdcLXr/nyFpqYOvTdak9TIQ5HoO3xQyowY/cRICQHJoMEKrSnHWGuixF6of
	ECDIpxQ+6M8BZ4HKyWa/wpwlrMpozeAjDz+ufSAz3iw==
X-Gm-Gg: AY/fxX6Tl8jLhMu73+SyPTIR95ztiZPg7bNLt53HHuOTOJtKpci49wwjWmurb4HIv2k
	TlWkE7CHpemQfb7hR39fzt3qGwfm0g2uHDapEGxmlQzjWWaRJU5OJ+OxGKmxBpaDhcVUdApZFUk
	bHJkb1rWREJeqDAgps8+SPHdSI7PksMfW+OP1RLqQmfWwd1bnKY6jxlnLtMSkZTj3J18ObdTH5a
	606HaPABAc2qQ7B2i4D7JItE41HdcpRzumw1AvFG8uzRga91O9ceB61RHwHI820wOFyk0T/
X-Google-Smtp-Source: AGHT+IH809LkpcrXd59rFV/WoVkKW55EoZ1xZdmo39Ao0aQ147EUvuSJKHBsYMOYGzZrMhhpL2xWuHgy5IQD0M+isVk=
X-Received: by 2002:a05:7022:622:b0:11a:5cb2:24a0 with SMTP id
 a92af1059eb24-121f8ab7afdmr7923042c88.1.1768075523694; Sat, 10 Jan 2026
 12:05:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108172212.1402119-1-csander@purestorage.com>
 <176796707483.352942.3630670392140403614.b4-ty@kernel.dk> <CADUfDZoacSnJz5FOZQov50k4_nP0sxqxDHYOvDqp1_7KKD8z1A@mail.gmail.com>
 <cf37342e-c2dc-48c9-a63b-e62fe8e791e4@kernel.dk>
In-Reply-To: <cf37342e-c2dc-48c9-a63b-e62fe8e791e4@kernel.dk>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sat, 10 Jan 2026 12:05:12 -0800
X-Gm-Features: AZwV_QhhcGwSr6PGLZhrCHk9FCk9XsGW2-9uTLK0DbuTKuqxYz315UE5EtjC3kc
Message-ID: <CADUfDZqbqWjGhY3FuSOgBk5pgTR7By6LgXPBH+A=7g9wLp5qmg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] block: zero non-PI portion of auto integrity buffer
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Anuj Gupta <anuj20.g@samsung.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 9:21=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/9/26 9:29 AM, Caleb Sander Mateos wrote:
> > On Fri, Jan 9, 2026 at 5:57=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wro=
te:
> >>
> >>
> >> On Thu, 08 Jan 2026 10:22:09 -0700, Caleb Sander Mateos wrote:
> >>> For block devices capable of storing "opaque" metadata in addition to
> >>> protection information, ensure the opaque bytes are initialized by th=
e
> >>> block layer's auto integrity generation. Otherwise, the contents of
> >>> kernel memory can be leaked via the storage device.
> >>> Two follow-on patches simplify the bio_integrity_prep() code a bit.
> >>>
> >>> v2:
> >>> - Clarify commit message (Christoph)
> >>> - Split gfp_t cleanup into separate patch (Christoph)
> >>> - Add patch simplifying bi_offload_capable()
> >>> - Add Reviewed-by tag
> >>>
> >>> [...]
> >>
> >> Applied, thanks!
> >>
> >> [1/3] block: zero non-PI portion of auto integrity buffer
> >>       commit: eaa33937d509197cd53bfbcd14247d46492297a3
> >
> > Hi Jens,
> > I see the patches were applied to for-7.0/block. But I would argue the
> > first patch makes sense for 6.19, as being able to leak the contents
> > of kernel heap memory is pretty concerning. Block devices that support
> > metadata_size > pi_tuple_size aren't super widespread, but they do
> > exist (looking at a Samsung NVMe device that supports 64-byte metadata
> > right now).
>
> Good point, let me see if I can reshuffle it a bit. In the future, would
> be nice with these split, particularly if they don't have any real
> dependencies. I'll shift 1/3 to block-6.19.

Thanks, I'll try to label my patch series more clearly in the future.
Christoph had suggested splitting apart the fix patch 1 from the
cleanup patch 2, but I see how that makes it a pain to apply the
series. I'll resend patch 2 once for-7.0/block picks up patch 1 from
block-6.19.

--Caleb
