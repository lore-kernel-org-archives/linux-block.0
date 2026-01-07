Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB0331AAA3
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767791157; cv=none; b=jxbajKG6UI/1yU/4SkuXmeh0Cn8wMbJ4aWlGuTpnOfpJ4BuJFHTjRKtaIOwlBDhEsMoQrBAGUunP0Ruke4VB2aK0DKqFTzYBIy9S1Om5F7SR0VAjrS3+ylbXP9nh4S7KRy+Ho73U9gFyLhZOcE+3opasOWIjk8Z1t9VyZHYhaeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767791157; c=relaxed/simple;
	bh=qzNG7uqiHdzI8ewoggig0HskK8lGgAMbdXIS/XZZpZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvuyXcvOmTEBwjaaLCo3zsERBfvvWBfGh7Gwo8z0ZLzduz54PSnGZ2B6bk2e9lDEYcYkGldbgkNrIPVL+fUaKD3/tCgzNpItUNc2bfVHOrP8u8IiFczo+ccFfU6qJzXQ77h4luQzdNt48ToPJ9v5tmxHOjToZVxqPmQBpBnUPmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E21x906k; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E21x906k"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-941063da73eso1336900241.3
        for <linux-block@vger.kernel.org>; Wed, 07 Jan 2026 05:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767791154; x=1768395954; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qzNG7uqiHdzI8ewoggig0HskK8lGgAMbdXIS/XZZpZs=;
        b=E21x906kuGsNhZ1wa36jAIlR7OUU/a9MFGAvKJbXbC/Axd5IVZKcYh7noOIcP3T4jv
         cYhAI5SjzwtqmxgwAphwUQL+BK5rMQ90hBa0+SzE6EF0tMhl1TVb6XaRccgCCCl1S/jX
         uSYgAcbgeNAu5BysKvHyXY+5wRLUBSx5dTMNvitzmL7w5Mk18QTAMa65f7A5sioZq0H3
         HDZvm2MDpTvgsg6EZLrzrcbBTNO1jtbhDMoJCE9XXpmgSwFK3LdHYk1QJXHPStNCnuqv
         Mu8PDMoixIwANSbLiULnhOf8VbDZ39gBuIh5r2rgiujAG0Mi9WmYKwZOBHYIKqI81bAq
         WIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767791154; x=1768395954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzNG7uqiHdzI8ewoggig0HskK8lGgAMbdXIS/XZZpZs=;
        b=seVhe9JR5tTR3YasKacKHp8A4wKjXq/PDEPBMCilTq0sZ/7ReJlSbpdb3ZiVTCosDE
         mX5AK+Whegg2jYqoOTChgkLDBbe/2UxgEXWiPxCYCj/UfeIKAx6fu1HngVIkezW3Q7eT
         R/YoIzalDsHuTyjiuzISDw021lIRQD7DCTkwLiUkTa9yDKlvMPGG71CzoeLBVb8nCYEE
         fBqR1/iLE4BOFKvlnXwHsldEwt5BWji/zqagR168Jqxpc0a+F7r/sutJmGbsggNCDhaL
         kWEtG7nGttQQSBHSPOJpk2UN+SEQjwwaJkl6ni5HiiIktR/4glDXvTks+p66iQjeYclp
         MoKg==
X-Gm-Message-State: AOJu0YxL2+5T2+/VvICsYOPuiti5sJ92SL11HgU16mkyB5948p4/j/lM
	BT/M4bJGWVVdndq2a8X54yd2pfJuYt/WB7K/f10lEe7SU8XukaQlPTWcSev4gKiVa+bXmf+Bw9A
	GttfO2dnEKH2odZguUov7L8+mNsc9ySQ=
X-Gm-Gg: AY/fxX4inQu3441ovwx4ZxxG0/HhCRLmneCRPArejpMtPhSXpgyf2VT5s8D38peN8Uo
	dZgBq1XKh5dr0bfBZMtsKS/teU2agrvvCY/phnvSjCbelHLUg8plb4xhNN0jEevEFxBJh/qllxF
	wu4CZN1zhOFesqS2Y3nM4AH5KfrSyVAtITbEsDJw9kFkj9dQO72k8x4bACayOYphAPHPurhgfqa
	fzZZhDQe8j+JFD7Yg0lN8zJhTz4eUJaU8n42jGf3pbOVKlvOPnbOKDA7MvTEaw+bSOdaP7VvV1l
	OD6PhSWyAbigFGyo8b5ZLypmHx75
X-Google-Smtp-Source: AGHT+IFnNlNo6WDhAIrQsE84p6Xjc9YulduAvY+W3lIyNrnjsdyAHz3l5KS7q1vQazIQ+gufafyHW/niyaYPbQ4u/j8=
X-Received: by 2002:a05:6102:3710:b0:5db:f5d1:5799 with SMTP id
 ada2fe7eead31-5ecb69056c8mr956926137.33.1767791153625; Wed, 07 Jan 2026
 05:05:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224115312.27036-1-vitalifster@gmail.com> <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
 <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com>
 <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com> <CAPqjcqpPQMhTOd3hHTsZxKuLwZB-QJdHqOyac2vyZ+AeDYWC6g@mail.gmail.com>
 <6cd50989-2cae-4535-9581-63b6a297d183@oracle.com> <CAPqjcqo=A45mK01h+o3avOUaSSSX6g_y3FfvCFLRoO7YEwUddw@mail.gmail.com>
 <58a89dc4-1bc9-4b38-a8cc-d0097ee74b29@oracle.com> <CAPqjcqq+DFc4TwAPDZodZ61b5pRrt4i+moy3K1dkzGhH9r-2Rw@mail.gmail.com>
 <704e5d2a-1b37-43c5-8ad6-bda47a4e7fc6@oracle.com>
In-Reply-To: <704e5d2a-1b37-43c5-8ad6-bda47a4e7fc6@oracle.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Wed, 7 Jan 2026 16:05:42 +0300
X-Gm-Features: AQt7F2oYpr1KySfJY9yrBJPS500_11WcpTTT3dSzcpl_rsbFoDQJth87qlW7Iwo
Message-ID: <CAPqjcqqhFWz0eNGJRW-_PoJhdM7f-yxr=pWN2_AfGSP=-VpyMg@mail.gmail.com>
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> What is the actual usecase you are trying to solve? You mentioned "avoid
> journaling", which does not explain what you want to achieve.
>
> You could arrange your data so that it suits the rules.

I can't. My usecase is a distributed ceph-like SDS based on atomic
writes. Writes on a virtual block device have arbitrary length &
offset of course, nothing like 2^N, like on a regular block device.
Atomicity is implemented through journaling (double-write) on disks
without hardware atomic write support.

Then I found the new atomic write feature and SSDs with support for it
and implemented a new storage layer which can take advantage of it. My
new storage layer has write amplification about ~1.0 with atomic
writes (i.e. almost zero overhead). It's a huge improvement for me -
the old storage layer has WA from 3 to 4.

And everything was fine until I finally deployed it with enabled
RWF_ATOMIC (production setups should use safety features) and stumbled
upon the 2^N restriction... It was a big surprise, I never thought
that such a limitation could exist. It's absolutely irrational - the
device doesn't have that limitation and I'm just using the raw device.

It's normal and expected in the context of simple file systems like
ext4 and xfs. But for the raw device... I only discovered it after
several days of investigation with bpftrace and after reading the
kernel code. It's really unexpected. I think anyone expects the raw
NVMe disk to have the same requirements as it's described in the NVMe
spec.

> The atomic write API is based on:
> a. doing statx to find atomic write min and max limits.
> b. issuing a write with RWF_ATOMIC means that the write should be
> naturally aligned and fit within the size limits.
>
> That is the same for both raw block devices and regular FS files. And
> any atomic write boundary is not part of the API.

For raw block devices, you also have sysfs. You can look there and
determine actual restrictions. In fact I didn't even know about the
statx API when I was implementing atomic writes, and I don't use it.

And speaking of that API, why does it have to be like this? Currently
it looks like an API designed around existing internal restrictions of
the implementation - of two implementations more exactly: ext4 and
xfs, both of which are classic non-cow file systems. I suspect that if
it was primarily designed after zfs & btrfs then chances are the
restriction wouldn't exist.

Ok, it's already designed like this, but anyway, if the user is fine
with statx and with the 2^N restriction, then removing the restriction
for block devices also doesn't break anything for him. He'll send his
2^N aligned writes just like before. It's fine for databases like
mysql & postgresql because they always overwrite a whole fixed-size
page. But even speaking of databases, it's not guaranteed that **all**
databases will always have the same layout and that arbitrary atomic
write offsets will never be useful for them.

So again, can we please remove the restriction for raw block devices?
I can re-submit the patch :-)
