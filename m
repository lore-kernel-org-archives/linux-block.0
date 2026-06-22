Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC89391E4C
	for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 08:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782117115; cv=pass; b=YeBVXVK6zS9e/KYgsK+Rk4xsYbczhFpJwz1gGgFM8CrjAUEeJA8y19hxtNA6A2mZf3UDhjpzzYiW4zgQ3GDuz6OapfkBAsmNaIVL8nP3Wu4GeOqBCOz7I1ZsvvRjxbaQIErzSjcKh/MKaE4quPzPX0FJEbEmZ2WVjkJ+Ji/QSWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782117115; c=relaxed/simple;
	bh=ig7N46VIRPdHLHwAftM4zR7B+ytNecdkZgiaA4Kj/To=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSmZfrnu1ffsHemoHcVHJfpIe/w8jBLQfiEmNlTFanM+pvmNRmRwnIoZCwfd3ezZ+rFyL8fPL2y7oNFcHWuTNLBRe2oT3O6yl9J2ac+5mpfo70G1iZ2J3z/3W9qV0iSFeuKLBdKk2C5zlpErGhw3d/MpnOEgpXs44mAVh7YD4JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dHAuP0bX; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dHAuP0bX"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5176ca6bab1so48644061cf.0
        for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 01:31:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782117109; cv=none;
        d=google.com; s=arc-20240605;
        b=gtTthqQROrpLR9d/TqjQWvvNgyr98aws9wlNoRI4S7777DmEm1nXwJGRk4ESsT7czS
         rIVkq3esmNco9KtRHDp6MmrmSkqFXDsnt/YPz5aUEP1Ux8UGcWqki2cHUkAG3pYNSNCJ
         F2yhiKE7ku6R9iua/kOO4Nrpt2Pen8DX6CrOK3NT+iAnGCdqX6eWzzXM3MlhpmbJaF1I
         3ZATC7AVhlN5uXHjI3xDsqIVuzlCRhW4qNL9mEekiILOV0ng4W13ZrxxHgwW6ClW09Kv
         5M9fluSA5+fyTMaLcoUtJGQ8LLQ84Vq3BvHLjs+vrGBGXnAP+l3JJ/CzwE1wuNVKofQc
         OAzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ig7N46VIRPdHLHwAftM4zR7B+ytNecdkZgiaA4Kj/To=;
        fh=swioSWXNOXIqleZX12Ah4+piqVk5OhritZqV0it03cc=;
        b=ioNT+rlNRdhcftZPmbQcDjYtC+oJuco3AEI0NwAHYJG1bD8WMrmS5Y+vvtSJHVzN+q
         7n7llmeYhf5zOf7ECTndRlqfrV7nxGWTv14Y6KfaCjvKhB9UpGjdNEAJTktbVw4to6KZ
         ZCCQCiMIeOyS9VafiuwUdc2WzaB7ivLGWUS4+ICiktZB9kk+F52mHaPfQaKHg/EmCJAL
         3Tt9ImLUu1vl6RnhRz++MEwtBUM0l/8DRQaRF0YQ25n5vtKCJUo9XFb/XAWvrLz14uw2
         INA5hcQHuZfXqOaxS02BKlVa0sTFou2PJyBZu3X8l3uQNfsHkEaNxIsYHUh2DsOr1PNm
         nokQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782117109; x=1782721909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ig7N46VIRPdHLHwAftM4zR7B+ytNecdkZgiaA4Kj/To=;
        b=dHAuP0bX7cTNWr0EgPBfjw4Ga1zmPqw2Ued7sgh4STqNSfzfjgrXGjntmltYt+uo91
         xLsNdXn3o4NAliz9r/6PQfMZo1Xf7WtnR1SqVgyvAehmgXMW9S8jASz3m9gEoxc0IBUI
         y9E2n4m5ojfrpXrhAqANzy0NxLe9bRLSEe6yh4BGm1ZlykcGIDiXVSm96yei6lpQ0+s4
         vZxQtx0Y0merqcEAml9duw0djSYjnEf3/dsg49iRLqcWxHLY023hoGr9Nfcp5xg9PRcg
         LcdDrNAIKlLwM1GRq7/LEwCraVIrFpcBKrRGISpvZb3Dxps6xTi9sY/KaIyEV4AsLQz2
         uaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782117109; x=1782721909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ig7N46VIRPdHLHwAftM4zR7B+ytNecdkZgiaA4Kj/To=;
        b=YUV3Kag++dCQ8eNrxhuu3SoP31K355fuUKeP1+PILDKkzGQfuuuvnV8piv8r8aPIpU
         LzydzRRq5fx0xPXgQ+wrGcr2af+o8L2ZYLAtsUDKUxlOXjWbP+IzqnQ7QZZ6XGUJ2tcD
         HdPbOxOuLLFTqgj5ucWNx2Cl8kNs6PATpO47fPt9Spi5uJEp0oTTnscanppJWig44+vN
         E+bWcPnq9LYq6P7y1rhB69dSB1vQxHM95JTUg/RxIB4iMkUnA2hU4DbchB08JxlK7lVv
         AA2eSA/W8oGlZ0RryXcd6ZUfmjgMFdoAT2uTdkTClijUuA4rkJY9Wh8jcuMn9B/QmOmZ
         lEBg==
X-Forwarded-Encrypted: i=1; AFNElJ8+ed4n8QU1zVLRpU51w2z0BAPrI/q/hMqca5GEDpzzgS/YqvnG4udRY0qqBNrNVYfWD/FlG06oFzKF9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSN4RNv32l9NSh0mtSrodqEIttEQQ5BeicsCpyFN2MG9yFZmD8
	Y79bv88q6ITvl9V7UPer7GLL1r60dhN91Ah+L5iuZqY49Sbtpup1eb510S8ub9GH4SMo6cD0p7E
	oI8Mp3/BwI3EJ36HwRv4X0rEqxKa5MXtPGdsmtGNT
X-Gm-Gg: AfdE7cn8OiSYWoDltFA6mM5K7jAcBBRAFhRkKrAgYr38wa7pBwFs0PHcEQzKgVI1V/q
	1CKNqA56r4z8n+9HokFFcEXqb1kNFmaWOeYJvaVNikWddRzbH7ZRtHHUJHGV4Axiw5KequQt0ku
	scjA/SLErtxcJyAjQpKq3+c9NsNgc/TeQ9N7a9NX3OAlJswQH77Nk/iIp9pDpzltR+UKZEB5RIm
	7NWn6YspFXvOvQjh0Sa7fRRQhHRY73oc6dFQQ0OeOmyNpI49pzodGUflqFQoES5KOUPWR4vgPU4
	fGmMIJKKvs+jOADfnRcLZ+Oyx/O6vofbRNl6KP7BW53cD1BBrkRtQ+vv7W7dKu2gJ3s2RihquWm
	tWlTCicxYjup/91lgPLg=
X-Received: by 2002:ac8:5f4e:0:b0:516:ddfa:b6b9 with SMTP id
 d75a77b69052e-519e66509ddmr120243541cf.23.1782117108133; Mon, 22 Jun 2026
 01:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260621235255.66015-1-kartikey406@gmail.com>
In-Reply-To: <20260621235255.66015-1-kartikey406@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Jun 2026 01:31:36 -0700
X-Gm-Features: AVVi8Ce7w-soiHgBKLGE9ut0Bz1-9KSRdqKSJVe3-LxE5mWN0xgtRYb-cNEzQD8
Message-ID: <CANn89i+ZE5nEMvhxJQAUp3WgyVLpQCdDhKbx1EqqQTRUtzVLeQ@mail.gmail.com>
Subject: Re: [PATCH] nbd: don't warn when reclassifying a busy socket lock
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: josef@toxicpanda.com, axboe@kernel.dk, linux-block@vger.kernel.org, 
	nbd@other.debian.org, linux-kernel@vger.kernel.org, 
	syzbot+6b85d1e39a5b8ed9a954@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 21, 2026 at 4:53=E2=80=AFPM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
>
> nbd_reclassify_socket() warns via WARN_ON_ONCE() if the socket lock is
> held at the point of reclassification. That assertion was copied from
> nvme-tcp, where the socket is created internally by the kernel
> (sock_create_kern()) and is never visible to user space, so the lock
> is guaranteed to be free.
>
> NBD is different: the socket is looked up from a user-supplied fd in
> nbd_get_socket(), and user space retains that fd. A concurrent syscall
> on the same socket (or softirq processing taking bh_lock_sock() on a
> connected TCP socket) can legitimately hold the lock at the instant
> NBD reclassifies it. sock_allow_reclassification() then returns false
> and the WARN_ON_ONCE() fires, which turns into a crash under
> panic_on_warn. This is reachable by simply racing NBD_CMD_CONNECT
> against socket activity on the same fd, as reported by syzbot.
>
> Hitting a held lock here is expected for an externally owned socket and
> is not a kernel bug, so skip reclassification silently instead of
> warning. Reclassification is a lockdep-only annotation, so skipping it
> in the rare racing case is harmless.

Acked-by: Eric Dumazet <edumazet@google.com>

Thanks!
