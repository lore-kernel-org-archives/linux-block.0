Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FD027452
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 02:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731984707; cv=none; b=QbSU+r5sM4Z3U/Des+mdkntdvlRrJ0wj7JtmqFTiqQV3xpADs5D4zpBca/o+rDzZf1P4R0puCg5cWUAP2N+KbBuLHFezauaSgZNwYxhd3xID0IgiFjf+3MRYRRs+ZWjUG4OjegjlXvoSPmmSloeUshzQ9KWilPTwGJ9Tt3KhFks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731984707; c=relaxed/simple;
	bh=NIcjQPZbYXf+GMnOCoJkJW86oPw3tuRloRLV5XHElk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJ3q5o/kSY7kkoDxQh4Oj//Ww4U9lOciBfr85ulQBIB89uYExcyU0lXw5xeLdm3g9gxfeZu0ljCZCtKq2r1q8rJ8SD9kQlqmSAq5KtIvjCXcl/qcko42PBGnWxttbxoEq4YvlAfKuSlT65Y0CTqaAyScNITH6H2njWjOh0e3cbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUGqzPNM; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUGqzPNM"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-50d2d300718so1031130e0c.1
        for <linux-block@vger.kernel.org>; Mon, 18 Nov 2024 18:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731984705; x=1732589505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTIURbw5EEIxdiFhvrHBiCH8qsvGetEbwGmJfZUUGNg=;
        b=NUGqzPNMCRls2rHKcSlxqe64X8uUyrJxJCqQ2lEoZT7eg0VHFue5Q7UXGfdlG3i7nc
         HGXbNF4WL4m/aQXvZn0dTsbEuu4tJDvvKlWGlIUrFi13MXY0qaGL+qhZEhx9StQSiaGb
         tTvmrwGNnEFIb8GUH21UXy4yWv0u3tUe2qH90guMkAhvdiuDjcLcKhsk4GTyQ9zCCkdI
         E50yZYnAx4mUN6ao5dYzVRc2+ukpIUAdziHgBMK4VDnVmg/049XWtqkPxRPf91+g2zDM
         K+DV5a/whrr4JXcdDmS85gcdUZ2o3mFZN8RpA9FlEDCbTbcMfsHQGUQRbECkqeGjYOAF
         DazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731984705; x=1732589505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTIURbw5EEIxdiFhvrHBiCH8qsvGetEbwGmJfZUUGNg=;
        b=pgMtO2/PAsm7DDu8yxt1cmwu27ve3Dy9MPSVX2kcl5UlmBIj5vJfoGejeUBe/l7kHQ
         ffeV/od754+CCTXnizoNCiURPbIyo0i6HgDAH0eAmVhS4PQFmqeWuW5WgZD4tBb8zzjk
         6xtHeKqvtk9kxnFar9JypHWst00MS2jVv5QlNgA3UadSiJudt0NxqSwZdlZO7iq2gfQB
         HQJpv2YSGZEURsFpPD/aiVbYiwicHXaoYLWxbpz5ncjxHeRnwFkTrp1iyuUU/HpuuBnd
         Z5DA81GHgAbmd8ykDEYglU1My+ibv1tFQ/Jxh3rYBbaidW2ihalP0Pa8D8KnxjVm6pre
         aj9w==
X-Forwarded-Encrypted: i=1; AJvYcCWjvpyR4Nx4JpiAPyh2O84T6a/FOieEYLP87PpVuNeg2/YxnojHQV2HV0BJ5NcphuYrAWMXMZhPJILaSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAN1weJPzBd9gAq+F7p5ButoYs0fVN1g8B/ACPPXZqEmCyINo6
	bUFn56ad0hDjOAh2hvB2Y2f+nWD57cz9Jy60fb5uI5N3tBnRELRFApgyJL8xBVq1q4k5Ldq0Zxg
	kH1W1WHxqZYLwl6Nd0dHiq2zWXOs=
X-Google-Smtp-Source: AGHT+IHEwJR/63PnU9Y4bPwec530PsaNhXhlYIp/JApfU/r4NiezH+1B/bowH9/eomqUHg1+o8FEKPoIRZs3QQUeGJ4=
X-Received: by 2002:a05:6102:d8e:b0:4ad:571b:c16e with SMTP id
 ada2fe7eead31-4ad62b61de6mr13769972137.3.1731984705167; Mon, 18 Nov 2024
 18:51:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107101005.69121-1-21cnbao@gmail.com> <87iksy5mkh.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAGsJ_4wOGPbGQgqDidnYUCCpAT8sw+S92NEU+trAQL_rnC10ZA@mail.gmail.com>
 <28446805-f533-44fe-988a-71dcbdb379ab@gmail.com> <CAGsJ_4yuZLOE0_yMOZj=KkRTyTotHw4g5g-t91W=MvS5zA4rYw@mail.gmail.com>
 <20241118095636.GA2668855@google.com> <CAGsJ_4xmVm3QmfQoUe20OouiYQoer5CGnAiz-ppvum1esNmeDw@mail.gmail.com>
 <20241119024513.GB2668855@google.com>
In-Reply-To: <20241119024513.GB2668855@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 19 Nov 2024 15:51:34 +1300
Message-ID: <CAGsJ_4yEn9E29sELRE=4ywREKjXL=pZQzb+5+oUuq4xAXOY8LQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/2] mTHP-friendly compression in zsmalloc and zram
 based on multi-pages
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Usama Arif <usamaarif642@gmail.com>, "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org, 
	akpm@linux-foundation.org, axboe@kernel.dk, bala.seshasayee@linux.intel.com, 
	chrisl@kernel.org, david@redhat.com, hannes@cmpxchg.org, 
	kanchana.p.sridhar@intel.com, kasong@tencent.com, linux-block@vger.kernel.org, 
	minchan@kernel.org, nphamcs@gmail.com, surenb@google.com, terrelln@fb.com, 
	v-songbaohua@oppo.com, wajdi.k.feghali@intel.com, willy@infradead.org, 
	yosryahmed@google.com, yuzhao@google.com, zhengtangquan@oppo.com, 
	zhouchengming@bytedance.com, ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 3:45=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/11/19 09:27), Barry Song wrote:
> > On Mon, Nov 18, 2024 at 10:56=E2=80=AFPM Sergey Senozhatsky
> > <senozhatsky@chromium.org> wrote:
> > >
> > > On (24/11/12 09:31), Barry Song wrote:
> > > [..]
> > Yes, some filesystems also support mTHP. A simple grep
> > command can list them all:
> >
> > fs % git grep mapping_set_large_folios
> > afs/inode.c:            mapping_set_large_folios(inode->i_mapping);
> > afs/inode.c:            mapping_set_large_folios(inode->i_mapping);
> > bcachefs/fs.c:  mapping_set_large_folios(inode->v.i_mapping);
> > erofs/inode.c:  mapping_set_large_folios(inode->i_mapping);
> > nfs/inode.c:                    mapping_set_large_folios(inode->i_mappi=
ng);
> > smb/client/inode.c:             mapping_set_large_folios(inode->i_mappi=
ng);
> > zonefs/super.c: mapping_set_large_folios(inode->i_mapping);
>
> Yeah, those are mostly not on-disk file systems, or not filesystems
> that people use en-mass for r/w I/O workloads (e.g. vfat, ext4, etc.)

there is work to bring up ext4 large folios though :-)

https://lore.kernel.org/linux-fsdevel/20241022111059.2566137-1-yi.zhang@hua=
weicloud.com/
