Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B2C2DCC08
	for <linux-block@vger.kernel.org>; Tue, 19 May 2026 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204148; cv=pass; b=O3/IZ1fWVR6Boll+ojpMTx0HQaAXZAdKRMX67A6Os5kR61D0HOo6ILelwufhdaXhpHESVGelPcqvEh0nRoFdyT8dhsqROoiilnkISGUa3ku/L2rr1dH+f3akdWJjAR9glkI3IglzMYWdkK/rJxgvONGHU3but1Ii0nuN0Umbmrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204148; c=relaxed/simple;
	bh=TdW54Ef0Qp54Bpn6nCJfMLZafyoDHjgNco3iHK6pw1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7HQev+RLFwQFdluP39gDMyyFqBZZPN58sFkdDznIjlqcx5tW1b11Yu2gV8/zDCKpsNS5IUUfUXIxFVCWgIErvCWz8o4UBEcGRcJWtPXj4Gzb63QiQNSMgpIDJAujJfXK/B6/neV5p943wMQztuojESyUYAxvQwUHI1nErlvt2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oqnexmMw; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oqnexmMw"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so55514765e9.2
        for <linux-block@vger.kernel.org>; Tue, 19 May 2026 08:22:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779204145; cv=none;
        d=google.com; s=arc-20240605;
        b=RxOELtrM1/p8p/+0NtqyuBoR5EOTqIBiAjPgBOlWGGZRwoAJ3B/FamBNsZUANWKgcI
         ARxkNpLCfPE6d3LEAwnWSTF5q6q6D64z6ycDHzG/0FYcm/bOKbMIUx6jvs0LxkU7Fm3h
         W24zxPUoceh2k9kDFAB6XWCw1oYAv0iAm7yCqboAKpfYdSw8w0oTNryKLw+Q+AQWK8wA
         1M0nK1464fF0m3blY6T7fplaWVDgR2oxoIdGf1D38OpfYHxhoqTVtZskrDMFQuzlJ7Iq
         znuCKKkpMrtp+aehrB91dymS32OvNXIdP1ihba+210fW/R+2bsCn6j8MJuNd+82hxYEW
         9vvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/iDWAhlCPV3/tme9mQXsHwz4tEUoB63+uViXPcbHvCU=;
        fh=CGRTseFUgbvpBpmICfkYQ6aRtHqXGwtlEIxoqV6LZ/Q=;
        b=SoRuoDBNYO3JbGXo8lWKap1YXynqEzqaJagd3ETkUHfaRHYIr9WdrK+ayzG3YDJUyC
         IiVwOBlh2Bi4Gz38mpYgVdZlLjLXhg3jcPbmuNDwcPliQDIV9SIaujpbpKGtFst2X9rh
         8Q2q/eDj4fmrsMFlnXMLh6541n/FeLKgaxdgtOk8SANC+Ur2rJm2swd7yv2oScYk/Bbw
         hgBMQnUpAPiBkeJK3IP/5i+NWEVnFBc+lTczTdBB4xIXBTPG7qHm1w8H+QBs2lRODVcH
         YU7sp2rzYTPG0ZkhGCX6ICIPPUrHgdbG4YPKNlm4BOI3zMp5BhUxjlhNjP8xpiH49pyi
         gyFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779204145; x=1779808945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/iDWAhlCPV3/tme9mQXsHwz4tEUoB63+uViXPcbHvCU=;
        b=oqnexmMwLYxllDGT3sFHDwJ6GyHn4pQ/qCIrpZrBgf7j39h/zxiXTjK7a7Wv5c8QbR
         9vOmfh8xkuGfTxg02DTyJA5bt9UetdgeVK5QgknSXEfbUsj8QyaWLoPPAXtpQE7IZr04
         DK2rQCC2tj9IHaUHAYIAryTesqsdAPFLbGx/1eobF4Cp3Ozv4K6Fqc+b8yK10+rUiOKH
         fwKeUMfmeJQu5fCwt7kCI9YtiOCRMK9i0LUnE2IPplrsmdCpzz/+XaR4bL58DIsLDCM4
         O9Vxojp01agqOBHRRONgN2M9pZIY506bjKfE3BT/YnhhqDUGTm9A8+RMhVWUyrXlVJVJ
         /Lsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779204145; x=1779808945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/iDWAhlCPV3/tme9mQXsHwz4tEUoB63+uViXPcbHvCU=;
        b=LMvSq1wCVwOBxc3COk4WjmidfPx1hfyjIfQdsSWUVQzjAyGg29LnWgl15/hTYSCTfE
         +DCMnWwkYWsrEUbhJgDMU87nLGUipGdX3HEsWGHRBTtfDf1eJGDHf5zhJ32j7Ig2A081
         hBg4SBXGbGMD4B+uZwAC4JcJ3CxxpCknzNosBGDxQYeHvQNvn/JtVJyR0XPMPurpXe6J
         Z8uwfH0hRb5x1y3RBcficjuXNhGpotuVAUj9GrFZs/EBtiRCSPmFiTnFaUQGcweRgKrk
         pohWJOSNco56rjQ7s/O0GeS1RxrUwXbY4wCYaESnOvxg6NpIwDCxG/GRXw/prE6fjM53
         Cq5A==
X-Forwarded-Encrypted: i=1; AFNElJ+x59NbHHzQXxUwZM25UKUDmap99U1N0azJaMGurJ1r2Wr5bM4/s7zLtyqmX6w10xsmrXQOdZhuiECq2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdVhaNRhIq0UdE1LR19SbSBOCKD14X+uIql0jN41oWo/h8U6Zf
	P2qnfaFUyy+ALXszdluk6p/uajQUP9tcwhh2v3pshWGVHsfj9YP6F0bFGdCwm/kDnuwjBxJ3t3G
	UfpSPbhAqgtFPDGtaUOhfYaI2liclBSo=
X-Gm-Gg: Acq92OFElDUfrveD3+FguUrYA/hAN4te4X/7A6JRa6ZWHEeOUgVMBdecAPqxLoDT+0r
	i+H4yUGFVPkvi3K5jdgtp79rjM1VXNiiqtEv+nBIutAiUDDaIEuLiXVuUnHBAe+e07cRDaghyQh
	ZbLkOyMkKp4X7mMVE10m7TpT44rhlLCCmib4DAS/QfF7Jp0l50NwgvrZHNAAi17KjP/13kEaBQo
	q1qXchdUQhASDd22rEkhz43ghKO70p7NScrqBcgKESI8cWTuwYdEI/aMfTyI55zHW/oYlMM2TTk
	j4h6ymy1rip25DiErDPpE2OK36KIY9nSurbvr2M=
X-Received: by 2002:a05:600c:198d:b0:487:5c0:671f with SMTP id
 5b1f17b1804b1-48fe60e552cmr353658225e9.9.1779204145152; Tue, 19 May 2026
 08:22:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421121616.3298845-1-haowenchao@xiaomi.com>
 <CAOptpSPs-1UrEa8AHg19e590=SiV6bpnex7gCbif8=aY7BtpuA@mail.gmail.com>
 <CAO9r8zOjugCwWqHP3zxXPmjp8TwpoROCjCqTZ_uxOBQwVqCWqA@mail.gmail.com>
 <CAOptpSMQyyb+q-VJdJ0RzNkjaer1CTePM5WkwEj_7cAO4aUToQ@mail.gmail.com>
 <CAKEwX=PrfrNys4ao7-d11J7r4pv5VmE8gTU_7iUHaHAKNaFuBQ@mail.gmail.com>
 <CAOptpSOnRCHo35KK5x3S0f5y9+7+dxfznpjNRH072jZvhYHwww@mail.gmail.com>
 <CAKEwX=PgsM4Z0URJcF5VSXX_jdy-cAs2JxDCCR1a8CGwV4tCAg@mail.gmail.com> <CAOptpSMdFwQUxT7bP7s1GWyXvzUQrg3ROtGp3w_zYy2rSkDYRQ@mail.gmail.com>
In-Reply-To: <CAOptpSMdFwQUxT7bP7s1GWyXvzUQrg3ROtGp3w_zYy2rSkDYRQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 19 May 2026 08:22:13 -0700
X-Gm-Features: AVHnY4K_3KhfCUyoOD17UMb7drMZ1A7kQu16M1lcn73pn_ab-u5O9yx4JSFvN1g
Message-ID: <CAKEwX=MPRguTkTgqsD+k=QFB26Drz67CE+DdJ+ZUc_FasOakCw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] mm/zsmalloc: reduce zs_free() latency on swap
 release path
To: Wenchao Hao <haowenchao22@gmail.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Weiner <hannes@cmpxchg.org>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>, Xueyuan Chen <xueyuan.chen21@gmail.com>, 
	Wenchao Hao <haowenchao@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 2:08=E2=80=AFAM Wenchao Hao <haowenchao22@gmail.com>=
 wrote:
>
> On Sat, May 9, 2026 at 7:33=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
> >
> > On Wed, May 6, 2026 at 6:55=E2=80=AFAM Wenchao Hao <haowenchao22@gmail.=
com> wrote:
> > >
> > > On Sat, May 2, 2026 at 3:21=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> =
wrote:
> > > >
> > > >
> > > > Oh man, you are eliminating pool lock here right? This would help m=
y
> > > > other patch series a lot too :)
> > > >
> > > > https://lore.kernel.org/all/CAKEwX=3DM5YpR0cQrryX_y4pm_BuxyUWZ_8Mbh=
Wodwbf1Fe=3Dgzew@mail.gmail.com/
> > > > https://lore.kernel.org/all/CAKEwX=3DPkFiP+u+ThrzjTKBi+usQf2uuhTZcf=
B2BNNA8RboOFDQ@mail.gmail.com/
> > > >
> > >
> > > Yes, exactly. With class_idx encoded in the obj value,
> > > zs_free() can determine the correct size_class without
> > > any pool-level lock. The lockless read gives a valid
> > > class_idx because it's invariant across migration (only
> > > PFN changes), and we re-read obj under class->lock to
> > > get a stable PFN.
> > >
> > > >
> > > > /*
> > > > * The pool->lock protects the race with zpage's migration
> > > > * so it's safe to get the page from handle.
> > > > */
> > > > read_lock(&pool->lock);
> > > > obj =3D handle_to_obj(handle);
> > > > obj_to_zpdesc(obj, &f_zpdesc);
> > > > zspage =3D get_zspage(f_zpdesc);
> > > > class =3D zspage_class(pool, zspage);
> > > > spin_lock(&class->lock);
> > > > read_unlock(&pool->lock);
> > > >
> > > > It's basically just this blob right?
> > > >
> > >
> > > Yes, that's the blob being replaced. On the
> > > ZS_OBJ_CLASS_IDX path (64-bit systems), it becomes:
> > >
> > >     obj =3D handle_to_obj(handle);
> > >     class =3D pool->size_class[obj_to_class_idx(obj)];
> > >     spin_lock(&class->lock);
> > >     obj =3D handle_to_obj(handle); /* re-read for stable PFN */
> > >
> > > No pool->lock at all. We've also added compile-time
> > > gating (#if BITS_PER_LONG >=3D 64) since 32-bit systems
> > > lack the spare bits in OBJ_INDEX to fit class_idx. On
> > > 32-bit, it falls back to the original pool->lock path.
> > >
> >
> > BTW, I've tested your idea with a hacky prototype, when I was playing
> > with my vswap series. It absolutely improves free time in the usemem
> > benchmark :) Idea is very promising - I won't scoop your work of
> > course, just letting you know that at least in my use case, it works
> > :) Look forward to seeing it submitted soon!!!
>
> Thanks, Nhat, that's great to hear.
>
> I've split this part out and posted it as its own series:
>
>   https://lore.kernel.org/linux-mm/20260508061910.3882831-1-haowenchao@xi=
aomi.com
>
> Review there would be very welcome.

Huh I think I might have been unsubscribed from linux-mm again -.-
Weird - I wonder if this is because of Gmail shenanigans.

Can you cc me the thread next time just in case?

>
> Also, could you share the details of your usemem setup? I'd like
> to reproduce it locally on the same baseline.

Sure! I left some notes here:

https://lore.kernel.org/all/20260505153854.1612033-1-nphamcs@gmail.com/

But for your convenience, this is the benchmark I ran:

2. Usemem single-threaded: anonymous memory allocation (56GB) on a host
   with 32GB RAM, 16 rounds.

I don't put a limit on the cgroup, relying on global pressure (per
Kairui's instructions).

I'm not on my work server right now so I don't have the exact command,
but hopefully that should be enough to show the wins with your patch
series! I wanted to run it for your patch series myself but I do not
have the cycles right now, unfortunately :(

>
> Thanks,
> Wenchao
