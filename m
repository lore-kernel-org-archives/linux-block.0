Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400DE347524
	for <linux-block@vger.kernel.org>; Thu,  7 May 2026 07:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778137304; cv=none; b=OLDAHWgqwvVvWux0GkiOEqeHppgA/U4DWU3mBJ1G8Zwy3N5hwOM3+gP1hm7CoWFRU2nC04m5WCc73DAzLtm+SYPEJJhIdRHuIGYjxfN5kp34ikQeOhezK1MHplj/ZX5WOWppFWMymYUcp4UndLmOi9BsLH9TGWcYJ2xayQMnzmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778137304; c=relaxed/simple;
	bh=wSB8uDFWewI9KVK6xI37bpDbnAZx6c4sCHTYrJq0ubc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMf+s7GNEpyZTUvYNAtjczq1C91A2M6YqyaRfQx4hn2RFea2aIkY2/GQcJ0n+/B4AXkVFYRSbbrgmiiIoY90gWKXNyFlmt2lf1nk4C5TQlczQFEDzWu3ANxG/qpahj0s3omrFEdNX1lAWaQ0ZUMew/F/e/nGpzsgLuVtyvqc8fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67e43a8996fso169102a12.0
        for <linux-block@vger.kernel.org>; Thu, 07 May 2026 00:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778137297; x=1778742097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wYY6mvk1MccueTeU8KvMLmNziGDSZgSJEywCr+M3mHo=;
        b=XItEkdOUkQzHqnjdqJ58gFywFmC+PhfRGxHaYhDTfX0EstDr5FQBB8O26m9Qhr71nM
         Oll0cZT7U9yLMlc+wruYIuzGWaJOmrYR6WsmWYec8YJpxKUi+Y1zpI82BTfrXE7Esl9D
         FtJcV/+k0qmp/RsAhG5FPhrESQB1vX5H3vm0nCmE3tfNVD5rITDDA5vRPbgOGXh71Gx/
         QIhD32pU1gepKrHDEx4+YFEUKIqBVmZpKWspTeLKtkfMGDmtGrhtpGknYJndWWwlz4aB
         eU5czCquizLRziOnoRPfzUSG0Imc1fci1Y/KadZuZ6BWS47FrWdGWOkIPimSQHc/UMSU
         MEmA==
X-Forwarded-Encrypted: i=1; AFNElJ/8CzpFvN4Er9BgEtcFMyJ9Hm2mlTFVBKw1hDrKgABpme4kahJYKn37HwVBKjEBQVtkS8ajjgj4HuqPew==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwWg4rDN/2nWF7IzNtQtH8EGmYbOHWVfrSEKKFRc/ydZSO1VCl
	ZtjUEyK03TKeWdfBKetM3VdlhFiIli8g618HP4yGD03EbZ8/MzS4mDsm0BeGU/Ir
X-Gm-Gg: AeBDiet1Ii613R3iair9MweAOk8sNZ3ixs9Wfvo0XKdnUclSDYDd/cCcyEp670H1Gv4
	ou6Xq8agMnjkuigDH7bfPLfZeN/OYykkBwJWVmfy19+Cq+u+InKwFrqOMMdoDthB0641MM1un97
	dnuMsWqBR2tchpnK54i+E/TajdyI49S9SE37OEBhtQadXbNJgoHO/Y3YBl+XmaCCbEcFk3BCt1Y
	WNJ8EDK6hOlpij9G1x7tPtJUskOJ+vQfxp20GeR5fSrxdgSF5SEdYUg+ekaJ4xxVdPG1ufzzRt2
	/96tR4+GMhVSdqrO6HaqunBave1H3HoIgNbkPAhspGouHTjIhHb/vQ4Lugj+xdNquXrPiHFu17y
	qIHcycoarKgM1ULEQxbDIaDtsM1GNbWGo0l+JI0iEy/sbk73Zg+fKXNvNpsTpdEkJuCNJgbwLFk
	V+vuxNnYwLKxXhoT0bK+Mb0xe3riC1flcXwd/4EL9laOyCNNsl5cBwkaEf96p+zJ9tua+Csrcen
	SZl
X-Received: by 2002:a05:6402:520f:b0:67c:c1d5:b7cd with SMTP id 4fb4d7f45d1cf-67d63d91677mr3474088a12.11.1778137296433;
        Thu, 07 May 2026 00:01:36 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67cd91a486csm1765676a12.17.2026.05.07.00.01.36
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 00:01:36 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so425935f8f.2
        for <linux-block@vger.kernel.org>; Thu, 07 May 2026 00:01:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+m6mOtwF5b+9dBzMNtqLQOzcsNC4Tt4ZJK5MdrX/5ztaIkaYzKutHLxVp1nXRGagby7kGwppiIv6zmLw==@vger.kernel.org
X-Received: by 2002:a05:6000:4283:b0:43d:1bf6:927 with SMTP id
 ffacd0b85a97d-4515b52452emr10894538f8f.14.1778137295684; Thu, 07 May 2026
 00:01:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427040926.987166-3-iam@sung-woo.kim> <afM2oyQTraSWa5vO@shinmob>
In-Reply-To: <afM2oyQTraSWa5vO@shinmob>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Thu, 7 May 2026 03:01:19 -0400
X-Gmail-Original-Message-ID: <CAJNyHp++fZG2SM_x6zrVyNCzDxKV_Fv0bqMmTFYxD4xP=9e-oA@mail.gmail.com>
X-Gm-Features: AVHnY4JLE1m_hVljQublA9Lx63M53WCBINCrISLdWKr3exjHJqCTqUKmt3lN8uo
Message-ID: <CAJNyHp++fZG2SM_x6zrVyNCzDxKV_Fv0bqMmTFYxD4xP=9e-oA@mail.gmail.com>
Subject: Re: [PATCH v4] block: bio-integrity: Fix null-ptr-deref in bio_integrity_map_user()
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Chao Shi <cshi008@fiu.edu>, 
	Weidong Zhu <weizhu@fiu.edu>, Dave Tian <daveti@purdue.edu>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Just a gentle reminder on this patch in case it got missed.
Please let me know if there are any concerns or changes needed.

Thanks,
Sungwoo.

On Thu, Apr 30, 2026 at 9:35=E2=80=AFAM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Apr 27, 2026 / 00:09, Sungwoo Kim wrote:
> > pin_user_pages_fast() can partially succeed and return the number of
> > pages that were actually pinned. However, the bio_integrity_map_user()
> > does not handle this partial pinning. This leads to a general protectio=
n
> > fault since bvec_from_pages() dereferences an unpinned page address,
> > which is 0.
> >
> > To fix this, add a check to verify that all requested memory is pinned.
> > If partial pinning occurs, unpin the memory and return -EFAULT.
> >
> > Reproducer in blktest: https://github.com/linux-blktests/blktests/pull/=
244
>
> The blktests Pull Request modifies the test case nvme/064 to write with 8=
0KiB
> size metadata. With this change, I confirmed that the Oops below was recr=
eated
> on my test system using the kernel v7.1-rc1.
>
> >
> > Kernel Oops:
> >
> > Oops: general protection fault, probably for non-canonical address 0xdf=
fffc0000000001: 0000 [#1] SMP KASAN NOPTI
> > KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> > CPU: 0 UID: 0 PID: 1061 Comm: nvme-passthroug Not tainted 7.0.0-11783-g=
90957f9314e8-dirty #16 PREEMPT(lazy)
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-=
0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> > RIP: 0010:bio_integrity_map_user.cold+0x1b0/0x9d6
> >
> > Fixes: 492c5d455969 ("block: bio-integrity: directly map user buffers")
> > Acked-by: Chao Shi <cshi008@fiu.edu>
> > Acked-by: Weidong Zhu <weizhu@fiu.edu>
> > Acked-by: Dave Tian <daveti@purdue.edu>
> > Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> > ---
> > V3: https://lore.kernel.org/linux-block/20260420020327.1667156-3-iam@su=
ng-woo.kim/
> >
> > V3->V4
> > - Addressed a sashiko's comments [1], if it makes sense.
> > - V3 wrongly assumed that iov_iter_extract_pages() always pins user
> >   memory.
> > - V3 insufficiently handled the return value range.
> >
> > [1] https://sashiko.dev/#/patchset/20260420020327.1667156-3-iam%40sung-=
woo.kim
>
> I applied this v4 patch to v7.1-rc1 kernel. With this, I confirmed that t=
he
> Oops goes away. Looks good from testing point of view.
>
> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>
