Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam01on0078.outbound.protection.outlook.com ([104.47.32.78]:46145
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935300AbeF2LWW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jun 2018 07:22:22 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: Hans Holmberg <hans.holmberg@cnexlabs.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: recover chunk state on 1.2 devices
Date: Fri, 29 Jun 2018 11:22:16 +0000
Message-ID: <43D7E3C4-765F-46AB-9B84-27E37FCAE016@cnexlabs.com>
References: <1530177121-24908-1-git-send-email-javier@cnexlabs.com>
 <1530177121-24908-2-git-send-email-javier@cnexlabs.com>
 <e42e5ab4-48c7-e822-618d-dc28c25262ed@lightnvm.io>
In-Reply-To: <e42e5ab4-48c7-e822-618d-dc28c25262ed@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_AD99028E-9BBB-4F95-BB01-A1E4D6C8AACF";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_AD99028E-9BBB-4F95-BB01-A1E4D6C8AACF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 29 Jun 2018, at 13.14, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 06/28/2018 11:12 AM, Javier Gonz=C3=A1lez wrote:
>> The Open-Channel 1.2 spec does not define a mechanism for the host to
>> recover the block (chunk) state. As a consequence, a newly format =
device
>> will need to reconstruct the state. Currently, pblk assumes that =
blocks
>> are not erased, which might cause double-erases in case that the =
device
>> does not protect itself against them (which is not specified in the =
spec
>> either).
>=20
> It should not be specified in the spec. It is up to the device to =
handle
> double erases and not do it.
>=20
>> This patch, reconstructs the state based on read errors. If the first
>> sector of a block returns and empty page (NVM_RSP_ERR_EMPTYPAGE), =
then
>> the block s marked free, i.e., erased and ready to be used
>> (NVM_CHK_ST_FREE). Otherwise, the block is marked as closed
>> (NVM_CHK_ST_CLOSED). Note that even if a block is open and not fully
>> written, it has to be erased in order to be used again.
>=20
> Should we extend it to do the scan, and update the write pointer as
> well? I think this kind of feature already is baked into pblk?
>=20

This is already in place: we scan until empty page and take it from
there. This patch is only for the case in which we start a pblk instance
form scratch. On a device already owned by pblk, we would not have the
problem we are trying to solve here because we know the state.

>> One caveat of this approach is that blocks that have been erased at a
>> moment in time, will always be considered as erased. However, some =
media
>> might become unstable if blocks are not erased before usage. Since =
pblk
>> would follow this principle after the state of all blocks fall under
>> pblk's domain, we can consider this as an initialization problem. The
>> trade-off would be to fall back to the old behavior and risk =
premature
>> media wearing.
>=20
> The above is up to the device implementation to handle. We cannot
> expect users to understand the intrinsics of media.
>=20

Of course. The point is that with this approach, erases are left a bit
in the air and "preventable" write errors might happen, with the =
previous
the burden was put on the device to deal with double erases. It's a
tradeoff that I want to make clear before the path is taken.

>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/lightnvm/pblk-init.c | 138 =
++++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 124 insertions(+), 14 deletions(-)
>> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
>> index 3b8aa4a64cac..ce25f1473d8e 100644
>> --- a/drivers/lightnvm/pblk-init.c
>> +++ b/drivers/lightnvm/pblk-init.c
>> @@ -697,47 +697,138 @@ static void pblk_set_provision(struct pblk =
*pblk, long nr_free_blks)
>>  	atomic_set(&pblk->rl.free_user_blocks, nr_free_blks);
>>  }
>>  +static void pblk_state_complete(struct kref *ref)
>> +{
>> +	struct pblk_pad_rq *pad_rq =3D container_of(ref, struct =
pblk_pad_rq, ref);
>> +
>> +	complete(&pad_rq->wait);
>> +}
>> +
>> +static void pblk_end_io_state(struct nvm_rq *rqd)
>> +{
>> +	struct pblk_pad_rq *pad_rq =3D rqd->private;
>> +	struct pblk *pblk =3D pad_rq->pblk;
>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>> +	struct nvm_geo *geo =3D &dev->geo;
>> +	struct pblk_line *line;
>> +	struct nvm_chk_meta *chunk;
>> +	int pos;
>> +
>> +	line =3D &pblk->lines[pblk_ppa_to_line(rqd->ppa_addr)];
>> +	pos =3D pblk_ppa_to_pos(geo, rqd->ppa_addr);
>> +
>> +	chunk =3D &line->chks[pos];
>> +
>> +	if (rqd->error =3D=3D NVM_RSP_ERR_EMPTYPAGE)
>> +		chunk->state =3D NVM_CHK_ST_FREE;
>> +	else
>> +		chunk->state =3D NVM_CHK_ST_CLOSED;
>> +
>> +	bio_put(rqd->bio);
>> +	pblk_free_rqd(pblk, rqd, PBLK_READ);
>> +	kref_put(&pad_rq->ref, pblk_state_complete);
>> +}
>> +
>> +static int pblk_check_chunk_state(struct pblk *pblk, struct =
nvm_chk_meta *chunk,
>> +				struct ppa_addr ppa, struct pblk_pad_rq =
*pad_rq)
>> +{
>> +	struct nvm_rq *rqd;
>> +	struct bio *bio;
>> +	int ret;
>> +
>> +	bio =3D bio_alloc(GFP_KERNEL, 1);
>> +
>> +	if (pblk_bio_add_pages(pblk, bio, GFP_KERNEL, 1))
>> +		goto fail_free_bio;
>> +
>> +	rqd =3D pblk_alloc_rqd(pblk, PBLK_READ);
>> +
>> +	rqd->bio =3D bio;
>> +	rqd->opcode =3D NVM_OP_PREAD;
>> +	rqd->flags =3D pblk_set_read_mode(pblk, PBLK_READ_SEQUENTIAL);
>> +	rqd->nr_ppas =3D 1;
>> +	rqd->ppa_addr =3D ppa;
>> +	rqd->end_io =3D pblk_end_io_state;
>> +	rqd->private =3D pad_rq;
>> +
>> +	kref_get(&pad_rq->ref);
>> +
>> +	ret =3D pblk_submit_io(pblk, rqd);
>> +	if (ret) {
>> +		pr_err("pblk: I/O submissin failed: %d\n", ret);
>> +		goto fail_free_rqd;
>> +	}
>> +
>> +	return NVM_IO_OK;
>> +
>> +fail_free_rqd:
>> +	pblk_free_rqd(pblk, rqd, PBLK_READ);
>> +	pblk_bio_free_pages(pblk, bio, 0, bio->bi_vcnt);
>> +fail_free_bio:
>> +	bio_put(bio);
>> +
>> +	return NVM_IO_ERR;
>> +}
>> +
>>  static int pblk_setup_line_meta_12(struct pblk *pblk, struct =
pblk_line *line,
>>  				   void *chunk_meta)
>>  {
>>  	struct nvm_tgt_dev *dev =3D pblk->dev;
>>  	struct nvm_geo *geo =3D &dev->geo;
>>  	struct pblk_line_meta *lm =3D &pblk->lm;
>> +	struct pblk_pad_rq *pad_rq;
>>  	int i, chk_per_lun, nr_bad_chks =3D 0;
>>  +	pad_rq =3D kmalloc(sizeof(struct pblk_pad_rq), GFP_KERNEL);
>> +	if (!pad_rq)
>> +		return -1;
>> +
>> +	pad_rq->pblk =3D pblk;
>> +	init_completion(&pad_rq->wait);
>> +	kref_init(&pad_rq->ref);
>> +
>>  	chk_per_lun =3D geo->num_chk * geo->pln_mode;
>>    	for (i =3D 0; i < lm->blk_per_line; i++) {
>>  		struct pblk_lun *rlun =3D &pblk->luns[i];
>>  		struct nvm_chk_meta *chunk;
>> -		int pos =3D pblk_ppa_to_pos(geo, rlun->bppa);
>> +		struct ppa_addr ppa =3D rlun->bppa;
>> +		int pos =3D pblk_ppa_to_pos(geo, ppa);
>>  		u8 *lun_bb_meta =3D chunk_meta + pos * chk_per_lun;
>>    		chunk =3D &line->chks[pos];
>>  -		/*
>> -		 * In 1.2 spec. chunk state is not persisted by the =
device. Thus
>> -		 * some of the values are reset each time pblk is =
instantiated,
>> -		 * so we have to assume that the block is closed.
>> -		 */
>> -		if (lun_bb_meta[line->id] =3D=3D NVM_BLK_T_FREE)
>> -			chunk->state =3D  NVM_CHK_ST_CLOSED;
>> -		else
>> -			chunk->state =3D NVM_CHK_ST_OFFLINE;
>> -
>>  		chunk->type =3D NVM_CHK_TP_W_SEQ;
>>  		chunk->wi =3D 0;
>>  		chunk->slba =3D -1;
>>  		chunk->cnlb =3D geo->clba;
>>  		chunk->wp =3D 0;
>>  -		if (!(chunk->state & NVM_CHK_ST_OFFLINE))
>> +		if (lun_bb_meta[line->id] !=3D NVM_BLK_T_FREE) {
>> +			chunk->state =3D NVM_CHK_ST_OFFLINE;
>> +			set_bit(pos, line->blk_bitmap);
>> +			nr_bad_chks++;
>> +
>>  			continue;
>> +		}
>>  -		set_bit(pos, line->blk_bitmap);
>> -		nr_bad_chks++;
>> +		/*
>> +		 * In 1.2 spec. chunk state is not persisted by the =
device.
>> +		 * Recover the state based on media response.
>> +		 */
>> +		ppa.g.blk =3D line->id;
>> +		pblk_check_chunk_state(pblk, chunk, ppa, pad_rq);
>>  	}
>>  +	kref_put(&pad_rq->ref, pblk_state_complete);
>> +
>> +	if (!wait_for_completion_io_timeout(&pad_rq->wait,
>> +				=
msecs_to_jiffies(PBLK_COMMAND_TIMEOUT_MS))) {
>> +		pr_err("pblk: state recovery timed out\n");
>> +		return -1;
>> +	}
>> +
>> +	kfree(pad_rq);
>>  	return nr_bad_chks;
>>  }
>>  @@ -1036,6 +1127,23 @@ static int pblk_line_meta_init(struct pblk =
*pblk)
>>  	return 0;
>>  }
>>  +static void check_meta(struct pblk *pblk, struct pblk_line *line)
>> +{
>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>> +	struct nvm_geo *geo =3D &dev->geo;
>> +	struct pblk_line_meta *lm =3D &pblk->lm;
>> +	int i;
>> +
>> +	for (i =3D 0; i < lm->blk_per_line; i++) {
>> +		struct pblk_lun *rlun =3D &pblk->luns[i];
>> +		struct nvm_chk_meta *chunk;
>> +		struct ppa_addr ppa =3D rlun->bppa;
>> +		int pos =3D pblk_ppa_to_pos(geo, ppa);
>> +
>> +		chunk =3D &line->chks[pos];
>> +	}
>> +}
>> +
>>  static int pblk_lines_init(struct pblk *pblk)
>>  {
>>  	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
>> @@ -1077,6 +1185,8 @@ static int pblk_lines_init(struct pblk *pblk)
>>  			goto fail_free_lines;
>>    		nr_free_chks +=3D pblk_setup_line_meta(pblk, line, =
chunk_meta, i);
>> +
>> +		check_meta(pblk, line);
>>  	}
>>    	if (!nr_free_chks) {
>=20
> I'm okay with us doing this in pblk for now. Over time, someone may do
> the work move this (and other specific only-1.2/2.0 stuff) into the
> lightnvm subsystem. I don't think pblk should need to care about
> either 1.2 or 2.0.

That would be ideal.

Thanks!

--Apple-Mail=_AD99028E-9BBB-4F95-BB01-A1E4D6C8AACF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAls2FmUACgkQIX4xUKFR
nnRkiRAAySagb+zN3SFmjGXDwec78EY7IKfm3U9kG5gJPfbPdW1QjqZBDeyAhSf2
L6yGkLxZowSa/Sk/nL8mBrkCOaeFXy9RBJ+8FOvCz0yB//6AAzdG1Z2VOZxhV9pd
2mpnhEZo0qo+lJDTCCYt3m3CvwLbudxxRs0jc0TperBTqpXv4ZGNk3sftyDuu91V
8kXJPVLWHAOabUpwvO+DvO63CHPDkrUjznbofGoP7JiGFqbnmXlD8rmJc00yB+mt
vb926LLeqwBJ8wU64C4iU6WXhiF9KUy3NOwtRtksOhA9kFEPNlIrj7FEACM9LQcl
YCdHeePmp95EFc9AyHBIGzevuVVf8Tt9j2s3T5dm6nU0iXXu4kA8K3nJ++l78ojV
hEgC6F8V34hF/H7KqS8ziML/WwiHW7U6TzEsFPkLi2dxRmFftpNBgDNa0WHuNOll
gbXQagyreYrr8AZ1iJQPSfSc/VRYCd2U9dVmqGzxwyBJ7ZmKQi/bR5hFydNXTAvM
n7L/rKSI+2R9Yx4pHqkmuZeQxYmWA6CEyfXR6hmI3+HBpBvduJmA9hV8ExTJTWkX
zJWOvhF7qnYrRp26pZQROelv4Wy1b/Y3PJ7GK6sZM0CfeAfjoUaXGZmT1Y1dNxpH
bQFJ4Y+/fA1lm3Mp+2Tv2DS0ctgXi4ZM25JwnWt3PzgMXvL+3rw=
=3n2W
-----END PGP SIGNATURE-----

--Apple-Mail=_AD99028E-9BBB-4F95-BB01-A1E4D6C8AACF--
