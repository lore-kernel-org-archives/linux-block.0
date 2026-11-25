Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634657;
	b=ugJwJXITrFT14t6BKAsla8IZZgmySPvA+vfeqpS0rRvqHhegtePsU4hnTO9MsrjSGCM6
	 UwsHSmR3CtNVzOKqPny/qoltNjj96/RMRK/0/Tv5+E96092UGTdt6sw+xVohiIblcCVeq
	 /xJRImVjDpgXqJ8Al6reoC3hfMGJPoOI1auYcdXsBb/nGEE4rfm3/jT3co/MVy1rEfZXo
	 xpur65XX0ppjouQ2tdse9w7FXswe5la1ypeCMipMF2zPHgobsCsXSZNfPkpOjFEXm0c2w
	 F676KtE56QLpGWuhQragMKe0uClk11ZQvk9z7xvCcpfXdineu4Cx99E3LFT+IbJh6Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=N55gjPKFtoyQEkpZ+mulBFdiGvAn3buEDUMJWwRWBLA=;
	b=TCcjTm0FJWpu3P/mP/PCmcNgatoejjH2VFNv3ZGCzm8Fv5ME07O6/xd6la+utbreBXUk
	 cYDiEF2iGpEv59qHDAjzQHmeuLgdWvE+9Iv9mipm3yGQznrMDHqxmrx7IMwASMEO1fBhx
	 Ikc0Zcq0LI1Fhjg1B6HAdjlyuvJ5TCl61BuzWaXf3vjEIySUlv5GTkLCTFV0hNKDpKCaP
	 mstIkAdK0M9+v1k16HmGA5MVHdBQVdJDtQgu0s+ceSgVpmQriY7X4JYvcpEjffWF4XJhn
	 d6h71vA0qa8pjOFVdH99lrT3X97EIO/88k6lwCpJUv26sIyH1WN3TnRwmxYJP62vtbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PQxZQo0T;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFAD606A331
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 19:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FFAD606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PQxZQo0T
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b29b83fdf1so3290952b3a.2
        for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 11:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795634655; x=1796239455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N55gjPKFtoyQEkpZ+mulBFdiGvAn3buEDUMJWwRWBLA=;
        b=PQxZQo0TTqoCAQqV96+d5EoAEWVnLcJP15L/GDv397QjtUn2t3l5136UUhvM4tv/Ye
         /o1K4Z5hEm9bYDztTZbC2tXo1IU4+GUmeoqyiuDiGsKdVLefuFWDdbvvuSPIyscCxFoP
         Cz4ZSeO5vANruk+8Am3i2DzZ4yo4APgqe8I/txsx9lJPZVEtO9eDX/jJ0NvmuTWbmBfh
         /V2lhq+B/jWKFHoehpwQtNkrtDkVscLJPhf1ctnG7DF99Uz2LPxpw1SR5D67WU3cM393
         fLAlhmwaFKwppT+9uL1ESlPHR8gqRsgEzs/ToyHZbUgXX/nL83IF07v5cJH14tA3PxVU
         eIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795634655; x=1796239455;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N55gjPKFtoyQEkpZ+mulBFdiGvAn3buEDUMJWwRWBLA=;
        b=x8VF6SHTRoT2JrtGbG7+B1VLoOCaBVeYO12btKM9n3NX3AYEs1ZLpsZeKmeT8k97Jy
         01AA3X55yhS9iv+m1xSuuHLmwJtvUU3jM3G+zuVfwZVYMd3TSTmWLJUwXZiXRmP7Og2M
         N+tvAz7BogLOyiMJ20mnX835j8CNvF1NTu+c1GIiO4ZupqC32/AvmSN0U0vff5EHXcCu
         R8dsh2MoyQG8ujfd54adGvC4yWDtHgFls+LOiB7k32mwTNB/5W0CwBg7VKRcPY79qLXS
         W1QZJg+gPFmBFNs8aDzsR6A7l5xn2fXY42AlcNaLaT1KwvCF+oM7EIlKRvmUJJe1GCjE
         l/dw==
X-Forwarded-Encrypted: i=1; AL+hErEDeJEsdep6QfemskrpMu4uycKDez5HQTlZuFcmLSeOfq4pvjg3Cx+RelqGHH6Ln+SMprJ6jH6a/+pVsQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9BY1JoxNBWWpLHoFLnMbcM5W261nHpcv4ZCdV2wAzAvqn8Lopg
	4HcbC3c73De3NmKVLZKYnKZsrM24FH5rmQAOcaf3DALEuTwr8T94nHMyIf31/7bHow==
X-Gm-Gg: AZFdTZd5K78m2a/jEJsqeTQQHhMJ4Dua3tESknuoZIgYmXZtCa5IpsLyB1e4aZ7Sp2l
	ZS2PcVRN6RPnVBsmI2JlAQcuEU+6EQizsHX2Tx6P+7tx0f1phuE1YElAwrQ9Pb/BpV1v8ynXCqn
	awCH+1XYUFkbhR871HsBzA15dLHvDwpFHUQ/2CZW7AN+XPQNFlw3eFXVrpKVJEKnEQEkjYZHu6N
	xU8nJX6bPxY35Xkg8fnOajjlLSh1NuIPMLv1KP+6Kvth05KM4p6vA8hgLUMKJj61haZ7SOV/1Yr
	AfIscFlxvCszwadITMREbZ9F1UQi1Wv5KJadMpvqMcaU+HF7vu4ZZud90vE8ht118mHKWXITIeI
	fO4y4O/bGo2+CpZegYF1dXLzMh9Yx6I/a/8E1JkBwhYGEqjSO/sj3sZKDjJGybJ2r/aN2rBsY1Z
	CwU/9R4pjKwS7pogUezSbdxDMQUdiHh5cF1a86dktMF7UM8LkdEf9Wx2YTW1d65U/4aETdLPQk1
	DzAg0mdnVJdHQoHUTtkfe3hlkp41KDHt5usNCtLtM9RSN3DCRA3lQ6TtfEp8zhq98LOUkecvhZP
	FvHYCz4Y0KU961pGabQptPSigVKjkpj/4jb3gisidFztjzjifLEP25+wKrVYBiRFI5MCASnvDk6
	FkF7qEHe6ogAsm3xclMGKL5JXPhu+1R+E/ClSi+sPlt1Lc43stBd88GgIQr8JYIu//aqL7HU2BC
	JrToWOL6nVLA==
X-Received: by 2002:a05:6a00:a908:b0:886:773d:a6a with SMTP id d2e1a72fcca58-8c87c199463mr15925448b3a.28.1795634654761;
        Wed, 25 Nov 2026 11:24:14 -0800 (PST)
Received: from google.com (196.126.197.35.bc.googleusercontent.com. [35.197.126.196])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077bc47sm9717494b3a.6.2026.11.25.11.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 11:24:13 -0800 (PST)
Date: Wed, 25 Nov 2026 11:24:10 -0800
From: Benson Leung <bleung@google.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-mm@kvack.org,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>, David Heidelberg <david@ixit.cz>,
	oe-linux-nfc@lists.linux.dev, Chas Williams <3chas3@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	MPT-FusionLinux.pdl@broadcom.com,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <mkp@kernel.org>, linux-scsi@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	linux-mtd@lists.infradead.org, Neill Kapron <nkapron@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	xen-devel@lists.xenproject.org, Hans de Goede <hansg@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	linux-ext4@vger.kernel.org, Mike Marshall <hubcap@omnibond.com>,
	devel@lists.orangefs.org, Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>, linux-cifs@vger.kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	intel-gfx@lists.freedesktop.org,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	intel-xe@lists.freedesktop.org
Subject: Re: [PATCH v3 11/12] docs: ioctl-number: update platform entries
Message-ID: <awc12oWB5WDJi8XZ@google.com>
References: <20261125061340.3402300-1-rdunlap@infradead.org>
 <20261125061340.3402300-12-rdunlap@infradead.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Kk3dCghKBQNrocaf"
Content-Disposition: inline
In-Reply-To: <20261125061340.3402300-12-rdunlap@infradead.org>


--Kk3dCghKBQNrocaf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 10:13:38PM -0800, Randy Dunlap wrote:
> Update the list of platform/ files where ioctls are defined and update
> the ranges of function numbers that are used.
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Tzung-Bi Shih <tzungbi@kernel.org> # cros_ec

For cros_ec as well:

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
> v2: no change
> v3: rebase
>=20
> [Since having multiple maintainers trying to merge these would
> cause some conflicts, it would be more manageable for Jon to
> take all of these through the docs-next tree.]
>=20
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-doc@vger.kernel.org
> Cc: Florian Fainelli <florian.fainelli@broadcom.com>
> Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadc=
om.com>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Cc: Benson Leung <bleung@chromium.org>
>=20
>  Documentation/userspace-api/ioctl/ioctl-number.rst |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> --- linux-next-20261123.orig/Documentation/userspace-api/ioctl/ioctl-numb=
er.rst
> +++ linux-next-20261123/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -434,6 +434,7 @@ Code  Seq#    Include File
>  0xBA  00-0F  uapi/linux/liveupdate.h                                   P=
asha Tatashin
>                                                                         <=
mailto:pasha.tatashin@soleen.com>
>  0xC0  00-0F  linux/usb/iowarrior.h
> +0xC4  00-1F  platform/raspberrypi/vchiq-interface/vchiq_ioctl.h
>  0xCA  00-0F  uapi/misc/cxl.h                                           D=
ead since 6.15
>  0xCA  10-2F  uapi/misc/ocxl.h
>  0xCA  80-BF  uapi/scsi/cxlflash_ioctl.h                                D=
ead since 6.15
> @@ -446,7 +447,7 @@ Code  Seq#    Include File
>  0xDD  00-3F                                                            Z=
FCP device driver see drivers/s390/scsi/
>                                                                         <=
mailto:aherrman@de.ibm.com>
>  0xE5  00-3F  linux/fuse.h
> -0xEC  00-01  linux/platform_data/cros_ec_chardev.h                     C=
hromeOS EC driver
> +0xEC  00-02  linux/platform_data/cros_ec_chardev.h                     C=
hromeOS EC driver
>  0xEE  00-09  uapi/linux/pfrut.h                                        P=
latform Firmware Runtime Update and Telemetry
>  0xEF  00-0F  uapi/linux/ntfs.h                                         N=
TFS
>  0xF3  00-3F  drivers/usb/misc/sisusbvga/sisusb.h                       s=
isfb

--Kk3dCghKBQNrocaf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCawc12gAKCRBzbaomhzOw
wuvSAP9FFr45oXAv5Psc3n5xsSYyPFouusI/XwRnWy3tYxQspAD+KIeOTWQfcOeC
TWeqyAANog5rg68r7xNPxeH8I/R6xAQ=
=Fk2v
-----END PGP SIGNATURE-----

--Kk3dCghKBQNrocaf--
