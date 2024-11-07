Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2999E322E
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731012839; cv=none; b=PRjx+0VD/49gUfbSoC71xoqhmzLdFdGTZ+dZjMtNWsMMwefx1hbsNftWeLa2ne44QcGACUco4r0o8eDjPTCRbgLVwTnMpCb6MFeWKrVLfckU5ryvuioh8JTvIg+UVHew4gYBYVDMrmO8Lt0Kl5sNh4ALM3dp8UVEJM3ifz6qiKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731012839; c=relaxed/simple;
	bh=DK/EOloJBs2VEyPdYFRbSIXX2M+VdCvqyiqIQYj0htk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DuJIK/6C8iTbxk095/RhQuN1c7XopclCCRwk8CLeZzESIe4kWDXvSielsyAgNYFdvdKeC5Z6waycdiYO5o2BU+W3qeVlZ3ozzKkb/vdBHylxphBJbJrWSapQ2o2pfc0CZNFTPONNn4GMMZGVeuLekn5fTkMS2r61a8osWxlblG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMqmxU8U; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMqmxU8U"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-84fc21ac668so500726241.1
        for <linux-block@vger.kernel.org>; Thu, 07 Nov 2024 12:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731012837; x=1731617637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LiI5PmN3yOlhOciy8T3neuTdt71zqYk84uEfxQdpXg=;
        b=BMqmxU8Ue6bQh4S/fdFlWy5wYEItCGMHXecmhHRN2Zlx+kpZdtMZUuUqxZuOTpEoya
         gpOomnFTIN7oj6//J0DIt85b1oULIG/rHX0E5na8OknyIOVDstDvfRfyDLMizGRQAiGm
         0sMM4ZDtg3M7HtVP+q+nSCSzZO0TMCLn0+0GGvhtSh5o776Bnq5pw6saa3MhJpGBPj0l
         UlU7aw0y07BhGSdpVd1DIDfcu03YyVuLJswJ1m2+T+N5cf5lJfy0rxvHhOGo/6OCbZJS
         B9FDZ83f2dmXRxEIJbthucQbcOaJYu+diZBYZ9y+KZBdxA7BwataoY7LgtYuAqhQKULX
         ySpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731012837; x=1731617637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LiI5PmN3yOlhOciy8T3neuTdt71zqYk84uEfxQdpXg=;
        b=LqJy+W0PSsL8l4o423FeP9uYU097WEuEG1rXWp/R31gIjQbiWqrF5L8iz+rA8ruEgc
         ugEUVi0Y2NIr5CvztgPhkKrkeVD3477zk4Pxd8FHfRKV0dDCVAW2hLOqku9uDljWPjgM
         ibB3G8y/e0KCyL3292OXSIiGCLv7YwaWEMYQLP1bvZ/CTuQFR9gD5iaavdBetufjWk18
         37UqGgTfwT805r/Xd3vNxj7Ih90Ub4vOARxiNAkWn3/GLZMMgnb9+jvuY6wA61IQeSyg
         bXv+gRnRQejViv6YsCz93AmfdwyGXsXytk82MAAiQa8uZofpF6r+LGP1HkH4VgXNS7bE
         lLow==
X-Forwarded-Encrypted: i=1; AJvYcCURNUjQR4Jp6KXFUbZ88KygniDX8OgLullT/xr12Ml5ZRHQPu1dXzcIxWCP4/+niGjJx/iBHLw8uJ1B8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2iZbPhmx4u53CXGWLyWahCa0vBxCyCOdz/NRr3MT/7DEPo9Qi
	dFBJrJ34OMzqJSKf8WjORg9B+gwTP64EiX25Q52ZzRUAHNr92LKEs16e1wc3FHiMes8R0yJiV4Q
	z+0StWFBHpHsnHQRtPc9ChBKsyTI=
X-Google-Smtp-Source: AGHT+IE6Bpnntr9NX1ALyWqsmGCtjviaoSUOX8WNouvOOOs8uLHtVWlROgS4j1r5o5g1IcomiFrCuTyJcjRlK/ca+0Q=
X-Received: by 2002:a05:6102:4192:b0:4a4:8b67:4f73 with SMTP id
 ada2fe7eead31-4aae139c9afmr668929137.7.1731012836845; Thu, 07 Nov 2024
 12:53:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327214816.31191-3-21cnbao@gmail.com> <20241021232852.4061-1-21cnbao@gmail.com>
 <eabf4f2c-4192-42d5-b6cc-f36a3c7ad0f2@gmail.com> <CAGsJ_4w0f_eqHvmAr59FRNCsydjc2EQu4eHhSGFvurJn=TuvJA@mail.gmail.com>
 <CAGsJ_4yrsCSyZpjtv7+bKN3TuLFaQ86v_zx9HtNQKtVhve0zDA@mail.gmail.com> <490a923e-d450-4476-a9f5-2a247b6d3a12@gmail.com>
In-Reply-To: <490a923e-d450-4476-a9f5-2a247b6d3a12@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 8 Nov 2024 09:53:46 +1300
Message-ID: <CAGsJ_4wHEexCguL0hfNnuunuxqwqUPWrXRsbBNqBSJTz+HUa3A@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] zram: support compression at the granularity of multi-pages
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, chrisl@kernel.org, 
	corbet@lwn.net, david@redhat.com, kanchana.p.sridhar@intel.com, 
	kasong@tencent.com, linux-block@vger.kernel.org, linux-mm@kvack.org, 
	minchan@kernel.org, nphamcs@gmail.com, senozhatsky@chromium.org, 
	surenb@google.com, terrelln@fb.com, v-songbaohua@oppo.com, 
	wajdi.k.feghali@intel.com, willy@infradead.org, ying.huang@intel.com, 
	yosryahmed@google.com, yuzhao@google.com, zhengtangquan@oppo.com, 
	zhouchengming@bytedance.com, bala.seshasayee@linux.intel.com, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 12:49=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 07/11/2024 10:31, Barry Song wrote:
> > On Thu, Nov 7, 2024 at 11:25=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> >>
> >> On Thu, Nov 7, 2024 at 5:23=E2=80=AFAM Usama Arif <usamaarif642@gmail.=
com> wrote:
> >>>
> >>>
> >>>
> >>> On 22/10/2024 00:28, Barry Song wrote:
> >>>>> From: Tangquan Zheng <zhengtangquan@oppo.com>
> >>>>>
> >>>>> +static int zram_bvec_write_multi_pages(struct zram *zram, struct b=
io_vec *bvec,
> >>>>> +                       u32 index, int offset, struct bio *bio)
> >>>>> +{
> >>>>> +    if (is_multi_pages_partial_io(bvec))
> >>>>> +            return zram_bvec_write_multi_pages_partial(zram, bvec,=
 index, offset, bio);
> >>>>> +    return zram_write_page(zram, bvec->bv_page, index);
> >>>>> +}
> >>>>> +
> >>>
> >>> Hi Barry,
> >>>
> >>> I started reviewing this series just to get a better idea if we can d=
o something
> >>> similar for zswap. I haven't looked at zram code before so this might=
 be a basic
> >>> question:
> >>> How would you end up in zram_bvec_write_multi_pages_partial if using =
zram for swap?
> >>
> >> Hi Usama,
> >>
> >> There=E2=80=99s a corner case where, for instance, a 32KiB mTHP is swa=
pped
> >> out. Then, if userspace
> >> performs a MADV_DONTNEED on the 0~16KiB portion of this original mTHP,
> >> it now consists
> >> of 8 swap entries(mTHP has been released and unmapped). With
> >> swap0-swap3 released
> >> due to DONTNEED, they become available for reallocation, and other
> >> folios may be swapped
> >> out to those entries. Then it is a combination of the new smaller
> >> folios with the original 32KiB
> >> mTHP.
> >
>
> Hi Barry,
>
> Thanks for this. So in this example of 32K folio, when swap slots 0-3 are
> released zram_slot_free_notify will only clear the ZRAM_COMP_MULTI_PAGES
> flag on the 0-3 index and return (without calling zram_free_page on them)=
.
>
> I am assuming that if another folio is now swapped out to those entries,
> zram allows to overwrite those pages, eventhough they haven't been freed?

Correct. This is a typical case for zRAM. zRAM allows zram_slot_free_notify=
()
to be skipped entirely (known as miss_free). As long as swap_map[] indicate=
s
that the slots are free, they can be reused.

>
> Also, even if its allowed, I still dont think you will end up in
> zram_bvec_write_multi_pages_partial when you try to write a 16K or
> smaller folio to swap0-3. As want_multi_pages_comp will evaluate to false
> as 16K is less than 32K, you will just end up in zram_bio_write_page?

Until all slots are cleared from ZRAM_COMP_MULTI_PAGES, these entries
remain available for storing small folios. Prior to this, the large
block remains
intact. For instance, if swap0 to swap3 are free and swap4 to swap7
still reference
the old compressed mTHP, writing only to swap0 would modify the large block=
.

static inline int __test_multi_pages_comp(struct zram *zram, u32 index)
{
        int i;
        int count =3D 0;

        int head_index =3D index & ~((unsigned long)ZCOMP_MULTI_PAGES_NR - =
1);

        for (i =3D 0; i < ZCOMP_MULTI_PAGES_NR; i++) {
                if (zram_test_flag(zram, head_index + i, ZRAM_COMP_MULTI_PA=
GES))
                        count++;
        }

        return count;
}

a mapping exists between the head index and the large block of zsmalloc. As=
 long
as any entry with the same head index remains, the large block persists.

Another possible option is:
swap4 to swap7 indexes reference the old large block, while swap0 to
swap3 point to
new small blocks compressed from small folios. This approach would
greatly increase
implementation complexity and could also raise zRAM's memory consumption.

With Chris's and Kairui's swap allocation optimizations, hopefully,
this corner case
will remain minimal.

>
> Thanks,
> Usama
>
>
> > Sorry, I forgot to mention that the assumption is ZSMALLOC_MULTI_PAGES_=
ORDER=3D3,
> > so data is compressed in 32KiB blocks.
> >
> > With Chris' and Kairui's new swap optimization, this should be minor,
> > as each cluster has
> > its own order. However, I recall that order-0 can still steal swap
> > slots from other orders'
> > clusters when swap space is limited by scanning all slots? Please
> > correct me if I'm
> > wrong, Kairui and Chris.
> >
> >>
> >>>
> >>> We only swapout whole folios. If ZCOMP_MULTI_PAGES_SIZE=3D64K, any fo=
lio smaller
> >>> than 64K will end up in zram_bio_write_page. Folios greater than or e=
qual to 64K
> >>> would be dispatched by zram_bio_write_multi_pages to zram_bvec_write_=
multi_pages
> >>> in 64K chunks. So for e.g. 128K folio would end up calling zram_bvec_=
write_multi_pages
> >>> twice.
> >>
> >> In v2, I changed the default order to 2, allowing all anonymous mTHP
> >> to benefit from this
> >> feature.
> >>
> >>>
> >>> Or is this for the case when you are using zram not for swap? In that=
 case, I probably
> >>> dont need to consider zram_bvec_write_multi_pages_partial write case =
for zswap.
> >>>
> >>> Thanks,
> >>> Usama
> >>
> >
> > Thanks
> > barry
>

Thanks
Barry
