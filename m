Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890044A0A
	for <linux-block@vger.kernel.org>; Tue, 27 Feb 2024 02:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709001525; cv=none; b=N1GHnwWrwo88iOv8SipEBXkVqFr6tz/QPHAYyF3cxnvH7Bkh7huhnS9eO/bEPQDfq1b6enr3CocdnA5rQfYnvgMr/+bWQ3YS4WVmvPSt9Bv/liAoulPa6Fmj1/YhKVAU98+vWzqOKFyuQNaYR9MKEQKHgcXiRYujHd88wE1syuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709001525; c=relaxed/simple;
	bh=wzHJ46BFnOmmzw24/OvHTgHPU/3MGKrNJ5SrtFfGYWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BOG7XZ2jFCzeoxnm3QKE8XjeNHJmQFKjnJMeBBEiRKBHEf3Xf4JzoMuhb0erskYcX1LyELap1yN5+vJSPaBos1FAF/eM4sPEMS2U/O4GSjuYnt3fY8MRGH2eZ2SiQItijLfpi2i8ujk1gxpoPZ5jqlF/ThiAShVZsjyutTESirk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=stYhZiiu; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="stYhZiiu"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42e6939d34fso134081cf.0
        for <linux-block@vger.kernel.org>; Mon, 26 Feb 2024 18:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709001522; x=1709606322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzHJ46BFnOmmzw24/OvHTgHPU/3MGKrNJ5SrtFfGYWY=;
        b=stYhZiiuS9v4qHTb1CYBRy1mwqJjAI4ARBGCSnPAKR3bcz0wX7hfBuSATFcWkLTNeJ
         hlhGll50/P11hzxpUt96zmD3y2FKAJzHSxkhZaAjOS0MhVem0e7G35WT2CXy5Hk6yMG0
         LJgrtjLS3kDFYxj2Q0VXwxnCCxYdG/QA3EOK4QljWHIlBxFlb/64wDxeuXe9J0DC6c+l
         9SeB5QfqAPJA7PIV2lRRFgBFaCFvISjMUwVQPks3yiIn6dp7yi8HTWSP2Qbyc9k4MJOT
         McfJaJyW/7WlNmMV/X91aEq1RNuXqyywcGYx4Ujfqt+XsM04d81Le6z/GiNsdonG3MS3
         cQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709001522; x=1709606322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzHJ46BFnOmmzw24/OvHTgHPU/3MGKrNJ5SrtFfGYWY=;
        b=qmZSkonWpnG7A1JavI+3NWufWKdqxcEI3kXQVq+hfDaqXCH/+OcMQlKV5Ixw2ov1sN
         30kSMbDOVgDI98t3F9F6fnEp6f95rmSBxeoJUn0L16j6JOQgcC+ivQLhbr+rOdNyvbsh
         odl0fXkHnhwpuXa3LDcSrtQMkwstA6/DS9l6JTM/P8R6VPuvnBa0p0ZcwVVIeJpbbtOI
         Aj3h0qQRYfCmqyE7okgkluDMP//A8tVfYYXhz12+r7+QMR2frUsKpSRmm/Hn36qzSkVj
         BXSwYmdZyzz2Pj9dNy1avPwg36UQlyk+jdJtPVcRSiP7nRCPbRtDoGdSyH2Ibb5MV7Sf
         5NWw==
X-Gm-Message-State: AOJu0YxvJgPF8VfHustzswKwN45MGox+7k4toXseBdBs9NdBQ4bgqCKJ
	R0sdiSkRNUcvi98tBUBVlH7jFVOSDxZG0AJLn7qrhVqoxjF0ifILllvPxgj+DCsk20MWbH6Y3/d
	j8lyMLSZc6DZKf8CrEcdRovud9v/32WjX1/fl
X-Google-Smtp-Source: AGHT+IGkN92KN2eCRzbILdsKVYxE5It4UF4iW/4AZvclEAU+FOBH0Z9L2TO4QsvzfkYYKYkovQbtzjx70/BwIgRoKNM=
X-Received: by 2002:a05:622a:1016:b0:42e:646c:6ac2 with SMTP id
 d22-20020a05622a101600b0042e646c6ac2mr120348qte.28.1709001522281; Mon, 26 Feb
 2024 18:38:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP9s-SrvNZROseNkpSL-p-qsO0RT6H+81xX4gg-TV71gQ_UbYA@mail.gmail.com>
 <20240212154411.GA28927@lst.de> <CAP9s-Sr3_GVYBv-XObPRC9L27jJoQqX40d8g3gysEmy6VdQS1Q@mail.gmail.com>
 <CAP9s-So3NkfexGOQ2ogt5duaCevbWXb3wJf_zyB2F+eotBmg6w@mail.gmail.com>
In-Reply-To: <CAP9s-So3NkfexGOQ2ogt5duaCevbWXb3wJf_zyB2F+eotBmg6w@mail.gmail.com>
From: Saranya Muruganandam <saranyamohan@google.com>
Date: Mon, 26 Feb 2024 18:38:30 -0800
Message-ID: <CAP9s-Sp+H8rBUyAURpKOu9ZuiU_GRTmqc+ksoiJx_xHdfFHqig@mail.gmail.com>
Subject: Re: regression on BLKRRPART ioctl for EIO
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, sashal@kernel.org, 
	Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
Is there advice on how to fix this `blockdev --rereadpt` regression in
the kernel?
Would appreciate some advice.

Thanks,
Saranya


On Mon, Feb 12, 2024 at 8:01=E2=80=AFPM Saranya Muruganandam
<saranyamohan@google.com> wrote:
>
> When we fail to read from the disk, BLKRRPART used to be able to
> capture and bubble this up to the caller.
> It no longer does since we no longer capture the error from bdev_disk_cha=
nged.
>
> Here is an example with fault-injection:
>
> # echo 0 > /sys/kernel/debug/fail_make_request/interval
> # echo 100 > /sys/kernel/debug/fail_make_request/probability
> # echo -1 > /sys/kernel/debug/fail_make_request/times
> # echo 1 > /sys/block/sdc/make-it-fail
> # blockdev --rereadpt /dev/sdc # no error
> # echo $?
> 0 # incorrectly reports success.
>
> Whereas fdisk and sfdisk correctly report the issue :
>
> # sfdisk /dev/sdc
> sfdisk: cannot open /dev/sdc: Input/output error
> # fdisk /dev/sdc
>
> Welcome to fdisk (util-linux 2.28.2).
> Changes will remain in memory only, until you decide to write them.
> Be careful before using the write command.
>
> fdisk: cannot open /dev/sdc: Input/output error
>
> Best,
> Saranya
>
>
>
> On Mon, Feb 12, 2024 at 8:00=E2=80=AFPM Saranya Muruganandam
> <saranyamohan@google.com> wrote:
> >
> > When we fail to read from the disk, BLKRRPART used to be able to captur=
e and bubble this up to the caller.
> > It no longer does since we no longer capture the error from bdev_disk_c=
hanged.
> >
> > Here is an example with fault-injection:
> >
> > # echo 0 > /sys/kernel/debug/fail_make_request/interval
> > # echo 100 > /sys/kernel/debug/fail_make_request/probability
> > # echo -1 > /sys/kernel/debug/fail_make_request/times
> > # echo 1 > /sys/block/sdc/make-it-fail
> > # blockdev --rereadpt /dev/sdc # no error
> > # echo $?
> > 0 # incorrectly reports success.
> >
> > Whereas fdisk and sfdisk correctly report the issue :
> >
> > # sfdisk /dev/sdc
> > sfdisk: cannot open /dev/sdc: Input/output error
> > # fdisk /dev/sdc
> >
> > Welcome to fdisk (util-linux 2.28.2).
> > Changes will remain in memory only, until you decide to write them.
> > Be careful before using the write command.
> >
> > fdisk: cannot open /dev/sdc: Input/output error
> >
> > Best,
> > Saranya
> >
> > On Mon, Feb 12, 2024 at 7:44=E2=80=AFAM Christoph Hellwig <hch@lst.de> =
wrote:
> >>
> >> What scenario are you looking at?
