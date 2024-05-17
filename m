Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED6C13DB83
	for <linux-block@vger.kernel.org>; Fri, 17 May 2024 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966538; cv=none; b=u/Cfzu8FmrsQhYw6N2Rjws7PmDHQY9/z0Am44lIcDVkjrE8sM9W57ViDSr9HkBmki4zsU3kK/T8sYEjnjdXKmmvVNJ0Aj9JIP7GJRU1RKCae0Caj+MareSyWx2osvMUlbGsYWKChS9y7wAg5BsqmsxDz1z8h+EJOiPkEqgi88V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966538; c=relaxed/simple;
	bh=mSbO7HksBDo+HeEzl/bNAopNXW6i+R3p89PpYrgJauI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bm8A6xnGUM7eoLF5CdfPKVWf1Xoq/gmNfLTXfREP3b4e/pSJaJt3xPb2ADdjEEkSENhuoZM720jAYpatkAaR2fwDqJTYtAGXwspDBW0zA1aApnUK4zhKQMzPpAElKw8pOzMwcJtsWF8pDwqiCjn1yRaHLUerEpswIJth0lmQFIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=RKJghd+f; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="RKJghd+f"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e7078a367eso8285691fa.0
        for <linux-block@vger.kernel.org>; Fri, 17 May 2024 10:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1715966535; x=1716571335; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9v5UHstQmCiEMrDNZmaD/04p0iBzlvQ5DIypYPTouQ=;
        b=RKJghd+fY3vIStOOABOGn4xSEB/JtXozQCk0dHSQ8bZM9nwDG5szcI010IUwVIzOUA
         UltEUO5q9L8B57RT/sHoCPnieeo91r483/QGZBIvmOiksoAL8UkasV46HpOOlS6uVW8u
         Wlb5lLtLcJjKcANyF952rj2+UqtrMEKT50caQZLrXyK74jIqo0/f7Cw3QsVcCDaORFIZ
         jt476vA0BWL/QpaO8tJdYu87lQsJdI3vM3X00X3NqAwQ+5C466tTBXlgNMWatilJF/UZ
         N5zqTsNuWAE6WayxLeP+1VSVxpaCH6t5GkC943I1/SIPopPiSIhtR/gC0zK/OuLaudOM
         4+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715966535; x=1716571335;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9v5UHstQmCiEMrDNZmaD/04p0iBzlvQ5DIypYPTouQ=;
        b=PWd6GOzq2MdKuEhG7aTIGyfreRg/cHhI/42poCnRKP0ur3y3p4zPN27OipzMf8sNfj
         IvkUzOF5K+lYozUv4L4qi3gvwFqms9TLD7lrW/lOvLzKMfl7pkV/ktxzWXFv4KxmXSOJ
         o0u5epTht/1vlf+k/g5u0tMZL2XOIDCAM1kjnl/fQOUCfG8nvoGg0TUcF80H40QkyIgV
         R4bBis0h/HmgT8I48T5ZqbUQ8HnLWiubIH31y1NSGxztC274VL8j/PgQq57F29k4EMhP
         Oo1bT9c+Ud+YKlycPd78wcF5C8Ea042tpdHzpVDlv4mL9Id3Doubi5te+eA2+3e5lzHC
         8LFw==
X-Forwarded-Encrypted: i=1; AJvYcCWcX+aMvquG7pUCarfWWeZpsYBIux/e001D0uXtwrG32jmh1F6ukZ/TGxDG+egrs22zP1KBSUnGhhjJYZY97sCetYZHRrMfE+i2IXY=
X-Gm-Message-State: AOJu0YzqE6FgRxCP3Q065mdPrBErrX9qREIAqWpd/4+kIienqpoYYT/K
	Lnh8fC1y/fFkumtoGjiopEVM+tlrBKzG2NRoYqttrGrHPcqVYscd6aq/LON2LQ4=
X-Google-Smtp-Source: AGHT+IFzagdP4PeigI0hrZjJ8bPqkcttP59bYrzytO6RudEioXqfJ1z28D27QFTyu+49dRg0+vhc3w==
X-Received: by 2002:a05:6512:1289:b0:519:65fe:ac10 with SMTP id 2adb3069b0e04-5220e68b5a3mr8362770e87.32.1715966534663;
        Fri, 17 May 2024 10:22:14 -0700 (PDT)
Received: from smtpclient.apple ([2a00:1370:81a4:8e0a:197b:a3fe:ebe2:821e])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d8bafsm3319862e87.235.2024.05.17.10.22.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2024 10:22:13 -0700 (PDT)
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
In-Reply-To: <CA+1E3r+hgO=-K=oojP8xMBDOkVtma60FK-RTxQhbvg2yUc+Abg@mail.gmail.com>
Date: Fri, 17 May 2024 20:22:11 +0300
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
Message-Id: <E069A44C-9B95-4B7D-97C2-0087A8E68B48@dubeyko.com>
References: <CGME20240510134740epcas5p24ef1c2d6e8934c1c79b01c849e7ccb41@epcas5p2.samsung.com>
 <20240510134015.29717-1-joshi.k@samsung.com>
 <CB17E82F-C649-4D13-8813-1A6F2D621C51@dubeyko.com>
 <CA+1E3rLxUnuv9E_BxCFj1aodOTp3yrOEh7cFYt_j-Yz+_0q29g@mail.gmail.com>
 <88421397-1B95-4B2A-A302-55A919BCE98E@dubeyko.com>
 <CA+1E3rJtJpxk3EmTmtJWDFwP8km0xqRPt2QeQTRar7sTHtdD2Q@mail.gmail.com>
 <6078F029-A2ED-4B11-AC3B-B0E54D1BEB97@dubeyko.com>
 <CA+1E3r+hgO=-K=oojP8xMBDOkVtma60FK-RTxQhbvg2yUc+Abg@mail.gmail.com>
To: Kanchan Joshi <joshiiitr@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.8)



> On May 17, 2024, at 7:27 PM, Kanchan Joshi <joshiiitr@gmail.com> =
wrote:
>=20
> On Tue, May 14, 2024 at 2:40=E2=80=AFPM Viacheslav Dubeyko =
<slava@dubeyko.com> wrote:
>>=20
>>=20
>>=20
>>> On May 15, 2024, at 6:30 AM, Kanchan Joshi <joshiiitr@gmail.com> =
wrote:
>>>=20
>>> On Tue, May 14, 2024 at 1:00=E2=80=AFPM Viacheslav Dubeyko =
<slava@dubeyko.com> wrote:
>>>>> On May 14, 2024, at 9:47 PM, Kanchan Joshi <joshiiitr@gmail.com> =
wrote:
>>>>>=20
>>>>> On Mon, May 13, 2024 at 2:04=E2=80=AFAM Viacheslav Dubeyko =
<slava@dubeyko.com> wrote:
>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>>> On May 10, 2024, at 4:40 PM, Kanchan Joshi <joshi.k@samsung.com> =
wrote:
>>>>>>>=20
>>>>>>> Flexible Data Placement (FDP), as ratified in TP 4146a, allows =
the host
>>>>>>> to control the placement of logical blocks so as to reduce the =
SSD WAF.
>>>>>>>=20
>>>>>>> Userspace can send the data lifetime information using the write =
hints.
>>>>>>> The SCSI driver (sd) can already pass this information to the =
SCSI
>>>>>>> devices. This patch does the same for NVMe.
>>>>>>>=20
>>>>>>> Fetches the placement-identifiers (plids) if the device supports =
FDP.
>>>>>>> And map the incoming write-hints to plids.
>>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>> Great! Thanks for sharing  the patch.
>>>>>>=20
>>>>>> Do  we have documentation that explains how, for example, =
kernel-space
>>>>>> file system can work with block layer to employ FDP?
>>>>>=20
>>>>> This is primarily for user driven/exposed hints. For file system
>>>>> driven hints, the scheme is really file system specific and =
therefore,
>>>>> will vary from one to another.
>>>>> F2FS is one (and only at the moment) example. Its 'fs-based' =
policy
>>>>> can act as a reference for one way to go about it.
>>>>=20
>>>> Yes, I completely see the point. I would like to employ the FDP in =
my
>>>> kernel-space file system (SSDFS). And I have a vision how I can do =
it.
>>>> But I simply would like to see some documentation with the =
explanation of
>>>> API and limitations of FDP for the case of kernel-space file =
systems.
>>>=20
>>> Nothing complicated for early experimentation.
>>> Once FS has determined the hint value, it can put that into
>>> bio->bi_write_hint and send bio down.
>>>=20
>>> If SSDFS cares about user-exposed hints too, it can choose different
>>> hint values than what is exposed to user-space.
>>> Or it can do what F2FS does - use the mount option as a toggle to
>>> reuse the same values either for user-hints or fs-defined hints.
>>=20
>> How many hint values file system can use? Any limitations here?
>=20
> As many as already defined (in rw_hint.h). Possible to go higher too.
> No hard limitation per se. Write is not going to fail even if it sends
> a hint that does not exist.
>=20

OK. I see. Thanks.

>> And how file system can detect that it=E2=80=99s FDP-based device?
>=20
> It does not need to detect. File system sees write-hints; FDP is a
> lower-level detail.

I see your point. But SSDFS doesn=E2=80=99t need in hints from =
user-space side.
SSDFS has various types of segments (several types of metadata segments =
and
user data segment) and I would like to use hints for these different =
types of segments.
I mean that SSDFS needs to make decisions when and for what type of data =
or
metadata to send such hints without any instructions from user-space =
side.

Technically speaking, user-space side doesn=E2=80=99t need to care to =
provide any hints
to SSDFS because SSDFS can manage everything without such hints.
So, I would like to have opportunity to change SSDFS behavior for =
different
type of devices:

if (zns_device)
   execute_zns_related_logic
else if (fdp_device)
   execute_fdp_related_logic
else // conventional SSD
   execute_conventional_ssd_logic

Does it mean that there is no such way of FDP based device detection?

Thanks,
Slava.

