Received: from a1-bg02.venev.name (a1-bg02.venev.name [213.240.239.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5502837107A;
	Tue, 17 Feb 2026 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.240.239.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771350052; cv=none; b=qADrPJ4zXqEkOYpATvjXkoOl+wsW3mKN/HPTJ5bUnTCL/CBbvzYeWhB9aLW2P/QNIhnNA9nksH6F5m3dSI2zGbnMeWckGcyxHTO9k47UXz9MvfmCd5Ko/UjVm1DKuMegOAuECOC9+Hd1kj2C8FoLt+9NdnYmZjPrrohAfuvGYnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771350052; c=relaxed/simple;
	bh=bx8ltbMTWp0UveWQZhheXSavSfUUgDZEwTgmD9Qwd3Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LHock5MjhCM+iYV7is8dLLob+gUPG7UXJgI92+lqt4BpVFHyY1bfxY4ntgufmGcZ+40G2hmQmMp0BRMuKkssTktNOOY1YWwSmFWIS/OU4UMjt09nNRCVYQEm5Wyw35MEmoHpCxd47QYllbcmwYp/dDg6F8lHh9Oc++GFnZRk72k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=venev.name; spf=pass smtp.mailfrom=venev.name; dkim=pass (4096-bit key) header.d=venev.name header.i=@venev.name header.b=DTcF0Yy0; arc=none smtp.client-ip=213.240.239.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=venev.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=venev.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=venev.name header.i=@venev.name header.b="DTcF0Yy0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=venev.name;
	s=default; h=Content-Transfer-Encoding:Content-Type:Date:To:From:Subject:
	Message-ID:Reply-To:Sender; bh=bx8ltbMTWp0UveWQZhheXSavSfUUgDZEwTgmD9Qwd3Y=; 
	b=DTcF0Yy0rXsDwsUQfNzovoYC28DkESS92+TD0RHEkAkgJqacalxbwWzjp8eZX5JsOquyxk270UC
	URVGDI+DJuSmz3qVtJjpklrGPCeWPl/LCoveJXrmfSvmIZc03Pleiiy8eXMF70HF0L9ALRnv7udpF
	iaP8fyAyGEIQbmdbpjybubn/+MKm56M7eqgabj3mIFide+zHxHvMS0pgsWPV9EjYkALu4T4ZktKXV
	XfeBUG8DyuAseVFwSIczwF6j7TV88AHBVEBqcRv04nJuDrkaddK3I/bHTKyk3NSAUQ8Ss8o2pMfmD
	m8+UQ0ekuXF4L8ShUZV/fVSNwWsgOR4uNuxwaapuY/uOlFHrLscWmjV73boY3WK9m779sB8T3n+Gt
	O26QNNe2tUFb9NcYfwDmHOO1E0ABZu/h9Al9ah4Roh6+w+vhYkzo5xDiUjZD6psvX4YFtjjEMvI7s
	uQXiq412q66WsaZQpvnoS0yNiR2DNQhZ4Guk9sb8/HXeWMNdn8uRpJ/9rZBpvMoXEbnzJbxT0ui2H
	LbRW6vXGg0iDLXaF+f/GuThGxxvRD5iJyJZ0b2U4deQzy8nnDUMpkC9lPNHuiRqCH4wEeGNBwFEvK
	CMgQ6Oj6reAlVAs/Nlxfr/fatoxnjv3IpCTpOkrLqZj2OQi7baltxvvnqJlK4ugokNDbM=;
Received: from a1-bg02.venev.name ([213.240.239.49] helo=pmx1.venev.name)
	by a1-bg02.venev.name with esmtps
	id 1vsP3r-0000000EX02-2lII
	(TLS1.3:TLS_AES_256_GCM_SHA384:256)
	(envelope-from <hristo@venev.name>);
	Tue, 17 Feb 2026 17:40:35 +0000
Received: from box.m.venev.name ([213.240.239.49])
	by pmx1.venev.name with ESMTPSA
	id AbcRMxGolGkU2TQAdB6GMg
	(envelope-from <hristo@venev.name>); Tue, 17 Feb 2026 17:40:35 +0000
Message-ID: <6a1339999b091edaaa15e34aceb7961dfc61581b.camel@venev.name>
Subject: Re: [PATCH] netlink: specs: add specification for NBD
From: Hristo Venev <hristo@venev.name>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, Jens Axboe	
 <axboe@kernel.dk>, linux-block@vger.kernel.org, nbd@other.debian.org
Date: Tue, 17 Feb 2026 19:40:33 +0200
In-Reply-To: <m2o6lnlg2y.fsf@gmail.com>
References: <20260215180309.2255721-3-hristo@venev.name>
	 <m2o6lnlg2y.fsf@gmail.com>
Autocrypt: addr=hristo@venev.name; prefer-encrypt=mutual;
 keydata=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
 AjQ6o01lu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-17 at 12:17 +0000, Donald Hunter wrote:
> There are yamllint errors:
>=20
> make -C tools/net/ynl lint
> make: Entering directory '/home/donaldh/net-next/tools/net/ynl'
> yamllint ../../../Documentation/netlink/specs
> ../../../Documentation/netlink/specs/nbd.yaml
> =C2=A0 159:81=C2=A0=C2=A0=C2=A0 error=C2=A0=C2=A0=C2=A0 line too long (10=
4 > 80 characters)=C2=A0 (line-
> length)
> =C2=A0 169:6=C2=A0=C2=A0=C2=A0=C2=A0 error=C2=A0=C2=A0=C2=A0 syntax error=
: expected <block end>, but found
> '<block mapping start>' (syntax)
> =C2=A0 170:7=C2=A0=C2=A0=C2=A0=C2=A0 error=C2=A0=C2=A0=C2=A0 wrong indent=
ation: expected 5 but found 6=C2=A0
> (indentation)

Thanks, I will fix the lint errors in v2.

> > +doc: See :file:`drivers/block/nbd.c`
>=20
> Prefer to see a meaningful doc string here.

I will add more proper documentation in v2. I couldn't find any
existing documentation of this netlink interface, so I guess I will
write it myself.

> > +attribute-sets:
> > +=C2=A0 -
> > +=C2=A0=C2=A0=C2=A0 name: nbd-attrs
> > +=C2=A0=C2=A0=C2=A0 name-prefix: nbd-attr-
> > +=C2=A0=C2=A0=C2=A0 doc: Configuration policy attributes, used for CONN=
ECT
> > +=C2=A0=C2=A0=C2=A0 attributes:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: unspec
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value: 0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type: unused
>=20
> No need for unspec in the attribute list, ynl codegen does the right
> thing.

For me `pyynl.ynl_gen_c --mode uapi --header` no longer generates
`NBD_ATTR_UNSPEC` if I remove this. Is there a YNL property to specify
the name of the zero value of the attribute set? If not, should I
remove it anyway, changing the generated header?

> > +=C2=A0=C2=A0=C2=A0 name: device-item-attrs
> > +=C2=A0=C2=A0=C2=A0 name-prefix: nbd-device-item-
> > +=C2=A0=C2=A0=C2=A0 doc: |
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This is the format for multiple devices=
 with
> > :code:`NBD_ATTR_DEVICE_LIST`
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .. code-block::
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [NBD_ATTR_DEVICE_LIST]
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [NBD_DEVICE_ITE=
M]
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [NB=
D_DEVICE_INDEX]
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [NB=
D_DEVICE_CONNECTED]
> > +=C2=A0=C2=A0=C2=A0 attributes:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: unspec
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value: 0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type: unused
>=20
> Not required.

The same question applies here.

> > +=C2=A0=C2=A0=C2=A0 name: device-attrs
> > +=C2=A0=C2=A0=C2=A0 name-prefix: nbd-device-
> > +=C2=A0=C2=A0=C2=A0 attr-max-name: nbd-device-attr-max
> > +=C2=A0=C2=A0=C2=A0 attributes:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: unspec
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value: 0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type: unused
>=20
> Not required.

The same question applies here.

> > +=C2=A0=C2=A0=C2=A0 name: sock-item-attrs
> > +=C2=A0=C2=A0=C2=A0 name-prefix: nbd-sock-item-
> > +=C2=A0=C2=A0=C2=A0 doc: |
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This is the format for multiple sockets=
 with
> > :code:`NBD_ATTR_SOCKETS`
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .. code-block::
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [NBD_ATTR_SOCKETS]
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [NBD_SOCK_ITEM]
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [NB=
D_SOCK_FD]
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [NBD_SOCK_ITEM]
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [NB=
D_SOCK_FD]
> > +=C2=A0=C2=A0=C2=A0 attributes:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: unspec
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value: 0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type: unused
>=20
> Not required.

The same question applies here.

> > +=C2=A0=C2=A0=C2=A0 name: sock-attrs
> > +=C2=A0=C2=A0=C2=A0 name-prefix: nbd-sock-
> > +=C2=A0=C2=A0=C2=A0 attributes:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: unspec
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value: 0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type: unused
>=20
> Not required.

The same question applies here.

> > +operations:
> > +=C2=A0 enum-model: unified
> > +=C2=A0 name-prefix: nbd-cmd-
> > +=C2=A0 list:
> > +=C2=A0=C2=A0=C2=A0 -
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: unspec
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value: 0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doc: NBD_CMD_UNSPEC

A similar question applies here. If I remove this, `pyynl.ynl_gen_c
--mode uapi --header` no longer generates `NBD_CMD_UNSPEC`. Is there a
YNL property to generate it? If not, should I remove it anyway?

> > +=C2=A0=C2=A0=C2=A0 -
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: connect
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doc: See :file:`drivers/block/nbd.c`,
> > :code:`nbd_genl_connect()`
>=20
> Prefer to see meaningful doc string (same for other ops)

I guess I will have to document the four operations in v2 as well.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attribute-set: nbd-attrs
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dont-validate: [strict]
>
> nbd.c has strict & dump, should this be [strict, dump] ? (same for
> other ops)

The NBD operations don't have `dump`, only `do`, so adding `dump` to
`dont-validate` does not change the output of `pyynl.ynl_gen_c --mode
kernel --source`. Should I add it anyway?
