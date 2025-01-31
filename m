Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4491F2369
	for <linux-block@vger.kernel.org>; Fri, 31 Jan 2025 20:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738354049; cv=none; b=M7X1ZaHVIAekqTXL8CizDlqdiC+6E1+WBqDMEtM040wobFaRRSQuL2wSPjWF09AroC3y/1keBFXlci0o60AEyv4oxbkIc9rWelS6gzjXzI9rdfJjpeCABqBkCH97tRw1/xdnXzJP5LbD1haaEBfcQeTK2tpAmf9QJZNedkkXn/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738354049; c=relaxed/simple;
	bh=cWtzQbEgZPAq+mH95aWLjasbStFBal1CvhZspkrtVMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loSFdUW3wO7r795Um5k7u9gsBhEWCRNoSGsKd6/VEhOAvHtiUur+azAHYq4KblQXv+aZetIqu+M6ZWK4GpjmSPQseOfavI19leVVt9mxQlxxXPabgwOYydEswsInaCzRKUPeV390e8oTJfc5dWRzb+ohWTx52KtwLh/u0is71qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nkae82rM; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nkae82rM"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ee709715d9so3323377a91.3
        for <linux-block@vger.kernel.org>; Fri, 31 Jan 2025 12:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738354047; x=1738958847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TI5V1/OQyv2H0OpRJJwzwoIlcN4peiCQ44wdj1tTeSA=;
        b=Nkae82rMQe1yxCUbpt5qJCq4WTqhpUzxZFKaXv3acbtgt3akixFY0OT1PjYggjrT+s
         fu+6q22aj7OI/pJDSAOtS/LnuYl/uz/kOtL5sF3s8E/VHkf3uzTBykP7sop+eyrEVUaM
         LLLW9G1ol7tnbAXoowuDg/CtSHT+Ki6bm+l9Fk/+SaN+5QxO5wNyy0dp3HC2wFy0t+F9
         LslSw0LO0/gdlgonV7WmEa9MCh4IYgFg/wuUac/DU9MvE5xEBkQeYR04R20VWcid9Qqv
         mXi28MmH17CP3Ubmu/MUH45JEd2VGwzMVlMomH/1IvqV2BqLkibdHVNnxUZ+o9ZAyoxx
         EFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738354047; x=1738958847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TI5V1/OQyv2H0OpRJJwzwoIlcN4peiCQ44wdj1tTeSA=;
        b=pG79s1dMci+/62pyHfERh8B7Z2mmd6MELWN8ivziyJRRbXJnjkaUgZ815YXw/nCMmI
         QgRX1NJ3i11Y7gDAsxceXGKPuzOX50XoOCJONqIdAPFhXdhrQPNmjejnNmE6ARJ0IMCe
         GpdO39dg6pUa90RW4XFEJ/0yCPJUbCP5TdTz/pbM0U0kYsGOw/Y4tL/+PehiiipzhWMH
         u6Ts0kVlG0G8uscd8HZOzEdBHpr76G2zy80if57gdBzQESkJKGvNFMwgtGRyWjIwvG36
         5DIEIKj7jvxGrhesGTPlM4r9zbcvEW+WSgOxaPCavYw2NqsiyKPWMMISIY0fpu8TaHw1
         fC2A==
X-Forwarded-Encrypted: i=1; AJvYcCVl7XaKL/cbTecg69pXPIpRxoqXWHL81qXzK/M0adB2whHzCDt6vsm9uPeMd65uAFiscwdxxSQjF06UhA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm17GT4CFT1UWCqeTtJ4bs0sNuBJ9SpLxt7u5+5LhnNy7s2/hV
	2kqnzr8oBSWgH7UxnIbc/2+xu4BU0MdxzHQhpY3ns2up07K3SevW9M+TM8Q0JC+2HYOvLAmACLd
	cbVhdg+JJUs1Vk2gqGS7jqZhBN54=
X-Gm-Gg: ASbGncu1Ge/TEzvDfVI6j1DR8i3m4Vxam4JXBIlPT2H+cs28mLiOUL0AnQVVLvvvQTd
	5pBQn4WCSvMmBHMisPL50BHlm48GuH59LFyOzZvbDMfC6qmIuPqpKLPEc5sB4RQiHkc1uPek=
X-Google-Smtp-Source: AGHT+IGvaq3Co3JmSgBBFQMHYxYFOJLYw5BChtm16cmkI3EWKem0JZbt4AMmTJaq8haSXCNMsIwAYYd3xLxtr4mTrs8=
X-Received: by 2002:a17:90b:2d48:b0:2ee:c5ea:bd91 with SMTP id
 98e67ed59e1d1-2f83ac8acfcmr18113513a91.29.1738354047044; Fri, 31 Jan 2025
 12:07:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOBGo4xx+88nZM=nqqgQU5RRiHP1QOqU4i2dDwXt7rF6K0gaUQ@mail.gmail.com>
 <20250109045743.GE1323402@mit.edu> <CAOBGo4w88v0tqDiTwAPP6OQLXHGdjx1oFKaB0oRY45dmC-D1_Q@mail.gmail.com>
 <20250109155119.GF1323402@mit.edu> <Z4DhK_JrkL5jn5P1@infradead.org>
In-Reply-To: <Z4DhK_JrkL5jn5P1@infradead.org>
From: Travis Downs <travis.downs@gmail.com>
Date: Fri, 31 Jan 2025 17:06:50 -0300
X-Gm-Features: AWEUYZmTObX6fGSyQ7ZMMALbKek-_ziJfPE94STCjadBypwFlQ20iwcySk9MIbg
Message-ID: <CAOBGo4y_zo08BX=hRYsAQrdSfaLfn2kMci+Jk1R+B1-kjzsX1g@mail.gmail.com>
Subject: Re: Semantics of racy O_DIRECT writes
To: Christoph Hellwig <hch@infradead.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 5:58=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Thu, Jan 09, 2025 at 10:51:19AM -0500, Theodore Ts'o wrote:
> > For Linux, if the block device is one that requires stable writes
> > (e.g., for iSCSI writes which include a checksum, or SCSI devices with
> > DIF/DIX enabled, or some software RAID 5 block device), where a racy
> > write might lead to an I/O error on the write or in the case of RAID
> > 5, in the subsequent read of the block, Linux will protect against
> > this happening by marking the page read-only while the I/O is
> > underway, either if it's happening via buffered writeback or O_DIRECT
> > writes, and then marking the page read/write afterwards.
>
> This only happens for buffered I/O, and not for direct I/O.

Thank you. To clarify, "this" means the RO protection, right? So in direct =
IO
there is no such protection?

>
> But that only matters when your operation is inside the sector (LBA)
> boundary that the device interface operates on, e.g. if you using 512
> byte sector size as long your stay outside of that you're still fine.

Sorry it's not clear if you are talking about the buffered or direct
I/O case here.

Also, my problem description was not clear enough. I made it sound as if
we only concurrently write to different 1k blocks than the data we care abo=
ut,
but there is actually no such alignment: we might write to adjacent bytes o=
f
alignment 1.

That is, we may write bytes [0, 777) of some 4K block, then send it down fo=
r
direct IO via io_submit, and before that returns we may write the next regi=
on
[777, 1234) or whatever. So we are definitely interested in the case where
there are writes within the same 512-byte sector.

>
> BUT: that assumes device checksums.  File systems can have checksums
> as well and have the same problem.  Because of that for example running
> Windows VM images which tend to somehow generate this pattern on qemu
> using direct I/O on btrfs files has historically causes a lot of
> problems.

So is it fair to say that for direct IO these types of racy writes are not =
safe?

Specifically, we are looking at behavior in a 3rd party, proprietary
block device
(implemented as a kernel module) and are wondering if these types of racy
writes break the implied or explicit semantics of safe direct IO writes.
