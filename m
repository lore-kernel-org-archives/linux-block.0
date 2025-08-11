Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D664D2DAFBE;
	Mon, 11 Aug 2025 20:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754944986; cv=none; b=cjcx4DyZfUZdQwlEgNRhwehPIalgjMnxwSf3Xif5n602E8rpHP2kjl6AyXWmZr6Vjaxibc8rU0qJJyJPXkwn+uZSsCivaXSlsy5Q+qj/wPqmM1C1OoVvFlVU+MSE1+iIcjAnvoka+gp1OmrUWn/DiSaJakLSVsOjFRQaXB3ZIeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754944986; c=relaxed/simple;
	bh=BRo9k3JFejDsK8n/OLS2TXB9BHIncmGfXiHdt5aQZZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d20z9W2DghSmcxqdzdpZsohLCiUhOWqPPghpOaewHhCkTQr2Zbe1ETD9u/fOjlax5qyB/sh/tTSjiESG9tOGt1INqKyon+xP8Zgok4Uo5JnxRhi0tT5KeqiJSs4ZiRd+xzRT+Ac6/+qZlT1UZnutebHK9vtQcVmJFAdbUfVKlMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=sicsFSqE; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="sicsFSqE"
Received: from spock.localnet (unknown [212.20.115.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 1258B635B040;
	Mon, 11 Aug 2025 22:43:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1754944980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=epr51fyacq8S8wo/Irurh0cQPovilFvLcdw3EwV5RAo=;
	b=sicsFSqEBfPjKKKc8vl3Ha5STHfVdeVdOjrq7qOnr3T1QQmkNB3n1e8eBsbt1c1WlO1ytq
	oyyJ2Z8WtrTwW3um9OuESyXSx9ja8YqKgXsCsCUTdi5kljoOXE/Lh/o9pYAq1dylWPpQ7y
	G9Lt76MLVXpCJ0r5qPDI1J7gS/dx0pA=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: David Rientjes <rientjes@google.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
 John Garry <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-mm@kvack.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Michal Hocko <mhocko@kernel.org>, David Hildenbrand <david@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Subject:
 Re: [REGRESSION][BISECTED] Unexpected OOM instead of reclaiming inactive file
 pages
Date: Mon, 11 Aug 2025 22:42:46 +0200
Message-ID: <15056829.uLZWGnKmhe@natalenko.name>
In-Reply-To: <199fb020-19ee-89d1-6373-7cc7f5babab8@google.com>
References:
 <5905724.LvFx2qVVIh@natalenko.name>
 <199fb020-19ee-89d1-6373-7cc7f5babab8@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4238270.e9J7NaK4W3";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart4238270.e9J7NaK4W3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: David Rientjes <rientjes@google.com>
Date: Mon, 11 Aug 2025 22:42:46 +0200
Message-ID: <15056829.uLZWGnKmhe@natalenko.name>
In-Reply-To: <199fb020-19ee-89d1-6373-7cc7f5babab8@google.com>
MIME-Version: 1.0

Hello.

On pond=C4=9Bl=C3=AD 11. srpna 2025 18:06:16, st=C5=99edoevropsk=C3=BD letn=
=C3=AD =C4=8Das David Rientjes wrote:
> On Mon, 11 Aug 2025, Oleksandr Natalenko wrote:
>=20
> > Hello Damien.
> >=20
> > I'm fairly confident that the following commit
> >=20
> > 459779d04ae8d block: Improve read ahead size for rotational devices
> >=20
> > caused a regression in my test bench.
> >=20
> > I'm running v6.17-rc1 in a small QEMU VM with virtio-scsi disk. It has =
got 1 GiB of RAM, so I can saturate it easily causing reclaiming mechanism =
to kick in.
> >=20
> > If MGLRU is enabled:
> >=20
> > $ echo 1000 | sudo tee /sys/kernel/mm/lru_gen/min_ttl_ms
> >=20
> > then, once page cache builds up, an OOM happens without reclaiming inac=
tive file pages: [1]. Note that inactive_file:506952kB, I'd expect these to=
 be reclaimed instead, like how it happens with v6.16.
> >=20
> > If MGLRU is disabled:
> >=20
> > $ echo 0 | sudo tee /sys/kernel/mm/lru_gen/min_ttl_ms
> >=20
> > then OOM doesn't occur, and things seem to work as usual.
> >=20
> > If MGLRU is enabled, and 459779d04ae8d is reverted on top of v6.17-rc1,=
 the OOM doesn't happen either.
> >=20
> > Could you please check this?
> >=20
>=20
> This looks to be an MGLRU policy decision rather than a readahead=20
> regression, correct?
>=20
> Mem-Info:
> active_anon:388 inactive_anon:5382 isolated_anon:0
>  active_file:9638 inactive_file:126738 isolated_file:0
>=20
> Setting min_ttl_ms to 1000 is preserving the working set and triggering=20
> the oom kill is the only alternative to free memory in that configuration=
=2E =20
> The oom kill is being triggered by kswapd for this purpose.
>=20
> So additional readahead would certainly increase that working set.  This=
=20
> looks working as intended.

OK, this makes sense indeed, thanks for the explanation. But is inactive_fi=
le explosion expected and justified?

Without revert:

$ echo 3 | sudo tee /proc/sys/vm/drop_caches; free -m; sudo journalctl -kb =
>/dev/null; free -m
3
               total        used        free      shared  buff/cache   avai=
lable
Mem:             690         179         536           3          57       =
  510
Swap:           1379          12        1367
/* OOM happens here */
               total        used        free      shared  buff/cache   avai=
lable
Mem:             690         177          52           3         561       =
  513
Swap:           1379          17        1362=20

With revert:

$ echo 3 | sudo tee /proc/sys/vm/drop_caches; free -m; sudo journalctl -kb =
>/dev/null; free -m
3
               total        used        free      shared  buff/cache   avai=
lable
Mem:             690         214         498           4          64       =
  476
Swap:           1379           0        1379
/* no OOM */
               total        used        free      shared  buff/cache   avai=
lable
Mem:             690         209         462           4         119       =
  481
Swap:           1379           0        1379

The journal folder size is:

$ sudo du -hs /var/log/journal
575M    /var/log/journal

It looks like this readahead change causes far more data to be read than ac=
tually needed?

=2D-=20
Oleksandr Natalenko, MSE
--nextPart4238270.e9J7NaK4W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmiaVcYACgkQil/iNcg8
M0uaQBAAnLctV0WUNBWBHFrDA2boniapX5Hn2yObdFClyFNDhrC3AUPTQVyeBI7t
N9m52BCep1W3GuXSP8o/WdxR+6Mh/99J+kad5/gNczVI/XoOxdd6hWv9FNJAtuRQ
RD3sl0SMHM+vS04837GgBw6bVZvRpHVSWpVZIs/ujiY2RSp4XQDPQEgB96wvGCbc
rcLTeTdSZCQM2E3B6mw/EpAWg6+YzdZ3Cv4Xy5T7wk6rH3G+EiQA7536nlT9syF4
/M3+6e5A8I2WbKgV+cvaQYGSujAoXQXnHT/9S8n2XdvQ1rD9oX6PSyuxhOykaUV+
PldAX9jezn0fgswsooTR3ILUwzubDVGnDDQPW+w7TMritHG6ErJD0AS/DbQvoxVu
iEsL4wCThFm8N1HEH9IFGmGD3kHx6NAif2zmj61KjJ3Y6vQOHvcpxgHqdfuajKM8
iA4VvucrvOPlkowmW7cnxxZuZapJBLQSDcRCoU8vngfBC7OdX32EUZthAPw0vvei
rSw6NyUeJ/fLRPDsRa1RPp5YYEqksTDaqhL0vjFOPEE1c0asC1QOfljqU7wpG5Vh
bwZDfOtidoVpqXe0pjFUIkigoTPrsOj1boUFOvmg5DTjtWkqYEfmig7JK914PnaM
PU/2zXHaegKLg1EirXuaC/k2i/LO6WZFwJ9ub9K5YZlVV68LQew=
=Mz8p
-----END PGP SIGNATURE-----

--nextPart4238270.e9J7NaK4W3--



