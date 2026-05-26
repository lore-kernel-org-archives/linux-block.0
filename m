Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A3130C630
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 18:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779818563; cv=pass; b=CabptfQtE6gXj2ZdpoX+qIBUgXSPK0Wzf3yU3CE2M8DW8mQv3Enazoh5yLP3yT+9u3KA8WStvNn57e1xEFTeNjjBr/VK+qDtySceRTffFptsp6PU9m6sNpzkT8Ta4LFdYhDGYTkEkzwwWfri9RMQoGFiALTIJPdny18FlfCfq0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779818563; c=relaxed/simple;
	bh=ZaAtzlYyiZ9vDcx2mG+Vc/njgcOwf5fe+9JMdr02KY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRV/AJ1iDuqAOngk1u5rl09DUrkhhNwfdtJ/s9Tj76Ek87RecruNm154qJQpeeGwt6DDQp6+tb84fzAPZesIu9Dkjrb9nGTyq5ahYDEYRoB7McbFNGIFv5V9tcHdzOkWTzsGlfB7y5Fx/gPzqtM4df9YwDvUGqDSTnqCOGyF63E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kV4oFDjT; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kV4oFDjT"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bdf8add254dso327104466b.1
        for <linux-block@vger.kernel.org>; Tue, 26 May 2026 11:02:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779818561; cv=none;
        d=google.com; s=arc-20240605;
        b=g4rJM5fbkTTGXHbc1KTlum7PaNTMvbivzHS15eueBq0ofPuxTsuHz+RrwMo6ov2Lxy
         LANzLvIRKWdnXiIgnbeMGfIASuBHt8aqMYEuegy6yQFibTmPF+o8qYLy5KeSxgm8uIKG
         MlCJokiCXuzEKAwU9M7WUhp5dpKBG3Rm1jQg+Bo/0Tqbh8rUHvWWBbRQZimGIjtVn3MP
         zRdxitq0WOAakki0RlDHPrTZ8S/c8Xj4gAIF/pWIAVk3PshgtOlAn0vvkermzNdsDgTU
         9GpomBd0gHOn+Ig9BpGR85RsBlw3UxlVqXCVvx8IWv2oGlgrRK4dsDxlWdm3fa4OC0Ap
         1S9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u2yr/TnlLJ3QluCqFrvycdU+0iJIGme3P7fn2IgBvQk=;
        fh=8Oa+OW7YNScrmdrJgjamjPAZ5Rj1nqcPlIVkLkrER+s=;
        b=CLDCYp0IZ6PPe9pnF+Oxd8ZvPB3IPIbYk7nlRgAu3jFX6y35M6VC+iA/4rKUZv3Pn5
         s6fJVG2Bx+sGc8WV6K+d+Td+uCXdNEjUgAT2UFvC3aDoUw3TwGDLBySi1Z39ZtMK6Fyv
         e+gr3NCNXuSaPS1RpzW2kn/cFxIR6lShKAz3UzoNoH+6HnyNNtOp4UHsixWj2qN0TEAg
         94cYA51Tpg/KF9XGEiVoY+VLnGDZ0YgjanHoiLVd3gEKLXVfOae5pH3/dO3FKe/EITTI
         fSuzVaaqItKEja+l/Lrukc4GZRNeunH9S1qXGAv2KXiXOrYdYVnVjHTtMwV+w2bgFw2S
         Zgnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779818561; x=1780423361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2yr/TnlLJ3QluCqFrvycdU+0iJIGme3P7fn2IgBvQk=;
        b=kV4oFDjT0EVzaI+0XWiL0C5ymUcfpjWF5EMgNFzowPv7+6KABYSPbP1JnmCsXzjvrL
         rwVJDUsksR6TbMqZfP7B2pLZHEKNJV6K5XngFKV3m19zGyXAfsv6m9xxj0g+VwWRdTEv
         lPct0907Olvveusw95ihtx36NJ8JA8dczbyJUcnxLAqY4MX9YvN3TppRm1i1pPbwROV3
         lh+mLKUh5DB+mtZt7DptakNvPIIik8M3ZXDvmA7gnmBdIEuyG2JYRO+1TjJT6FcPV5WV
         nAyDgHG1Yx8JxMIIExzSFHQduDidVW88kH0ruKasnPS41dVxz5bkmJDsdvbR3n5cnPQn
         xdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818561; x=1780423361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u2yr/TnlLJ3QluCqFrvycdU+0iJIGme3P7fn2IgBvQk=;
        b=VFosVEqHIguTGEORVnNEQROPQiefRLMRRl7ECVlCD3tKQOk9tyZXTnFgQB55UcpP8i
         tlpH9XjKqy/6AZ3etxcBg6CBrdHhEYEn86MtZSWt2kC1dAlqV7Nr3fb7aSwhtDfWD76Y
         1bvpzA5Rg9sXpOl8SescabNZX5dGhd5DLqXYb+54gsEjyaumXq03vTMzlpdOr+fawuSB
         Fk11kW0F4DL96c2Rc69rYcG5GcGWS009gjV0zVTvR2/tBGNhjyltIQVdD62oCVS2EWmN
         kNDmitpy6BP4BAy4D2hhTMq6iQNDXEZDu/OwXCuxixoSPbxiG0z4F91z63hTr1On+hM0
         25Mg==
X-Forwarded-Encrypted: i=1; AFNElJ9oGaYvGRQBMjzN9HRmzIXvpDIbpcWVyxLr9f5V/IeLxCHP+Wq6ORjnoVo5wqAvP5l91YCbaIgrSR6rHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDonT6hmI+f73OM2WyEWHFFw3L245VCPqXVjO8ldfPUkT+HFU2
	hpxuM8Jn9zFaY31ueXURndNVBB+ywM+umVEMDEdEm/iGgnN/bzGkUWyMR0uuVenycimbsXS38KX
	mjXbONAlDBGQHqgoQZnxW+tz/UvJyfrY=
X-Gm-Gg: Acq92OEw+vhyNRs/CFx1FrdCT0mri1gNFngXmSY+6bUCCHobGKIzqDpJwNpnbU0qGAX
	jYLL6WocFUe5kgQ+hqFDZH9BcL/FTj9l5AYp1pcp9pZc5tCODOFGG3WWNNVvsfIN+q9RBWUiQc7
	ufrxaAu7fs5iDZF7N1DFTm0wyPaVH9aiuAKfh9xNDlCaucDRNgz9UqBgutX5+C0jSJ2uth9rHCu
	8ipzQRloPfIw52L23pP12mn6JhvvEczjlt9/lNim079ckt0ACvH6hVQr/x5gsUMomYTrFEHWE7Z
	YKuCLjVHDyjhAbzB6w==
X-Received: by 2002:a17:907:9604:b0:ba8:2ebd:dfb6 with SMTP id
 a640c23a62f3a-bdd25de289cmr1192642566b.23.1779818560374; Tue, 26 May 2026
 11:02:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522220025.1770388-1-coshi036@gmail.com> <177981343047.464267.10378401249582627288.b4-ty@b4>
In-Reply-To: <177981343047.464267.10378401249582627288.b4-ty@b4>
From: Chao S <coshi036@gmail.com>
Date: Tue, 26 May 2026 14:02:24 -0400
X-Gm-Features: AVHnY4KzuxEsBiiKJ_yFObio6pBm4s0WB0v6fgnampd9IL2XRtJQBNx6JQfoDhI
Message-ID: <CACd_6n2x4Hgxus-0zkjavAEw-MxkP=5BhzvS4795oa3vh9OD5Q@mail.gmail.com>
Subject: Re: [PATCH] block: skip sync_blockdev() on surprise removal in bdev_mark_dead()
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Jens! I appreciate your work!.

Best,
Chao

On Tue, May 26, 2026 at 12:37=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote=
:
>
>
> On Fri, 22 May 2026 18:00:25 -0400, Chao Shi wrote:
> > bdev_mark_dead()'s @surprise =3D=3D true means the device is already go=
ne.
> > The filesystem callback fs_bdev_mark_dead() honours this and skips
> > sync_filesystem(), but the bare block device path (no ->mark_dead op)
> > lost its !surprise guard when the holder ->mark_dead callback was wired
> > up (see Fixes), and now calls sync_blockdev() unconditionally, which ca=
n
> > hang forever waiting on writeback that can no longer complete.
> >
> > [...]
>
> Applied, thanks!
>
> [1/1] block: skip sync_blockdev() on surprise removal in bdev_mark_dead()
>       commit: 304f384f34af98a205086ce67331cad4fea6504d
>
> Best regards,
> --
> Jens Axboe
>
>
>
