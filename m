Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2965D372052
	for <linux-block@vger.kernel.org>; Thu,  2 Jul 2026 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993245; cv=pass; b=CCFysHbU5p1ejEevaiLqn/Lgq7e0AvhEAqGJ3tBKp5W8JoA99b5d+YysgyxDbdiBQgUgL4d4U5Po+NWPFDcqvCArpgw7B6KqNhlrXlga5Zdq1j3vvHmxjKUJ2OQM6LYOoDkuWXfShIsrcHsD3dXT03oPL9DVcnJu0pNqtUtpUHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993245; c=relaxed/simple;
	bh=cTB0VfE1d+0Ee/RoWGncspUgiGZBeynSuwaTByL01zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Slqp5l/8CGqc2gEPv45GO64dkMoG9Q9FLNGGgD96GmP2aqym8ku4+BG4QHqjv/fvFIC3johQ3nFNWONOmOIFLG+iuNUkAc3BcBg/AQ8PO7NNYOq6PVM9Dj2wg/gr1PpDwmy8mNKlNX8cQaEHPXbaUIPdGsp8ux9TEL8/k6hbzFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ptu5xhGF; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptu5xhGF"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4471b489240so519630fac.2
        for <linux-block@vger.kernel.org>; Thu, 02 Jul 2026 04:54:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782993243; cv=none;
        d=google.com; s=arc-20260327;
        b=kPAb9q2oDRiIWCMhRXLsiMdv/vIUsac+UhPtNKlhnV4EQzGW2edlSnkhi8WFgewBEN
         vE5IEdvpVQ8/YInTxOyVWQ4JAP1psegTJjMrDWqopT85Cy+Y872W2Gv8SzOTbaV95wmN
         nCbGr/lwd4fPioGvHndJEEKmutNUa3U4ZYHUH5LOkeLWqMGXwmed4ZEPF5E+mWCj1ff2
         /tGOt5ObCQh2gZB+0YyowO+JF+xV7OSKAIKXuUvHO/1unC87zlcB7Jijrahe53izxLtE
         Kf7LzJsNrIx3pm9ypu//nnHMUt4FQPcrBmUhdUToMGRml6GIOoS7hI9uFKckqSd0VQFa
         Q/eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cTB0VfE1d+0Ee/RoWGncspUgiGZBeynSuwaTByL01zg=;
        fh=w2IGoGkJSP6MwrI5O148XD8JZwaBUgpQFyIk6iALmm0=;
        b=nhlMbD7iSDEssO7OJwjYfmSQxhVAWmrp09YVTNw3tS+D8zPb+I0RC0YF2UyWlro5Ep
         LCDPceoAYmkNJ0JaavqvGZJ9BK+dIF0mN3bHIqjwMRtNXSOViTzolXlfYN0Emd/DrDc6
         y7hQBKE75eUfueZSJfuXijKUgTQNmRUpvQWYTNdAxt7gkVhQV0OnE55LfwuM5IyMp0g2
         skTLaAU2QZd3RfLoflst47tw11W0/hfTCoR5HLbEj94WtZaqV185tCzH/g/ZxArDrKRe
         H2VQS9TimcqeCX0powinMgA84M9PjI/7x1Qlv2086os7VQLflWw1eqlMD+GCsawzw9jz
         XHww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782993243; x=1783598043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTB0VfE1d+0Ee/RoWGncspUgiGZBeynSuwaTByL01zg=;
        b=ptu5xhGFnnSAyB/KDyUKfspPU8ipZZlioX7mnDtozkAUrgTOli3ZEiOJ3pz2lBuEn6
         oE+fQ308/mFFF/dbZJ1SVktkq7jQ2ZqvBQQfL2zkw1Vz9HalL/zIfW3CJ3VWXZR+e7NH
         H/YEDCu6nrOycCwwMHL/0cugd4lfazh1NiOzefbilnHmUQXft/ruGlZwjrd0PW5ydijF
         cm2gx74RRg81quHG80PHeT1mg0vZ+kXwuHGFGMF0yk3rvGEpff1A0ji3KF3RWPEZckj/
         kUm5RLIlh8aKb327EqXh2MicWhNY0OHmCljs+hGyjxakADKvKnwVhkbAbSKJbNiG99Pk
         sjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782993243; x=1783598043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cTB0VfE1d+0Ee/RoWGncspUgiGZBeynSuwaTByL01zg=;
        b=QoNhlhiBKt6ta9/aUFTGvE/6ZJQuGHrAc1gODgdcDXKjt6DR9Lb57Gf5Ky34CoJ1Qe
         2YDkp5sJXsIDfmmmE3vwzHfvnFBO5IoIBg8r90DfirTdZ7rPt7BtQGNPiTLc9pb282yD
         7rJJ5KFCYK/WSSLiLyEMwXno3H2/NHUCqlwVutCuynm72hMm5V0r9GQdFAgMCOknvFmt
         apACZ4Ewzi1xEOnL4U8iwH20dgfJebbZD4MF/26L/qTjSop+9B+gGVKJgKnVDX3yWKd7
         hS5Et/RWYC+4QdgEZnXPuD5TXfElsw/8TlYF4qYcpCCD8XVgnY0RT1lKKzAK6Dmv0vbt
         cdPg==
X-Forwarded-Encrypted: i=1; AHgh+RqrGRvJwWFbrY7a2Sr3XGwi/wL7ZtwI9z6CzjS10f/HaJRnzMiv7i4JOU3c/2KHKEHIyPJZrbKK3F9DdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHDzwBX1Hk1g7qXCjfuZDQlSYx3nPpn23pw5NdcKdU1puA60G0
	AJ5ouKxzgqds5b4fGF6DNsi2tdv7ODhKT7MIo5BkzqMlemssXG7khRIKUhthv3ArpaOBYXCHqpG
	9C+0jFuE2djeAH4nZGnMjJkPhyZOdKFPVXg==
X-Gm-Gg: AfdE7clcMpgK30CHX98qrdjc6wjKOSRaa9LWCnCKZT0O2dHngYRG05LwqRDB+sbyAFP
	UGvvYO8V4ht4QQ8PV2iaeLsTz47N93wIrztxG5b1FQLRMG7jNVtrPGr43AnNjZEFfc9YnLv9eW9
	BK4C4ySV+Nq/dNuKZaQc4iINL4XbRxBSmcSjjDaZ8npOu+xkBGELRKzAJfrkkTR0qwFulwtsH5n
	AQpsIQU8xl3SsMahgCSMlvYBFEZo6zAZUQr47eo5QMw0iuVpjwWNKw9Kbq9nk0KMpxWlXewFegl
	+J6SHPwhAWNtFvbDjYQaULQhIvUSvLyBUmI1wodqN0pQcbrHdn/qwxK7xJP5bHSa+B/CzU/i
X-Received: by 2002:a05:6870:be86:b0:430:29c3:9d15 with SMTP id
 586e51a60fabf-44cab4f5ab5mr3404122fac.1.1782993242995; Thu, 02 Jul 2026
 04:54:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630211827.50475-1-alhouseenyousef@gmail.com>
In-Reply-To: <20260630211827.50475-1-alhouseenyousef@gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 2 Jul 2026 06:53:51 -0500
X-Gm-Features: AVVi8Cdlh0ezi0CoH7M8cV39VtUoYE332zrI4qf4X3qdabNfMGHbBorQKkIEf8c
Message-ID: <CACVXFVP7Dn+y=mpX1MYH9CCbC=EcTO=2VcFOZjoaqpnT5XXymQ@mail.gmail.com>
Subject: Re: [PATCH] ublk: snapshot batch commands before preparing I/O
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Caleb Sander Mateos <csander@purestorage.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+1a67ee1aa79484801ec6@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 4:18=E2=80=AFPM Yousef Alhouseen
<alhouseenyousef@gmail.com> wrote:
>
> The batch prepare path rereads its userspace element array when rolling
> back a partially prepared batch. Userspace can change an already
> processed tag before the second read, causing rollback to reject the
> replacement tag and leave earlier I/O slots prepared. The
> WARN_ON_ONCE() in the rollback path then fires.
>
> Copy the bounded batch into kernel memory before changing any I/O state
> and use the same snapshot for preparation and rollback. Commit and fetch
> batches retain the existing chunked userspace walk.
>
> Fixes: b256795b3606 ("ublk: handle UBLK_U_IO_PREP_IO_CMDS")
> Reported-by: syzbot+1a67ee1aa79484801ec6@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D1a67ee1aa79484801ec6
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>

The fix looks fine, given the copy is only added in prep stage, which
isn't part of fast io path:

Reviewed-by: Ming Lei <tom.leiming@gmail.com>



Thanks,
Ming Lei
