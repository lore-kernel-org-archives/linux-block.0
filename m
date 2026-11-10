Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794332238;
	b=EWPqnl/BToOC0SSVl9NUbml0sTbKCq1+FHZwX8weG9ZTX2gDr7BUL1RHYJEywGDglTL8
	 NYEcwg6JTBto8mVcjtIUTGaqM1GHUsIemV9envoreXo4lKyig2izzhmjgO30bDQcL90lh
	 RiLwUARQZ/9yaR5RHcj1pm9BZ0wW+Yp7G7yafu9m9FA8z03NFsM5rM+DYyoZH7thQQqte
	 Sgfj2qCuaAvWFUmmYAxqGxMFsEkWvhdF4YRWBQXH2BNWE/9Z0s8FLkyE+G3pAmjCIT54R
	 /YluRFUYGIpWm1wK3pom+O0SfiSZ16Q/PeTo3Q03m6gWDwD/+BLwYAxf/1DKoThcMQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=aTj3qd6Vt1MRZaASDWxaes19J99UpofFOdzQAHbhsTI=;
	b=44pH55KzoGybwnaXIIohHvcp8eQp41+lsIAY8zLST26fk3+STY9QD7dh/aSYH0iHskPb
	 /rmjs+6jTOchhvOVknfvVv83Zz3ewPITgz0LhNt7Y+NtMFelRi9pjqX+cJkAlRYGuqRRX
	 362qoN7lQXk9NxqwscuWU/Wblqk+eKG11CYKfs3uhg3pxLuUb0/exqJ94kR5QlBUVI2Vs
	 WqogbtWXLj34px1BebjG9BoV3gQysEU+aAxyqBHPn5tEDyyw/MUiZIfyXNS1ttlOF1eot
	 6issUQR7+LnQjZWRk5Me6xnrTBTn1ChV+PHECWozGGJId4II8TLF6M7Aas3lS1Iwiaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IALzEI6U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7839D606A31C
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 17:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7839D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IALzEI6U
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5c126fa1e3aso1511481e87.2
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 09:37:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794332237; cv=none;
        d=google.com; s=arc-20260327;
        b=coFiY3S5B65WW9L4H41lPJyQGNJDsLNBm1aL4ZOZCUV3GGm6eOkfkhJ84I9R+KGbq0
         z2eBWyMgWS7uuojxuPNxxtrFpTgO0ZfhpjP56wntemniD41TEpt41UzJgoBAwB74Ox79
         ajNafYmXWe6S/GY24Qs5tzJM22G6c849l9lFAa3aGXDcFHvEutASXq+d/1aeIRD5hyB9
         2r3Nb5BPGZpDDgefCt4hvms6stibKRFMnYmk6CtlauV4ddtpX3oyT1gvCfRWc36KpSFL
         yegpu71pMinNQV+sUMndc5vQpH91ICwulTOx/YfCi1AbP7PK0HGeYzCpqehhajw4Q6pW
         tg5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aTj3qd6Vt1MRZaASDWxaes19J99UpofFOdzQAHbhsTI=;
        fh=8PcRdR9C6f/MMVxPdh3RHyOcpsBwKpazvCHzITQA7Sw=;
        b=Gq5Qcb0NqzONGH5OhYNMcpeHmdbsECuIUfhVpHoIvnd6H7REidfaCiuWgtLgDcpZ0r
         iHXgSSWWWISsDSRKbkn4e+Cz2Qo6u3XH0H/YNxYFhezGq4r3+ojXZ17O7Ni3i3NMh8D6
         VA9UJFSrjAgz/1OV3g0AqIZyyHiTvvIi7geP+ug4ud54IxfvQdWN/OJ9Pv+BSdSfhfMB
         N9kPs0hrwabQ3S84MPs/4Sun4zmubqeS52LZbV2VtW+7rqPV7LDZ5yi/R+CJ2Xxo41ad
         jaNpKtGyxYh31XqbbYtu5bXg52IIgLmVRgPAkeEWwEbwjePd4rvvYyyg0dEwWnf/8/VP
         KmtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794332237; x=1794937037; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aTj3qd6Vt1MRZaASDWxaes19J99UpofFOdzQAHbhsTI=;
        b=IALzEI6U9cts48X2+tWtXmvjKgMvF5xWHwrbRtgsrZ8/yQd9AzRsTBHK6GBRTB9V2Z
         TB7KRiyhzAIfOASyMGLyElUeCHPztvFDKxfYo8pdZv+AdUH6C1zSjsdXds3cS68RnmFo
         EasI+pOD/DYYWg51m1D+Qx+pSRU71B6nDD9LQNtKZfBtuD6hmFcXb/lzK/zaFPtEJrn5
         a4S7SzWDlPf2aA3+zfwi3KaIdonbqmwIcFtGO7OsyIq8NQPcNU8CEfuMJ8yX7LB9kO/N
         1TZpD75ylGMmOSTIoSvEnmyCZEaafUFiyHojb3BZ5MjxdZ/7hJf9LpEpG/HeVWHoS02Q
         VQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794332237; x=1794937037;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aTj3qd6Vt1MRZaASDWxaes19J99UpofFOdzQAHbhsTI=;
        b=dmu2Is7w04W1iqW7Np72HjVl8IXIG+LEWrlyjn5lfn174LeTwReo/q9uf1dAyZ5JhP
         yWlsgirNrPL/fHzLgNVMrD1FO0zV7R6bnyPIi+tlKbrKoFbSwH3J5OMXNDbAWMdKzwRp
         0lL/puQuKx0C2rqdUV0e9S8KeIx2OrcgysgxGN08x+veO1YoAiXb6c4RsPeS11jfMMyA
         r7+2kn1hm7idhqaZCTmjVnHFEAElVoUGZY2CQH6A+hlsBvwWUtdXK9kCttTclKDsISvJ
         LcEy08A94Q44YIf5mRvxsm7lNfCWxAIs22WWowkdv+tptI6E1dpt1KZgNdO8/QnxP3VL
         th3Q==
X-Forwarded-Encrypted: i=1; AL+hErEgyEvBYVU9fLuacUngHn35sFjeKXznuSN0djztO52Xb4j0nor6XvjA3YEAo8deKuMnlm56qmmB0pIF9g==@vger.kernel.org
X-Gm-Message-State: APuU4Z+u3M+YC+tWgiZoQGy3sRaX6ga4s/pkq48ykkTYstcRTrRbDoHv
	vPMTFdiqrHRCi+SWvfgPSGbOrMRmYH6NMirTfCG4E3tbHQUX7YnTv1v4rhtI/qGRJ9xJCcuC4Rs
	U0sT2TlHLvlOBjUyBjS28oV3VJ3j8ntg=
X-Gm-Gg: AYBFou0uQdsabA6STTFeGhAG6lh3hVdp/umnmrYmYMlPf3k8wog55SoyOle/cuflpOY
	aqQ9d2A6QfWNcMdt2HBB2KJjceOPtIcJfyl7lUcb3HLfl62DJ/JzilfufoubUmw2QeHiBu7Yl2M
	e3m81TCP7UOobvutO8OSdW+lwWTaqmWvuZFpFUERiwa4x7wA3EGEUbdvjsMv0E1UVa5Ig9lJz6W
	5MPQKgJF9K3QtRnLceIhYB/Pax0uK+klZUpVcBkVPo/MNA68xXAOsj/zztcKlVCyxj+wV511VeE
	vjYQtU/5hoZW0rp1vZHREGZsK2ueKaO7zXECKXGOj07MDWrKXpvRkV+H/QPjSAAb1U1Hxa8CkUX
	bXtSL/jwywiT/+Q2Hwa1Y3UssNOVxoQmrng3Xlq9Zvh7bC31j7VTCVpBsLPdwcw+Mh1p9QuGyBD
	Kx1BfFrYyX9O0EB6RC79AY+ZVmMYDIVbuZvwQdAiH9Xyfj3c/fer+m
X-Received: by 2002:a05:6512:3d1a:b0:5be:5dfc:864f with SMTP id
 2adb3069b0e04-5c156edbe56mr956551e87.50.1794332236347; Tue, 10 Nov 2026
 09:37:16 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110054836.1515030-1-senozhatsky@chromium.org> <20261110054836.1515030-4-senozhatsky@chromium.org>
In-Reply-To: <20261110054836.1515030-4-senozhatsky@chromium.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 10 Nov 2026 10:37:03 -0700
X-Gm-Features: AclHuK9LQ0vxiDk2KIYMiT7GhqA-_skur47RligP3Oz7EqQzE4-EQhLXbRXuiB0
Message-ID: <CAKEwX=N44K-0d1KMV_iURtJU+xSuv-X_x2R=g1tBUt_QBEx1Fw@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] zsmalloc: return handle from obj_allocated()
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Brian Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, Richard Chang <richardycc@google.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 10:48=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Allocated handles are valid kernel addresses and never 0, so let
> obj_allocated() return the handle directly (or 0 if unallocated)
> instead of returning a bool.
>
> No functional change.
>
> Suggested-by: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>
