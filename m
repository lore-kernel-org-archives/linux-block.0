Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0A5BE5E
	for <linux-block@vger.kernel.org>; Thu,  3 Jul 2025 02:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751508885; cv=none; b=p9MoAhNfeGcummvPMBycN5ZBDw0gKPFMag9giagP4GCw8/PTy7PKtMzwR7/qtZYD5Wpevhps165Z5my1/26UPAbe/qxwZ2370vrX+yZLEMCzvrrhQHTZiAiAkvgRIAzzeBqNNmY3eu0xS1c+3NtceTd6635lMXqHBXB7kuNJxJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751508885; c=relaxed/simple;
	bh=oCqsm9LL/Jf9vB9VSzvQ1odPkBlfGZ21ZVGDGILtbwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sSrgBvpe0A8qyN/FzcJNeg0MVZ3GV3tzhhsML1g22Lez431cxP6Jtmg7tc09DORj0hph8hE8VwciDdPMO+shl9E7vqx0ieKN+aB7xMJQZKfwbLKuNwaq2B5U+QLkn1vOel8pBBf2BDlIjD6+Oq+9l5SQyOAU/qyxQg/aY6NSa5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fgZGzeEJ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fgZGzeEJ"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-313fab41fd5so1635011a91.1
        for <linux-block@vger.kernel.org>; Wed, 02 Jul 2025 19:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1751508883; x=1752113683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCqsm9LL/Jf9vB9VSzvQ1odPkBlfGZ21ZVGDGILtbwA=;
        b=fgZGzeEJ+7KDvatBckbBYrkDF/d90p8BWl78mJj83Grc1ZWVECxVQu09lUXVqV6lrf
         eeLMnLriUO06lyQ1LiRkcrcr8nedponjX/bSjYUkRIGj10qYiDJu2KiaAWbOvy5YmC3n
         Ue9VuNbBWACfZsEbtxogj+ibQwkYxW5+87DjvHnLRJS0wGTT+tlzZwVpiS98TFJ371RU
         lJOUXWvwfM/z2SR85G9ysXQteS0tFtMfu8ZKyphVWCPWt3mZAGHyjHpQRsU1hKPo7QXF
         KaQPNBOv80xrep5qHWGGfOfIc5tW2pD/Bzjes/ycTv6C9cGYQMOx+fMKcHHpHH7J8bEp
         uFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751508883; x=1752113683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oCqsm9LL/Jf9vB9VSzvQ1odPkBlfGZ21ZVGDGILtbwA=;
        b=E7zpUZ5Vo5QT7a/aYzji2qHJP99HIFTRq8TPcJixfnzppim/OG7+HRJXP7Dg6rax9P
         CgZe6feTpF+IBLtDk3ELUUTRqKfxF9YxkdbQ/mVSzwrfpQPTlVbzaCorVMdwCK3FyKIy
         XA6POUXpyYZELl5Fk67I9MJOZRSzTYOdDRN+lRoL841IJIN5BsKzbsIsoO07UmbAPjMK
         iJGH1ieA3/aPUbxsn4Ux/T0m7NKBiBX8ngjwnaXFkTZ7nLUqO5ca4GClHS4ilYCb5BtW
         BAUA/4z13Z4OgDceq7JOCgr36zaLciTd9n+jO4v6CCW2UUn79Udh2kUN/o9cygteeT3C
         WzCg==
X-Forwarded-Encrypted: i=1; AJvYcCXrsW9qKsj5Y8+MAmPsmezJTsIuhq+tNwNN/YUp/OQIZOeuJhHBwybfuHACxu9Jf+72QmxLcrvwTLwvpw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw98l1nWlJFjSNh4x7TqhTBGccS1W6ZEOkEIF7SjBUEhCv5ki5n
	bcnPMlEYfCC7a9MCCAy4FJN3Ica5fB4o/53GCR1tlElcHnkBnm41vf28T8skPyV4f+BR6tvf6oU
	PVwH+8BW2dHZrQT2elyQn0+MIXOQfN/QMPUF32n4WUDR6m2jQ+qrkymk=
X-Gm-Gg: ASbGncvbSuyJPQzpIcCHcNK5CYemszN7C9YuJxRJnrd6XLarlgJfO3DffRTMZw155K8
	1gsNwHGS9Z3Ah5lYkhg/QQIsTpHCle7sDULZDDD38TdeW1sShmlY3GfGDaIAitIaWIMlYeKZuQ1
	+iDUsFrVVkIa5dJ8f2ZtijGRruyJHQBv+Iroz3w7iidg==
X-Google-Smtp-Source: AGHT+IH9oPegk/kN62jbfkzu+/wNPSokhsBihccbhNpBxiYfa6jVJ+R3Bk090x8ekWfWpOflexmFrVWq8mZY7+89fR0=
X-Received: by 2002:a17:90b:4cc7:b0:311:b0ec:135e with SMTP id
 98e67ed59e1d1-31a9f2bb6camr286396a91.2.1751508882716; Wed, 02 Jul 2025
 19:14:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dd82e081-a508-4b55-9ba6-36bbb54a2c2a@kernel.dk> <aGNBu1jngH4r-SZ4@fedora>
In-Reply-To: <aGNBu1jngH4r-SZ4@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 2 Jul 2025 22:14:31 -0400
X-Gm-Features: Ac12FXxXa0kdYyjRhMapU6pLcuMsEUQC58GbBtp1qDBxDzeVjS0TON6phU_1R38
Message-ID: <CADUfDZrg2POQ94G_iEKOBXzvd7XuMUZ7tCyALEjcrrp94NAMbA@mail.gmail.com>
Subject: Re: 6.17 block tree rebased
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 10:02=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wro=
te:
>
> Hi Jens,
>
> On Mon, Jun 30, 2025 at 04:08:29PM -0600, Jens Axboe wrote:
> > Hi,
> >
> > As per discussion last week for ublk, I've rebased the block branch
> > for-6.17/block to be based on v6.16-rc4 to avoid a bunch of issues on
> > the ublk side.
> >
> > For ublk, could you folks please check the end results?
>
> Thanks for the rebase.
>
> We have merged commit 4c8a951787ff ("ublk: setup ublk_io correctly in cas=
e of
> ublk_get_data() failure") to -rc4, commit c5adc2714c2c ("ublk: move ublk_=
prep_cancel()
> to case UBLK_IO_COMMIT_AND_FETCH_REQ") becomes not correct any more, can =
you drop it
> from for-6.17/block?

Indeed, I noticed this too but didn't have time to rebase my patches
before I left for a week. I agree with dropping that commit.

Thank you both,
Caleb
