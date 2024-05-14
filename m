Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E930D181BA9
	for <linux-block@vger.kernel.org>; Tue, 14 May 2024 21:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715722810; cv=none; b=FsmRm9PY/YspZDuRLjAX5BBbONpRSSHji1CG8PoRiWTm3N8XELbF8MNZEPph4RQs3FRTUFZ+tOrUvTso08eYcz1UJG7CBh66dLLZbRXy3MYPimonK7VXHafQ57HFfGpmyTtv1DW6vSB5ZdMjsHJo+WxPc10LjUZXHqHdadVK2B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715722810; c=relaxed/simple;
	bh=EbVISRVWTpGwhW+AztODaoguU9xS274FQMB4Blc32Ow=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JRGK9v2pPZBI9/Y3Qs5JF2caAJQZOnqVLFxAMMreM29wHIFdoo96m2S/LPE6qyY+ddP70wql6niOwb8vDnYjnQogHaz0mUzbYm3NSI0+K1tKcyiwDEahF6FdxAjrxN5L/2re1TmCpVWq8a+5wOgtAAUY8YFvUFr9WJzXe8AploM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=wQA7+PK8; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="wQA7+PK8"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51f45104ef0so6689189e87.3
        for <linux-block@vger.kernel.org>; Tue, 14 May 2024 14:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1715722807; x=1716327607; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrziG9n2X44unPcKHLDimt60QjyvFXSxnAYMGkXTekg=;
        b=wQA7+PK8GQqoBBYfZMqBfL8ADWIYWoV0EDH1ZY3GcTKaIT3m/5J3wpfsTQca2EfOL6
         uifCeQEIpQvSXieaS/WdhjqHsdYC8L6n0IIQM2ibWW1/EsC+wg10JJ+hTmzvfeLjksQN
         WuhYSvlSeMvSGw1Z2TR/Ouc5bgA6qJIAiPW2VvXvgHbM0Ta4Y7QrBiiohalJb++BcGs0
         0OOCUcego2j76jDXTHSV9PPqG1Iocr4GlS8EU1lKaZ5V22EcfqpMTttYvW/TsHs9rC5V
         3pBh6ON7SWVOfGUYLyYcIaH+CCInPa4PkA09VQBzQiZvwwEbk42r+o5ZbuOT1LgPbOpw
         mSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715722807; x=1716327607;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PrziG9n2X44unPcKHLDimt60QjyvFXSxnAYMGkXTekg=;
        b=M5OGLT8t+d3zc7YltQzFZIZBNbKk3+fKeoaJ0roF9ilNVMrizMWdlAdXzHxhT/QeQV
         tFvfmX0BmIx3fgyKH8adOTc7N+5KmZ6nTnxU/KRfM3sF/I4Rc1gaW5Vb6Abtt4wPZYEp
         KJrW6fVto0GCkzkX+JuvDyib4aBPPL5/X6b4mdFsjap3QXX5nMe9p7utpd/MbzkDQTEC
         4lMObKIE6ntvOLO+o3H5at+VLZYxdQBfEsZ1xa2yyBvQVbcyehM55K6ZTwV2n6728yz/
         TmsP1ncJYHmDiipPy0eelwQUJUXebnmOW00/K3F/TmjOH/5DiZfiMLitMeWEOnWNrem4
         kY/A==
X-Forwarded-Encrypted: i=1; AJvYcCV9PuwBb8h3YjtPhUoRz/x1439IAv0V1/W+Q9eAKtfGTgMF32Kxj5nME1IwDavGYnPmTS4CV0B5yDhCX2Nswzu8TG/W4lNYb5Gwrw4=
X-Gm-Message-State: AOJu0Yx6mbZcF7l/Mk8piUlosRM+re7DXeLhB+tZgNQkkRoDaCGVXhO4
	Os3eiL3Sh0iDcSNoqC8dh67jb1t/Aq776R85AoAjEKQ0Icbat5pqWKqtgxV69Yw=
X-Google-Smtp-Source: AGHT+IFGSTaDocCTelgf45mS4akR4/F1HUdr9D0HIeSNCHWfG9nxMysqTGBM6ywDHE34trO1bftJhQ==
X-Received: by 2002:ac2:4c4e:0:b0:523:6a08:1c91 with SMTP id 2adb3069b0e04-5236a081d53mr2435710e87.26.1715722806864;
        Tue, 14 May 2024 14:40:06 -0700 (PDT)
Received: from smtpclient.apple ([2a00:1370:81a4:8e0a:7881:38ef:d13d:5d35])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5238a36c718sm100571e87.245.2024.05.14.14.40.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2024 14:40:05 -0700 (PDT)
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
In-Reply-To: <CA+1E3rJtJpxk3EmTmtJWDFwP8km0xqRPt2QeQTRar7sTHtdD2Q@mail.gmail.com>
Date: Wed, 15 May 2024 00:40:01 +0300
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
Message-Id: <6078F029-A2ED-4B11-AC3B-B0E54D1BEB97@dubeyko.com>
References: <CGME20240510134740epcas5p24ef1c2d6e8934c1c79b01c849e7ccb41@epcas5p2.samsung.com>
 <20240510134015.29717-1-joshi.k@samsung.com>
 <CB17E82F-C649-4D13-8813-1A6F2D621C51@dubeyko.com>
 <CA+1E3rLxUnuv9E_BxCFj1aodOTp3yrOEh7cFYt_j-Yz+_0q29g@mail.gmail.com>
 <88421397-1B95-4B2A-A302-55A919BCE98E@dubeyko.com>
 <CA+1E3rJtJpxk3EmTmtJWDFwP8km0xqRPt2QeQTRar7sTHtdD2Q@mail.gmail.com>
To: Kanchan Joshi <joshiiitr@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.8)



> On May 15, 2024, at 6:30 AM, Kanchan Joshi <joshiiitr@gmail.com> =
wrote:
>=20
> On Tue, May 14, 2024 at 1:00=E2=80=AFPM Viacheslav Dubeyko =
<slava@dubeyko.com> wrote:
>>> On May 14, 2024, at 9:47 PM, Kanchan Joshi <joshiiitr@gmail.com> =
wrote:
>>>=20
>>> On Mon, May 13, 2024 at 2:04=E2=80=AFAM Viacheslav Dubeyko =
<slava@dubeyko.com> wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> On May 10, 2024, at 4:40 PM, Kanchan Joshi <joshi.k@samsung.com> =
wrote:
>>>>>=20
>>>>> Flexible Data Placement (FDP), as ratified in TP 4146a, allows the =
host
>>>>> to control the placement of logical blocks so as to reduce the SSD =
WAF.
>>>>>=20
>>>>> Userspace can send the data lifetime information using the write =
hints.
>>>>> The SCSI driver (sd) can already pass this information to the SCSI
>>>>> devices. This patch does the same for NVMe.
>>>>>=20
>>>>> Fetches the placement-identifiers (plids) if the device supports =
FDP.
>>>>> And map the incoming write-hints to plids.
>>>>>=20
>>>>=20
>>>>=20
>>>> Great! Thanks for sharing  the patch.
>>>>=20
>>>> Do  we have documentation that explains how, for example, =
kernel-space
>>>> file system can work with block layer to employ FDP?
>>>=20
>>> This is primarily for user driven/exposed hints. For file system
>>> driven hints, the scheme is really file system specific and =
therefore,
>>> will vary from one to another.
>>> F2FS is one (and only at the moment) example. Its 'fs-based' policy
>>> can act as a reference for one way to go about it.
>>=20
>> Yes, I completely see the point. I would like to employ the FDP in my
>> kernel-space file system (SSDFS). And I have a vision how I can do =
it.
>> But I simply would like to see some documentation with the =
explanation of
>> API and limitations of FDP for the case of kernel-space file systems.
>=20
> Nothing complicated for early experimentation.
> Once FS has determined the hint value, it can put that into
> bio->bi_write_hint and send bio down.
>=20
> If SSDFS cares about user-exposed hints too, it can choose different
> hint values than what is exposed to user-space.
> Or it can do what F2FS does - use the mount option as a toggle to
> reuse the same values either for user-hints or fs-defined hints.

How many hint values file system can use? Any limitations here?

And how file system can detect that it=E2=80=99s FDP-based device?

Thanks,
Slava.

