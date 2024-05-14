Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E0A1E504
	for <linux-block@vger.kernel.org>; Tue, 14 May 2024 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715713257; cv=none; b=kUDnO2jVRpSPlhMPAVh7UQ3GFYd1/Oo5Q2KG/LXvE4RNLXNLwUcByUWBePYINWPMprkEMAyivu3Ak8jiHYDW71UcpA/TwhPVPXPUCnjBkgzcKuhX6f+dkMEVhhOnhQYrthfgJpjbfXQGJqONHsBFSHhGaMKcYop8YRqbouRgv1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715713257; c=relaxed/simple;
	bh=RlCA1EtoNX39uA5IHrsyJZpW2tq7ERtIHtW/Y8P0+mo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fd1WEjjq8UCfYxkeTcvygj05USHh4Uo3AQ/MjexWWXl70Hv6v4PaZQsDhZvtXsO+Ehg9FiaZ5nWTAF/8+OGV5tTxbzxmhj5VKgoSV0qwiZIqjRQ1O/erNpwmAj1KWk8COc/Dl/pHik+3v1AchZ54BVU9iwv1y6Eg3F5ONaJcdww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=aJ1Yf9Nk; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="aJ1Yf9Nk"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2df83058d48so77454521fa.1
        for <linux-block@vger.kernel.org>; Tue, 14 May 2024 12:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1715713253; x=1716318053; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uaRNapfMv5f1rVugo2BX+9Ar9b3PGznLd2aVR8CIok=;
        b=aJ1Yf9Nkm/Whb+ilzk8Idd6Wj0qjxxE6Vlo/NkFTx20oQRiQBoUE3STuAsR/77/oCo
         mBrcgOSM6Wfs7vhGVVX/3T5UquUkZHjpnuiM9dd5NATxeuqE6aJ++C2HtdLIKY8hNDh3
         BE2u9jKHtEGjdo0c3MjbrK8/CWEl2NrXti0SrU79Ym8gtVJTGxob9+Os0ly0GBqEj/wq
         Ouqca1LVvMN8I2aRyz2ssMDGG6MpLbK9fzN5F6F6L9VITXNpOTQ/UEmQbdmXcagBL6Eh
         Ca6If/QqY2r4eJDEU9u3/HdqIkN7um3YFLx2ua5Tn9jHneKYT9JTvOyc6Ii5fVjB2WVc
         ZOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715713253; x=1716318053;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5uaRNapfMv5f1rVugo2BX+9Ar9b3PGznLd2aVR8CIok=;
        b=WoQ6TRwTOWzsDc+mGlDnGIJ3ezIPFhWJiMecatOb1EZUm6Z8jzFbteZ7AGyFv8dn4B
         Zk/MU5P/T6sO5T7RAJOeHgYDYfiJqL1B4+TqpM04GT1T4tmQLbJMF81Bq8gcveq4n/LV
         Q5KJwg9TVieDwuH4G9ra1ZzFS4CnKEIFe4zAU+PIvfN8UIRtENDtZ2wAc2SOYkgrAN6d
         WMKgR9sj6OWOwSdbI88afcXfr+af1Ir28Ar9Uv6TvJS7DGzU6J+f+UWxdu2XRTMoHfax
         hxGFvWYf5gt26XluTiyRoqQ74yZoIrVwHmaE2HrvPEuhSUjVp1LK+4Q97lY9PIvSRF6x
         RmrA==
X-Forwarded-Encrypted: i=1; AJvYcCXM+d7i64Ea+UOI1WroiT/iPdW8Rkd+wQfxliPwMFxg4K4AUd+RiUX/vRb/ENy5vusZ+GwjaqrEGpqd6wTFuf6OciUj6ghkfIEwbX0=
X-Gm-Message-State: AOJu0YwPtqKHRCa9Hz1r3bQTAOXOWIDMLwKCzOQY0Dd3FMNVoUoR7Vu+
	fwkNfm90LgAnNvoGjawoRCAZFu4NlsQwEIrphZVgHCEL+8udIcDrT/ZGP1H1jUE=
X-Google-Smtp-Source: AGHT+IF8Tfh2uu+B1TsYgX0zRT6Rbfo1m6HiOQghs7bs/CgInno9rJlztpdNh3x1sVdGe6eXublZZg==
X-Received: by 2002:a05:651c:505:b0:2df:baf3:2ae3 with SMTP id 38308e7fff4ca-2e51ff4d047mr107289251fa.29.1715713252968;
        Tue, 14 May 2024 12:00:52 -0700 (PDT)
Received: from smtpclient.apple ([2a00:1370:81a4:8e0a:7881:38ef:d13d:5d35])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e4d0ef09ffsm18123191fa.59.2024.05.14.12.00.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2024 12:00:52 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.8\))
Subject: Re: [PATCH] nvme: enable FDP support
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <CA+1E3rLxUnuv9E_BxCFj1aodOTp3yrOEh7cFYt_j-Yz+_0q29g@mail.gmail.com>
Date: Tue, 14 May 2024 22:00:48 +0300
Cc: Kanchan Joshi <joshi.k@samsung.com>,
 Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org,
 =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
 Bart Van Assche <bvanassche@acm.org>,
 david@fromorbit.com,
 gost.dev@samsung.com,
 Hui Qi <hui81.qi@samsung.com>,
 Nitesh Shetty <nj.shetty@samsung.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <88421397-1B95-4B2A-A302-55A919BCE98E@dubeyko.com>
References: <CGME20240510134740epcas5p24ef1c2d6e8934c1c79b01c849e7ccb41@epcas5p2.samsung.com>
 <20240510134015.29717-1-joshi.k@samsung.com>
 <CB17E82F-C649-4D13-8813-1A6F2D621C51@dubeyko.com>
 <CA+1E3rLxUnuv9E_BxCFj1aodOTp3yrOEh7cFYt_j-Yz+_0q29g@mail.gmail.com>
To: Kanchan Joshi <joshiiitr@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.8)



> On May 14, 2024, at 9:47 PM, Kanchan Joshi <joshiiitr@gmail.com> =
wrote:
>=20
> On Mon, May 13, 2024 at 2:04=E2=80=AFAM Viacheslav Dubeyko =
<slava@dubeyko.com> wrote:
>>=20
>>=20
>>=20
>>> On May 10, 2024, at 4:40 PM, Kanchan Joshi <joshi.k@samsung.com> =
wrote:
>>>=20
>>> Flexible Data Placement (FDP), as ratified in TP 4146a, allows the =
host
>>> to control the placement of logical blocks so as to reduce the SSD =
WAF.
>>>=20
>>> Userspace can send the data lifetime information using the write =
hints.
>>> The SCSI driver (sd) can already pass this information to the SCSI
>>> devices. This patch does the same for NVMe.
>>>=20
>>> Fetches the placement-identifiers (plids) if the device supports =
FDP.
>>> And map the incoming write-hints to plids.
>>>=20
>>=20
>>=20
>> Great! Thanks for sharing  the patch.
>>=20
>> Do  we have documentation that explains how, for example, =
kernel-space
>> file system can work with block layer to employ FDP?
>=20
> This is primarily for user driven/exposed hints. For file system
> driven hints, the scheme is really file system specific and therefore,
> will vary from one to another.
> F2FS is one (and only at the moment) example. Its 'fs-based' policy
> can act as a reference for one way to go about it.

Yes, I completely see the point. I would like to employ the FDP in my
kernel-space file system (SSDFS). And I have a vision how I can do it.
But I simply would like to see some documentation with the explanation =
of
API and limitations of FDP for the case of kernel-space file systems.

Thanks,
Slava.

