Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B002F5332
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763544267; cv=none; b=PF7xp7EmCtGQda+PUcxXE3EalfoMs4ugcchsbh1zNx52I4ZU/eA5mfS8deydbkWR6da7OE+0yKggWnAVmRtoUXgd5YFih5+5zzPEdC+pro/n71MSgkke15DFar6KrRXGLv/581smYBBqkwpnH3K7pQhI/daum5DVmETaMF18XHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763544267; c=relaxed/simple;
	bh=A/YbrX7Nece/aQqAAYJa8NW35ANT3RkEPTuMGrcXrxE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eRPYo42HB8DURhus/qvBnzUwmYZBuef60/KFvV246Ici/UJYuCoH+mXkgc/oifTUEQDTIb+q0BdVOBumU4D/k3eU+6xZK2Lt7tVOvCwaMTp60cNNgfiKtSWIEM+qUNFURUomSjxp+3HL0LmOrwOKYIhfxE1Le0A5Yfqt33TcQZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=o63Xk2O8; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="o63Xk2O8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:In-Reply-To
	:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2MPa91mXMDwUky2x4JD3NQGE7KuFbGDdg5+CBd03CaM=; b=o63Xk2O8rVtlZUBx48PwjZm9ze
	bG2uWcEa1JE6I7jfyBK0mg5RamkNv4J3VPLGAD/2fkN7Zq+cdx47A+7ZWLofhIFzgx2OCzCJ1XjX2
	dBQk0/zmhLnnQKnEYYFf6TpocUpw6JYkbrpnm8nGjbDXyPwb9Kza61g+Qcaj02gI9VIjH6TANpH3n
	pFC39aR4VP9HEmenk+wxtI/0/q+vBP3mRGsZFf+JFUzcz/EN/YKfKncXIKyzZ7+XKz0j9dlpZGDe8
	fjhGRVC+WYDpVQZcFDh1Pc9EFEQ/v6LhxNvRwaz+ZtU8UmUpiB96ltzNw+52Glr/f1tFugM5vuVWn
	3+IuUD4g==;
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
In-Reply-To: <4d3482372549a7746c639299c50319bad6b4b6c7.camel@physik.fu-berlin.de>
Date: Wed, 19 Nov 2025 10:24:20 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 efremov@linux.com,
 Nick Bowler <nbowler@draconx.ca>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1E5D751F-0DCE-4AE2-9DC5-4D9EF0D8FA8E@exactco.de>
References: <b1e17016-3d4d-4fac-b5b0-97db357d0749@kernel.dk>
 <20251114.172543.20704181754788128.rene@exactco.de>
 <fec67c88-53f5-4482-aeef-86e1213d187e@kernel.dk>
 <20251114.192119.1776060250519701367.rene@exactco.de>
 <708B7962-86CD-489B-AC33-4B929F2902B6@exactco.de>
 <c8cbccc1-964c-43ce-a992-624d2efcfd4a@kernel.dk>
 <57be21424d0e23142ea67ca9de3ca4ca033e1ee7.camel@physik.fu-berlin.de>
 <900D7C37-DF73-49D5-950D-81D84D6DA9CD@exactco.de>
 <4d3482372549a7746c639299c50319bad6b4b6c7.camel@physik.fu-berlin.de>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
X-Mailer: Apple Mail (2.3826.400.131.1.6)

Hi,

> On 19. Nov 2025, at 10:22, John Paul Adrian Glaubitz =
<glaubitz@physik.fu-berlin.de> wrote:
>=20
> On Wed, 2025-11-19 at 10:12 +0100, Ren=C3=A9 Rebe wrote:
>>>> Yep we can do that. It'd be great if we could augment the change =
with
>>>> what commit broke it, so it can get backported to stable kernels as
>>>> well. Was it:
>>>>=20
>>>> commit fe4ec12e1865a2114056b799e4869bf4c30e47df
>>>> Author: Christoph Hellwig <hch@lst.de>
>>>> Date:   Fri Jun 26 10:01:52 2020 +0200
>>>>=20
>>>>   floppy: use block_size
>>>=20
>>> Yes, Nick Bowler (CC'ed) bisected it to this commit in [1].
>>=20
>> Nice, thanks!
>>=20
>> Carefully, it appears to be another commit though:
>>=20
>>> I bisected the failure to this old commit:
>>>=20
>>>  commit 74d46992e0d9dee7f1f376de0d56d31614c8a17a
>>>  Author: Christoph Hellwig <hch@lst.de>
>>>  Date:   Wed Aug 23 19:10:32 2017 +0200
>>>        block: replace bi_bdev with a gendisk pointer and partitions =
index
>=20
> Yes, you're right. I was briefly distracted when writing this mail.

No worries, just checking. Should I send a new patch with the Fixes:
or can Jens just add it?

Thanks,
	Ren=C3=A9

--=20
https://exactco.de =E2=80=A2 https://t2linux.com =E2=80=A2 =
https://patreon.com/renerebe

