Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam01on0041.outbound.protection.outlook.com ([104.47.32.41]:41824
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726312AbeIDViv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Sep 2018 17:38:51 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "Dziegielewski, Marcin" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: remove debug from pblk_[down/up]_page
Date: Tue, 4 Sep 2018 17:12:36 +0000
Message-ID: <0E11AFCC-AE0F-4DF4-A6DA-E57CCD423231@cnexlabs.com>
References: <20180829140832.29341-1-mb@lightnvm.io>
 <AAA74C68-4C22-48C8-B138-1C8EE72A875C@cnexlabs.com>
 <e0076c19-7e7e-b51a-1f25-25250ed88b5c@lightnvm.io>
 <D61CDC07-86BC-434A-AE01-135E7B09042C@cnexlabs.com>
 <ba7202f4-b3d4-4d33-d64e-075dca4545e1@lightnvm.io>
In-Reply-To: <ba7202f4-b3d4-4d33-d64e-075dca4545e1@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_5690FC3B-5253-432A-BAE5-320FA46D9F04";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_5690FC3B-5253-432A-BAE5-320FA46D9F04
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 4 Sep 2018, at 02.49, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 09/03/2018 11:12 AM, Javier Gonzalez wrote:
>>> On 31 Aug 2018, at 16.22, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 08/31/2018 02:11 PM, Javier Gonzalez wrote:
>>>>> On 29 Aug 2018, at 16.08, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>>>=20
>>>>> Remove the debug only iteration within __pblk_down_page, which
>>>>> then allows us to reduce the number of arguments down to pblk and
>>>>> the parallel unit from the functions that calls it. Simplifying =
the
>>>>> callers logic considerably.
>>>>>=20
>>>>> Also, rename the functions pblk_[down/up]_page to =
pblk_[down/up]_pu,
>>>>> to communicate that it takes a lock on the parallel unit.
>>>>>=20
>>>>> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
>>>>> ---
>>>>> drivers/lightnvm/pblk-core.c     | 34 =
+++++++++-------------------------
>>>>> drivers/lightnvm/pblk-map.c      |  2 +-
>>>>> drivers/lightnvm/pblk-recovery.c |  6 +++---
>>>>> drivers/lightnvm/pblk-write.c    |  6 +++---
>>>>> drivers/lightnvm/pblk.h          |  6 +++---
>>>>> 5 files changed, 19 insertions(+), 35 deletions(-)
>>>>>=20
>>>>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>>>>> index bb1a7cc24cbb..08df6bcd2f81 100644
>>>>> --- a/drivers/lightnvm/pblk-core.c
>>>>> +++ b/drivers/lightnvm/pblk-core.c
>>>>> @@ -1861,8 +1861,7 @@ void pblk_gen_run_ws(struct pblk *pblk, =
struct pblk_line *line, void *priv,
>>>>> 	queue_work(wq, &line_ws->ws);
>>>>> }
>>>>>=20
>>>>> -static void __pblk_down_page(struct pblk *pblk, struct ppa_addr =
*ppa_list,
>>>>> -			     int nr_ppas, int pos)
>>>>> +static void __pblk_down_pu(struct pblk *pblk, int pos)
>>>>> {
>>>>> 	struct pblk_lun *rlun =3D &pblk->luns[pos];
>>>>> 	int ret;
>>>>> @@ -1871,13 +1870,6 @@ static void __pblk_down_page(struct pblk =
*pblk, struct ppa_addr *ppa_list,
>>>>> 	 * Only send one inflight I/O per LUN. Since we map at a page
>>>>> 	 * granurality, all ppas in the I/O will map to the same LUN
>>>>> 	 */
>>>>> -#ifdef CONFIG_NVM_PBLK_DEBUG
>>>>> -	int i;
>>>>> -
>>>>> -	for (i =3D 1; i < nr_ppas; i++)
>>>>> -		WARN_ON(ppa_list[0].a.lun !=3D ppa_list[i].a.lun ||
>>>>> -				ppa_list[0].a.ch !=3D ppa_list[i].a.ch);
>>>>> -#endif
>>>>>=20
>>>>> 	ret =3D down_timeout(&rlun->wr_sem, msecs_to_jiffies(30000));
>>>>> 	if (ret =3D=3D -ETIME || ret =3D=3D -EINTR)
>>>>> @@ -1885,21 +1877,21 @@ static void __pblk_down_page(struct pblk =
*pblk, struct ppa_addr *ppa_list,
>>>>> 				-ret);
>>>>> }
>>>>>=20
>>>>> -void pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list, =
int nr_ppas)
>>>>> +void pblk_down_pu(struct pblk *pblk, struct ppa_addr ppa)
>>>>> {
>>>>> 	struct nvm_tgt_dev *dev =3D pblk->dev;
>>>>> 	struct nvm_geo *geo =3D &dev->geo;
>>>>> -	int pos =3D pblk_ppa_to_pos(geo, ppa_list[0]);
>>>>> +	int pos =3D pblk_ppa_to_pos(geo, ppa);
>>>>>=20
>>>>> -	__pblk_down_page(pblk, ppa_list, nr_ppas, pos);
>>>>> +	__pblk_down_pu(pblk, pos);
>>>>> }
>>>>>=20
>>>>> -void pblk_down_rq(struct pblk *pblk, struct ppa_addr *ppa_list, =
int nr_ppas,
>>>>> +void pblk_down_rq(struct pblk *pblk, struct ppa_addr ppa,
>>>>> 		  unsigned long *lun_bitmap)
>>>>> {
>>>>> 	struct nvm_tgt_dev *dev =3D pblk->dev;
>>>>> 	struct nvm_geo *geo =3D &dev->geo;
>>>>> -	int pos =3D pblk_ppa_to_pos(geo, ppa_list[0]);
>>>>> +	int pos =3D pblk_ppa_to_pos(geo, ppa);
>>>>>=20
>>>>> 	/* If the LUN has been locked for this same request, do no =
attempt to
>>>>> 	 * lock it again
>>>>> @@ -1907,23 +1899,15 @@ void pblk_down_rq(struct pblk *pblk, =
struct ppa_addr *ppa_list, int nr_ppas,
>>>>> 	if (test_and_set_bit(pos, lun_bitmap))
>>>>> 		return;
>>>>>=20
>>>>> -	__pblk_down_page(pblk, ppa_list, nr_ppas, pos);
>>>>> +	__pblk_down_pu(pblk, pos);
>>>>> }
>>>>>=20
>>>>> -void pblk_up_page(struct pblk *pblk, struct ppa_addr *ppa_list, =
int nr_ppas)
>>>>> +void pblk_up_pu(struct pblk *pblk, struct ppa_addr ppa)
>>>>> {
>>>>> 	struct nvm_tgt_dev *dev =3D pblk->dev;
>>>>> 	struct nvm_geo *geo =3D &dev->geo;
>>>>> 	struct pblk_lun *rlun;
>>>>> -	int pos =3D pblk_ppa_to_pos(geo, ppa_list[0]);
>>>>> -
>>>>> -#ifdef CONFIG_NVM_PBLK_DEBUG
>>>>> -	int i;
>>>>> -
>>>>> -	for (i =3D 1; i < nr_ppas; i++)
>>>>> -		WARN_ON(ppa_list[0].a.lun !=3D ppa_list[i].a.lun ||
>>>>> -				ppa_list[0].a.ch !=3D ppa_list[i].a.ch);
>>>>> -#endif
>>>>> +	int pos =3D pblk_ppa_to_pos(geo, ppa);
>>>>>=20
>>>>> 	rlun =3D &pblk->luns[pos];
>>>>> 	up(&rlun->wr_sem);
>>>>> diff --git a/drivers/lightnvm/pblk-map.c =
b/drivers/lightnvm/pblk-map.c
>>>>> index dc0efb852475..ff677ca6e4e1 100644
>>>>> --- a/drivers/lightnvm/pblk-map.c
>>>>> +++ b/drivers/lightnvm/pblk-map.c
>>>>> @@ -79,7 +79,7 @@ static int pblk_map_page_data(struct pblk *pblk, =
unsigned int sentry,
>>>>> 		}
>>>>> 	}
>>>>>=20
>>>>> -	pblk_down_rq(pblk, ppa_list, nr_secs, lun_bitmap);
>>>>> +	pblk_down_rq(pblk, ppa_list[0], lun_bitmap);
>>>>> 	return 0;
>>>>> }
>>>>>=20
>>>>> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
>>>>> index eea901d7cebc..df624d504d24 100644
>>>>> --- a/drivers/lightnvm/pblk-recovery.c
>>>>> +++ b/drivers/lightnvm/pblk-recovery.c
>>>>> @@ -227,7 +227,7 @@ static void pblk_end_io_recov(struct nvm_rq =
*rqd)
>>>>> 	struct pblk_pad_rq *pad_rq =3D rqd->private;
>>>>> 	struct pblk *pblk =3D pad_rq->pblk;
>>>>>=20
>>>>> -	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
>>>>> +	pblk_up_pu(pblk, ppa_list[0]);
>>>>>=20
>>>>> 	pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
>>>>>=20
>>>>> @@ -339,12 +339,12 @@ static int pblk_recov_pad_oob(struct pblk =
*pblk, struct pblk_line *line,
>>>>> 	}
>>>>>=20
>>>>> 	kref_get(&pad_rq->ref);
>>>>> -	pblk_down_page(pblk, rqd->ppa_list, rqd->nr_ppas);
>>>>> +	pblk_down_pu(pblk, rqd->ppa_list[0]);
>>>>>=20
>>>>> 	ret =3D pblk_submit_io(pblk, rqd);
>>>>> 	if (ret) {
>>>>> 		pblk_err(pblk, "I/O submission failed: %d\n", ret);
>>>>> -		pblk_up_page(pblk, rqd->ppa_list, rqd->nr_ppas);
>>>>> +		pblk_up_pu(pblk, rqd->ppa_list[0]);
>>>>> 		goto fail_free_bio;
>>>>> 	}
>>>>>=20
>>>>> diff --git a/drivers/lightnvm/pblk-write.c =
b/drivers/lightnvm/pblk-write.c
>>>>> index cd579b440b56..55d198edd70a 100644
>>>>> --- a/drivers/lightnvm/pblk-write.c
>>>>> +++ b/drivers/lightnvm/pblk-write.c
>>>>> @@ -270,7 +270,7 @@ static void pblk_end_io_write_meta(struct =
nvm_rq *rqd)
>>>>> 	struct ppa_addr *ppa_list =3D nvm_rq_to_ppa_list(rqd);
>>>>> 	int sync;
>>>>>=20
>>>>> -	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
>>>>> +	pblk_up_pu(pblk, ppa_list[0]);
>>>>>=20
>>>>> 	if (rqd->error) {
>>>>> 		pblk_log_write_err(pblk, rqd);
>>>>> @@ -420,7 +420,7 @@ int pblk_submit_meta_io(struct pblk *pblk, =
struct pblk_line *meta_line)
>>>>> 		list_del(&meta_line->list);
>>>>> 	spin_unlock(&l_mg->close_lock);
>>>>>=20
>>>>> -	pblk_down_page(pblk, ppa_list, rqd->nr_ppas);
>>>>> +	pblk_down_pu(pblk, ppa_list[0]);
>>>>>=20
>>>>> 	ret =3D pblk_submit_io(pblk, rqd);
>>>>> 	if (ret) {
>>>>> @@ -431,7 +431,7 @@ int pblk_submit_meta_io(struct pblk *pblk, =
struct pblk_line *meta_line)
>>>>> 	return NVM_IO_OK;
>>>>>=20
>>>>> fail_rollback:
>>>>> -	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
>>>>> +	pblk_up_pu(pblk, ppa_list[0]);
>>>>> 	spin_lock(&l_mg->close_lock);
>>>>> 	pblk_dealloc_page(pblk, meta_line, rq_ppas);
>>>>> 	list_add(&meta_line->list, &meta_line->list);
>>>>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>>>>> index 2f61f4428fcb..390855375b1e 100644
>>>>> --- a/drivers/lightnvm/pblk.h
>>>>> +++ b/drivers/lightnvm/pblk.h
>>>>> @@ -823,10 +823,10 @@ u64 pblk_alloc_page(struct pblk *pblk, =
struct pblk_line *line, int nr_secs);
>>>>> u64 __pblk_alloc_page(struct pblk *pblk, struct pblk_line *line, =
int nr_secs);
>>>>> int pblk_calc_secs(struct pblk *pblk, unsigned long secs_avail,
>>>>> 		   unsigned long secs_to_flush);
>>>>> -void pblk_up_page(struct pblk *pblk, struct ppa_addr *ppa_list, =
int nr_ppas);
>>>>> -void pblk_down_rq(struct pblk *pblk, struct ppa_addr *ppa_list, =
int nr_ppas,
>>>>> +void pblk_up_pu(struct pblk *pblk, struct ppa_addr ppa);
>>>>> +void pblk_down_rq(struct pblk *pblk, struct ppa_addr ppa,
>>>>> 		  unsigned long *lun_bitmap);
>>>>> -void pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list, =
int nr_ppas);
>>>>> +void pblk_down_pu(struct pblk *pblk, struct ppa_addr ppa);
>>>>> void pblk_up_rq(struct pblk *pblk, unsigned long *lun_bitmap);
>>>>> int pblk_bio_add_pages(struct pblk *pblk, struct bio *bio, gfp_t =
flags,
>>>>> 		       int nr_pages);
>>>>> --
>>>>> 2.11.0
>>>> The patch looks good to me. The renaming to PU though is confusing. =
The
>>>> underlying reason to take the semaphore is to avoid write pointer
>>>> violations. At the moment, we only have an open line in pblk, which
>>>> makes that the semaphore effectively protects a PU, but when we =
have
>>>> several open lines this is no longer true.
>>>=20
>>> I don't understand this, how will it change when multiple lines are =
active?
>>>=20
>>> My guess is that one has to keep track of the number of outstanding
>>> I/Os for each PU.
>> The confusion comes from the current semaphore having 2 purposes: (i)
>> guaranteeing the write pointer at a chunk level, and (ii) being the
>> mechanism used by the scheduler to minimize internal write =
collisions.
>> When we have several open lines this semaphore will still be used for
>> (i), however, we will need a separate mechanism for (ii).
>>> Regarding naming, pblk_[down/up]_line doesn't quite cut it, and =
_page
>>> doesn't mean anything to me. Can we find a better name?
>> Give the above, what do you say pblk_[down/up]_chunk?
>=20
> Ok, works for me. I'll update the patch and push. If getting to
> multiple chunks per PU, then this can be flushed out to remove the
> rest of the confusion.
>=20
> Thanks.

Great. Thanks!


--Apple-Mail=_5690FC3B-5253-432A-BAE5-320FA46D9F04
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluOvQIACgkQIX4xUKFR
nnSsJQ/+JHYLP3xmyPXErNtF+y6ZlRVNJ6eRvkSteRz5ZiqGBY/m5MhjqU/t3UCA
uPS2E8pWRwGg1t+WRSl9QP4fqkCCH6oKNYVGmCNkOoyDaDLlH5dL5JCrrmquQNaK
a2PV19fbLWPMcJDdhiHCL08XKllFHd1dANKVRVK05BmW8YFAurILDtNOw2+B9zb0
PwM4ib0e7ittlJNgQ8KR2AriuVYy3+m8LHvCc3RcioW84Zcg7S+8IQhscT48J/kl
fAhaA1nwsoUwHa9ctm7pZKvyb+04IaXrA1mA181Sp7BxFKf7gUyFyl19b4fovCmA
dFuX1NtrsS/Qj6Ynh7uYHV2V6fvyTznOGyfX+GtlJofo/dd2PPimjqPcAiTP45ru
7W5Ftno8x+nwvesgrdm/bzsHKyigvnIltoYVDVgDfywYkdfEgTrTGn15bKUti7NE
RmLdDS9qe9AEg8m8Ix5oJfJC9qrneHB3Gt3Gyw2WEKrtIVkIRcEpLJUD8PNi6WF2
P8EZyV/4qvlNFXM3KkpgT0dcuHt4dqthHNMrnxOc3/VPmflgjZQcQfP7j6Tpb4Gg
KcZgh6GunzLtMaruT6jZrS2ARhNnvgxaAZXzZJ6BOLzecjcT0pRIRlGWAAEp557L
UabgKLD3TfMarzGAGELs7Ev0en/n1THCFkki+RO3FkauRJ4q82I=
=3MHg
-----END PGP SIGNATURE-----

--Apple-Mail=_5690FC3B-5253-432A-BAE5-320FA46D9F04--
