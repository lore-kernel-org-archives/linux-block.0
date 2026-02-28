Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FDE20C463
	for <linux-block@vger.kernel.org>; Sat, 28 Feb 2026 02:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772247472; cv=pass; b=kZEAB3ilssEJbRDbkQSs2F2pGG7kMEoR+ds+oF9i5C/SSAYRC6Ic+t6cfPN79T+Fk1EXN1iZHGqP3hkr/R/SStsTT7do8VwAQZqP3rUXJf/z990Frj2GsVXfSZlTriH3mzHtpOSooEdAI4ItqqDkIPme9+5jvaC3BN5GWfaEjlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772247472; c=relaxed/simple;
	bh=9S4SIIkLX06GNJFvcNA6SeLa7KLLLvQ8vdgh1Yqg778=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYfp/yIONowvNo774HPKxdlC3sMpT7AMTKhAE784sDmW2Kd1x03CZMc0WwkChUqChvC189VoQvbqRuKAx39LjYCZFexyRGlzOC1GQnh3YPP9VCaSWx3wgK+Go4HP/xrIjm2cXe5u6l11qbjgcs8LhSoj1OT29ofF/WSARXSspxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W+qJ8fMO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SWW7mXpH; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+qJ8fMO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWW7mXpH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772247469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ul9ErbzYFrTHEYKr0As/6D1/FUSyXsPZPt7ruX+ITJg=;
	b=W+qJ8fMOb/E04qFLjdSRzmtY8EJZu3RYUCXm9rz6oXo5jcnEZl5GhnabgbItcoV4VsO1Ue
	DTFYAdR+cREbhPuhjcdZgVfnbxOBnOT2NTmwMevqrQnaINnzi38KkyzyOz6HX7lpxtxj3V
	2lTBD1Vc7DcvVRIIke5k+qO7Lb+KlEQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-WebZYusrMKCa8lxHttWLjQ-1; Fri, 27 Feb 2026 21:57:48 -0500
X-MC-Unique: WebZYusrMKCa8lxHttWLjQ-1
X-Mimecast-MFC-AGG-ID: WebZYusrMKCa8lxHttWLjQ_1772247467
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-389fdcff4ebso19525881fa.3
        for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 18:57:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772247467; cv=none;
        d=google.com; s=arc-20240605;
        b=F1y+8MfcrApWlkx8O46/yHGoKt2SfqCu7umFQbSkOuK6/tptY4PECMcgLg4VgRXblf
         vmkUpORbTJvIlz0iOPTobfE2sLRXvPGkTBAvjTexiYa/Row6zWxcB5Hlo68cNJzSd+ul
         Hg2wZKFiavq3IR6U7dQvu0vy2FW5iaOzFe2LgYREVH2G1k9FBNVaSjNy7rRKEXD6J7WN
         CSeWjnCZvvZfHXXOmDZm8J98o0FnVqrnWJ7jIaC+E+378NcQVm9c+97jZn4aAZmF83LR
         o0QqFTb+V5L/+Cw7+FiCyIerfmrev6vOu97fpU3tZTRdbZ1bQT1tl/BekZOWZCxtIqqA
         ojdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ul9ErbzYFrTHEYKr0As/6D1/FUSyXsPZPt7ruX+ITJg=;
        fh=vsQ9cS8UHyrnho4yHO1RuoxPiE4SA5WvZhwcZBuI6Xo=;
        b=XKyXGwtDdtBw1LrSULbDR6ixTW+E8Ptso2s40YANaQzQkhKqb9/adRERtBX9W3L8mt
         HEdcn86QELP7GV6lkC2ZRpQBHZgbT9BI+0WogeIkAvt1LcwH8SRkkmCIEogIRiW4joJs
         LRRBIdpF5p/2zW4HtaKQDEPvPG88wdyByVRMk21jaOxVh6q+iiZVUHrprX+1zZAaZ0hS
         uapl6mqyj56kkUwFUseVVa2DtfhKlsh/H8hW1+vqRGZ4ML5QFEch9gxw8tRle2YWlVsb
         MaFuscyJgLuYA/u7+tLGFo6eMHhq204MDl+zJXql98eKV3nuN7b6J33od5+e1BOX4tyt
         Aq1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772247467; x=1772852267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ul9ErbzYFrTHEYKr0As/6D1/FUSyXsPZPt7ruX+ITJg=;
        b=SWW7mXpHZ2/l/t1Ll+ZBcaxsGOep3+oJPaCbltA4PV1zTkBFdkQr+UWewiW4HOpOcv
         YT2918X/77njsLwVn2pQGYcfLT+aEBRl8eheBSZ+NEN/f+aN+BC6/Uqqib9kiC28fikc
         uuU/4UYtdAx5ETQvIubVg43SMvVyZgrItdgiJpuqRDuD+3KAG6X/Lc6HovnMR5jBst54
         4m5KkHZsThyYvrMl6BabF1+Vruftuu9zGcUsLaS4Wcgv5hlzhVhB+ZtAUErhQ0avWyRY
         nZhds4y/Gy5ksEEJuxCVbKU3R3maIklv6DI/+STB68X/gMAJAmIXkuannIOx/YhRa48l
         g6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772247467; x=1772852267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ul9ErbzYFrTHEYKr0As/6D1/FUSyXsPZPt7ruX+ITJg=;
        b=gdorsGTWkIaCwf5hmTbcApmLcAj28NWcaGBA2jn2bNmMVjPxj/Mkjwuud6xzYEMJsm
         EYsQ5jJ6JzJN/DhcA000Quy+7kw3Km3sBsMhPIQ/WsgTyHQFNGmWuugAyH/FF+DvP5Dz
         qFKBAUEgpWqRRQJ9A9Kf2JgTYb5vgwImF0AR6yjjxfGfBH8F45SoFlyb7Df6B/IJyMJO
         NLfVCEaCJ0l6AJkJKlHF2FaKfpQfQgIRsa/RSnQSJ+jg9c56SfDr8ZtMQNr9NAIVdEgN
         NNDQcevqXHFy0Rah/1W+tXrfNCbhnVLTBzT/12cyZGQsiPJ9DI4n3/Ub7BvFwF+SwYtJ
         5YLg==
X-Forwarded-Encrypted: i=1; AJvYcCXbUk6ZucHp8HyOnkuM9JjMfBfOlG/GZ1me+pfhP21LyxhHREDv8l7QCYuKDSfx5YOGq4Z/Cbu1AnhUFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdffKjy3QrKpElwP5UFSBQyKtSJ5fmJh6ow5kA5Zouv2KWw1s0
	eg+iKE2ZspubSkDHpZqETPBPLJrBO0boF1+QU8ByOp3gNaffMtWpo6Hxr13fT/oizEYdI9+bKSY
	AiQxCrdUVrQUkcHD4GCBlq5AE+ia3yRaEaZHzehqcXb1Z0MQbhEYnRqjqyBGjXy68UtH9EJHkjK
	rADBWwCOfq37LzvdxXsG10n08aAgvcoCeQfPut5yE=
X-Gm-Gg: ATEYQzxG+lebcKmC9t1Lm7s1KVAUlBWL3PhQSSE5K1US4oNNb5+5GroUpxCXldeTPwy
	PbWcdX5oy3j8eTY06kIDEzXgAaamZ7x1T6CrQouarRBQzJsu+zi5AFrXJszQAVtwwS8qjhyLJmD
	Uydyg7dSNgvXrs3/+a9jP8AQCImQ0Or9BT/1Z/nerz2kmFkfrz98nKVpYmRPORTqDNYZRMYjhpl
	iuJckrIT3ZxJYM0aMWSrXS2L2iGbOlXkzFU7HMnggCzXDW2aE68muaXcu16o7Hiw6NOKl5oDXO3
	+sVTmA==
X-Received: by 2002:a05:651c:893:b0:389:fc69:45e8 with SMTP id 38308e7fff4ca-389ff13552fmr36092211fa.13.1772247466609;
        Fri, 27 Feb 2026 18:57:46 -0800 (PST)
X-Received: by 2002:a05:651c:893:b0:389:fc69:45e8 with SMTP id
 38308e7fff4ca-389ff13552fmr36092081fa.13.1772247466164; Fri, 27 Feb 2026
 18:57:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGVVp+U0EYVX+VbbEHzcYP70zdmOXwAmUvpMYV9y3jBSRFmS6g@mail.gmail.com>
 <CAFj5m9L8ahNYFf-tUAZFKAUzkeyqV-Sx94MxC268XJ-hqHPCig@mail.gmail.com>
 <CAFj5m9+OCswLULgVx8eSydTG0OeN4f-8dK1-JyoAA70CNF88Qg@mail.gmail.com>
 <CADUfDZrq96YGiMN9==gMitAHZtXydOAwy-767-d0j5LdUqO91Q@mail.gmail.com> <df5dac1b-286d-43d5-a742-375b6de8730f@kernel.org>
In-Reply-To: <df5dac1b-286d-43d5-a742-375b6de8730f@kernel.org>
From: Changhui Zhong <czhong@redhat.com>
Date: Sat, 28 Feb 2026 10:57:34 +0800
X-Gm-Features: AaiRm50A-oreMROg-IZY0a7VYOIC_N5HQ9n4L5iqJp7NRvUvCh2O8zvAPssSEws
Message-ID: <CAGVVp+X6jSJeKoJ0YAjGqcvrwPMBThLRpD176SG2OR20s08XgA@mail.gmail.com>
Subject: Re: [bug report] Bug: Write fault blocked by KUAP!
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Caleb Sander Mateos <csander@purestorage.com>, Ming Lei <ming.lei@redhat.com>, 
	Linux Block Devices <linux-block@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 3:05=E2=80=AFAM Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
>
>
>
> Le 26/02/2026 =C3=A0 17:59, Caleb Sander Mateos a =C3=A9crit :
> > On Thu, Feb 26, 2026 at 4:44=E2=80=AFAM Ming Lei <ming.lei@redhat.com> =
wrote:
> >>
> >> On Thu, Feb 26, 2026 at 6:48=E2=80=AFPM Ming Lei <ming.lei@redhat.com>=
 wrote:
> >>>
> >>> Hi Changhui,
> >>>
> >>> Thanks for the report!
> >>>
> >>> Loop Caleb Sander Mateos  in.
> >>>
> >>> Thanks,
> >>>
> >>> On Thu, Feb 26, 2026 at 6:37=E2=80=AFPM Changhui Zhong <czhong@redhat=
.com> wrote:
> >>>>
> >>>> Hello,
> >>>>
> >>>> on the ppc64le arch, I hit the issue below with ublksrv on the lates=
t
> >>>> linux-block/for-next, please help check it, and let me know if you
> >>>> need any info/test for it. Thanks.
> >>>>
> >>>> INFO: HEAD of cloned kernel
> >>>> commit 37a43fd770f3dcac8f72f3ea909b3e893e2385c9
> >>>> Merge: 13cd9b41227a c1dfbd7e71b0
> >>>> Author: Jens Axboe <axboe@kernel.dk>
> >>>> Date:   Wed Feb 25 08:37:06 2026 -0700
> >>>>
> >>>>      Merge branch 'for-7.1/block' into for-next
> >>>>
> >>>>      * for-7.1/block:
> >>>>        ublk: report BLK_SPLIT_INTERVAL_CAPABLE
> >>>>
> >>>> reproducer:
> >>>> compile and install https://eur01.safelinks.protection.outlook.com/?=
url=3Dhttps%3A%2F%2Fgithub.com%2Fublk-org%2Fublksrv.git&data=3D05%7C02%7Cch=
ristophe.leroy2%40cs-soprasteria.com%7Cf0b0066758be476be95508de75587a73%7C8=
b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639077220067774377%7CUnknown%7CTW=
FpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOI=
joiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dki4yUMx%2FBTANcpfzEoVMdBKs=
uflIbzhHO2Wqpxtvj5g%3D&reserved=3D0
> >>>> #echo 0 > /proc/sys/kernel/io_uring_disabled
> >>>> #modprobe ublk_drv
> >>>> #cd ublksrv
> >>>> #make test T=3Dnull
> >>>> #make test T=3Dloop
> >>>>
> >>>> dmesg log=EF=BC=9A
> >>>> Feb 26 00:24:30 ibm-p9z-27-lp26 journal: running null/002
> >>>> Feb 26 00:24:30 ibm-p9z-27-lp26 ublksrvd-0[57921]: start ublksrv io
> >>>> daemon ublksrvd-0
> >>>> Feb 26 00:24:30 ibm-p9z-27-lp26 ublksrvd-0[57921]: tid 57923: ublk d=
ev
> >>>> 0 queue 0 started
> >>>> Feb 26 00:24:30 ibm-p9z-27-lp26 ublksrvd-0[57921]: tid 57924: ublk d=
ev
> >>>> 0 queue 1 started
> >>>> Feb 26 00:24:36 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> >>>> [1772083476.4882] platform-linux: do-add-ip6-address[2:
> >>>> fe80::8448:a3ff:fe51:f102]: failure 13 (Permission denied - ipv6: IP=
v6
> >>>> is disabled on this device)
> >>>> Feb 26 00:24:36 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> >>>> [1772083476.4885] platform-linux: do-add-ip6-address[2:
> >>>> 2620:52:9:160c:8448:a3ff:fe51:f102]: failure 13 (Permission denied -
> >>>> ipv6: IPv6 is disabled on this device)
> >>>> Feb 26 00:24:36 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> >>>> [1772083476.4938] l3cfg[0f1985ec14299e62,ifindex=3D2]: unable to
> >>>> configure IPv6 route: type unicast fe80::/64 dev 2 metric 1024 mss 0
> >>>> rt-src ipv6ll
> >>>> Feb 26 00:24:38 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> >>>> [1772083478.4938] ipv6ll[95ab7f3fdbfe643d,ifindex=3D2]: changed: no =
IPv6
> >>>> link local address to retry after Duplicate Address Detection failur=
es
> >>>> (back off)
> >>>> Feb 26 00:24:38 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> >>>> [1772083478.4943] platform-linux: do-add-ip6-address[2:
> >>>> 2620:52:9:160c:8448:a3ff:fe51:f102]: failure 13 (Permission denied -
> >>>> ipv6: IPv6 is disabled on this device)
> >>>> Feb 26 00:24:48 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> >>>> [1772083488.5034] platform-linux: do-add-ip6-address[2:
> >>>> fe80::8448:a3ff:fe51:f102]: failure 13 (Permission denied - ipv6: IP=
v6
> >>>> is disabled on this device)
> >>>> Feb 26 00:24:48 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> >>>> [1772083488.5037] platform-linux: do-add-ip6-address[2:
> >>>> 2620:52:9:160c:8448:a3ff:fe51:f102]: failure 13 (Permission denied -
> >>>> ipv6: IPv6 is disabled on this device)
> >>>> Feb 26 00:24:48 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> >>>> [1772083488.5041] l3cfg[0f1985ec14299e62,ifindex=3D2]: unable to
> >>>> configure IPv6 route: type unicast fe80::/64 dev 2 metric 1024 mss 0
> >>>> rt-src ipv6ll
> >>>> Feb 26 00:24:50 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> >>>> [1772083490.5034] ipv6ll[95ab7f3fdbfe643d,ifindex=3D2]: changed: no =
IPv6
> >>>> link local address to retry after Duplicate Address Detection failur=
es
> >>>> (back off)
> >>>> Feb 26 00:24:50 ibm-p9z-27-lp26 NetworkManager[818]: <warn>
> >>>> [1772083490.5039] platform-linux: do-add-ip6-address[2:
> >>>> 2620:52:9:160c:8448:a3ff:fe51:f102]: failure 13 (Permission denied -
> >>>> ipv6: IPv6 is disabled on this device)
> >>>> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: Kernel attempted to read use=
r
> >>>> page (7fff81210000) - exploit attempt? (uid: 0)
> >>>> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: ------------[ cut here ]----=
--------
> >>>> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: Bug: Read fault blocked by K=
UAP!
> >>>> Feb 26 00:24:58 ibm-p9z-27-lp26 kernel: WARNING:
> >>>> arch/powerpc/mm/fault.c:231 at bad_kernel_fault.isra.0+0xc8/0x2c0,
> >>>> CPU#5: lt-ublk.null/57924
> >>
> >> oops, it shouldn't be related with `ublk: report BLK_SPLIT_INTERVAL_CA=
PABLE`,
> >> Perhaps one issue lies in the ppcle64 architecture code.
> >
> > Agreed, the "Kernel attempted to read user page" error seems
> > incorrect. The call trace shows this is in copy_from_iter(), so
> > reading a user page is expected. I too would be suspicious of the
> > powerpc copy_from_iter() implementation.
>
> Looks similar to:
>
> https://lore.kernel.org/all/20260109064917.777587-2-sshegde@linux.ibm.com=
/
>
> That fix was rejected, more acceptable fix here:
>
> https://lore.kernel.org/all/20260217124457.89219-1-sayalip@linux.ibm.com/
>
> Let us know if it fixes the issue for you.
>
> Christophe
>

Hi=EF=BC=8C Christophe

confirmed that after applying the patch
https://lore.kernel.org/all/20260217124457.89219-1-sayalip@linux.ibm.com/,
this issue has not been hit again, the fix works.

Thanks,
Changhui

