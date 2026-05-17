Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F59678F39
	for <linux-block@vger.kernel.org>; Sun, 17 May 2026 03:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778990104; cv=pass; b=cbmwm7urZg2Q3ml2oG+YnlGJv8KADBI+hqQdL1yu9Et/Ft09NsdF2cwyv0H9IC8B6XSWq1rLXOBlOIAlBL55cvndaK/ym1jYgUaV34gPmHEhLzkJKpQ5TxuD6tgZrkjsYM3DdQ3JIEsXGBQr/nAk6vHPpsxF2MLuoFK3auFFwNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778990104; c=relaxed/simple;
	bh=MGbNGGBrt96LxxsGIl1MmJBnklkCm2VwM8yespY/gaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dyIqvSFnCqR886JOT4nsFnrIzng4bsC8U/w2IoTUVSMVvJe4m6BKdTtof1TrqVONbGIXVnvP6BivGjqoVlQeWYQ7gkd1RnFA22KzEeeSkGMSuNjYYcELW7pt39B5G4KZy0DGYR3xxOWhoFlM3/WQkZFAioI5p8TQExINm7ObtBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DW86/3wE; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DW86/3wE"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-67be41d5eeeso2524397a12.1
        for <linux-block@vger.kernel.org>; Sat, 16 May 2026 20:55:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778990101; cv=none;
        d=google.com; s=arc-20240605;
        b=bjECYcYivrigjsR3xZ4tjzTMSBuaw6NhIIs96OkFuXPtZKwsQ7buiv4He9e5KMtMxG
         UHx6L06wWYl0nRGTkuRuclhJu+koYOqvteMAU3d+AGMtDTseDQSZ6O+jOCEjI3DTW321
         X10XEo0nu6ohECoDpR1EWzdhZalrhpDr/O3Rvt6gRgoLbVs80/00sXIXa9QhC4RJshqh
         Js4lDOy0oKXgBNO7jOswszYVfT57XF9HMGojnYPZv2tZojKSLS68GyvVbswGdVaVivbP
         JZALcxt3DRdg1EXp0fU1ym+lVbC5CIN1qNyPSBc5VTQ7RmFXnLWkLZWQ2gUM3mgXUptJ
         hMCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xbrf0vLOxShJff8wjdlTZGIuqanEforPTuzsfc2p+uU=;
        fh=ytrT6lh546Jt7Z2d1Rdpqi/vK+UhgGhhn/hNziCTdS4=;
        b=L9YYzmygCu85bX4u3dAY4GLWE8KS6TLpZXIuKG3HjwMMrGbHN05bsqb73lGUjlCCRT
         XvD+QZdgWxeopTYicu25WOHVAan4+NdxvlfWu+I0EldvSUuFIX6gx3D4FcH85FffndTL
         rMldKOvq4Q5E0LtFwKBUfEmNJXBd01ggJGxj9+zCM6CHpCACf5dZ88WJX8kk4jBwPzxI
         +u/7zlN+hQUIoxr8VSl29GnR/6XOokscCuwcXEVVP7WmqXiBCxZmHChhRB+nzTx5Owo7
         HuN11xRfurEX/4HB/F6Og23BWdeC3Wryxxf3YK/r8MC+JJCRb5fDrT7mQDHggi1tzBmW
         ZELQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778990101; x=1779594901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbrf0vLOxShJff8wjdlTZGIuqanEforPTuzsfc2p+uU=;
        b=DW86/3wEt4xb9+gS5otyLkCZsEhI+ppti/utsyNM+7xt4srtzwLk9mz/OvhPAOW1db
         LSN+KlK1boU6q1cDgucMife4QInapTHmvEhnu7hIcoAtm1snLYi5TBWRuCGGs/zUC58t
         V2oN1Vc7eoSfIbd0aXBHPXK6Z204y7aJ8Y4b7HN+NA+7Ks5pfhzSSlxxMgk2fw5n/nFI
         ovxOAh4Yl/ljiasvQb7F63bz+CnUvpzlbREPqIumGVl/lQFgVUdC1779WUX7jkvs3Ev+
         dX3no8QtVJUO+0FEPx204fXXf3FmUEHcrMaP+yUqzxL4wsaTcQosOVKSOV4BGxWEGZts
         XN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778990101; x=1779594901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xbrf0vLOxShJff8wjdlTZGIuqanEforPTuzsfc2p+uU=;
        b=E+V+xVJ45W4BjNYNtbWjRlvXLadjigDjatxb9Qa8ghFDJ8GsJhAkT0HDIMvkGqeeno
         xLNdL/6emapLJ7OcrJzaUMKZ4kr9LbfE4b7xdFYqmVQZj6MAXv5AJiT1FprSIo1acAB1
         D5maYIU3T5Y0YseNjy0N2AGb9Sp5ESc4GI0MFHwi6g8WiW4rvqBXBYCjuG2mpgl41SBx
         HBRIGMznhB5uZWnBz6cmvd88m0mlT0Ggx+IvCRl/E+AMge3zIQl3lOCPePQ0jrIkwoK/
         2iGD+rl44R2ZZbjfZORGqoRAiTn2xfmq1vUhBEQ464xcm7APmUcD6On445jHeRxjZGXB
         +SJQ==
X-Forwarded-Encrypted: i=1; AFNElJ9H7wHuseJYGmAtZNWYbuE9gPmMb7D9sYXaac1TnPF0MJAm8NPhPfXotXLbCHbwpdpe6y56KZe/w+Nt2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRX4RuRC/KZDPPuvTG+JNv7kLhKJW7OfnUv+25dPvPkP9RnY7F
	bu9Yf/Ig+238vToySpE6rqkVKQzEGp3mGX5CF7xl6qrwDC2qzfKD5AMMi74MKocDYxwjXLmc8e0
	c5CBx+ucF/34V8ZPpudIGdEt6QJu6gkI=
X-Gm-Gg: Acq92OGz5WiKo5EmQXxQEoudHT/9QD5zkRTa5/Oq9Lrgjy7bf9lTBALv3HfmbBCuiq5
	Auj1HI+6bnViwDomELuGyy5dGucbD4bQNGptbJs/FTTiQzV5lgp0MmsJNcP4dURKb7PFVKyy3lR
	9ZDd80eUfykQeScvD3AFwS/SaW0Lv5IT+c0B1NvkEsFgcq/oONebNK2C2yE+QTUHyb3aSrMMqZ6
	COJmthjGsAI2xNL5oCbd28Wv8fnvkKybjlRHEVClANBcjb4bufPSmmNmnISpjkfG+8VUktbWdep
	azpddZ0K
X-Received: by 2002:a17:907:c291:b0:bd3:7b11:7870 with SMTP id
 a640c23a62f3a-bd51777ca61mr544791966b.5.1778990100962; Sat, 16 May 2026
 20:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427003457.1264511-1-coshi036@gmail.com> <20260507054809.GA19796@lst.de>
In-Reply-To: <20260507054809.GA19796@lst.de>
From: Chao S <coshi036@gmail.com>
Date: Sat, 16 May 2026 23:54:49 -0400
X-Gm-Features: AVHnY4KNTLVuSXINN0lA9vSO1jrGqK4vd0JcUP-N_FlwT8kc6OamExo64gDnw3s
Message-ID: <CACd_6n3s+Y+xdsuQVja=t1RUEdro2yQRyJyjpqFcd9_pF98OzA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] nvme: downgrade WARN in nvme_setup_rw to pr_debug
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk, 
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2026 at 07:48:09AM +0200, Christoph Hellwig wrote:
> What is "semantic mutation of Identify Namespace responses" [...]

The emulated controller returns a mutated Identify Namespace on
rescan (flbas META_EXT, lbaf.ms !=3D 0, dps =3D=3D 0) -- the host-unaware
geometry change Keith described (out-of-band format on a shared
namespace, or a non-compliant device), learned via rescan/AEN, not
the host's own Format NVM.

> [...] rather theoretical case [...]

Agreed v1 was wrong (1/2 hid the signal, 2/2 unrelated; 2/2 dropped).
Not fuzzer-only though: the out-of-band-format path Keith acknowledged
is real, and the branch is reachable from device data, so under
panic_on_warn this is a device-triggerable panic.  The deeper fencing
fix is the bigger TP-level work; v2 does not attempt it -- it only
adds the missing nvme_setup_rw() case for an unusable (metadata, no
PI, no profile) namespace whose I/O is already rejected, replacing the
assertion with one dev_warn_once().  Worth the bigger fix, or leave it
documented?

Thanks,
Chao

On Thu, May 7, 2026 at 1:48=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Sun, Apr 26, 2026 at 08:34:56PM -0400, Chao Shi wrote:
> > When an NVMe namespace is configured with embedded metadata (flbas bit =
4
> > set, NVME_NS_FLBAS_META_EXT) but no Protection Information (dps=3D0) an=
d
> > no NVME_NS_METADATA_SUPPORTED, nvme_setup_rw() fires WARN_ON_ONCE on
> > any request that reaches it with REQ_INTEGRITY unset.  The WARN was
> > observed repeatedly during NVMe fuzz testing with a FEMU-based fuzzer
> > that performs semantic mutation of Identify Namespace responses.
>
> What is "semantic mutation of Identify Namespace responses" supposed to
> mean?
>
> > In both cases the bio was submitted without REQ_INTEGRITY (because
> > blk_get_integrity() returned NULL at dispatch time, so
> > bio_integrity_action() returned 0 and bio_integrity_prep() was not
> > called), and it reaches nvme_setup_rw() for a namespace where
> > head->ms !=3D 0.  The existing BLK_STS_NOTSUPP return correctly handles
> > this dispatch; the WARN_ON_ONCE is a false positive.
>
> That means we fail to properaly freeze and quiesce the queue over
> update=D1=95m which has much worse results than just a WARN_ON.  So if we
> care about this rather theoretical case we'll need to fix that.
>
