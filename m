Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F9982D6E
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706040255; cv=none; b=u9vxQrwiXO9Xk51sov3VWVHbG+WPZGw+lvf5DLg4rCxlcD6ISmedGgMruC/8EvcQno1ZXE397S19fsr5ZHWGKedfjaU46kFjD8Oz746PRGHX/QK9XSYhFYk31OyjJU6TKNOAOajYnqwtaCV2g+sH25vkPR+Hf/3nfa28TpU5RW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706040255; c=relaxed/simple;
	bh=mOmIH5wL4V/CCoLcyqHhQgE8tzV1Oo8ITTb61A38GZw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ibM0hRvGwjnS3l1SkEUhw8vEcruBnzEt1jhv3S7vvm+/mrMqULeUgGwniUS6oP7jqsMB5EHA9b1ikn5bKmgG+SHNDGveYlXu5m55rBwaMgUHa32jz9+a/SHOZb2roWu9qNA3iiyj33dK3mjghYB1sRPpCLQWFlypUlqmVsxnyN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=u8pwC+xR; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="u8pwC+xR"
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 3C360635B04A;
	Tue, 23 Jan 2024 21:04:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1706040242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=imb7tfjJqL2msrJNrUU6kOeGMtI7Z0rfy9NcNMo6ffw=;
	b=u8pwC+xR/inTvts2VErcRnSHJ8q6zRwIOUoFZudjjSzKmNanI/3FUAA9dJslQKtgZZQ0yd
	bGgzuWVtBa2lLJVLRs5g2Yp9kOM+m7C8stul7kRu22kLHUmqzxMM8h38++TQwGr8MY+314
	HYmmIlkNTYqZuUhSZsmVwZuiWxdOuvo=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHSET v3] mq-deadline and BFQ scalability improvements
Date: Tue, 23 Jan 2024 21:03:51 +0100
Message-ID: <2313676.ElGaqSPkdT@natalenko.name>
In-Reply-To: <20240123174021.1967461-1-axboe@kernel.dk>
References: <20240123174021.1967461-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4865610.GXAFRqVoOG";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart4865610.GXAFRqVoOG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Date: Tue, 23 Jan 2024 21:03:51 +0100
Message-ID: <2313676.ElGaqSPkdT@natalenko.name>
In-Reply-To: <20240123174021.1967461-1-axboe@kernel.dk>
References: <20240123174021.1967461-1-axboe@kernel.dk>
MIME-Version: 1.0

Hello.

On =FAter=FD 23. ledna 2024 18:34:12 CET Jens Axboe wrote:
> Hi,
>=20
> It's no secret that mq-deadline doesn't scale very well - it was
> originally done as a proof-of-concept conversion from deadline, when the
> blk-mq multiqueue layer was written. In the single queue world, the
> queue lock protected the IO scheduler as well, and mq-deadline simply
> adopted an internal dd->lock to fill the place of that.
>=20
> While mq-deadline works under blk-mq and doesn't suffer any scaling on
> that side, as soon as request insertion or dispatch is done, we're
> hitting the per-queue dd->lock quite intensely. On a basic test box
> with 16 cores / 32 threads, running a number of IO intensive threads
> on either null_blk (single hw queue) or nvme0n1 (many hw queues) shows
> this quite easily:
>=20
> The test case looks like this:
>=20
> fio --bs=3D512 --group_reporting=3D1 --gtod_reduce=3D1 --invalidate=3D1 \
> 	--ioengine=3Dio_uring --norandommap --runtime=3D60 --rw=3Drandread \
> 	--thread --time_based=3D1 --buffered=3D0 --fixedbufs=3D1 --numjobs=3D32 \
> 	--iodepth=3D4 --iodepth_batch_submit=3D4 --iodepth_batch_complete=3D4 \
> 	--name=3Dscaletest --filename=3D/dev/$DEV
>=20
> and is being run on a desktop 7950X box.
>=20
> which is 32 threads each doing 4 IOs, for a total queue depth of 128.
>=20
> Results before the patches:
>=20
> Device		IOPS	sys	contention	diff
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> null_blk	879K	89%	93.6%
> nvme0n1		901K	86%	94.5%
>=20
> which looks pretty miserable, most of the time is spent contending on
> the queue lock.
>=20
> This RFC patchset attempts to address that by:
>=20
> 1) Serializing dispatch of requests. If we fail dispatching, rely on
>    the next completion to dispatch the next one. This could potentially
>    reduce the overall depth achieved on the device side, however even
>    for the heavily contended test I'm running here, no observable
>    change is seen. This is patch 2.
>=20
> 2) Serialize request insertion, using internal per-cpu lists to
>    temporarily store requests until insertion can proceed. This is
>    patch 3.
>=20
> 3) Skip expensive merges if the queue is already contended. Reasonings
>    provided in that patch, patch 4.
>=20
> With that in place, the same test case now does:
>=20
> Device		IOPS	sys	contention	diff
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> null_blk	2867K	11.1%	~6.0%		+226%
> nvme0n1		3162K	 9.9%	~5.0%		+250%
>=20
> and while that doesn't completely eliminate the lock contention, it's
> oodles better than what it was before. The throughput increase shows
> that nicely, with more than a 200% improvement for both cases.
>=20
> Since the above is very high IOPS testing to show the scalability
> limitations, I also ran this on a more normal drive on a Dell R7525 test
> box. It doesn't change the performance there (around 66K IOPS), but
> it does reduce the system time required to do the IO from 12.6% to
> 10.7%, or about 20% less time spent in the kernel.
>=20
>  block/mq-deadline.c | 178 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 161 insertions(+), 17 deletions(-)
>=20
> Since v2:
> 	- Update mq-deadline insertion locking optimization patch to
> 	  use Bart's variant instead. This also drops the per-cpu
> 	  buckets and hence resolves the need to potentially make
> 	  the number of buckets dependent on the host.
> 	- Use locking bitops
> 	- Add similar series for BFQ, with good results as well
> 	- Rebase on 6.8-rc1
>=20
>=20
>=20

I'm running this for a couple of days with no issues, hence for the series:

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Thank you.

=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart4865610.GXAFRqVoOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmWwG6cACgkQil/iNcg8
M0sQBRAAq/xXyerNlTDv0zKkdWKsPjbJNpTqSpIW5FgqnxfQIkuqT5z27UHJCurY
IUDhCKIzBpxwLo+Nr+XuUkL5y0IM+3a7lodNHXuP7yNZX0QbAvGH9N3P0qQ+QYqc
7yNM2Lm0s+DiGYhtVxKR4XY8utogCUSzw1DrMkQrz8aOeBSs4JO8LFsmpGRgzS9R
rLN3ah6Yg/s9rVWcic2jqIQc1DnqW2+eWCxMt19+wqGJu0bVcC+2AANaWSfVumEB
bmFTuzvyhurPLNG0Au8OvwLFhKfRMd6yxZspNSUaq54Q57Om3n4NZsKmx5itKt6q
S67V301SyQQ+g9cUOd9XPkncvQ6+4rP2tp83ocnRcg3JRViQLbOBEzDqHblphbV/
2/oO6qJmv1I91YQwzQGkCM40p/mr11QgpINDOQcBUyqLmadDseEd92bc+MYpP7F1
AG7xYlgIbUkO0C62kwCwQpwZwtP08ReZS/H9tMbNYJj//heJeWph2SQ5tdBfRNzD
3HuRJU+5vhB8a6fYV/vIweWfrmBtI6O8ZN8RiYCXvGo6rap/PhtKbnJemXZy/Ba6
EFih85tL1OCUtRlljZTs2Amwe0L7bzdO5XDWuKkzgZUoN8TYOM93aLOz8NVa+x9d
mkqYDqsX2WnuDVVHPk7aiPfGESvb5AFRpRe6EpnkqBqC3qTmu/E=
=fEwg
-----END PGP SIGNATURE-----

--nextPart4865610.GXAFRqVoOG--



