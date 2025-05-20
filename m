Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B701C8603;
	Tue, 20 May 2025 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747760034; cv=none; b=Xya7Wt+VfypHjjZsvnG5tYTYpNL3916Y0bOXDkvj79S8V/zjLe4pmJpYyUBBulT1UC88ibglBHnmu62EFrioUGDJ19wPhadMj8FYHYqc+tX1LkpSpskbjwKvqxAsvRwb6/5rzLxGmUD0u++xHRIqhK11BM3ZZY9LneIJ+IyfORs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747760034; c=relaxed/simple;
	bh=3UH+ZcUFshEQoIRRVqSxr0uhm208CXi7zM9SCX9eyoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JasrqxdHmmrpJeBDvdvN1fXe+kNlJuB+hHlZhDpA2OTupvwVR2xe8Abigw9V8AUZtDpLBp0e29B/zG0OOHr5XQhylG6y8KCBuGFJTkjGTJZGrRyOdBdhX7VUJnbMNSh27/VqMVqI61xi3knjuWdeYHK5EMI///f6z1LaIJRUtt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=C+UutEV3; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="C+UutEV3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1747760016; x=1748364816; i=christian@heusel.eu;
	bh=hHynfVSUu1REHbTvVUtKdTkFvVCFs0veYLhTP/QJJYc=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=C+UutEV36iN2ZzCvbfG7cfHqdRdUpa96hSUzFziBC5GwPj591ZoBRW5mR/G8RXS9
	 HmnFAKhUUjNwIFXQNNpohCHTmsYEOHOvfetK1GGhGMj9bvJgY7mAyuwPGZTrslrli
	 qe8vej6AdlcQsfl41rxJgURd0TVR+cwYsU+jNbdVJzfSAd8IS3HGrV5q56IHhU+qV
	 Ozya4fJcUxxhyjkkasZs2JuqcEQqSTnyeZo3yJPonOPAYSLPRI6VmkWVZI7xfquOd
	 0GrY9hgX0JQBtE+fIl1LA5uxDRaO6L7F/rTgS07Tp37NVo2LiGupAxnI4E6DMOYqc
	 ITNVY8X7C5YSeYb8kA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([129.206.143.169]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MAORn-1u7Dch0ONv-003qEE; Tue, 20 May 2025 18:53:36 +0200
Date: Tue, 20 May 2025 18:53:31 +0200
From: "christian@heusel.eu" <christian@heusel.eu>
To: "hch@infradead.org" <hch@infradead.org>
Cc: Christian Hesse <mail@eworm.de>, "Xu, Lizhi" <Lizhi.Xu@windriver.com>, 
	"axboe@kernel.dk" <axboe@kernel.dk>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ming.lei@redhat.com" <ming.lei@redhat.com>, 
	"syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com" <syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com>, 
	"syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH V5] loop: Add sanity check for read/write_iter
Message-ID: <f17dfb4c-8c18-4a49-b8f9-532aacd4df8f@heusel.eu>
References: <20250519175640.2fcac001@leda.eworm.net>
 <20250520030051.177205-1-lizhi.xu@windriver.com>
 <20250520073901.6fdfbee4@leda.eworm.net>
 <BL1PR11MB5979C666DA3BC228C2C30E92869FA@BL1PR11MB5979.namprd11.prod.outlook.com>
 <aCwlRMEuvvP31UGG@infradead.org>
 <BL1PR11MB5979EFA72DA54AB231D408CF869FA@BL1PR11MB5979.namprd11.prod.outlook.com>
 <20250520144622.3fd9592a@leda.eworm.net>
 <aCx6QFZ1kiyB9ec0@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jt6awhmybxmxnqwi"
Content-Disposition: inline
In-Reply-To: <aCx6QFZ1kiyB9ec0@infradead.org>
X-Provags-ID: V03:K1:nruTG/GaRtLk9w0k19aoH1F3Hy32HcfS/Zm1t0lud1RSGBzJkem
 8UcGhM9A1XTkiCCTf19Ld8t45n6qtZvJy0MwBjdHGz4c4ieYBPtfBY2gZi6E6TyEifp/QNh
 /VsRgE/1D/XNs0fJqpzrGHs0+/kSQ0z//0fRcRGwBBY6FFXq714UcwIJrPoxR7LhfSBYI8v
 O09ebSwSjhb8bCG8/qtRg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KdPONAnUY6U=;XJKJcwB1mTgMxa0mzD8GlFoAtgY
 dDIGcRBf/CdM0ThP6dTDTjiHpoImeMLnzURkwLpitX5vZo3DLo2AgV73qykyIKoEgBf5QPQPv
 YAlw7Z7UE6/wWEtL4l2FCtNE5TfegtbhGpSHDqFRXYgqGDXLtDQcMb2hNxCwtBMtBf1ylTUEv
 BbNyPR0pe05E8cz+DBjlHb7CM6qD1TDEfqNCUT7saB910b18EYiErGPIBcckkOQ3friKDUaH9
 WKNoiEY7mij5lSjJTr54mNkSZaPtLPDSi6kHCXX1W8tsa1NvkkvaGeD9Emnw8309vHLL5uKtC
 3ORjJeKGc7v3D2cwNm86NfVvDTygvzGSOfxDVCBxy14kABOoD/FHS4Hp4rRW6OWk8y3UaoqK9
 iUiIFR4IN7GG6kZ3tFHLR0XrkRZJRHNL4TYqUs9bhmT5w05AU1K8QOjAB9Dukq6riw0fZDap1
 YAKlHZXbNMYCVqTpgBYOY0OmRJeahhAQc6z2eo0L9gWXI7RIWH1k/GAiXGFNq6bSnFHaWtU65
 GzSkQqKP3Ry+6oulLrAMtEZLtdyBGTTz4BSLvJOAFSrnkaw/FfHCvGy/WUKNnYKd29krq6Vhf
 TnkOUkp2VtNgnb/I9DA8DG8Q2ivH9q1NV4/bCTVb2RUICWxtCgjJqO0aBDZ07QQDAMwBPZfKu
 CasgkXFvMXpV3wpFWXysq+vvR6Wg2bdPtiehzOmjPvg5yDQIrAEdJqC7Ua/a7q9u1htKm8lA8
 fNd96G5qhMWDGM8xIdBsSjvFXywfRe6divuDgxPunwsz6IEycrFMSJlPwCQgKY0ViwY542AZR
 Id36oO1AN2U47YWMD2lyioBXBjmFffUJSFn4AUZn6+lAaK2oXg1p1fs5mcZ9/p8k8JG4eQQAb
 ABhluMe7UFFYnqvDuq2MCcXGd1KMKxkzZH90b30tU7Y7Aape5/r+yoHW8TTcLgLilv9Hv7jtV
 ti3V7sBD3Wplnrf25Lfo7Sft2fbCdzJnZcalS/cAqPhJXMPAdS23b9+j2bSV5N86LAvDkbkhU
 /k17qRmtg+Hqr2dRaoivDMm7sN7/NJLWoaZjEThyPzYHAeQ1qtCPuHkxNkHB+ZGHyP1+qCTkb
 Y+DgqpFI+J8uNyHByI8ewM2eH7cNfsFYzQZtyGPtnGY7xYoB7c/M29Id7j9iQEiXw19cov/fk
 cx3CKW+T+S3fp5y1Kf4U00uTq3XwSY/y080MowivFRL1XT11seLleuMJXARdEgf308+dCTvHS
 9d9qTu9vpx7FLAKKYOpJ6Xs2+qrBnFx7Bbmofq7RsYZwO2zCF62l0dyt/MDJWaCEIOJmAV1xP
 KnlarWzzpwbHXA+AtkKeXPmKC2rtMREZWQVVP129RIbwXwz53jmkIeiGfKfQ/hX8enHn5rrjp
 CskhCXk4UqpnMqp0tAbATfw7BFqIriwQTnPgEpxR8KZgnooOa6g3vredkTUivfIiYKE4x/sUB
 HVD82Uw==


--jt6awhmybxmxnqwi
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V5] loop: Add sanity check for read/write_iter
MIME-Version: 1.0

On 25/05/20 05:49AM, hch@infradead.org wrote:
> On Tue, May 20, 2025 at 02:46:22PM +0200, Christian Hesse wrote:
> > "Xu, Lizhi" <Lizhi.Xu@windriver.com> on Tue, 2025/05/20 12:27:
> > > If it is a regular file, generic_ro_fops is used. In this case,
> > > isofs supports read_iter. When a regular file has a writable attribut=
e,
> >=20
> > Just tested with an iso file where writable flag from loopback file ins=
ide
> > was explicitly removed. No change.
> >=20
> > > the problem will recur because isofs does not support write_iter.
> >=20
> > We have two indications here that setup should happen in read-only mode:
> >=20
> > * The underlaying filesystem is read-only
> > * `losetup` is called with switch `--read-only`
> >=20
> > I would expect both to make this happy.
>=20
> Can you test this patch?
>=20
> We historically allow a writable fd on block devices even when they
> are read-only.  I suspect your use case is doing that and the new
> check for write_iter is interfering with that:

I have tested the patch and can confirm that it fixes the usecase as
represented by the reproducer that I have used to bisect the bug.

If you turn this into an actual patch you can add my

Tested-by: Christian Heusel <christian@heusel.eu>

if you want :)

--jt6awhmybxmxnqwi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmgss4oACgkQwEfU8yi1
JYWSgw//SL2gMT/6oUPfkJO4iMYHkkhr83Dwr5DiBxyjd7ryh6oBUBNaKhAV4la5
NepOZ38QMRp+5B4uxtzh9repJOa8jAJNAn1jt+c9C2tBBQPmFQ2KOWVMsD6o5JKF
yy1eak/TgiiH29eyCMEWv6zvxN71bBtSuG5PxzHyt3fHofML920/pbTucjihuVl+
hXL6aKvofeB/nOQhu4Gz1jva+W54URECIZzpjcfjpxQH8kllTebEVnxuAAHnPFZe
p15pDjytaLbLCcLjQAwT+xnguBh5D5O2UOA3c2w2A8jWuU2klD8qp+7JStfTEdMK
ezDc+nOzA9IM757VLK65TtzOk4406VbMje4ldrdkB5oSlvlDOStDKf9RdLDHmL+8
/jj8UcIBUq8P++QJ+0h9x+X5dCF9XLLQFow6OeY4vyMRos2RDXr+JvJqusrKiEMQ
SjdXGSqB6OGbc9v0hMeZMNmObdptzSLYvGCxmaQ8XHWFKV5SG8vr8spEZeWdytKx
Nmq0y+Gnv/d67oTI70VNNWVpqw+wTm+jGrk1jfJzq95y/1a261/UukQMv5AgOQL+
gw0xGmT5DCXqkVL+6wO9NcDynm6KaTjRMMoHXHQw5uDQWDxwk6dq3T8n0o844SKE
yAGNIoZ3VdTPvkZQ8CtkdaqKViaaivi3fW6wi36XqkxNnI2T8NA=
=NPHG
-----END PGP SIGNATURE-----

--jt6awhmybxmxnqwi--
