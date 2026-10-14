Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791A9309EEB
	for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 20:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792010800; cv=none; b=hWGVp4MFY0UKUfnrpZHW334Y39PQcxegvgVzujQB1kPBtAtA4Veor0Yfe/1Nvkxq1ysCQwpm1PtP+OJzo8r66tYjuvsjD10VuvMNRrDwmbfc6+ePKQmm54fkl172dA64rtIzszb8LSTslqD0jzUXSGInxZZbwmCIVSd6WG9YIJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792010800; c=relaxed/simple;
	bh=+ZrykYisplv6ihmUa30REc3yl058My87vK/8HY05NOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jf8aPN0fwy6HhdzJSoNubNgeUJnR0cEFZ0Rgny6RF0NCRUTkVKdE8eTEAEFYNYp1VfCGXB7EeT6vxP0uS++Avy1R/XQHxfl6InxiBxEQ+y7O1oSNGdy8yqVf6p9TP37rWqas/GzxQdspErJUjcEYrZZ0sElYn5SbTQJCE6+REJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6DEXWQf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6DEXWQf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAC91F000C7
	for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 20:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792010799;
	bh=BOFXdtlLJRQYMv76Rgndlsjsm+9tUOiWDlM1kttoyjI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=c6DEXWQfVGokGZ9CK9fvFUarx2vlpofDu5HZHLOpqf6xCyYjLf0uqQkloauiJw8dE
	 gW6Rbsel1roRQZeatWFTIDafi5MoF0MKr3blHEzWknrPMekFnPlKdSpRQZzZ3KVKFR
	 i2eLbJRcJKZKczi9f+QirwOLqGh5Uiy3swk5aj/fIJphLd+NghwNa6wxO1hJ/hGHV6
	 JJJxnYZTCtIs47pPG3JJOdG6PQyt1FofSUddaX6PvClGABAqvm07sp6Et+LOIKTqvF
	 Mx10GgqzqLlEaLYCM7P4L5IkaurRxP4TP8/QV+ztAhIVSPViMOt71WPYCyJwfDAxDB
	 1K1/gpsHCfenQ==
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93efc0452b5so59381885a.0
        for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 13:46:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw5eTRr0MLiW8I8L3z1LPl7EmqpejepNG47Re6CoVak4hNBl4iqQKYRl9oE9/gR1Nq8vzRKulErsjE91w==@vger.kernel.org
X-Gm-Message-State: AFq9FYIgzjzgrkWamUK3D3ZbQvEDGBP2c4/4XIPx9P6i1/H/0pz5y7uf
	s+//cS0C4e78aAvf6AU5D1Emz9xsegz3Z25/2hgWZoQGPLZaNO+z/7w+xbq1vTCVgEDzIvNcdDT
	g7rqeoS6u/0gG96O1YkG3vdfJuEOVvBw=
X-Received: by 2002:a05:620a:370c:b0:93e:7944:b874 with SMTP id
 af79cd13be357-93ebd244676mr2716481385a.33.1792010798449; Wed, 14 Oct 2026
 13:46:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013035201.2809924-11-senozhatsky@chromium.org> <20261014153603.1365617-1-zhangbo56@xiaomi.com>
In-Reply-To: <20261014153603.1365617-1-zhangbo56@xiaomi.com>
From: Barry Song <baohua@kernel.org>
Date: Thu, 15 Oct 2026 04:46:27 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wuPCPR0DnbrLp7ebdO=Oih6K_yP4XxwETKQ+3U+THVjg@mail.gmail.com>
X-Gm-Features: AclHuK96raYTD1_AYOBRwPY6SYxU3fp-WrN3O5LVPixrw0o-dNEHuRIoMVnayBo
Message-ID: <CAGsJ_4wuPCPR0DnbrLp7ebdO=Oih6K_yP4XxwETKQ+3U+THVjg@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] zram: use rw_semaphore for decompression streams
To: Bo Zhang <zhangbo0325@gmail.com>
Cc: senozhatsky@chromium.org, akpm@linux-foundation.org, bgeffon@google.com, 
	minchan@kernel.org, richardycc@google.com, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 11:36=E2=80=AFPM Bo Zhang <zhangbo0325@gmail.com> w=
rote:
>
> Following up on the RFC thread [1]: Sergey pointed me at this series as
> the reworked version of the by-direction split I had tested, so I applied
> patches 9 and 10 and re-ran the same A/B. Big improvement.
>
> [1] https://lore.kernel.org/lkml/20261012123328.1138059-1-zhangbo56@xiaom=
i.com
>
> Setup as before: real Android device (MemTotal ~7.7GB, zram ~8GB), cycle
> 20 apps through fg/bg to force swap-out/in, 8 rounds, reboot before each.
> Same trylock instrumentation on the stream locks across all builds. For
> patch 10, "read contended" =3D dpin_contended + dexcl_contended. Decompre=
ss
> ("read") is the swap-in path, which is what matters for us.
>
> I use decompress acquire count (swapped-in pages) as the comparability an=
chor
> instead of swap volume, which stays within ~20% across builds.
>
>                       baseline   preempt-disable   9 + 10
>   read contended      24,749     406               1,959
>   read wait_ns total  239.8 s    3.78 s            ~12 s
>   read wait_ns max    757 ms     51.7 ms           72-96 ms
>   read acquire        3,948,150  4,305,078         3,510,610
>
> Decompression on 9+10 splits into:
>   shared (stateless backend, single-page): 76.7% -> down_read never
>       blocked (dpin_contended =3D 0)
>   exclusive (cross-page object): 23.3% -> excl_lock, ~1,959 contended
>
> - 9+10: read contention -92%, total wait ~-95%, worst case 757ms -> ~90ms=
.
>   The rwsem does the heavy lifting: ~77% of swap-in decompressions now ru=
n
>   concurrently with zero pin contention - exactly the reader-vs-reader
>   queuing we were hitting. Clear win over the two-mutex split.

Nice to see such a significant improvement from Sergey's patchset!

> - Residual contention is all on the exclusive path, mostly cross-page
>   objects (which need the ->local_copy bounce), not a specific backend -
>   lzo-rle single-page objects all go shared.
> - preempt-disable still shows the lowest read contention (406). It covers
>   the other half of the root cause (holder preempted/migrated while
>   holding the stream), so the two are complementary rather than
>   competing: 9+10 removes reader-vs-reader queuing structurally, and the
>   ~90ms tail that remains on 9+10 is the preempt/migrate effect.

is it due to the case that sg_is_last() is false, local_copy is needed?

bool zcomp_shared_decomp(struct zcomp *comp, struct scatterlist *sg)
{
        /*
         * Shared decompression is only safe when the backend has no
         * mutable per-stream decompression context and the object is
         * contained within a single page (no ->local_copy bounce needed).
         */
        return !comp->ops->create_dctx && sg_is_last(sg);
}

Also, with either deflate or zstd, create_dctx() will
always be present. So, what algorithm are we actually testing?
What happens if we switch to zstd?

Best Regards
Barry
