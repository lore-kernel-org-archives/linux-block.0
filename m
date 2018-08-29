Return-Path: <javier@cnexlabs.com>
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] lightnvm: pblk: refactor metadata paths
Date: Wed, 29 Aug 2018 13:19:45 +0000
Message-ID: <F7595311-472D-4250-9B88-F2186334B7C8@cnexlabs.com>
References: <1535532980-27672-1-git-send-email-javier@cnexlabs.com>
 <1535532980-27672-2-git-send-email-javier@cnexlabs.com>
 <e147e01b-8317-3ab5-497c-70f601a92a2a@lightnvm.io>
In-Reply-To: <e147e01b-8317-3ab5-497c-70f601a92a2a@lightnvm.io>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_F77FE437-FDC0-4E49-BFCE-30D73CA80827";
	protocol="application/pgp-signature";
	micalg=pgp-sha512
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

--Apple-Mail=_F77FE437-FDC0-4E49-BFCE-30D73CA80827
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 29 Aug 2018, at 15.02, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/29/2018 10:56 AM, Javier Gonz=C3=A1lez wrote:
>> pblk maintains two different metadata paths for smeta and emeta, =
which
>> store metadata at the start of the line and at the end of the line,
>> respectively. Until now, these path has been common for writing and
>> retrieving metadata, however, as these paths diverge, the common code
>> becomes less clear and unnecessary complicated.
>> In preparation for further changes to the metadata write path, this
>> patch separates the write and read paths for smeta and emeta and
>> removes the synchronous emeta path as it not used anymore (emeta is
>> scheduled asynchronously to prevent jittering due to internal I/Os).
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/lightnvm/pblk-core.c     | 338 =
++++++++++++++++++---------------------
>>  drivers/lightnvm/pblk-gc.c       |   2 +-
>>  drivers/lightnvm/pblk-recovery.c |   4 +-
>>  drivers/lightnvm/pblk.h          |   4 +-
>>  4 files changed, 163 insertions(+), 185 deletions(-)
>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>> index dbf037b2b32f..09160ec02c5f 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -661,12 +661,137 @@ u64 pblk_lookup_page(struct pblk *pblk, struct =
pblk_line *line)
>>  	return paddr;
>>  }
>>  -/*
>> - * Submit emeta to one LUN in the raid line at the time to avoid a =
deadlock when
>> - * taking the per LUN semaphore.
>> - */
>> -static int pblk_line_submit_emeta_io(struct pblk *pblk, struct =
pblk_line *line,
>> -				     void *emeta_buf, u64 paddr, int =
dir)
>> +u64 pblk_line_smeta_start(struct pblk *pblk, struct pblk_line *line)
>> +{
>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>> +	struct nvm_geo *geo =3D &dev->geo;
>> +	struct pblk_line_meta *lm =3D &pblk->lm;
>> +	int bit;
>> +
>> +	/* This usually only happens on bad lines */
>> +	bit =3D find_first_zero_bit(line->blk_bitmap, lm->blk_per_line);
>> +	if (bit >=3D lm->blk_per_line)
>> +		return -1;
>> +
>> +	return bit * geo->ws_opt;
>> +}
>> +
>> +int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
>> +{
>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>> +	struct pblk_line_meta *lm =3D &pblk->lm;
>> +	struct bio *bio;
>> +	struct nvm_rq rqd;
>> +	u64 paddr =3D pblk_line_smeta_start(pblk, line);
>> +	int i, ret;
>> +
>> +	memset(&rqd, 0, sizeof(struct nvm_rq));
>> +
>> +	rqd.meta_list =3D nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
>> +							=
&rqd.dma_meta_list);
>> +	if (!rqd.meta_list)
>> +		return -ENOMEM;
>> +
>> +	rqd.ppa_list =3D rqd.meta_list + pblk_dma_meta_size;
>> +	rqd.dma_ppa_list =3D rqd.dma_meta_list + pblk_dma_meta_size;
>=20
> If patch 2 is put first, then this is not needed.
>=20

True... I will reorder with the changes on 2/3.


--Apple-Mail=_F77FE437-FDC0-4E49-BFCE-30D73CA80827
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluGnW4ACgkQIX4xUKFR
nnRMxBAA3UHHV7sp2en8SK6wroILCBJkxK548KZAM0KtIIztiNgSKSCiR17C3CRz
4RYyRPsm9weZI6v0R18giE8oXJ00PbBPT+6qSm5pnQCFCCrUZPd+PxelvIUHaaeu
zq5F5OWLwSAVWZzO3j/0mn8dCjDYQEGAxhAWIzs+t9Ano0jMo4CsrSqIyDmRYs2N
nJUNXrVJZ6u6GjFVYyTNuG/879TNQOiqD2A3XJ1uT8WAyP3K6DiOMu9Q1vCEhWAo
s7OdCLxOpEuSlUtxkmXO4ZmaBqAXAVoGLuxwCrf2SmB0qauorNd5i/BdAXk+5YWt
kcJ1oQk2F9qDvi2OlsMlKX8A/uU2T10cbPqigzOQM8/KLZrh+P9d9eqZJEoGngJs
OU7WedbvWuBj/Wepb7bvZ3vwtLaHt1AnZhiKk8TyWDqCU2Sy0EqzoievxY2WkMzJ
y+nYV38DYQRXGz+RAFdXAIQbkzV9TJtsPE6M/wIiNuJVhG2Cll0TZOAngWNwft/Q
mYXuIdkNAUlIp8sqUffnIGzRquNsstxFsYka9Ww+AS/PBEtgf3nuv2ojNhDetqzL
8MrG9HcKJ1L4koHopn302vuJzepJWflIGebbvTxY01phwRRJPimOLCqhi8P7XvqI
dmtyHVIUr/QLSa+CvPa74YQC8Imaqd84DKymzNYu7atgw+2yZHw=
=H95m
-----END PGP SIGNATURE-----

--Apple-Mail=_F77FE437-FDC0-4E49-BFCE-30D73CA80827--
