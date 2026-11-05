Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793900222;
	b=b0kHrq/KSIPY0qO0FxxQk4nd4JffeUt0PthFVzREOOMbWMqEEPYgoXbw4zJp37ZY4y8f
	 mE1gCMtzZZgXT4r/tB+ym2RNG/mkQyZxgCrnTasbf2p47GhXdu00Wf653CC7Z9yjHoAr3
	 8RUx0S2CoGdHSHnvRHSkdoi635jTmbm8CVr2PN0aJiIV58jAq5M6lwfM1s4PYWOvBGFIz
	 SFGVSHig94ojj+9DQb51/AAcxomhnr7oOCIlUbKxLgGroDT5lFoQcz3zaA4PSGpciba82
	 JF+j+MyuYGrW/+AQsR57yIzvv3ZLmbJK9TDWSqCKyrZ/uMtfNpkSLcLJdemeH2HNQtw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dk4g+BGecR/++NTUwlCVXRBVFsZCz/QDtiIPUnrLB94=;
	b=0BjGfG5jAbEN/kAYj2QggQa58K9cFCe4KZ66yDuBwHoq5FRuVsTGtTMsjFHGTEbw1JQC
	 BWqb1J3qPokWIVXt7eS92CDuapz6DVgC/HphDaprPUn+WB88zq/iWHXKoZAjRsvBDOS5/
	 +kh1nQP3z/ReqDezRAeEcKNhpl8P7t0D25/yE6emuTgW0yR3zLT1IfYTk1R3eRkPgBOJL
	 ZDEnP12RcNrddCefPcU4vYYYZ5dJ0taeCAb4ITCWlWGe2uXY7A5FBKCq2x269n0tk+9Iv
	 pTvCvkpJeR0yONQlOyGtbx9MrVW7AOqrBI4uxSGSHXIBeSvs5PyeKi5zcDb8EfKDt3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K7kVu37R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC0B606A326
	for <linux-block@vger.kernel.org>; Thu,  5 Nov 2026 17:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFC0B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K7kVu37R
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-49134c8509fso893432f8f.1
        for <linux-block@vger.kernel.org>; Thu, 05 Nov 2026 09:37:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793900220; cv=none;
        d=google.com; s=arc-20260327;
        b=HliJ6tKXhJKZVa+3mFM/4yJH1XCeDN/yu75b8wtI0hEqENJpkeS5VfKkwx0DLgSdi4
         pZ95rfdi5yRgwwMfMyMburX0SrvHei31sFEskH49eaBkSqvXwhLM4EOrcAktPq9mnRhr
         S/bGdrX/kUoywL4r0HYhIP95A5m7Ij7FWHPHbsRFKkMZgFNskJ+x971K38hFT4X2j9xA
         +hAt6FIhRVQx34E9ofyO1WRcSS9XcZ4PzxEUb7Qs241ABPsZJeCFxYZICOOg1X+/EvG+
         O6gn6CtrwhCKqQj8clwzI97Bcvvr+KdR8wWwjrMwaWR/GFkKTPOrxoxjIjzfMt356vWK
         FJRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dk4g+BGecR/++NTUwlCVXRBVFsZCz/QDtiIPUnrLB94=;
        fh=Bem1CB9eryhPhDDfZmLXcj04j/TBMc5SVsezrpREFnw=;
        b=BHDprI/98mODRKUusVL1Pz8OvWJgLbhrYmZNoxVy+UKCaY+9D82RSBFpS3QyqfWzxU
         1Y24BTnuGy6qofbZicNW81Gf/zDn+oM4NNSYIhhnBBRB24a3ZTMixh8unL8cgXd0oo7X
         /89K/M17cif0H1r8mSV5KFxVvbxLIglrgxbNLDCQckSEK/bMOKMfjvmBftrBQpSLfqOw
         TQAxDSPHDPxKa5naMpuvjvMMNc7At7FJNLrYS/unYQJEnjF00BKsNbcw3gSA7Gt7BaKc
         5Q5verUUkAbCrx58xqeOxafwsNaEx8a8b646kyWWwRfJwdpGkyTSlf7k7oGIKFP/7nKg
         DWoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793900220; x=1794505020; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dk4g+BGecR/++NTUwlCVXRBVFsZCz/QDtiIPUnrLB94=;
        b=K7kVu37R0eWcnSO0nBQjh4vfKVIHcpK2fP3N0EtYEzkTz7qfhrhVYnY666xgSibE+f
         9du+WOr5uZSRmv4vyS61JdP8oeWn3Pt03UFE1F4EfZ+pFngBtIFYeq/zvLgSrFvwgn2k
         VxjBlyP9T3COCIeGbCIrj//I4wYnBmap0quoSF7996rFURyo7+R8gXlmAjNDwcfEKjwL
         NVNa09Qn4n5CGNBIJ+iKwoMFCte/35X+ZkW1JDB3qTqFk9eksOB8SPQgi2HK1dfFKo9Q
         UvK+1U3/FgzMnu9r0MA54GVypSX6L3SJ5UeLiDPw7k9TXvaZ+KiNNSL6yB/My7R9G/Cw
         Uvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793900220; x=1794505020;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dk4g+BGecR/++NTUwlCVXRBVFsZCz/QDtiIPUnrLB94=;
        b=o1JMc+9EHSIEg+TRpu8PgAGN6JrAjb7dKyWRQVWQB/aZVeXSzaudb6CWJERHV/xG0d
         vAZAN4QR3YdrMJzG/e9nFRpdzEm8RWkAEF325T2rTj+V5F3ZvpNL0ZX37O6UTgp4x0fF
         g8U7uF4d5qfyd/46/QN6XsYhlB5+W/OpGf597vnLxUAMFHlsFoC4CofXT/Sdomp7+OiR
         hGLsY/OVcdbnk4r67m/hGWkHeiELAeUjxS5B47YEtXBNr6vAWAPyMLigxbe8UCZhJLq0
         5x02IRfZlx+BFBEFQ/RCqrTpvjUTOg73LtIfB/Vu7igeKYRL+B5w3nTNmy+mGUrXQNyE
         dJrw==
X-Forwarded-Encrypted: i=1; AKwUvBzK1chMCKq8kf2zagksO4lFXTr8rzpxaaQabt/+ry/MOYVJh3r+iy+SWolKcgtlyLNDoPs6fWkBtyjBJw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+eqAaY7PWPVmvCfgPnTyjte8AGYmv/bJEI5e8Vdgd8q983G3Sm
	0QK8LrHd8JjMJ2pGTsWMZtarWMeaVEcFk331Ds+zk9cZ5zUlKrEFQanr9lYHSljVUbEOaCDwW2f
	kKhL8aDO2FTmRRidcwwV+okMmoxoScu0=
X-Gm-Gg: AYBFou0w8VGSVcBdYHCMNKpInzUcOHPnHqqiw3y5ysk60ISPGTj/5cWagpzgTcuDEk4
	5kbqaJ9NmDYRVclkQhuZLckXX1dn+DVlXa/00Q/OVYqg6qyr7G4hCAsy6CpWgwHCfebFCyFK+LS
	s+KFTJOVglYeUQONdctsyFmrKxmh+z9HDGynpGOp7DoMPGY/Hp4twD0g3seN7MKir909CYjiPA/
	Ruugl4VkRYhE02jq/p1TSmZMGJJETPgVfuf7K7Ekz1kI1pcrZYZyRy3ElNWi+2Be++FhRlfYhCJ
	lfxAgDpklVZpdfCCjIVDELjF4C5kb549bQaE2rcToYUigkB4Dea8pEPWHpYC9lq9K3K4b9kk5ga
	Hb2fNAQ0Ef78nbdMQxuyA1d3GpWuPNXXWkHr2BF0EwWYDJ3yJZrkUCYV/FFC/Z9mfv5Ux7PWVSV
	tYsgbnyiXdOhwleudfL/RPK7BpoQWDjQOA8i0SHoIx+rwOJMnH1W21
X-Received: by 2002:a05:6000:2901:b0:48b:59f:db9c with SMTP id
 ffacd0b85a97d-492775f03ddmr690889f8f.53.1793900219836; Thu, 05 Nov 2026
 09:36:59 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105044752.1997895-1-senozhatsky@chromium.org> <auy9UfB30AlYabV8@google.com>
In-Reply-To: <auy9UfB30AlYabV8@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 5 Nov 2026 10:36:48 -0700
X-Gm-Features: AclHuK_riEVsVvEc_LND-HcPqE5QdPWZJpeStDe2FO2VdPoa8v6ez4SntyVogl8
Message-ID: <CAKEwX=Nao4jWtY04FXEjxiHUNUhJU2A6nCZLqhRRm-dPBZTmcw@mail.gmail.com>
Subject: Re: [PATCH 0/7] zsmalloc: redesign object alloc API
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, 
	Richard Chang <richardycc@google.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 10:31=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Thu, Nov 05, 2026 at 01:47:30PM +0900, Sergey Senozhatsky wrote:
> > Both zram and zswap already have per-entry structures that store zsmall=
oc
> > handles, so allocating a separate handle_cachep object per stored page =
is
> > redundant.  This series embeds struct zs_handle directly into zram and
> > zswap entries and drops handle_cachep, saving 8 bytes and a slab
> > alloc/free per stored object (2MB per 1GB of swapped out 4K pages).
>
> I always hated that extra layer of indirection, thanks for doing this!

+1.

The mental load saving excites me more than the memory saving :)
