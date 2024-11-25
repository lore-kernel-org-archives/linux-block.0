Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152181B3948
	for <linux-block@vger.kernel.org>; Mon, 25 Nov 2024 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732559571; cv=none; b=DWErjGvotBgsi3v+vdUpr8AuIQ0v57fvORTJyQcmQhptDWSgOClvkpNZs7bftJS8KvHRESYwKq7CA2JrrKi8yxDFPCMFrZa/hjcc/c66DpanENle7o5fnuSXAbMi2iSntlQKum2q9PfMGM5bHy0ts1dN0Gl2HGRJKD59q64U850=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732559571; c=relaxed/simple;
	bh=7Xq7LYJMLMlwZrEbOszyJpSwAyYCHzOxZRFe6J9pI6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZVkHcKV6/VGPZv4qi2/wORRKL61hprwBo1b6iLlbgEQgRDAPAuBZMYCKZZ5S2iqTer01Q43P2vTBNe9GTlUmrptCvB9uSNo3LncW2pJLvWItccFE7aJtUkqnjLlzJaGRKMUDaT3zVL5SZdxVqSwLX0/2rFq6WUCY8vGZ5+q4TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXwU0wzU; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXwU0wzU"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-71a5ab612ceso2344303a34.0
        for <linux-block@vger.kernel.org>; Mon, 25 Nov 2024 10:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732559569; x=1733164369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zc6X67DX02GxHbsO9YJwq3Z2iOa7eiBwg+zESmfMgjk=;
        b=dXwU0wzU0CH6WrrsOEabLTcps42oEqKVOIa0alXqAvdPA8rX6erz0UiAQrdorTt0rr
         ItnBDAxNImz/6+WdoNN1aiBIh+Sa8rRF/ZjyPVnX9GR0gPG5eN0+F3rWODLebwtEu6yX
         kv7ZLzckM35CC5XVSRqlAonogqj9V0bUkvqamutk+1r7ln1tNrqalb7LeypFVuevoCj+
         zqNmoAhOcEn3DJ5A/Yng5Kc09/4IKIYM8jR2OevjhSqsFeI3oXWsHfVlZfFysSFstMRf
         6TtwW4PWtbEvpmVUZNoz5/pzTHROXSPcinVOBSStIoyweQANcICGZtdTIzuWGMfSeWQb
         aXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732559569; x=1733164369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zc6X67DX02GxHbsO9YJwq3Z2iOa7eiBwg+zESmfMgjk=;
        b=SyO3pY1vrIrJ59wq7dSsrlDQx0vNxLa1Ng7dQs7/Tme4I62Wc1vIRxEXOL90W1pTgq
         zdmrTlHVHTH9eoIAkqEM3trHUMPP7cbmvbStFo4KcmoGLECcl+Ks6hv91nluZez+3wEI
         +bGWpuQwWqvV5p9RVGquihsrOn0NK0Y7YyoqHCVZb6k/JudCo3FoD0Rf+ootdr9AQsLs
         bD4fMp2gSuAK37QRi5qxL+rDI7VmEXQuBGvgPKvMlFdiJhsmv9GDBTNdJHwE8CHGGlMf
         UfC/dZKWd4ATYh52+tPzJgDJ/BBZds7v6b7mMvXgWPPZtSm3LmY/R9feVX7hwDWreb2B
         ja/w==
X-Forwarded-Encrypted: i=1; AJvYcCUR4IWeD46MQlzkvpLX26oLqlP91gpCnRVWP5aw6lXiFyxR5LsWgvjNalS+Y8UTLIpbzPuwJAZKdL3+oQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJZfxOPXb4en6C/OnUAToP9TwgRdtdOSuriPgAZno+92GNTwf3
	x6+fVZ5s8z9SISoBcRnLtp5oHsuaNsShuLjEyEBvQ/VlhsxCphZbzCKOAkh/x710SgJhA04x55l
	ClH6W6zOBE6UI72laZ4YmqHL7tv0=
X-Gm-Gg: ASbGnctdpxEVAKW8n/rQMPWpGGQMHSbs/J66F0PtbrzATu7jUuYwMLFHHxE1w+o3xds
	zcqNISQ8T9OMGaEqyLx5MVtiVTn2Q2voNp1qazHclNx4aVD57cxZAZ2p5d/tCNtTkwA==
X-Google-Smtp-Source: AGHT+IFkGljtknKdoqdkSxourhIdBkOKkKTww/nP3meVN1YxFUoWaimjGYLHMEeC31vIWdPdlylQpMd3F7Lj7OeYEN0=
X-Received: by 2002:a05:6358:e48b:b0:1ca:9b11:c7fe with SMTP id
 e5c5f4694b2df-1ca9b11c8f9mr208073455d.21.1732559569084; Mon, 25 Nov 2024
 10:32:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121222521.83458-1-21cnbao@gmail.com> <20241121222521.83458-5-21cnbao@gmail.com>
 <24f7d8a0-ab92-4544-91dd-5241062aad23@gmail.com> <CAGsJ_4wL=CgXdCt+2QC+aSKPh1873QyD_4ZkRSBniUipKX9AVA@mail.gmail.com>
 <b6db556d-70e6-4adf-9ce1-d4e5af08e89c@gmail.com>
In-Reply-To: <b6db556d-70e6-4adf-9ce1-d4e5af08e89c@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 26 Nov 2024 07:32:38 +1300
Message-ID: <CAGsJ_4wes=bVRtQiqKvK=hyqiS+F_bUHV_aq0j6gtR_udPAnMQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 4/4] mm: fall back to four small folios if mTHP
 allocation fails
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, axboe@kernel.dk, 
	bala.seshasayee@linux.intel.com, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, kanchana.p.sridhar@intel.com, kasong@tencent.com, 
	linux-block@vger.kernel.org, minchan@kernel.org, nphamcs@gmail.com, 
	ryan.roberts@arm.com, senozhatsky@chromium.org, surenb@google.com, 
	terrelln@fb.com, v-songbaohua@oppo.com, wajdi.k.feghali@intel.com, 
	willy@infradead.org, ying.huang@intel.com, yosryahmed@google.com, 
	yuzhao@google.com, zhengtangquan@oppo.com, zhouchengming@bytedance.com, 
	Chuanhua Han <chuanhuahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 5:19=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 24/11/2024 21:47, Barry Song wrote:
> > On Sat, Nov 23, 2024 at 3:54=E2=80=AFAM Usama Arif <usamaarif642@gmail.=
com> wrote:
> >>
> >>
> >>
> >> On 21/11/2024 22:25, Barry Song wrote:
> >>> From: Barry Song <v-songbaohua@oppo.com>
> >>>
> >>> The swapfile can compress/decompress at 4 * PAGES granularity, reduci=
ng
> >>> CPU usage and improving the compression ratio. However, if allocating=
 an
> >>> mTHP fails and we fall back to a single small folio, the entire large
> >>> block must still be decompressed. This results in a 16 KiB area requi=
ring
> >>> 4 page faults, where each fault decompresses 16 KiB but retrieves onl=
y
> >>> 4 KiB of data from the block. To address this inefficiency, we instea=
d
> >>> fall back to 4 small folios, ensuring that each decompression occurs
> >>> only once.
> >>>
> >>> Allowing swap_read_folio() to decompress and read into an array of
> >>> 4 folios would be extremely complex, requiring extensive changes
> >>> throughout the stack, including swap_read_folio, zeromap,
> >>> zswap, and final swap implementations like zRAM. In contrast,
> >>> having these components fill a large folio with 4 subpages is much
> >>> simpler.
> >>>
> >>> To avoid a full-stack modification, we introduce a per-CPU order-2
> >>> large folio as a buffer. This buffer is used for swap_read_folio(),
> >>> after which the data is copied into the 4 small folios. Finally, in
> >>> do_swap_page(), all these small folios are mapped.
> >>>
> >>> Co-developed-by: Chuanhua Han <chuanhuahan@gmail.com>
> >>> Signed-off-by: Chuanhua Han <chuanhuahan@gmail.com>
> >>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>> ---
> >>>  mm/memory.c | 203 +++++++++++++++++++++++++++++++++++++++++++++++++-=
--
> >>>  1 file changed, 192 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/mm/memory.c b/mm/memory.c
> >>> index 209885a4134f..e551570c1425 100644
> >>> --- a/mm/memory.c
> >>> +++ b/mm/memory.c
> >>> @@ -4042,6 +4042,15 @@ static struct folio *__alloc_swap_folio(struct=
 vm_fault *vmf)
> >>>       return folio;
> >>>  }
> >>>
> >>> +#define BATCH_SWPIN_ORDER 2
> >>
> >> Hi Barry,
> >>
> >> Thanks for the series and the numbers in the cover letter.
> >>
> >> Just a few things.
> >>
> >> Should BATCH_SWPIN_ORDER be ZSMALLOC_MULTI_PAGES_ORDER instead of 2?
> >
> > Technically, yes. I'm also considering removing ZSMALLOC_MULTI_PAGES_OR=
DER
> > and always setting it to 2, which is the minimum anonymous mTHP order. =
 The main
> > reason is that it may be difficult for users to select the appropriate =
Kconfig?
> >
> > On the other hand, 16KB provides the most advantages for zstd compressi=
on and
> > decompression with larger blocks. While increasing from 16KB to 32KB or=
 64KB
> > can offer additional benefits, the improvement is not as significant
> > as the jump from
> > 4KB to 16KB.
> >
> > As I use zstd to compress and decompress the 'Beyond Compare' software
> > package:
> >
> > root@barry-desktop:~# ./zstd
> > File size: 182502912 bytes
> > 4KB Block: Compression time =3D 0.765915 seconds, Decompression time =
=3D
> > 0.203366 seconds
> >   Original size: 182502912 bytes
> >   Compressed size: 66089193 bytes
> >   Compression ratio: 36.21%
> > 16KB Block: Compression time =3D 0.558595 seconds, Decompression time =
=3D
> > 0.153837 seconds
> >   Original size: 182502912 bytes
> >   Compressed size: 59159073 bytes
> >   Compression ratio: 32.42%
> > 32KB Block: Compression time =3D 0.538106 seconds, Decompression time =
=3D
> > 0.137768 seconds
> >   Original size: 182502912 bytes
> >   Compressed size: 57958701 bytes
> >   Compression ratio: 31.76%
> > 64KB Block: Compression time =3D 0.532212 seconds, Decompression time =
=3D
> > 0.127592 seconds
> >   Original size: 182502912 bytes
> >   Compressed size: 56700795 bytes
> >   Compression ratio: 31.07%
> >
> > In that case, would we no longer need to rely on ZSMALLOC_MULTI_PAGES_O=
RDER?
> >
>
> Yes, I think if there isn't a very significant benefit of using a larger =
order,
> then its better not to have this option. It would also simplify the code.
>
> >>
> >> Did you check the performance difference with and without patch 4?
> >
> > I retested after reverting patch 4, and the sys time increased to over
> > 40 minutes
> > again, though it was slightly better than without the entire series.
> >
> > *** Executing round 1 ***
> >
> > real 7m49.342s
> > user 80m53.675s
> > sys 42m28.393s
> > pswpin: 29965548
> > pswpout: 51127359
> > 64kB-swpout: 0
> > 32kB-swpout: 0
> > 16kB-swpout: 11347712
> > 64kB-swpin: 0
> > 32kB-swpin: 0
> > 16kB-swpin: 6641230
> > pgpgin: 147376000
> > pgpgout: 213343124
> >
> > *** Executing round 2 ***
> >
> > real 7m41.331s
> > user 81m16.631s
> > sys 41m39.845s
> > pswpin: 29208867
> > pswpout: 50006026
> > 64kB-swpout: 0
> > 32kB-swpout: 0
> > 16kB-swpout: 11104912
> > 64kB-swpin: 0
> > 32kB-swpin: 0
> > 16kB-swpin: 6483827
> > pgpgin: 144057340
> > pgpgout: 208887688
> >
> >
> > *** Executing round 3 ***
> >
> > real 7m47.280s
> > user 78m36.767s
> > sys 37m32.210s
> > pswpin: 26426526
> > pswpout: 45420734
> > 64kB-swpout: 0
> > 32kB-swpout: 0
> > 16kB-swpout: 10104304
> > 64kB-swpin: 0
> > 32kB-swpin: 0
> > 16kB-swpin: 5884839
> > pgpgin: 132013648
> > pgpgout: 190537264
> >
> > *** Executing round 4 ***
> >
> > real 7m56.723s
> > user 80m36.837s
> > sys 41m35.979s
> > pswpin: 29367639
> > pswpout: 50059254
> > 64kB-swpout: 0
> > 32kB-swpout: 0
> > 16kB-swpout: 11116176
> > 64kB-swpin: 0
> > 32kB-swpin: 0
> > 16kB-swpin: 6514064
> > pgpgin: 144593828
> > pgpgout: 209080468
> >
> > *** Executing round 5 ***
> >
> > real 7m53.806s
> > user 80m30.953s
> > sys 40m14.870s
> > pswpin: 28091760
> > pswpout: 48495748
> > 64kB-swpout: 0
> > 32kB-swpout: 0
> > 16kB-swpout: 10779720
> > 64kB-swpin: 0
> > 32kB-swpin: 0
> > 16kB-swpin: 6244819
> > pgpgin: 138813124
> > pgpgout: 202885480
> >
> > I guess it is due to the occurrence of numerous partial reads
> > (about 10%, 3505537/35159852).
> >
> > root@barry-desktop:~# cat /sys/block/zram0/multi_pages_debug_stat
> >
> > zram_bio write/read multi_pages count:54452828 35159852
> > zram_bio failed write/read multi_pages count       0        0
> > zram_bio partial write/read multi_pages count       4  3505537
> > multi_pages_miss_free        0
> >
> > This workload doesn't cause fragmentation in the buddy allocator, so it=
=E2=80=99s
> > likely due to the failure of MEMCG_CHARGE.
> >
> >>
> >> I know that it wont help if you have a lot of unmovable pages
> >> scattered everywhere, but were you able to compare the performance
> >> of defrag=3Dalways vs patch 4? I feel like if you have space for 4 fol=
ios
> >> then hopefully compaction should be able to do its job and you can
> >> directly fill the large folio if the unmovable pages are better placed=
.
> >> Johannes' series on preventing type mixing [1] would help.
> >>
> >> [1] https://lore.kernel.org/all/20240320180429.678181-1-hannes@cmpxchg=
.org/
> >
> > I believe this could help, but defragmentation is a complex issue. Espe=
cially on
> > phones, where various components like drivers, DMA-BUF, multimedia, and
> > graphics utilize memory.
> >
> > We observed that a fresh system could initially provide mTHP, but after=
 a few
> > hours, obtaining mTHP became very challenging. I'm happy to arrange a t=
est
> > of Johannes' series on phones (sometimes it is quite hard to backport t=
o the
> > Android kernel) to see if it brings any improvements.
> >
>
> I think its definitely worth trying. If we can improve memory allocation/=
compaction
> instead of patch 4, then we should go for that. Maybe there won't be a ne=
ed for TAO
> if allocation is done in a smarter way?
>
> Just out of curiosity, what is the base kernel version you are testing wi=
th?

This kernel build testing was conducted on my Intel PC running mm-unstable,
which includes Johannes' series. As mentioned earlier, it still shows
many partial
reads without patch 4.

For phones, we have to backport to android kernel such as 6.6, 6.1 etc:
https://android.googlesource.com/kernel/common/+refs

Testing new patchset can sometimes be quite a pain ....

>
> Thanks,
> Usama

Thanks
Barry
