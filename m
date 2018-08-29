Return-Path: <javier@cnexlabs.com>
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] lightnvm: encapsule rqd dma allocations
Date: Wed, 29 Aug 2018 13:41:31 +0000
Message-ID: <1CF9AE13-2C0C-426C-8B62-E0B111EDEB5E@cnexlabs.com>
References: <1535532980-27672-1-git-send-email-javier@cnexlabs.com>
 <1535532980-27672-3-git-send-email-javier@cnexlabs.com>
 <559e39f2-1601-95ea-9305-6a0566943798@lightnvm.io>
 <8B4755CD-3C36-49B4-9F94-1169E19EF090@cnexlabs.com>
 <e5d4678d-814d-e2a5-da3e-66245034743f@lightnvm.io>
In-Reply-To: <e5d4678d-814d-e2a5-da3e-66245034743f@lightnvm.io>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_374DE656-96F6-42B8-814F-1FA0FD472052";
	protocol="application/pgp-signature";
	micalg=pgp-sha512
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

--Apple-Mail=_374DE656-96F6-42B8-814F-1FA0FD472052
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 29 Aug 2018, at 15.36, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/29/2018 03:18 PM, Javier Gonzalez wrote:
>>> On 29 Aug 2018, at 15.00, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 08/29/2018 10:56 AM, Javier Gonz=C3=A1lez wrote:
>>>> dma allocations for ppa_list and meta_list in rqd are replicated in
>>>> several places across the pblk codebase. Make helpers to =
encapsulate
>>>> creation and deletion to simplify the code.
>>>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>>>> ---
>>>>  drivers/lightnvm/pblk-core.c     | 69 =
+++++++++++++++++++++++++---------------
>>>>  drivers/lightnvm/pblk-read.c     | 35 ++++++++++----------
>>>>  drivers/lightnvm/pblk-recovery.c | 29 ++++++-----------
>>>>  drivers/lightnvm/pblk-write.c    | 15 ++-------
>>>>  drivers/lightnvm/pblk.h          |  3 ++
>>>>  5 files changed, 74 insertions(+), 77 deletions(-)
>>>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>>>> index 09160ec02c5f..767178185f19 100644
>>>> --- a/drivers/lightnvm/pblk-core.c
>>>> +++ b/drivers/lightnvm/pblk-core.c
>>>> @@ -237,6 +237,34 @@ static void pblk_invalidate_range(struct pblk =
*pblk, sector_t slba,
>>>>  	spin_unlock(&pblk->trans_lock);
>>>>  }
>>>>  +int pblk_setup_rqd(struct pblk *pblk, struct nvm_rq *rqd, gfp_t =
mem_flags,
>>>> +		   bool is_vector)
>>>=20
>>>=20
>>> The mem_flags argument can be removed. It is GFP_KERNEL from all the
>>> places it is called.
>> Thought it was better to have the flexibility in a helper function, =
but
>> we can always add it later on if needed...
>>> is_vector, will be better to do nr_ppas (or similar name). Then
>>> pblk_submit_read/pblk_submit_read_gc are a bit cleaner.
>> We can do that too, yes.
>>>> +{
>>>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>>>> +
>>>> +	rqd->meta_list =3D nvm_dev_dma_alloc(dev->parent, mem_flags,
>>>> +							=
&rqd->dma_meta_list);
>>>> +	if (!rqd->meta_list)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	if (!is_vector)
>>>> +		return 0;
>>>> +
>>>> +	rqd->ppa_list =3D rqd->meta_list + pblk_dma_meta_size;
>>>> +	rqd->dma_ppa_list =3D rqd->dma_meta_list + pblk_dma_meta_size;
>>>=20
>>> Wrt to is_vector, does it matter if we just set ppa_list and
>>> dma_ppa_list? If we have them, we use them, else leave them alone?
>> If we only have 1 address then ppa_addr is set and the ppa_list =
attempt
>> to free in the completion path interpreting ppa_addr as the dma =
address.
>> So I don't think so - unless I'm missing something?
>=20
> In that case, we could drop is_vector/nr_ppas all together? That would =
be nice.
>=20

The problem is that the metadata region still needs to be used, even if
the ppa_list is not set. Thing that the oob area can be larger than
64bits, so we cannot do the dma address is the actual value trick.

So if encapsulating, we need to know if we need to allocate the ppa_list
or not.

Does it make sense?

>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +void pblk_clear_rqd(struct pblk *pblk, struct nvm_rq *rqd)
>>>> +{
>>>> +	struct nvm_tgt_dev *dev =3D pblk->dev;
>>>> +
>>>> +	if (rqd->meta_list)
>>>> +		nvm_dev_dma_free(dev->parent, rqd->meta_list,
>>>> +				rqd->dma_meta_list);
>>>> +}
>>>=20
>>> Looks like setup/clear is mainly about managing the metadata. Would
>>> pblk_alloc_rqd_meta()/pblk_free/rqd_meta be better names? Unless we
>>> can fold it all into pblk_alloc_rqd/pblk_free_rqd.
>> It's not easy to fold them there as we use nvm_rq allocations without
>> extra space in the rqd for metadata. This is also a problem for rqd
>> allocated in the stack. But I can change the names to make the
>> functionality more clear.
>=20
> Yep, that was what I felt as well. Renaming will be good.

Cool. Will do.

--Apple-Mail=_374DE656-96F6-42B8-814F-1FA0FD472052
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluGoogACgkQIX4xUKFR
nnRXxRAAxxJ/WsmBXfJiysYosPG+8VK26oBcpmFAF7We79TbP48V1oAYukwgfDGn
79s/umkCmvFOZ7/G3ff56GjUdMiTybAxO2Z8niCgCn7xmafNQ24s6eeJMB4bI/Xi
oNIGpUTyauyZqLhZiRVIw1lvcyxbrL52ze/zA2JW4mh02BszdbAMDGo0hbbvv8TG
SykmiDlxZHB320gVeKNfGL4PJLgs1eQQZw8B/n0TMzmQh9vMmPMbUPqM1UrMZZ3J
cBlkzncOAzLPbHhp58s6GvSVKBQGcnLChbtTXG2a2ruLbBUjuFJL3fWx0WPgbv1Y
dBWhqwHQ19AD/OYOXTSOufLgt17abbhT+76S1F28sszK+Qp05SODjEdEh/DtbBxG
ktI4Onb+OYHOWx5yGkmsejuUMpRIrt0uZpWhDaAcE115u3LVBcCCu0rMJ6LE/4a+
zqmf3dfmmIefHuKYfvO6WLr5qU2BGmCiIJ+gJXk6Eo0pXKVOBMzr+JpVAKUHhYXB
pevuKoDP1iKQ+utPMbXAz1EgHxfifxhciKZHrMQxfh5QLtJ3RhPT77YkmRagkCTs
iGUvtpHNgjJRv47TH20gJr9L0JjM9Y0QNL6/sAkEGguwFDQ5SCdW5vuNVmWd9gwM
zbqiTK9o8GVRHszybkPOuHUn+SD+ebRer46D5owXIdHaDLsE9j0=
=sRjE
-----END PGP SIGNATURE-----

--Apple-Mail=_374DE656-96F6-42B8-814F-1FA0FD472052--
