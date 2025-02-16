Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E86014658B;
	Sun, 16 Feb 2025 08:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739695632; cv=none; b=EDhzvsZsCp3CVMO2xTzuJ+HxUrYAcaYuNr4p5J/IGylu+rM/QkHFed2I/5WLrkUf0mEZemeR2kaB3ahWWMNqBn7N02eaJriDnj79xoWq4YbPJ41Od1P73EuF0x4Ah53VtoKaGljjTr9oKKU0dZgMnQjK30Vv/zxiTIkbmxeuTPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739695632; c=relaxed/simple;
	bh=dgLIkuXCcjsa0ryvpJNdPC6pa01pbIKoRU7VPbnSE/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPEjH7AfrF4vgI8UgsRdURNXG0miiScaP9JWQi5vhRuz+Wadd6+Oi70er3n3Yw3/RK1vhcdirT60s7/kXVE8NwIPapLPP0GhvOgZhm+3oRj/Ex2Q5YJi4FiZweTiI45c2agbR3305n/D/WVMcvtlC3qSrII+zZivqDVze7ZNW/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAJjO3BD; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAJjO3BD"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2212a930001so2105405ad.0;
        Sun, 16 Feb 2025 00:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739695630; x=1740300430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xGLzo1ULaJmlQlynE+LEweCnpKSiaThlEE0rSn94tRs=;
        b=AAJjO3BDOYTPHx6hGijqEeh5CE+tmf0uPAxp+2M5V/N/F3jvLPue7GAjooPckTztCR
         AygMzL1UBHV1ch36NpKfyJ7jw4y0f3iHNOnP4f1PWFbtwCvr7Csjv3ZlHTIde2stJ9/n
         N4bhB/t/WlB+epOy1hZxyoACzy7elHcSfmy15KIkOD2PUJcqprBSS76QWDDQ4ebq1KTf
         LJAFt4lkxKuBL8dBERieA3bBzIfr6evUYM8n5ohCL3rzC9a4nVx5+YyRQvysmU4Rozfl
         z8GoGuCw4/JNZ58M18Yy/enXVeijijJ+IM4TIxuOy/WOQB+E91suaeAEwdCnZv3yN2ty
         0TLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739695630; x=1740300430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGLzo1ULaJmlQlynE+LEweCnpKSiaThlEE0rSn94tRs=;
        b=cadxBCzDjILci4/S8UW4dOnfXmnCXo7WZ7wza0goRGQ7dsk9vPl9iIBrJJGLo9qToj
         0Ec5DYL7BJowZKXfLF3nx4UosJN/ZXNTLs7N9ONTkx05RlAV6Bpfv0LOPPkwOu2lpDoO
         C9wfEv1syeNHHXX6tYWO7kIvIlKzbkWLc6nEYARMm9bEAz6Fdv6sUNf6kufXWZjykBOp
         iUKv9MYpU5OtMv6L8Sr2if7Oq5tc1hI6k7E9CG4fkete7JIylpeuSuRZ65+20KG3lEyR
         ogrr1Glkp/Uyzhe9VjyLr95+XDRDezSJDywTINChfI/Q21ucC/vrPsuPQvM40ciPwk8j
         i6rg==
X-Forwarded-Encrypted: i=1; AJvYcCVBjpu0YwyL8YuLPWkDXn72z8wkeq4ceDcpNPBseJC64cVBTXeifbMletdmKsgZlhzqOeGtyK5BArbtLg==@vger.kernel.org, AJvYcCWpv2QjdnjRNm9NxUxtksTDRcli46JYbsOPd9Yb9PfrxvFx66bjrhdKKsjVYM0vErzjDyhaKK/jlk1T@vger.kernel.org, AJvYcCXxvk9MAmjy+5uT4n/xDUZ+Cb1soV34Ry80Y6wx2rN1vVTiyLYjaHkgirrrqUFas2eiaHEG7Spzzq5G8idY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4oQnvv6Ra1vHLGQKFF68kj1YVjIbthxpQvj8QocgwBdrWqONl
	E8DreAJ1BkC4zWzcGb7LlWF+D5o5WIPxws26NBfLlFR16VwUqhxa
X-Gm-Gg: ASbGnctwmH+sAoZhAxi6dEpw5RR5Alqdwkl62P90jY+MflHjszxIi8hZj31X9cOBZt7
	yfBVioTfl1xuioDPzj6AkbXXYPk/R7fHZarAJe3mEY1GAJENHKl/1dmoiqJGBRGZllpsI9TbKdY
	0ik6/2QR44c2UYsp7c+J6rpW1qOxKdlqg765z9iqcMKTLm9+73x70JRbR2emHV4DPCRhJMNCvtP
	ITLsiuWspAPN3Usk3eIIRBROZDUWuVDM/FBq3Q1ulpcj/zw11PilFB5eiiep3PU7o7JrmIppkZc
	dvmq/udp6WNarEM=
X-Google-Smtp-Source: AGHT+IFwGSO57uiGrSPWaSqPF81f0cIB7VO2BKvwKqm/QvTPTue+VPSNxvUpu8h5yIfCrS1nOycvLQ==
X-Received: by 2002:a05:6a21:62c4:b0:1e1:c0d7:7502 with SMTP id adf61e73a8af0-1ee8cc1347amr10454149637.37.1739695629977;
        Sun, 16 Feb 2025 00:47:09 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7325aadd797sm3323334b3a.34.2025.02.16.00.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 00:47:08 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id ADD564208F47; Sun, 16 Feb 2025 15:46:57 +0700 (WIB)
Date: Sun, 16 Feb 2025 15:46:57 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: David Reaver <me@davidreaver.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Konstantin Khlebnikov <koct9i@gmail.com>, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] docs: iostats: Rewrite intro, remove outdated formats
Message-ID: <Z7GmAcpIRrmbWHQ7@archie.me>
References: <20250215180114.157948-1-me@davidreaver.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1k5tCeOp3IGuamdw"
Content-Disposition: inline
In-Reply-To: <20250215180114.157948-1-me@davidreaver.com>


--1k5tCeOp3IGuamdw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 10:01:13AM -0800, David Reaver wrote:
> diff --git a/Documentation/admin-guide/iostats.rst b/Documentation/admin-=
guide/iostats.rst
> index 609a3201fd4e..9453196ade51 100644
> --- a/Documentation/admin-guide/iostats.rst
> +++ b/Documentation/admin-guide/iostats.rst
> @@ -2,62 +2,39 @@
>  I/O statistics fields
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -Since 2.4.20 (and some versions before, with patches), and 2.5.45,
> -more extensive disk statistics have been introduced to help measure disk
> -activity. Tools such as ``sar`` and ``iostat`` typically interpret these=
 and do
> -the work for you, but in case you are interested in creating your own
> -tools, the fields are explained here.
> -
> -In 2.4 now, the information is found as additional fields in
> -``/proc/partitions``.  In 2.6 and upper, the same information is found i=
n two
> -places: one is in the file ``/proc/diskstats``, and the other is within
> -the sysfs file system, which must be mounted in order to obtain
> -the information. Throughout this document we'll assume that sysfs
> -is mounted on ``/sys``, although of course it may be mounted anywhere.
> -Both ``/proc/diskstats`` and sysfs use the same source for the informati=
on
> -and so should not differ.
> -
> -Here are examples of these different formats::
> -
> -   2.4:
> -      3     0   39082680 hda 446216 784926 9550688 4382310 424847 312726=
 5922052 19310380 0 3376340 23705160
> -      3     1    9221278 hda1 35486 0 35496 38030 0 0 0 0 0 38030 38030
> -
> -   2.6+ sysfs:
> -      446216 784926 9550688 4382310 424847 312726 5922052 19310380 0 337=
6340 23705160
> -      35486    38030    38030    38030
> -
> -   2.6+ diskstats:
> -      3    0   hda 446216 784926 9550688 4382310 424847 312726 5922052 1=
9310380 0 3376340 23705160
> -      3    1   hda1 35486 38030 38030 38030
> -
> -   4.18+ diskstats:
> -      3    0   hda 446216 784926 9550688 4382310 424847 312726 5922052 1=
9310380 0 3376340 23705160 0 0 0 0
> -
> -On 2.4 you might execute ``grep 'hda ' /proc/partitions``. On 2.6+, you =
have
> -a choice of ``cat /sys/block/hda/stat`` or ``grep 'hda ' /proc/diskstats=
``.
> -
> -The advantage of one over the other is that the sysfs choice works well
> -if you are watching a known, small set of disks.  ``/proc/diskstats`` may
> -be a better choice if you are watching a large number of disks because
> -you'll avoid the overhead of 50, 100, or 500 or more opens/closes with
> -each snapshot of your disk statistics.
> -
> -In 2.4, the statistics fields are those after the device name. In
> -the above example, the first field of statistics would be 446216.
> -By contrast, in 2.6+ if you look at ``/sys/block/hda/stat``, you'll
> -find just the 15 fields, beginning with 446216.  If you look at
> -``/proc/diskstats``, the 15 fields will be preceded by the major and
> -minor device numbers, and device name.  Each of these formats provides
> -15 fields of statistics, each meaning exactly the same things.
> -All fields except field 9 are cumulative since boot.  Field 9 should
> -go to zero as I/Os complete; all others only increase (unless they
> -overflow and wrap). Wrapping might eventually occur on a very busy
> -or long-lived system; so applications should be prepared to deal with
> -it. Regarding wrapping, the types of the fields are either unsigned
> -int (32 bit) or unsigned long (32-bit or 64-bit, depending on your
> -machine) as noted per-field below. Unless your observations are very
> -spread in time, these fields should not wrap twice before you notice it.
> +The kernel exposes disk statistics via ``/proc/diskstats`` and
> +``/sys/block/<device>/stat``. These stats are usually accessed via tools
> +such as ``sar`` and ``iostat``.
> +
> +Here are examples using a disk with two partitions::
> +
> +   /proc/diskstats:
> +     259       0 nvme0n1 255999 814 12369153 47919 996852 81 36123024 42=
5995 0 301795 580470 0 0 0 0 60602 106555
> +     259       1 nvme0n1p1 492 813 17572 96 848 81 108288 210 0 76 307 0=
 0 0 0 0 0
> +     259       2 nvme0n1p2 255401 1 12343477 47799 996004 0 36014736 425=
784 0 344336 473584 0 0 0 0 0 0
> +
> +   /sys/block/nvme0n1/stat:
> +     255999 814 12369153 47919 996858 81 36123056 426009 0 301809 580491=
 0 0 0 0 60605 106562
> +
> +   /sys/block/nvme0n1/nvme0n1p1/stat:
> +     492 813 17572 96 848 81 108288 210 0 76 307 0 0 0 0 0 0
> +
> +Both files contain the same 17 statistics. ``/sys/block/<device>/stat``
> +contains the fields for ``<device>``. In ``/proc/diskstats`` the fields
> +are prefixed with the major and minor device numbers and the device
> +name. In the example above, the first stat value for ``nvme0n1`` is
> +255999 in both files.
> +
> +The sysfs ``stat`` file is efficient for monitoring a small, known set
> +of disks. If you're tracking a large number of devices,
> +``/proc/diskstats`` is often the better choice since it avoids the
> +overhead of opening and closing multiple files for each snapshot.
> +
> +All fields are cumulative, monotonic counters, except for field 9, which
> +resets to zero as I/Os complete. The remaining fields reset at boot, on
> +device reattachment or reinitialization, or when the underlying counter
> +overflows. Applications reading these counters should detect and handle
> +resets when comparing stat snapshots.
> =20
>  Each set of stats only applies to the indicated device; if you want
>  system-wide stats you'll have to find all the devices and sum them all u=
p.
>=20

The doc LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--1k5tCeOp3IGuamdw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ7Gl+gAKCRD2uYlJVVFO
o1p5AQDkfhl6zkpLLKdDOA6iiuY0vt3XzWg2iXIsZ9/ZMhviyQEA6nkZpo8HHpqN
TqtgvYhTFxAQ524Eb7DMKx3axQ/IXAk=
=CLqk
-----END PGP SIGNATURE-----

--1k5tCeOp3IGuamdw--
