Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C89841C68
	for <linux-block@vger.kernel.org>; Fri, 17 May 2024 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715963249; cv=none; b=nnS2mWERc1WRxwbcxkSCFYiWluxwhTcvrBiRCU8suC99E5j/GCcaupyS01zOTasi4Cj2Uz9QBUo/p/w9Ew9UzyqKNnA9l+LQ4BveD7reUeiBzmsQT+jtHhPII9fSOQff+MuTd4lR3JpjFx0JbTuFSPyCwoWjADMroKfZ78Rnz9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715963249; c=relaxed/simple;
	bh=bUZHCbfj4K9G8BE13IOCZ+12qUh0YLmxWuHMx2s8c7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SpiF0arUPfLJ8xJl2grXAUHBAZQRzgsFVo9xsU/pfDPzgFmCdVqE6ORNRaVntjmB2GOLnycp85NC0PDL8ahCg5VLt6uGRMEMznkl/E7nbU+rcaQVZ/W1vD+oo5n/EQjXxvFapAyHchAP8lxcuzM/ApglGPfXi73QTs2oCpc736A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=if6pmfDz; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="if6pmfDz"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c9a1d294cfso211833b6e.0
        for <linux-block@vger.kernel.org>; Fri, 17 May 2024 09:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715963247; x=1716568047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsBcgs+i07u2l3W88V5z3GmB5lAU185KFxQwtWbkIR0=;
        b=if6pmfDz1smorOFhQbe8fV+28y1762oOnrsQ3nR8ucJQUikCCNwZjS0sutW2CetE9N
         a0pbWOoHNuuXSt/qUTdby4oZdBE3L3UMg/bMKwNnaUjEj+xd3kDdYsJOA9sMAIv0DMFG
         ZqTho8zmT4O86isRd2Mhm7Z/xdCWOLWi8FtshbF4Th++Oc668CfSro8C/sr7MGnxhEx9
         xN34zZ/Sbw44tSkrALCuI95EKhZrPM8Zm6P9hP1OZckMBuXaZyFhG7s0kWwP1i6O/Dh5
         iyb05JND/EE9+uf/oz5phw5Vdj+cBzgXzyrUdQbKS9Px3MBZO0mxa639ZFpJsjuWM26a
         wTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715963247; x=1716568047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsBcgs+i07u2l3W88V5z3GmB5lAU185KFxQwtWbkIR0=;
        b=C5ny2HYtE8BVzHXnXi/IH0WKg6bt3Dzp5QciNbSqsuVc7ChgfIQBhbgswfjS7UdvNa
         vIrWYdlvtj6SaW8XSsgBlAf2umkl8oCghDS7FNKZ9xXzwUJXs5m3SbIvt2Qegz8V0mFI
         ljwjYzy/mpd6ZHypNk/JW/oc7sQqAtTlKuV8UUITS9kZoq5qmtOA6wGd5N906m/MMX7p
         /mkP7feCa3W8JE+ANfHd3x/S+NapCIcHpbXkkv/fNiyKFMFd9TjlXu0v0LdhszeYdoKF
         6JQAdIlBUoP9q9bN/Hanq9c/odqeOWfAkorTJz4zVX0hLjv40CUPtGhGfxA10/O0KfAy
         eTng==
X-Forwarded-Encrypted: i=1; AJvYcCU4i/j5RMHRudUpLfo0UlRm3gbt1k5IMgJl49es/+UnnOlsagDLFbIQTm9lh2+W6Wom4hK6HyN5dx3H4EdCebMgT1VXjIeGHYcDf+Y=
X-Gm-Message-State: AOJu0YxywuftuO+DasZkONu2XJkPAeWUC/EXwF16GoIgViOtexUg8Tfs
	uiIOPycVsj8MQEFIBvuZ34sdCnseuA19xipUrvGFOyr12dO52FchcmWXVxlLnAnlIAWbjlq0QOS
	YXGViuTIWp+5X5rz6zyJJ7EQvtBM=
X-Google-Smtp-Source: AGHT+IEog8f0lXH81lGhHBFVqjJdyaUhli4ZdwxANkP6pers4WIujvbAuERD6Y1ltN16MdEUhdCFPSnFoomxYWnGZqg=
X-Received: by 2002:a05:6808:18a0:b0:3c9:c7a0:94f7 with SMTP id
 5614622812f47-3c9c7a0964fmr4945200b6e.1.1715963246922; Fri, 17 May 2024
 09:27:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240510134740epcas5p24ef1c2d6e8934c1c79b01c849e7ccb41@epcas5p2.samsung.com>
 <20240510134015.29717-1-joshi.k@samsung.com> <CB17E82F-C649-4D13-8813-1A6F2D621C51@dubeyko.com>
 <CA+1E3rLxUnuv9E_BxCFj1aodOTp3yrOEh7cFYt_j-Yz+_0q29g@mail.gmail.com>
 <88421397-1B95-4B2A-A302-55A919BCE98E@dubeyko.com> <CA+1E3rJtJpxk3EmTmtJWDFwP8km0xqRPt2QeQTRar7sTHtdD2Q@mail.gmail.com>
 <6078F029-A2ED-4B11-AC3B-B0E54D1BEB97@dubeyko.com>
In-Reply-To: <6078F029-A2ED-4B11-AC3B-B0E54D1BEB97@dubeyko.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Fri, 17 May 2024 09:27:00 -0700
Message-ID: <CA+1E3r+hgO=-K=oojP8xMBDOkVtma60FK-RTxQhbvg2yUc+Abg@mail.gmail.com>
Subject: Re: [PATCH] nvme: enable FDP support
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, 
	linux-block@vger.kernel.org, =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>, 
	Bart Van Assche <bvanassche@acm.org>, david@fromorbit.com, gost.dev@samsung.com, 
	Hui Qi <hui81.qi@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 2:40=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
>
>
> > On May 15, 2024, at 6:30 AM, Kanchan Joshi <joshiiitr@gmail.com> wrote:
> >
> > On Tue, May 14, 2024 at 1:00=E2=80=AFPM Viacheslav Dubeyko <slava@dubey=
ko.com> wrote:
> >>> On May 14, 2024, at 9:47 PM, Kanchan Joshi <joshiiitr@gmail.com> wrot=
e:
> >>>
> >>> On Mon, May 13, 2024 at 2:04=E2=80=AFAM Viacheslav Dubeyko <slava@dub=
eyko.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>>> On May 10, 2024, at 4:40 PM, Kanchan Joshi <joshi.k@samsung.com> wr=
ote:
> >>>>>
> >>>>> Flexible Data Placement (FDP), as ratified in TP 4146a, allows the =
host
> >>>>> to control the placement of logical blocks so as to reduce the SSD =
WAF.
> >>>>>
> >>>>> Userspace can send the data lifetime information using the write hi=
nts.
> >>>>> The SCSI driver (sd) can already pass this information to the SCSI
> >>>>> devices. This patch does the same for NVMe.
> >>>>>
> >>>>> Fetches the placement-identifiers (plids) if the device supports FD=
P.
> >>>>> And map the incoming write-hints to plids.
> >>>>>
> >>>>
> >>>>
> >>>> Great! Thanks for sharing  the patch.
> >>>>
> >>>> Do  we have documentation that explains how, for example, kernel-spa=
ce
> >>>> file system can work with block layer to employ FDP?
> >>>
> >>> This is primarily for user driven/exposed hints. For file system
> >>> driven hints, the scheme is really file system specific and therefore=
,
> >>> will vary from one to another.
> >>> F2FS is one (and only at the moment) example. Its 'fs-based' policy
> >>> can act as a reference for one way to go about it.
> >>
> >> Yes, I completely see the point. I would like to employ the FDP in my
> >> kernel-space file system (SSDFS). And I have a vision how I can do it.
> >> But I simply would like to see some documentation with the explanation=
 of
> >> API and limitations of FDP for the case of kernel-space file systems.
> >
> > Nothing complicated for early experimentation.
> > Once FS has determined the hint value, it can put that into
> > bio->bi_write_hint and send bio down.
> >
> > If SSDFS cares about user-exposed hints too, it can choose different
> > hint values than what is exposed to user-space.
> > Or it can do what F2FS does - use the mount option as a toggle to
> > reuse the same values either for user-hints or fs-defined hints.
>
> How many hint values file system can use? Any limitations here?

As many as already defined (in rw_hint.h). Possible to go higher too.
No hard limitation per se. Write is not going to fail even if it sends
a hint that does not exist.

> And how file system can detect that it=E2=80=99s FDP-based device?

It does not need to detect. File system sees write-hints; FDP is a
lower-level detail.
