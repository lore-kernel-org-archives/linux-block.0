Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D88296BA2;
	Mon, 11 Aug 2025 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927744; cv=none; b=eeNURS5p9kc6g5fMeR8ddX5ExFBRVd5j8O6zAwQ1soy7feXlHHJvGHX5Ruj+wa5Qzq6udz3MxDl7DgYn3xwdoattbN55UkQ91jrWMWjIRRLS9abxzfu5rGeBkrsPOE2tLRQbCiRJl+n5Xc4RSDaM7mdYMSAPAhufxlOOqYwgVE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927744; c=relaxed/simple;
	bh=ElJ/T/tRj+7GGPhvILF3z+61P6Tjni3YzNxIaUm1aBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B/Ppws2R4aZKPd+W0yYqO5Y3V5qcKLcb4GQ4swH5x0HG3+l+ilp4myKXmXLiZGUOcI/o9U9/OhFDKQJhlvEWDAZWkuiw0TR/S6IAXuf4P82OrRqrLs3PBEdq0ehHiqm+Sb9BrblHs9rG+WKD+/iR9/dtZW0wTgohAT1g6g7hRME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=wL+LGZSW; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="wL+LGZSW"
Received: from spock.localnet (unknown [212.20.115.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 986B3635B040;
	Mon, 11 Aug 2025 17:48:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1754927302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=1L9wHhKVuXZQmzSOEtmhCm41l8tFu1qnDWrexhilFd8=;
	b=wL+LGZSWocUdhgr4uDnJkqv/zrJDjGwZO0DZ5R+3skpojeX9/PCnPdJb8dmZRkEGkhxQwm
	fZlDnWEpL9uNRlPOF54P6RoNCeCYp1wG2BTGWGuhhQwXcg4qbGAtqFYW7khRm9CzynxQm9
	KkqaxakLAtnJyncaLQ2jBvjGKFju27U=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <dlemoal@kernel.org>, John Garry <john.g.garry@oracle.com>,
 Christoph Hellwig <hch@lst.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-mm@kvack.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Michal Hocko <mhocko@kernel.org>, David Hildenbrand <david@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Subject:
 [REGRESSION][BISECTED] Unexpected OOM instead of reclaiming inactive file
 pages
Date: Mon, 11 Aug 2025 17:48:08 +0200
Message-ID: <5905724.LvFx2qVVIh@natalenko.name>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3613097.ElGaqSPkdT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart3613097.ElGaqSPkdT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org
Date: Mon, 11 Aug 2025 17:48:08 +0200
Message-ID: <5905724.LvFx2qVVIh@natalenko.name>
MIME-Version: 1.0

Hello Damien.

I'm fairly confident that the following commit

459779d04ae8d block: Improve read ahead size for rotational devices

caused a regression in my test bench.

I'm running v6.17-rc1 in a small QEMU VM with virtio-scsi disk. It has got 1 GiB of RAM, so I can saturate it easily causing reclaiming mechanism to kick in.

If MGLRU is enabled:

$ echo 1000 | sudo tee /sys/kernel/mm/lru_gen/min_ttl_ms

then, once page cache builds up, an OOM happens without reclaiming inactive file pages: [1]. Note that inactive_file:506952kB, I'd expect these to be reclaimed instead, like how it happens with v6.16.

If MGLRU is disabled:

$ echo 0 | sudo tee /sys/kernel/mm/lru_gen/min_ttl_ms

then OOM doesn't occur, and things seem to work as usual.

If MGLRU is enabled, and 459779d04ae8d is reverted on top of v6.17-rc1, the OOM doesn't happen either.

Could you please check this?

Thank you.

-- 
Oleksandr Natalenko, MSE

[1]: https://paste.voidband.net/TG5OiZ29.log
--nextPart3613097.ElGaqSPkdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmiaELgACgkQil/iNcg8
M0vbWRAA1sWIe8mVt6d0YmxKVEnYTYmMS1xatrN0wE+v1F22bp2RIiILZ5N1jlYM
s7mU4zQPn+K3KGeskURO7fI+Pkxqhas8UeN4p2GXkDGxSW3/N+eglmgbn0ICCE1w
I+fsBRbF7u5AI1xwUrDl4QDs+3YwW+v5RQbwFTwQYLu1oz9cARZD4tn4P80x7RIl
ct/TtcUvkHWjs0JEKXxfCqDQfEe36dD5TD2hFk5Fo1tIrSQfMojmoJ+gMXPCtXsh
tfPuXFeenpcySoLvu6PS5AayzqPCle4t2WOuVigE5KMhPkpNG22Of7PM4FbueRQa
O4QECIWlzQNs0n5VVrCNlAWC5dCtzGHvV/HI2tOmEGIUjdpU39JmibrQa9OsK3TA
lqMgmD8rgMT4r7TLgM0f4F48q5enU8nfSiuL3PVxeEWDJUlz2cCyb9cFp8u6ybI8
NI9n/1l+G8rV24E4eWuB7+vWMdpcio+/C1xxB0KZS8tdSdB1vQJqFhv4o0TqJshS
PurH9SL9ZoRz9s+JequLlnz5vZCULAHMD8pwcZ9KbjhuohA5BePtDt26IoH+0KoM
ph1zjJobDbwNCLvGi+xXorBKXjytESPDJEyBfQK77T5HeEGiFgzF5OG+Nt/9V085
ReA9mxcKPcpe1VXz4Hl3LHaPBUkg6ATQ9r0m+FTF6WIowpomIG0=
=guvX
-----END PGP SIGNATURE-----

--nextPart3613097.ElGaqSPkdT--



