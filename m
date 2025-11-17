Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFA6481CD
	for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763387844; cv=none; b=iJVrYvhUxxbM5Ct/oPt7bIbUklLAwGp+Iy6e+SWZMF4Edsqow3btaAx4uNGuVPJKVEtN6qUR1dpkYyZ9xMB/0rnvcQgxxIQJM1qnPECiD3Rrps4LgDFQvk9iaAnbXs0k+WcUwKw7zw5U46F5RFOzB/tz8U61Tha399bRLxY0xws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763387844; c=relaxed/simple;
	bh=e6cMsWJEGKLkcYhSmav6zttIyQpWjj1wJEGJQ9V8cpM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pvxcCWaSqbXFp62EVx7E7+o/xlXt/Aj+YlQapaAFz/fEW+OrBk0rENytmrNBROA8TE7puP8uwQZlkI6ZBbeEkA2X07CkaLGMr1sPpP4NoTk6mvk/ovOyNqeMgv551b6jB7oXSM3cT1mjRhiV8bLpdpReukE0r9yng6+865/PpHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=XjA7QL/l; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="XjA7QL/l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:In-Reply-To
	:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=co/RvmCclUG6bm1up2O4GSX5tfB4UTz9zXPDBpGkc+E=; b=XjA7QL/lBbraTbThEkafJePvdw
	z/Wt6S892UVDhkM34ycJN9HeXuaObBJooI8WQ1MZ1/Br4I3HCTn+eqp4zjbgQYtWZrWT/I6/DMGyD
	ijhZFxbLz1EHb31KE9msAHzUAaVTVhdSj21uOpExelAoZjThvbMGYM5/TsYT/vQ2jRPW8gNpMQ8HQ
	vGK7CbRaFrgcwoRWeiEQbDseumy2/OwwW2S9qlG9pXc58iJRxhEAXPjdrWksGKtIjmxVjWfSNWw9/
	Qzn9/0oigDBX85bxd6uMRNJjnrRz6Pf7v8tjcI4OOZzdqYZXJALwoDX42W0tzO30l/Bii3LeCFA83
	5l6Z1Nig==;
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH] fix floppy for PAGE_SIZE != 4KB
From: =?utf-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>
In-Reply-To: <c8cbccc1-964c-43ce-a992-624d2efcfd4a@kernel.dk>
Date: Mon, 17 Nov 2025 14:57:18 +0100
Cc: linux-block@vger.kernel.org,
 efremov@linux.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <AB0440F0-7D27-44E4-A92A-D7761E062A76@exactco.de>
References: <b1e17016-3d4d-4fac-b5b0-97db357d0749@kernel.dk>
 <20251114.172543.20704181754788128.rene@exactco.de>
 <fec67c88-53f5-4482-aeef-86e1213d187e@kernel.dk>
 <20251114.192119.1776060250519701367.rene@exactco.de>
 <708B7962-86CD-489B-AC33-4B929F2902B6@exactco.de>
 <c8cbccc1-964c-43ce-a992-624d2efcfd4a@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3826.400.131.1.6)

Hi,

> On 17. Nov 2025, at 14:23, Jens Axboe <axboe@kernel.dk> wrote:
>=20
> On 11/17/25 2:56 AM, Ren? Rebe wrote:
...
>> Any chance we can get my initial one liner constant PAGE_SIZE fix
>> for this over a decade old bug in? I currently don?t have a budget
>> to refactor the floppy driver probing for efficiency on bigger =
PAGE_SIZE
>> configs I?m not even having a floppy controller on.
>=20
> Yep we can do that. It'd be great if we could augment the change with
> what commit broke it, so it can get backported to stable kernels as
> well. Was it:
>=20
> commit fe4ec12e1865a2114056b799e4869bf4c30e47df
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Fri Jun 26 10:01:52 2020 +0200
>=20
>    floppy: use block_size

maybe, but I=E2=80=99m not 100% sure. Probably not the best answer
for kernel driver development. It might have been broken in
other ways for over a decade already. I would need to debug
that to be sure, but then I could also see if I can make it easily
work without changing the max size constant, ...

Thanks!
	Ren=C3=A9

--=20
https://exactco.de - https://t2linux.com - https://rene.rebe.de

