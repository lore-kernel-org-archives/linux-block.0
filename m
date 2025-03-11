Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1906C1F09AB;
	Tue, 11 Mar 2025 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741685598; cv=none; b=V0UofE11jq3iDTXJr29O+voAi1/xpwgz53V1TY2WEEyP173Nw1qQ6/oSBr6s8+qG4vjV8qp2tLxMKYG90dollojAkt+bIpZoqlOFDbavURDYgFE+wmd5g8LxfXNU+bHp59jqui69sGRrI1MCfqdxTHPJj4RPduwHnJAoo0ox9Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741685598; c=relaxed/simple;
	bh=mRNEtQhgbvcG/c9JNeEVRUgWt852dyGn4ZIiE2lQQ4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gp+/LjJLubwmBNg0qLkVetK9qOGM6OSzTyWexwdA1g2CPBV1BdJLNBgyr4BhGAI6OZmQR7CtkuxrlMiOvwzmOzN0lqzVv1La9Lo3+Z+IOdKmfkhSRqJGeNKtpvJaDUeYx1Y/Y26nOptzDBHL210eBAkCX1iEXg0el4g8rXKS7vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amqzzKMB; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amqzzKMB"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86d5e3ddb66so960653241.2;
        Tue, 11 Mar 2025 02:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741685596; x=1742290396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oci9eEq+toTA4eT0HbbNQG595NfpjyU1+E2PAns3Nzg=;
        b=amqzzKMBOdZ7CthW8a15WwXR624z97plJGPwLXW1uZGgm+bxInNh75oMhdQBFa7X2u
         rxXZFvvRspPGj/ftXh351aUcMI7awvLz4Y9oYfl6YaHwf+f1KQ4goqp7ORwdnDp0TbfG
         k2GhzvaZjxBEjJCh/lzRsecBpoo6fyGdEDQgSVrtkyexVRL3dMuTBKXfVA1WjU6ILrBL
         t02T527NV5l2TgWW4gkfpTSdCdsNvcS033pWy30zEjy4BFzv1F4zWg0IOtUpRUyUJW2E
         D0U+tqD6vNLG1d/j+OcAqrM/9np0JNgotlqnEcozWqkLVFR8F24+IEoRk0E11pr9FbnC
         ipEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741685596; x=1742290396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oci9eEq+toTA4eT0HbbNQG595NfpjyU1+E2PAns3Nzg=;
        b=fndz6A9tbjxOWXFWXOi5y1OLHicQiL+v3s+iHp1xZkdSxge2/cVJfIurorY00X+mpK
         BJKnebvB3XA5k24m7AWGZREM7VQkGe9DEO9++f6kG296sQbdyecWgseYeaMRgeqvsp5N
         wL0Io2R/oh4A1h3Qqp0sEFSxsq7xvkPpfUIJEyR3U6eImUs52gBu6il90VPhFKjkEk7S
         vLd6wJskkYQ77dk86WlkU0LVNMM6FJ0di8Kub4JW7Y7a4pDOVKT7C/Fnv2oalVovMwDP
         Ofssgs2E9tB0TIB1tdesZuXvWSvQxS1zlLXAHOyBEtnEKKJRB2dQjTHGgqgEfIjafpIR
         5XrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgPhvL1KNKji/fq2igGO9Mc6PdTKXwOMJcP9l9rTBFBVhC/5XTd/j9lgVgGhLzq/Wj7wXEyM0MSzBUV5g8@vger.kernel.org, AJvYcCX6CYVg4b02LLGlL9ejC8mkGPE5sIzeFSvMXiDI2W0TDv8X30K5BW+9PShBDm+ljZDlYNiPuUDDGb6qsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyek2sPeSWfwR8wAhfvHXxEJ68RFL/aIerd3YDOtdfd/5qiyNik
	C/MGAXj2Ay50Qh62mSB1tE0Ut+ZgJPW/CXb86RWp2ON1NLxPhW74W0fvAWpnYZJfQofzqyVyY8m
	kfaB5Nkq7swg6HH466J4GW35PVHQ=
X-Gm-Gg: ASbGnctbmw4TtZWcnaKTBNfBWKwH+L8zQ5fSB2q0/6h7nah0owIvOom0Gx4fhRw6xNR
	FjLLUX05gM9RBVpO29mgXtLUsgcS//UmAixURG2zQYw8dE+/PsTwBOKN2hVS/wVw/7PgfR5fg9d
	8OqFQ/DsSNlaSQRZSvLL5KuCqrLcKSLMkayhh+
X-Google-Smtp-Source: AGHT+IFjbF2BT/V8wuSBTDQZbf6t/hT/Znk/xR8O11b3YilMHbEGP/m6CvuSuPbsGl833OZDuyeAqkTBH4Ybr+MgCeE=
X-Received: by 2002:a05:6102:509f:b0:4c1:9e65:f904 with SMTP id
 ada2fe7eead31-4c30a718b91mr8809313137.23.1741685595784; Tue, 11 Mar 2025
 02:33:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307120141.1566673-1-qun-wei.lin@mediatek.com>
 <CAKEwX=NfKrisQL-DBcNxBwK2ErK-u=MSzHNpETcuWWNBh9s9Bg@mail.gmail.com>
 <CAGsJ_4ysL1xV=902oNM3vBfianF6F_iqDgyck6DGzFrZCtOprw@mail.gmail.com> <dubgo2s3xafoitc2olyjqmkmroiowxbpbswefhdioaeupxoqs2@z3s4uuvojvyu>
In-Reply-To: <dubgo2s3xafoitc2olyjqmkmroiowxbpbswefhdioaeupxoqs2@z3s4uuvojvyu>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 11 Mar 2025 22:33:04 +1300
X-Gm-Features: AQ5f1JpaKY-TJruiEfKLncijqOvg19zgNrZm_fVI7uamNPGD1sBBaPT6nlX2PNg
Message-ID: <CAGsJ_4wbgEGKDdUqa8Kpw952qiM_H5V-3X+BH6SboJMh8k2sRg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Improve Zram by separating compression context from kswapd
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Qun-Wei Lin <qun-wei.lin@mediatek.com>, Nhat Pham <nphamcs@gmail.com>, 
	Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chris Li <chrisl@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Dan Schatzberg <schatzberg.dan@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Casper Li <casper.li@mediatek.com>, Chinwen Chang <chinwen.chang@mediatek.com>, 
	Andrew Yang <andrew.yang@mediatek.com>, James Hsu <james.hsu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 5:58=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (25/03/08 18:41), Barry Song wrote:
> > On Sat, Mar 8, 2025 at 12:03=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> w=
rote:
> > >
> > > On Fri, Mar 7, 2025 at 4:02=E2=80=AFAM Qun-Wei Lin <qun-wei.lin@media=
tek.com> wrote:
> > > >
> > > > This patch series introduces a new mechanism called kcompressd to
> > > > improve the efficiency of memory reclaiming in the operating system=
. The
> > > > main goal is to separate the tasks of page scanning and page compre=
ssion
> > > > into distinct processes or threads, thereby reducing the load on th=
e
> > > > kswapd thread and enhancing overall system performance under high m=
emory
> > > > pressure conditions.
> > >
> > > Please excuse my ignorance, but from your cover letter I still don't
> > > quite get what is the problem here? And how would decouple compressio=
n
> > > and scanning help?
> >
> > My understanding is as follows:
> >
> > When kswapd attempts to reclaim M anonymous folios and N file folios,
> > the process involves the following steps:
> >
> > * t1: Time to scan and unmap anonymous folios
> > * t2: Time to compress anonymous folios
> > * t3: Time to reclaim file folios
> >
> > Currently, these steps are executed sequentially, meaning the total tim=
e
> > required to reclaim M + N folios is t1 + t2 + t3.
> >
> > However, Qun-Wei's patch enables t1 + t3 and t2 to run in parallel,
> > reducing the total time to max(t1 + t3, t2). This likely improves the
> > reclamation speed, potentially reducing allocation stalls.
>
> If compression kthread-s can run (have CPUs to be scheduled on).
> This looks a bit like a bottleneck.  Is there anything that
> guarantees forward progress?  Also, if compression kthreads
> constantly preempt kswapd, then it might not be worth it to
> have compression kthreads, I assume?

Thanks for your critical insights, all of which are valuable.

Qun-Wei is likely working on an Android case where the CPU is
relatively idle in many scenarios (though there are certainly cases
where all CPUs are busy), but free memory is quite limited.
We may soon see benefits for these types of use cases. I expect
Android might have the opportunity to adopt it before it's fully
ready upstream.

If the workload keeps all CPUs busy, I suppose this async thread
won=E2=80=99t help, but at least we might find a way to mitigate regression=
.

We likely need to collect more data on various scenarios=E2=80=94when
CPUs are relatively idle and when all CPUs are busy=E2=80=94and
determine the proper approach based on the data, which we
currently lack :-)

>
> If we have a pagefault and need to map a page that is still in
> the compression queue (not compressed and stored in zram yet, e.g.
> dut to scheduling latency + slow compression algorithm) then what
> happens?

This is happening now even without the patch?  Right now we are
having 4 steps:
1. add_to_swap: The folio is added to the swapcache.
2. try_to_unmap: PTEs are converted to swap entries.
3. pageout: The folio is written back.
4. Swapcache is cleared.

If a swap-in occurs between 2 and 4, doesn't that mean
we've already encountered the case where we hit
the swapcache for a folio undergoing compression?

It seems we might have an opportunity to terminate
compression if the request is still in the queue and
compression hasn=E2=80=99t started for a folio yet? seems
quite difficult to do?

Thanks
Barry
