Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABDB1E5732
	for <linux-block@vger.kernel.org>; Mon, 18 Nov 2024 20:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731961680; cv=none; b=VBuATGSIkC4znRSNxfSlbQxsJcJe6Ds+0c/ahMWVERkxRvuoI/hyF33xvIBKlHbbkALRLdJDoTD2KcWK4zq5UBG68+ZqlDvH4ncBOoVFHDMJNZxyWWUEJyfvehviXD86jS+lG4p8cy4gNSt1G0ZI65DxK1ltbNcgmDa0tyqp5KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731961680; c=relaxed/simple;
	bh=9wt15ulKBkpgMzG9LbQFUs4uKjQNjvWZsmCw0A961ZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1+qgc6vzDSQ+xkjCYrSxeIo441cM4y5rtTdA0qC/udcMHyQfOyTcWIFPtvvHmWtx3c156xZuWXennAiWlzAFnPUAQQFsdm1Ff+1q0pZtzTsJUhRtZEqNgEGDKljikd/Z2Y+ycsAoapJWQNubbZvP1FNLAJt8RP0qjKmv03NlKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5jn1WX9; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5jn1WX9"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5146e5fad69so1596930e0c.0
        for <linux-block@vger.kernel.org>; Mon, 18 Nov 2024 12:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731961677; x=1732566477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ImpYfP64Smf9+Sr1EizKCd05nlaJs+ATDqiVuVIPiY=;
        b=e5jn1WX9pPvEmZ4H92itmE2Ib7av9iO7QQif+tv2g4AOsqS34yl1HrUxIZTNtCNtzM
         k2l/wHSiFEhwtAQlQlHrJX2VF4iHc+4VSo4ZpazkhjTgDgXshFHdgviUxeG9VMiSj5t8
         A3Y8R9S4ZhHhXDQbgtC2gUvQU1o/oX6O0ZoqE508TERG06NyeYreOsqC5C3IFgAu0i9Y
         nxjgLMVjtDWdlatmqw0oeZY8gB48wYM0+twOFJ7f2tsNCzh3uIHRub86vwFWR8vq7kgU
         l/89onF1irh+Gd5XY1gfsr88/+3fShVqzBeExC5aMuE7ESyjyLOK4CYAHv3r3bUYHoFl
         lZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731961677; x=1732566477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ImpYfP64Smf9+Sr1EizKCd05nlaJs+ATDqiVuVIPiY=;
        b=s5VV8raLo96vfmU4iZEeXk3wm/qWzEnXhq6OTZRKFYpYVg/peuEiCUGHdgJ+z/TRr1
         0PEdYCcm3GjAA564EzHchJBrjusNA5V/UJVO6Y7WKGq/8Omj+ONKN+5/ZxelvYlximzF
         8la1+ahE6wWk+/vrAlTB8QpbaNhuOudlx9tus+dWB1x6kUlMS5jBwZ5jidK+MDhv+HZ9
         UiHBGqnk4VPjEJisWBcvI8nc3PpsnLpYiLXvmC/7ASbKmamb3LdzLzpjpoUE1Wz+3tiy
         uDmZXFEKPNdFqq6AxEgBYw0MGM/+PCXMcwm2Y/ZnUCGpxdMsCgSs4RVp+4uXqkbWz6Ub
         iF7A==
X-Forwarded-Encrypted: i=1; AJvYcCWmcXJbAygc8yFB/I+LUPKx1EmH1MQi1uRBrmmTPQblg3VweoJ2mfH07TQTRkmtWFpNIKzzuyWx7lSnZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsOaWmS7vbC1GG627iTAjyxZAMl8NQRbuXoqJqL9A03LYRrIs3
	bzKBMxNhFxx1lcmD768Cyv0Nt7m8YtbsdLXW9hbEdlg8dOkBBfctcKt+3ONMj6G7gwVU3iyXI4I
	mk8pGGB8HfCr1CYYXAyFjOU8QbTw=
X-Google-Smtp-Source: AGHT+IFetG3DwYT0YipBF7E9k3aPFZTcYMI164xuz6dT9vxzTiUhhaJ4F+2R4bSbd0jYr4SPlQJWQaMMQEH95fr+VwU=
X-Received: by 2002:a05:6122:c96:b0:50d:9c60:830c with SMTP id
 71dfb90a1353d-51477f99ceemr11701015e0c.7.1731961677316; Mon, 18 Nov 2024
 12:27:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107101005.69121-1-21cnbao@gmail.com> <87iksy5mkh.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAGsJ_4wOGPbGQgqDidnYUCCpAT8sw+S92NEU+trAQL_rnC10ZA@mail.gmail.com>
 <28446805-f533-44fe-988a-71dcbdb379ab@gmail.com> <CAGsJ_4yuZLOE0_yMOZj=KkRTyTotHw4g5g-t91W=MvS5zA4rYw@mail.gmail.com>
 <20241118095636.GA2668855@google.com>
In-Reply-To: <20241118095636.GA2668855@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 19 Nov 2024 09:27:46 +1300
Message-ID: <CAGsJ_4xmVm3QmfQoUe20OouiYQoer5CGnAiz-ppvum1esNmeDw@mail.gmail.com>
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

On Mon, Nov 18, 2024 at 10:56=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/11/12 09:31), Barry Song wrote:
> [..]
> > > Do you have any data how this would perform with the upstream kernel,=
 i.e. without
> > > a large folio pool and the workaround and if large granularity compre=
ssion is worth having
> > > without those patches?
> >
> > I=E2=80=99d say large granularity compression isn=E2=80=99t a problem, =
but large
> > granularity decompression
> > could be.
> >
> > The worst case would be if we swap out a large block, such as 16KB,
> > but end up swapping in
> > 4 times due to allocation failures, falling back to smaller folios. In
> > this scenario, we would need
> > to perform three redundant decompressions. I will work with Tangquan
> > to provide this data this
> > week.
>
> Well, apart from that... I sort of don't know.
>
> This seems to be exclusively for swap case (or do file-systems use
> mTHP too?) and zram/zsmalloc don't really focus on one particular
> usage scenario, pretty much all of our features can be used regardless
> of what zram is backing up - be it a swap partition or a mounted fs.
>

Yes, some filesystems also support mTHP. A simple grep
command can list them all:

fs % git grep mapping_set_large_folios
afs/inode.c:            mapping_set_large_folios(inode->i_mapping);
afs/inode.c:            mapping_set_large_folios(inode->i_mapping);
bcachefs/fs.c:  mapping_set_large_folios(inode->v.i_mapping);
erofs/inode.c:  mapping_set_large_folios(inode->i_mapping);
nfs/inode.c:                    mapping_set_large_folios(inode->i_mapping);
smb/client/inode.c:             mapping_set_large_folios(inode->i_mapping);
zonefs/super.c: mapping_set_large_folios(inode->i_mapping);

more filesystems might begin to support large mapping.

In the current implementation, only size is considered when
determining whether to apply large block compression:

static inline bool want_multi_pages_comp(struct zram *zram, struct bio *bio=
)
{
        u32 index =3D bio->bi_iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;

        if (bio->bi_io_vec->bv_len >=3D ZCOMP_MULTI_PAGES_SIZE)
                return true;

        ...
}

If we encounter too many corner cases with filesystems (such as excessive
recompression or partial reads), we could also verify if the folio is anony=
mous
to return true.

For swap, we are working to get things under control. The challenging scena=
rio
that could lead to many partial reads arises when mTHP allocation fails dur=
ing
swap-in. In such cases, do_swap_page() will swap in only a single small fol=
io,
even after decompressing the entire 16KB.

> Another thing is that I don't see how to integrate these large
> objects support with post-processig: recompression and writeback.
> Well, recompression is okay-ish, I guess, but writeback is not.
> Writeback works in PAGE_SIZE units; we get that worst case scenario
> here.  So, yeah, there are many questions.

For ZRAM writeback, my intuition is that we should write back the entire
large block (4 * PAGE_SIZE) at once. If the large block is idle or marked
as huge in ZRAM, it generally applies to the entire block. This isn't curre=
ntly
implemented, likely because writeback hasn't been enabled on our phones
yet.

>
> p.s. Sorry for late reply.  I just started looking at the series and
> don't have any solid opinions yet.

Thank you for starting to review the series. Your suggestions are greatly
appreciated.

Best Regards
Barry
