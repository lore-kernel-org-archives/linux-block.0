Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793805885;
	b=vxw6YHe1DOfKitiyUijj7NQoBWsXeSDg10S/AHDsawkpvERjY5FCOm9Lg1MvtJglWv4J
	 LjXy/Pzpn+6D5yU8yY6fJqGvE0qjhvQbo/N1CbGkENoHHBpHpnFMZRqC8AheV7b321kUn
	 Vuzm+10XR7QMvSJ3aycQOaTBcSeJEHN7s5EKFZ9fVYLrEGUqzRYHU4IpfXnuSdmzbh8kn
	 Tpi3WnHd0KNM7yjhNrPEVeH8mKT1MLv9nYzVlFdODLgud+078xn1h68nQDT50tv54w6u9
	 ddK8qhAz2rWXWcm5F2l0dkHk6i7ENQuWfal/Tw8opFjEsncNwAZP3bNKtSZ2ZVF1mAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=flDP2peFOVzNvXwcnvbCxj5AquiDajQXF7kcyM2P/Mo=;
	b=cR9bIb2BAnYv/0sL/8/+WypCvd7Vg/FVGEoYKvqDeGEOUuMEmx1+RP1mrcg//yAFQMlp
	 jbzttK7BsNglm1G2d5LIOG08VvQG7lbzjcZwAw1mhHAPq50gUigH0m+FtadEj7eXMlwvd
	 Jq1AHlYBqC1uy7lLJKGCFy/JoM9Cspo80ZVEK6Z6dDn+4u6D//9/V2SuGqidMpYo5UkdE
	 +Dmk2f8nSm0FaqiBYHMz6eLHZckb5TNWKj+VDexr+u1eiL0ttY4zzIs6o5uSBcBBNP9X3
	 hhxttw4+TgU6z94IISDHIcOyxrdSAH8tgMfxJx3XT6zwFIEuC2onXKJpnxHmmyoVYsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=F2FlsQEw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.45
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B249F606A328
	for <linux-block@vger.kernel.org>; Wed,  4 Nov 2026 15:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B249F606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=F2FlsQEw
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4a7e95f66d2so44103fac.1
        for <linux-block@vger.kernel.org>; Wed, 04 Nov 2026 07:24:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793805884; cv=none;
        d=google.com; s=arc-20260327;
        b=o2aMAmkfku5LhT26yZp/xiZ+K+XfKFyp/WSz1tKmeW38DxFIkrIU49RlZNdmYb92Qy
         iw4nu6OYxiMBOgwi1qbv9A+3YjgrAsgexwU3QbyJNUWayfcs941oyXH84splUsW/7BEr
         kYNXj4Dac3wRzLXutt3TAjijMDdXjaVwgHXukAmnYOooU3rJ+kz4HhjMrbHN5oH/pWqa
         2/HesxUUoMvSL1A7CPFjOmXLLasYcE700RjdZBmdzS6qYtBC+v6DMnWbIND+NVtP5IDZ
         i2Ol2ANe9lWnQjKwc8RMRwd5jh5Cg+HYeA4HWWuQGa3J6s1EfuVjP83BOpwF3l3SRAGV
         Pziw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=flDP2peFOVzNvXwcnvbCxj5AquiDajQXF7kcyM2P/Mo=;
        fh=m96GrsPon4COkBZuORK+btsCCv5tdpXUhhyg7COv6ow=;
        b=D1IdgIOaz0xHvWU+Wl2q9eBI/aLVMFLMH5sa4Qal6u76ZsUomKAZW0LSHDuwIa9IIz
         f4Sm8744bTWTGGrl000b+2EPapQMimILk+UvlqhAuZutvdyCMML3W1znTH45kPodU1cx
         iJZXjv30BHCjEDGpSw/UATi7Jpx80q2SdLa/ZdBZH0lMebRl/oO/VzFiHh86uPgT4V66
         Cpc3t0JTVZfvpPrcqpc8fNVrLrntntuwyIYlYpp2GGnWC915D9EsLO7zOYYsH2eG2hbf
         vmRxMsdarVOfPxoYZYLKqwOkmUQypiC6iNkcefRC5HkMDMSPiwLhIN0kVhd0spvSOwAs
         inyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793805884; x=1794410684; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=flDP2peFOVzNvXwcnvbCxj5AquiDajQXF7kcyM2P/Mo=;
        b=F2FlsQEwuvngD0Cs3xUh/uc9NpdhUow1/QhCVrIX6rEcw4PgpCGa6Qy7QfVlZOf8eJ
         2ELX/a1fHRXZyGSXTaDoC0QtbeCd5xbShvqfew/jAuwifMw+Zf742BHoCyqeTTiaMCOJ
         UbT5ILvHZpsOCOcp0aKMIGxYBpY9OMXYlo6qL4WaZsaFHuPPKKICpVYqN5b8GDz5XBj+
         /XjT8VpWUEw7P35P2OF4ep/XAtv9MPJxxz/NL3AJhJBrLY7YyqAi5eUP9zfG1dWy33SI
         /3FKa7cAs/q+meWYCL9PdjVcA/+uZHYBHh0C5woYIDdVkZfKjTcCR1jchUfA+LouX4gg
         5pOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793805884; x=1794410684;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=flDP2peFOVzNvXwcnvbCxj5AquiDajQXF7kcyM2P/Mo=;
        b=WAV0cdlKm+h3c8AlChfZwsQUssnFDXTIgXcVy7rHUKIvpK63mMdMvJ4o2u4SAnzYL2
         yXnr6bUqqwVRgPVeIc+fyXoLp9Vk8IqWx3q9S7KPbekXJBeV+NVCjXtfN0BqtAZWbEtA
         HOkFksfWJzeVG5DoEBqbe/IEzCebTNeMKIgHQaw6C3tm+BuDCRPolpi90x0YGHVrPQSY
         /gMkEAqvq6eg2ayA4B9TClymMtqTb5qB9rxA1XxKUJmfV4LkHivyYc8VLnzn8KpHfUA2
         bnStneimQ7+cYu74T/C9o/S/H8kpsK1Fp9DIgIVdav19Ie7S8F4geK/8BDmOToDwprTJ
         7vVg==
X-Forwarded-Encrypted: i=1; AKwUvByYEk73xChyjfEZKEN+vaBNJtf+OiXog+ntm74Ebh6U1vQr5g3+WvOv2tMr/mFQ1cBn2RDIPxs/+Y+ImA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/9uc+nZtwcuQobr3QDRy/9bECWx2y/nL5PaSloDyB/g1+1Mb8y
	pCta+v1kPgPla/yxy2TQle6hPVWAW/bNqjIwHW9SuaVHf4iSMImes8WLEVLQwQ/vaQK/Mq03MlA
	wwKcSYWTuWj2yaoWxepPUD7e0YOFz4D5teG6j2LSqww==
X-Gm-Gg: AYBFou11x9h7w0YKS/yy6jmMZd8u6fSppM3KaPaVw2UvzxaE0/ijU94fIGqvMcTVNOc
	XJySZZCfXbgF8YGN1Cj5lfBFnJCXYGF8l1jfZ/dWufsieozcEb9jzLwOx7/wLoP0B507OpdH2oO
	+OqQv0RWIwqhUYoswfVncJb7ODIiZE7iL2CKRhGoi5gWiS0DvsHuZ6KNxTPMbB0Ga00QVaY7PEw
	Yr59GkGHUwmRx0hdg/zaY6+oFi2WOa+33r+9Xn4Vn5TuKhfeq6xNq0su1GSQHL/xUMsdpKfskAx
	8yG/iQTNIZnshXAri6yzQ5eWPAGyC+PZVvZ0cAU5RNvB+iY3ez6Kql0ge5q2LBITSPKKKws2DYy
	BOj2T6/fuuoepdAvQHvzMK+QRLyYOGu6+eega
X-Received: by 2002:a05:687c:40c9:10b0:4a7:fe04:7dfa with SMTP id
 586e51a60fabf-4a906c5ce81mr12210477fac.0.1793805883319; Wed, 04 Nov 2026
 07:24:43 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104104909.129656-1-thuth@redhat.com>
In-Reply-To: <20261104104909.129656-1-thuth@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 4 Nov 2026 07:24:31 -0800
X-Gm-Features: AclHuK9voeX4CroBKewKkDb-TCTAm3mHMofh5zqgIby-6JO5pA3M1-VHQAtqXLY
Message-ID: <CADUfDZrwgy38Nt4bFeZd=nfHAOTScy=1PKjanTAoUFzUkydkbQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: ublk: Fix include path for out-of-tree builds
To: Thomas Huth <thuth@redhat.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 2:49=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrote=
:
>
> When building the seltests out of tree with "make kselftest-all",
> the compilation of the ublk tests can currently fail since they
> are using the headers from the distro instead the headers from the
> kernel source. For example, I'm getting:
>
>  kublk.c: In function =E2=80=98ublk_ctrl_dump=E2=80=99:
>  kublk.c:190:27: error: =E2=80=98UBLK_F_IO_DESC_SIZE=E2=80=99 undeclared =
(first use in
>   this function); did you mean =E2=80=98UBLK_F_UPDATE_SIZE=E2=80=99?
>    190 |         if (info->flags & UBLK_F_IO_DESC_SIZE)
>        |                           ^~~~~~~~~~~~~~~~~~~
>        |                           UBLK_F_UPDATE_SIZE
>  kublk.c:190:27: note: each undeclared identifier is reported only once
>   for each function it appears in
>  kublk.c:191:53: error: =E2=80=98struct ublksrv_ctrl_dev_info=E2=80=99 ha=
s no member
>   named =E2=80=98io_desc_size=E2=80=99
>    191 |             ublk_log("\tio_desc_size %u\n", info->io_desc_size);
>        |                                                 ^~
>  ... etc ...
>
> Fix it by using the KHDR_INCLUDES from the main selftest Makefile that
> should contain the right include path in either case.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tools/testing/selftests/ublk/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selfte=
sts/ublk/Makefile
> index fc64b8f028332..ba6df7c0b530b 100644
> --- a/tools/testing/selftests/ublk/Makefile
> +++ b/tools/testing/selftests/ublk/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> -CFLAGS +=3D -O3 -Wl,-no-as-needed -Wall -I $(top_srcdir)/usr/include
> +CFLAGS +=3D -O3 -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)

Sasha Levin already sent a patch for this:
https://lore.kernel.org/linux-block/20261103130131.4069212-7-sashal@kernel.=
org/

Best,
Caleb
