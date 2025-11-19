Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F93523817E
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 09:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763543563; cv=none; b=A83fXBKBdqxK0EmY8g/anImrcOMR/8r8nQrlqNwtksLp92Obm+YbfUxMaT6sF4jbohySifno65tleyGrtyLZxgMn0nRtnSedG1Xu3WJ8uHTZ8OF0b7Y7hATb6BCMX/XjXfBVstahNrkmd+O+/VGWx1GRIV03xczVJLworjadrik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763543563; c=relaxed/simple;
	bh=Le5H8Vw2Mx67uBgRdT4qfYFRWDAb2fm3GmU0Ki+UpdA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eKQoLDMGq4MZGUxQ2k/Jdsihec4c14cQmDd20I/XafBZaYmPyfeLZChoVB19t2O/8IyxEXO3MG0jq+zi1XAaFQXRAlO6jy/pmYTqcIFyzfm+AwGS2siE550tuw2TpRp2Iw1wyuoBDu6Gqt7BGBEVZwyrZJlimolrHBsmiEYW2lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=wX9pYtVT; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="wX9pYtVT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:In-Reply-To
	:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MeGsgPPm3UdyebZ/EuvOMyFFKVaF9N+kSNb60SJV8zM=; b=wX9pYtVTmyW5IjhwYzz0nOMvHJ
	4xcucEyWfinogJ8RE2rgAtyX/7t8dwjGr9aBQ0jA9pOwX4s1yEXilhB1OjqXDt7/q6smJ0UC9TRr9
	BbYrzyTMW1nEO+Pe0UCXrWodO+K2A5C8jad2qwSgJenN9RHkViHA4XgzKlWiZPlYseYAIWOkfKtxY
	sNht32AZ8x/X49mlXc/n3uuOyQwKdVZXqh1+W7/6abmlEDoxP8VgjQuhciMYcAgaVyxmSPknnOyNc
	H2lJxchOOS2z4eLRDGEZGOaPsAbABV0+jaLraWPVP1K/cyznmzyy2S9qPfhHOLUbnNr4cfFFAxjuk
	slK+zbMQ==;
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
In-Reply-To: <57be21424d0e23142ea67ca9de3ca4ca033e1ee7.camel@physik.fu-berlin.de>
Date: Wed, 19 Nov 2025 10:12:38 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 efremov@linux.com,
 Nick Bowler <nbowler@draconx.ca>
Content-Transfer-Encoding: quoted-printable
Message-Id: <900D7C37-DF73-49D5-950D-81D84D6DA9CD@exactco.de>
References: <b1e17016-3d4d-4fac-b5b0-97db357d0749@kernel.dk>
 <20251114.172543.20704181754788128.rene@exactco.de>
 <fec67c88-53f5-4482-aeef-86e1213d187e@kernel.dk>
 <20251114.192119.1776060250519701367.rene@exactco.de>
 <708B7962-86CD-489B-AC33-4B929F2902B6@exactco.de>
 <c8cbccc1-964c-43ce-a992-624d2efcfd4a@kernel.dk>
 <57be21424d0e23142ea67ca9de3ca4ca033e1ee7.camel@physik.fu-berlin.de>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
X-Mailer: Apple Mail (2.3826.400.131.1.6)

Hi,

> On 19. Nov 2025, at 10:00, John Paul Adrian Glaubitz =
<glaubitz@physik.fu-berlin.de> wrote:
>=20
> Hi Jens,
>=20
> On Mon, 2025-11-17 at 06:23 -0700, Jens Axboe wrote:
>> On 11/17/25 2:56 AM, Ren? Rebe wrote:
>>> Hi,
>>>=20
>>>>> 64k is 4% of a floppy disk! But I hear you, works for you.
>>>>=20
>>>> Again, still only 8k or 16k for most of such remaining workstation
>>>> floppy users.
>>>>=20
>>>>>> But if someone wants to refactor this code some more, ... I'm =
happy to
>>>>>> test it, too ;-)
>>>>>=20
>>>>> I don't think refactoring would be required here, it's probably =
just
>>>>> capping that probe read to something constant irrespective of =
hardware
>>>>> page sizes.
>>>>=20
>>>> Well, the floppy.c __floppy_read_block_0 does:
>>>>       bio_init(&bio, bdev, &bio_vec, 1, REQ_OP_READ);
>>>>       __bio_add_page(&bio, page, block_size(bdev), 0);
>>>>=20
>>>> Is there an easy way to limit that to less than a page without
>>>> refactoring it too much? Otherwise we could just apply this hotfix =
for
>>>> now.
>>>=20
>>>=20
>>> Any chance we can get my initial one liner constant PAGE_SIZE fix
>>> for this over a decade old bug in? I currently don?t have a budget
>>> to refactor the floppy driver probing for efficiency on bigger =
PAGE_SIZE
>>> configs I?m not even having a floppy controller on.
>>=20
>> Yep we can do that. It'd be great if we could augment the change with
>> what commit broke it, so it can get backported to stable kernels as
>> well. Was it:
>>=20
>> commit fe4ec12e1865a2114056b799e4869bf4c30e47df
>> Author: Christoph Hellwig <hch@lst.de>
>> Date:   Fri Jun 26 10:01:52 2020 +0200
>>=20
>>    floppy: use block_size
>=20
> Yes, Nick Bowler (CC'ed) bisected it to this commit in [1].

Nice, thanks!

Carefully, it appears to be another commit though:

> I bisected the failure to this old commit:
>=20
>   commit 74d46992e0d9dee7f1f376de0d56d31614c8a17a
>   Author: Christoph Hellwig <hch@lst.de>
>   Date:   Wed Aug 23 19:10:32 2017 +0200
>         block: replace bi_bdev with a gendisk pointer and partitions =
index


Ren=C3=A9

> So, I suggest to add a proper "Fixes:" tag so the patch is propagated
> to all stable kernels.
>=20
> Adrian
>=20
>> [1] =
https://lore.kernel.org/all/u3aaz4bx7xwlboyppeg4y3eixzgxbcodlmw7cwqloskmg6=
oqw2@j437p47sfww6/

--=20
https://exactco.de - https://t2linux.com - https://rene.rebe.de

