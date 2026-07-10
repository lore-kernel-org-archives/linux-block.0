Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCC836A035
	for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.189.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783708012; cv=none; b=gztfV/39R6NJRlozyLoU5jaXr79xyGNPMLVpKm352T4LldHgnb49IGUdCPY44f3Ulno6pGAiJl6RzMtGDp2zIyCo5vyMYEO72Ts5OFbOnOCc5AYN6FfXblPLjdLz340bAEz+iWWdVw2UyZsBYqs5G5c18KDLSN2M6LBLj7wNVK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783708012; c=relaxed/simple;
	bh=FeruS8Mh3rSSZXQZKl/+GWMfVsLUxPvLMYvTB9HmVlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGkULuEghUGGfOx+9bwzg7IiecTePRkUSWP4vHfybLxDuQLAtRsL/lXpsXTWDVJr5R7ynnPJK1lr6SodM0U4RVDn5nFuskxgEWrGUAiBuEME7uZVU5z9aBzC5bs3HLCDwacs2ipO56XbWX35aavclbIWNNKVkXjF7PpbLQ9SE/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org; spf=pass smtp.mailfrom=archlinux.org; dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=mKhhA2DS; dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=gPart2Tn; arc=none smtp.client-ip=95.216.189.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinux.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="mKhhA2DS";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="gPart2Tn"
Message-ID: <35646ff9-eea7-4c02-a39e-a13362e70dd6@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1783708007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FeruS8Mh3rSSZXQZKl/+GWMfVsLUxPvLMYvTB9HmVlU=;
	b=mKhhA2DSA3wDHDdKUFXlkFwhVoqQdCFx5sZdHuLkenKoMZfEetB776PW3CwKk3+ltD5t9l
	c5hQNFQM4LmjjnDw+0L8knyS4rBbyt4ZOiSi9lfw9bDgFcpPzX25zIwTtXbUsSZbn1Sw3T
	Y1Qr7BJd/dZM0bCxqJiPyTpyaFlaAlo3qTD/lfzQqClIF1Dsy1a5IASSeouDJRLJ+JlzY5
	fLR4OVF4ESaktCWgD8WgzSZNAc2gVGdoqHDCzO06DCR8I9FSCAgoFeb3a7XBtCHBozcbz6
	KLz4nQpQMjuJYVmkhFRVOlkCr3o2/2I3CR+MN4CkchCFuXSelzR5TDxx0nFWwibX25ZXGJ
	ruvxOF53s1TdMS+TCKodbr40CIVU//Ju8HC9ZLoP6lFdBePKByvf0whBtuoDMp9t5eMQKv
	S9QkSNiK1sqQQZs37upKXIetWSC9vkEU9vFb7Cu7vdE8hAlGrVWxMKZO8q0FRfVt+yoHll
	UeKvhN11zthC96o01b6+pPTyg5ySrGdvK297x+0xMwnIc1F3ZGbB3CCueDXMQXgX5hYJSn
	vnXnkST7OnNH8Ioo09KPf2UloEsulERxmtmYX9E9hDjfGpQFIol6HEkz1nw3O1jEnUyyVU
	sxxr03Wt+N8qv8UtUZWVlG9iTh+VXRtqxjx80UOXmHYih0fgRSm48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1783708007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FeruS8Mh3rSSZXQZKl/+GWMfVsLUxPvLMYvTB9HmVlU=;
	b=gPart2TnXor8hpgmlhuvJiYol6djos+pjNDOuamJitqPdjdbZIV/mOQbMcNNttKqsmrXpP
	gYqp+nqmJheGOiAQ==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=svenstaro smtp.mailfrom=svenstaro@archlinux.org
Date: Fri, 10 Jul 2026 20:26:46 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [REGRESSION] commit b520c4eef83d ("block: split bio_alloc_bioset
 more clearly into a fast and slowpath") causes fsync to fail with pmem
To: Keith Busch <kbusch@kernel.org>,
 Sven-Hendrik Haase <svenstaro@archlinux.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 regressions@lists.linux.dev, linux-block@vger.kernel.org,
 Li Chen <me@linux.beauty>, Joseph Qi <joseph.qi@linux.alibaba.com>
References: <8a2b1abf-3c8a-4242-82c5-fba9943cf8f4@archlinux.org>
 <alE3PqhMQ63lBcWe@kbusch-mbp>
Content-Language: en-US-large, de-DE
From: Sven-Hendrik Haase <svenstaro@archlinux.org>
Autocrypt: addr=svenstaro@archlinux.org; keydata=
 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
 2+Dd0G7AznpgJHOb1rk=
In-Reply-To: <alE3PqhMQ63lBcWe@kbusch-mbp>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------jxsjzV07zEsQBuQazo1N1E8M"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------jxsjzV07zEsQBuQazo1N1E8M
Content-Type: multipart/mixed; boundary="------------BuOUWLOJIKKESrq4MelpZBBr";
 protected-headers="v1"; hp="clear"
Message-ID: <35646ff9-eea7-4c02-a39e-a13362e70dd6@archlinux.org>
Date: Fri, 10 Jul 2026 20:26:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] commit b520c4eef83d ("block: split bio_alloc_bioset
 more clearly into a fast and slowpath") causes fsync to fail with pmem
To: Keith Busch <kbusch@kernel.org>,
 Sven-Hendrik Haase <svenstaro@archlinux.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 regressions@lists.linux.dev, linux-block@vger.kernel.org,
 Li Chen <me@linux.beauty>, Joseph Qi <joseph.qi@linux.alibaba.com>
References: <8a2b1abf-3c8a-4242-82c5-fba9943cf8f4@archlinux.org>
 <alE3PqhMQ63lBcWe@kbusch-mbp>
Content-Language: en-US-large, de-DE
From: Sven-Hendrik Haase <svenstaro@archlinux.org>
Autocrypt: addr=svenstaro@archlinux.org; keydata=
 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
 2+Dd0G7AznpgJHOb1rk=
In-Reply-To: <alE3PqhMQ63lBcWe@kbusch-mbp>

--------------BuOUWLOJIKKESrq4MelpZBBr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCk9uIDEwLjA3LjI2IDIwOjE3LCBLZWl0aCBCdXNjaCB3cm90ZToNCj4gT24gRnJpLCBK
dWwgMTAsIDIwMjYgYXQgMDg6MDc6MzJQTSArMDIwMCwgU3Zlbi1IZW5kcmlrIEhhYXNlIHdy
b3RlOg0KPj4gSSBub3RpY2VkIHRoYXQgc3RhcnRpbmcgd2l0aCBMaW51eCA3LjEsIG15IHBt
ZW0gdm9sdW1lcyBpbnNpZGUgb2YgUUVNVQ0KPj4gc3RvcHBlZCB3b3JraW5nLiBNeSB1c2Ug
Y2FzZSBpcyB0aGlzOg0KPj4NCj4+IHFlbXUtc3lzdGVtLXg4Nl82NCAuLi4gdG9ucyBvZiBR
RU1VIGZsYWdzIC4uLg0KPj4gLW9iamVjdCBtZW1vcnktYmFja2VuZC1maWxlLGlkPXBtZW0w
LHNoYXJlPW9uLG1lcmdlPW9uLGRpc2NhcmQtZGF0YT1vbixtZW0tcGF0aD0vcGF0aC9wbWVt
MC5wbWVtLHNpemU9MTAwRw0KPj4gLWRldmljZSB2aXJ0aW8tcG1lbS1wY2ksbWVtZGV2PXBt
ZW0wLGlkPW52MA0KPj4NCj4+IFRoaXMgdXNlZCB0byB3b3JrIGJ1dCBpbnNpZGUgdGhlIFZN
IEknZCBnZXQgdGhpcyB3aGVuIHJ1bm5pbmcgbWtmcy5leHQ0DQo+PiAvZGV2L3BtZW0wIHdp
dGggZ3Vlc3Qga2VybmVsIDcuMS4zOg0KPiANCj4gVGhpcyBwZW5kaW5nIGZpeCAod2hpY2gg
aXMgdGhlIHNhbWUgYXMgd2hhdCB5b3UgcHJvcG9zZWQgaGVyZSkgc2hvdWxkDQo+IHRha2Ug
Y2FyZSBvZiBpdDoNCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWJsb2Nr
LzIwMjYwNzA5MDIwMTQ1LjQwMTE1MzMtMS1qb3NlcGgucWlAbGludXguYWxpYmFiYS5jb20v
DQoNCk9oLCBpbmRlZWQuIFRoYXQncyB0aGUgdmVyeSBzYW1lIHBhdGNoLiBXZWxsLCBsb29r
cyBsaWtlIGl0J3MgaW4gdGhlIA0KcXVldWUsIHRoZW4uDQoNClNvcnJ5IGZvciB0aGUgbm9p
c2UuIDopDQo=

--------------BuOUWLOJIKKESrq4MelpZBBr--

--------------jxsjzV07zEsQBuQazo1N1E8M
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEj8FaBklQqZ3RvRTdOeS4d+YuuRUFAmpROWYFAwAAAAAACgkQOeS4d+YuuRVo
uA/9HpiOFKzs1F4I1O5DCFmeTytCYy/x/bFrpYBwCluqE15uY2U9IC9Zn1Pz5IhVGi+CdLTIDaGv
10yp+gDSpY6fVWoD6w3BSmTje2O447YGEeIzEbbMNRHgG1VVJ7BODoojoqhKjZxIby7IeObG1gVm
UGjpKCkm2IOQsecDKL+VmM88z6EJi6JvvSu+18R/Du+fX/BUaL+S5wkUL7rRqqL+i4pOZF7ai9O5
A78ClPRdsO/I7L6gTO2GTemegUB86R5NiSYLQ8RuFZ+xer4WxTKJCuQPztnym3b9e0ewyoEFsRSE
hNuRHNpDUWWflMqYZsNTRYtjKC+EJAdGHoiLRFkp4ecHdUAXMVAK95dBX/8ZmDdUVZ4ULs/f4xcm
ENGGrtrqcBCl7leeusqhmilZjBUTxB8HBE8YfsVVhEQVM1+ord63KlBrWBYbM5FtwEe2XgkPOrJk
9WOQ9hBPb/wgMXuJgApV5eotarkHwhNlrF5Vw/EjzdLWXi0j8Pln7eV+WY90WhvbL5zSX7Nc6TVg
BmeHOE7pgCmiRB70N8aQzs0aoBZlQgsBlpRrHBUp/2uw3JUp8QlH/iLgbmHNOErOhW0TB/3swIgh
zi5j/Qz6YKNMb4rjVpMNnR690hrutGkXJX2nwkMASeDlWkUiibFdBd7OsBeM6rSJTaQuyj7TZxO9
05c=
=Kmup
-----END PGP SIGNATURE-----

--------------jxsjzV07zEsQBuQazo1N1E8M--
