Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B568B372B44
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 01:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.135.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772069926; cv=pass; b=R32Dzc/C9UNPRyaBB823ZBk8gT8ASTLsTvIrALzMDWME/NVUQRiu4iV4WIYMWJvA/2AbhZEtbzBJTm9DEdtl+oxcoDC1D6l/0zUwynCYc2MA1gKva0aFb4jWPtP33MjcZhqO7OUiR/Z0e6FrJJ4bR7mWZi4k7z0eJf3kIq0Rvzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772069926; c=relaxed/simple;
	bh=ti4yzSkI6nET4kyh6UHM/WH/hezrg7wAnVqqzbeCD70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCFl2m5o+8DbgtAld3BqRqb6LMbzMF2ptgTi7sI7Y/Ybb+m0d4/DvM+9U5s6EmRPAwHR0lJk7UJVyPhqv1Kg90gJ9/wj3/2oe8FvzC9x5MyYLmByG5+UbsS0/jJzwdaOpqKkbC3Liz1P2Uu6kl0gpqzlPVz49OP9UhggoKCy5Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=alfh4g7z; arc=pass smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="alfh4g7z"
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q1CWlt1598992
	for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 20:38:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=RuUf
	KqLF8pxHEU0+4gJWx2JSltGDNKQcxuvzq6VPwys=; b=alfh4g7zGnrSJ3TqRJyt
	V5VcP7SDepx8NVi9vJhDyy8L5Ls5WE/RWZYhX4Ye5zukU4YSUajOuvw1hNA49SLE
	5MCVRYtKvCE10uV6CF70YwJulwzlLq4K9ukFkzKdcXeI/Bi4+EtJZkspWAQ/UxiS
	UAuXF8AJf0DZPpM47meX39PRepgBYuUes92asCRQQlWsHQzL/m7InreMTYXDR9TW
	g9tmlQQeJIjnOJXInA+ga3C6te0MJzR7Zh/RoLFz0L+iV9g1io5ESlZXDEXLNu3F
	RFDI77ScZHeVnIcmjYeOTWjiKdR4Xi3ro4xpWY03zOhgiOVRG1S+fz6senjXOYFF
	qg==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4chx6v6y51-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 20:38:41 -0500 (EST)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7982c3b7da7so6421677b3.1
        for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 17:38:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772069921; cv=none;
        d=google.com; s=arc-20240605;
        b=QkhfbkcczhF29JaV3Duvxv5KeqekcwPUYwoVhfhAZ+SI0cTQ4sZ04U0bBju1ZlBdvU
         3verPcU5uV/mSuXmcnMmn1wTs96V4Inxwg9iznTx+qHRhS0b7DihnByG63vPctq/PmmR
         6qzL3c6Z5YuURKzWbwZ+YoHSBfAyOL5piXEh71K4ulvHOlGsHkUbP3jdtilY5NSz2aUq
         3VGHf47/e+ji/scucg2tZECL96VJ6y8tlUXaoJ3sObtsBFQXkXTiwJFRJdjIWj20oNRn
         VKRowj9CZsVeuACe1oRZW31uuPJ99p3q7Ibb5PK7Pl2kZ806GaI1dbC5WnNlS9WSHKHb
         xXow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=RuUfKqLF8pxHEU0+4gJWx2JSltGDNKQcxuvzq6VPwys=;
        fh=SoDLsL7dP7omT8Dym4HDmSwtVwgi8oabk71wlnBZUTk=;
        b=hYxNeTxUtvMdk+zwc+kLyVBFzyqZmnGmJEMXSSuGD0PRWsS2cKUywa9GBmAb3/pdal
         w3kHElhG044DHXaHssp205Vyl8lLraMz2AvAri87s80TC2t1rAEz7k1/3RchEyyAz0C9
         OZUxxaGEqt7zo2JTnX/233G9leOagade9qnX7a7ThpYARxNMoTSNROHwty9ojMmCEaeR
         YvVvtO7q7iRdsUSodp2JzezAnqSj+SXoodU1pd8rLGMW+iKBjHz3mifs1xEd97tjz4f5
         aOLIuMtk0L2+zraCGjAoIxDnfGJFra8DDqIDHLZLuzFFMLmn9ia3SnkP41aPAaYPhEBS
         hqMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772069921; x=1772674721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RuUfKqLF8pxHEU0+4gJWx2JSltGDNKQcxuvzq6VPwys=;
        b=KaZzYANenZPQuNdTBFDiGqm6o//sEQ0Itc7jLa7hm7C13iEJN1gQPLNmqq0M/A9Faj
         XPNI7dxe/Jq+ldpw/QjWRnrfW2q27IMwy6G3ujAGsaO/dP3fdpplCUxHROSvMQpq2u7b
         2pNFFP07RGLe7fIUFn5kQov+omFSq4aX3+QTNfRyeeUM7U6iTMLL/+jnTJPNFB5PCHvI
         RdDF+Jm2QSGTTrfNwHWgnNibdC8QvjgT26yIY9Zm3L/cRs4tbFQmmEVxEC6xkYj4PTHq
         IWGmnFj9Win/dVfoSNGJaoU6EIFOgQ11r6GnplKF8XS1SQ0JP6yIffHQC/xvgEzcChbn
         9y2A==
X-Forwarded-Encrypted: i=1; AJvYcCXNBsXZTydCyVqU28xltl35796aXnWVzPWBgQpaqSlRyHV2S1ULpaE9Yse2Q+IeVnwfsI7Jy+dGfD0SCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwijF6p3IAifNUk2Ih2ntb/r5Uks9eBhg6C/gjJ2rIqvxwm5lnm
	R3bbwDfqhFODYnpw+aVSpg+I1ehwO6j8anZJinfDDWHeDUjjfg9x4fPOEiA1BlD/5KN89cPtPiQ
	7LolaUOUhq4UQV0MhPq8CP8JhIXMHcE2mejF1AVVG+jjbeLqgpnMB+vfMAxIbFNtZAS9b0NQus0
	ok73KnX32LKd1hkSgINJ9reEGcxS1gYK0y9kE=
X-Gm-Gg: ATEYQzxUF9uM3fw5mbols1CqZBqjTN4DYkzyIXFTQF06c8G8OmxS5OQKLI7d+T4MzTS
	eG77gsJfSdlhUOQIyprT7Yy3qIrGZQoZNHtmPKgF5mMPvPVEsSSFxwTl2Q6AqF0deknLIVUmafU
	iIo49P4QJt8wQ4YkuYot8ikvA5WlBKUCsDNmkEDBMR9t3r7X+C90BwVL08AHGoDeedvlhY6UXJn
	vwL+A==
X-Received: by 2002:a05:690c:4a05:b0:797:d268:b587 with SMTP id 00721157ae682-79876c862f0mr5591367b3.29.1772069921008;
        Wed, 25 Feb 2026 17:38:41 -0800 (PST)
X-Received: by 2002:a05:690c:4a05:b0:797:d268:b587 with SMTP id
 00721157ae682-79876c862f0mr5591057b3.29.1772069920550; Wed, 25 Feb 2026
 17:38:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225-blk-dontcache-v2-0-70e7ac4f7108@columbia.edu>
 <20260225-blk-dontcache-v2-1-70e7ac4f7108@columbia.edu> <c8078a80-f801-4f8a-b3cd-e2ccbfca1def@kernel.dk>
In-Reply-To: <c8078a80-f801-4f8a-b3cd-e2ccbfca1def@kernel.dk>
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 25 Feb 2026 20:38:29 -0500
X-Gm-Features: AaiRm52vdi5fnXqygcUgGP7ud7f8lrEjfwNIkhY8m1jYwEYqu5-B1oSLrvjdDbU
Message-ID: <CAKha_srSdS46FM8K-RKaiinP0y6kx_MhxnHjZ0KKP1NOAL+STA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/2] filemap: defer dropbehind invalidation from
 IRQ context
To: Jens Axboe <axboe@kernel.dk>
Cc: "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Yuezhang Mo <yuezhang.mo@sony.com>, Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Bob Copeland <me@bobcopeland.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        linux-karma-devel@lists.sourceforge.net, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: gMEuHP1TWg-CSRig_xidahUa-TTLtseJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDAxMiBTYWx0ZWRfXz/9zkL+ldasd
 Vi3WPUBd2GXFUFkTokXCuUAFiJGCccuaHNBOpi77su4WLlRLCNTNJD5a2wZOWkikZMilWCUHzhR
 LGR4MylohCgIqFRoY7rR9Yn9yCNEXE4QAuTzHbaMD+XrodlkkdwyaER7gB7zIJamcfgF08QcFTg
 3hcgp5hed8sz1jkkOem5BFOggwteZVFU5Mb7jeLC1b8C3fsEq5NA06nZMn8eu9OnBtoA6ZMKDre
 /AIA4m8qmVwvhV1cYxndi6EPIbH6B8IAowWpztuXUAK0Rn2E2l5RSVGbLQMPlONv6pSSTAk5h8x
 bLlKU4aQKvOxStBz88jdxZKfkRVNKkvTT90Bra26cykXTj73DCJQwf8GI1FqHUD/I8v3jDltRv1
 LXi5MzGjWVWFVwwhnr+eaZpuhK2KqsVoDEVSrdcIHLXQorGhQgWRqHrixbOWy8qwHH0MYc06dZM
 O7kUNAGTk1txug9FekQ==
X-Authority-Analysis: v=2.4 cv=FqMIPmrq c=1 sm=1 tr=0 ts=699fa421 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=x7bEGLp0ZPQA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22
 a=JR4YdQiviy7OQf72WyZ1:22 a=Sm8IU_2CoLCVsS0ef1cA:9 a=QEXdDO2ut3YA:10
 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-ORIG-GUID: gMEuHP1TWg-CSRig_xidahUa-TTLtseJ
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11712
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=10
 spamscore=0 bulkscore=10 lowpriorityscore=10 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260012

On Wed, Feb 25, 2026 at 5:52=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
> On 2/25/26 3:40 PM, Tal Zussman wrote:
> > folio_end_dropbehind() is called from folio_end_writeback(), which can
> > run in IRQ context through buffer_head completion.
> >
> > Previously, when folio_end_dropbehind() detected !in_task(), it skipped
> > the invalidation entirely. This meant that folios marked for dropbehind
> > via RWF_DONTCACHE would remain in the page cache after writeback when
> > completed from IRQ context, defeating the purpose of using it.
> >
> > Fix this by deferring the dropbehind invalidation to a work item.  When
> > folio_end_dropbehind() is called from IRQ context, the folio is added t=
o
> > a global folio_batch and the work item is scheduled. The worker drains
> > the batch, locking each folio and calling filemap_end_dropbehind(), and
> > re-drains if new folios arrived while processing.
> >
> > This unblocks enabling RWF_UNCACHED for block devices and other
> > buffer_head-based I/O.
> >
> > Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> > ---
> >  mm/filemap.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++----
> >  1 file changed, 79 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index ebd75684cb0a..6263f35c5d13 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -1085,6 +1085,8 @@ static const struct ctl_table filemap_sysctl_tabl=
e[] =3D {
> >   }
> >  };
> >
> > +static void __init dropbehind_init(void);
> > +
> >  void __init pagecache_init(void)
> >  {
> >   int i;
> > @@ -1092,6 +1094,7 @@ void __init pagecache_init(void)
> >   for (i =3D 0; i < PAGE_WAIT_TABLE_SIZE; i++)
> >   init_waitqueue_head(&folio_wait_table[i]);
> >
> > + dropbehind_init();
> >   page_writeback_init();
> >   register_sysctl_init("vm", filemap_sysctl_table);
> >  }
> > @@ -1613,23 +1616,94 @@ static void filemap_end_dropbehind(struct folio=
 *folio)
> >   * If folio was marked as dropbehind, then pages should be dropped whe=
n writeback
> >   * completes. Do that now. If we fail, it's likely because of a big fo=
lio -
> >   * just reset dropbehind for that case and latter completions should i=
nvalidate.
> > + *
> > + * When called from IRQ context (e.g. buffer_head completion), we cann=
ot lock
> > + * the folio and invalidate. Defer to a workqueue so that callers like
> > + * end_buffer_async_write() that complete in IRQ context still get the=
ir folios
> > + * pruned.
> >   */
> > +static DEFINE_SPINLOCK(dropbehind_lock);
> > +static struct folio_batch dropbehind_fbatch;
> > +static struct work_struct dropbehind_work;
> > +
> > +static void dropbehind_work_fn(struct work_struct *w)
> > +{
> > + struct folio_batch fbatch;
> > +
> > +again:
> > + spin_lock_irq(&dropbehind_lock);
> > + fbatch =3D dropbehind_fbatch;
> > + folio_batch_reinit(&dropbehind_fbatch);
> > + spin_unlock_irq(&dropbehind_lock);
> > +
> > + for (int i =3D 0; i < folio_batch_count(&fbatch); i++) {
> > + struct folio *folio =3D fbatch.folios[i];
> > +
> > + if (folio_trylock(folio)) {
> > + filemap_end_dropbehind(folio);
> > + folio_unlock(folio);
> > + }
> > + folio_put(folio);
> > + }
> > +
> > + /* Drain folios that were added while we were processing. */
> > + spin_lock_irq(&dropbehind_lock);
> > + if (folio_batch_count(&dropbehind_fbatch)) {
> > + spin_unlock_irq(&dropbehind_lock);
> > + goto again;
> > + }
> > + spin_unlock_irq(&dropbehind_lock);
> > +}
> > +
> > +static void __init dropbehind_init(void)
> > +{
> > + folio_batch_init(&dropbehind_fbatch);
> > + INIT_WORK(&dropbehind_work, dropbehind_work_fn);
> > +}
> > +
> > +static void folio_end_dropbehind_irq(struct folio *folio)
> > +{
> > + unsigned long flags;
> > +
> > + spin_lock_irqsave(&dropbehind_lock, flags);
> > +
> > + /* If there is no space in the folio_batch, skip the invalidation. */
> > + if (!folio_batch_space(&dropbehind_fbatch)) {
> > + spin_unlock_irqrestore(&dropbehind_lock, flags);
> > + return;
> > + }
> > +
> > + folio_get(folio);
> > + folio_batch_add(&dropbehind_fbatch, folio);
> > + spin_unlock_irqrestore(&dropbehind_lock, flags);
> > +
> > + schedule_work(&dropbehind_work);
> > +}
>
> How well does this scale? I did a patch basically the same as this, but
> not using a folio batch though. But the main sticking point was
> dropbehind_lock contention, to the point where I left it alone and
> thought "ok maybe we just do this when we're done with the awful
> buffer_head stuff". What happens if you have N threads doing IO at the
> same time to N block devices? I suspect it'll look absolutely terrible,
> as each thread will be banging on that dropbehind_lock.
>
> One solution could potentially be to use per-cpu lists for this. If you
> have N threads working on separate block devices, they will tend to be
> sticky to their CPU anyway.
>
> tldr - I don't believe the above will work well enough to scale
> appropriately.
>
> Let me know if you want me to test this on my big box, it's got a bunch
> of drives and CPUs to match.
>
> I did a patch exactly matching this, youc an probably find it

Yep, that makes sense. I think a per-cpu folio_batch, spinlock, and
work_struct would solve this (assuming that's what you meant by per-cpu lis=
ts)
and would be simple enough to implement. I can put that together and send i=
t
tomorrow. I'll see if I can find your patch too.

Any testing you can do on that version would be very appreciated! I'm
unfortunately disk-limited for the moment...

> >  void folio_end_dropbehind(struct folio *folio)
> >  {
> >   if (!folio_test_dropbehind(folio))
> >   return;
> >
> >   /*
> > - * Hitting !in_task() should not happen off RWF_DONTCACHE writeback,
> > - * but can happen if normal writeback just happens to find dirty folio=
s
> > - * that were created as part of uncached writeback, and that writeback
> > - * would otherwise not need non-IRQ handling. Just skip the
> > - * invalidation in that case.
> > + * Hitting !in_task() can happen for IO completed from IRQ contexts or
> > + * if normal writeback just happens to find dirty folios that were
> > + * created as part of uncached writeback, and that writeback would
> > + * otherwise not need non-IRQ handling.
> >   */
> >   if (in_task() && folio_trylock(folio)) {
> >   filemap_end_dropbehind(folio);
> >   folio_unlock(folio);
> > + return;
> >   }
> > +
> > + /*
> > + * In IRQ context we cannot lock the folio or call into the
> > + * invalidation path. Defer to a workqueue. This happens for
> > + * buffer_head-based writeback which runs from bio IRQ context.
> > + */
> > + if (!in_task())
> > + folio_end_dropbehind_irq(folio);
> >  }
>
> Ideally we'd have the caller be responsible for this, rather than put it
> inside folio_end_dropbehind().
>
> --
> Jens Axboe
