Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0056.outbound.protection.outlook.com ([104.47.41.56]:5860
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725898AbeICNcJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Sep 2018 09:32:09 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: remove debug from pblk_[down/up]_page
Date: Mon, 3 Sep 2018 09:12:48 +0000
Message-ID: <D61CDC07-86BC-434A-AE01-135E7B09042C@cnexlabs.com>
References: <20180829140832.29341-1-mb@lightnvm.io>
 <AAA74C68-4C22-48C8-B138-1C8EE72A875C@cnexlabs.com>
 <e0076c19-7e7e-b51a-1f25-25250ed88b5c@lightnvm.io>
In-Reply-To: <e0076c19-7e7e-b51a-1f25-25250ed88b5c@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_2A8167DA-39A9-403D-8AC3-AB44953D2B97";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_2A8167DA-39A9-403D-8AC3-AB44953D2B97
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 31 Aug 2018, at 16.22, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/31/2018 02:11 PM, Javier Gonzalez wrote:
>>> On 29 Aug 2018, at 16.08, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> Remove the debug only iteration within __pblk_down_page, which
>>> then allows us to reduce the number of arguments down to pblk and
>>> the parallel unit from the functions that calls it. Simplifying the
>>> callers logic considerably.
>>>=20
>>> Also, rename the functions pblk_[down/up]_page to pblk_[down/up]_pu,
>>> to communicate that it takes a lock on the parallel unit.
>>>=20
>>> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
>>> ---
>>> drivers/lightnvm/pblk-core.c     | 34 =
+++++++++-------------------------
>>> drivers/lightnvm/pblk-map.c      |  2 +-
>>> drivers/lightnvm/pblk-recovery.c |  6 +++---
>>> drivers/lightnvm/pblk-write.c    |  6 +++---
>>> drivers/lightnvm/pblk.h          |  6 +++---
>>> 5 files changed, 19 insertions(+), 35 deletions(-)
>>>=20
>>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>>> index bb1a7cc24cbb..08df6bcd2f81 100644
>>> --- a/drivers/lightnvm/pblk-core.c
>>> +++ b/drivers/lightnvm/pblk-core.c
>>> @@ -1861,8 +1861,7 @@ void pblk_gen_run_ws(struct pblk *pblk, struct =
pblk_line *line, void *priv,
>>> 	queue_work(wq, &line_ws->ws);
>>> }
>>>=20
>>> -static void __pblk_down_page(struct pblk *pblk, struct ppa_addr =
*ppa_list,
>>> -			     int nr_ppas, int pos)
>>> +static void __pblk_down_pu(struct pblk *pblk, int pos)
>>> {
>>> 	struct pblk_lun *rlun =3D &pblk->luns[pos];
>>> 	int ret;
>>> @@ -1871,13 +1870,6 @@ static void __pblk_down_page(struct pblk =
*pblk, struct ppa_addr *ppa_list,
>>> 	 * Only send one inflight I/O per LUN. Since we map at a page
>>> 	 * granurality, all ppas in the I/O will map to the same LUN
>>> 	 */
>>> -#ifdef CONFIG_NVM_PBLK_DEBUG
>>> -	int i;
>>> -
>>> -	for (i =3D 1; i < nr_ppas; i++)
>>> -		WARN_ON(ppa_list[0].a.lun !=3D ppa_list[i].a.lun ||
>>> -				ppa_list[0].a.ch !=3D ppa_list[i].a.ch);
>>> -#endif
>>>=20
>>> 	ret =3D down_timeout(&rlun->wr_sem, msecs_to_jiffies(30000));
>>> 	if (ret =3D=3D -ETIME || ret =3D=3D -EINTR)
>>> @@ -1885,21 +1877,21 @@ static void __pblk_down_page(struct pblk =
*pblk, struct ppa_addr *ppa_list,
>>> 				-ret);
>>> }
>>>=20
>>> -void pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list, =
int nr_ppas)
>>> +void pblk_down_pu(struct pblk *pblk, struct ppa_addr ppa)
>>> {
>>> 	struct nvm_tgt_dev *dev =3D pblk->dev;
>>> 	struct nvm_geo *geo =3D &dev->geo;
>>> -	int pos =3D pblk_ppa_to_pos(geo, ppa_list[0]);
>>> +	int pos =3D pblk_ppa_to_pos(geo, ppa);
>>>=20
>>> -	__pblk_down_page(pblk, ppa_list, nr_ppas, pos);
>>> +	__pblk_down_pu(pblk, pos);
>>> }
>>>=20
>>> -void pblk_down_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int =
nr_ppas,
>>> +void pblk_down_rq(struct pblk *pblk, struct ppa_addr ppa,
>>> 		  unsigned long *lun_bitmap)
>>> {
>>> 	struct nvm_tgt_dev *dev =3D pblk->dev;
>>> 	struct nvm_geo *geo =3D &dev->geo;
>>> -	int pos =3D pblk_ppa_to_pos(geo, ppa_list[0]);
>>> +	int pos =3D pblk_ppa_to_pos(geo, ppa);
>>>=20
>>> 	/* If the LUN has been locked for this same request, do no =
attempt to
>>> 	 * lock it again
>>> @@ -1907,23 +1899,15 @@ void pblk_down_rq(struct pblk *pblk, struct =
ppa_addr *ppa_list, int nr_ppas,
>>> 	if (test_and_set_bit(pos, lun_bitmap))
>>> 		return;
>>>=20
>>> -	__pblk_down_page(pblk, ppa_list, nr_ppas, pos);
>>> +	__pblk_down_pu(pblk, pos);
>>> }
>>>=20
>>> -void pblk_up_page(struct pblk *pblk, struct ppa_addr *ppa_list, int =
nr_ppas)
>>> +void pblk_up_pu(struct pblk *pblk, struct ppa_addr ppa)
>>> {
>>> 	struct nvm_tgt_dev *dev =3D pblk->dev;
>>> 	struct nvm_geo *geo =3D &dev->geo;
>>> 	struct pblk_lun *rlun;
>>> -	int pos =3D pblk_ppa_to_pos(geo, ppa_list[0]);
>>> -
>>> -#ifdef CONFIG_NVM_PBLK_DEBUG
>>> -	int i;
>>> -
>>> -	for (i =3D 1; i < nr_ppas; i++)
>>> -		WARN_ON(ppa_list[0].a.lun !=3D ppa_list[i].a.lun ||
>>> -				ppa_list[0].a.ch !=3D ppa_list[i].a.ch);
>>> -#endif
>>> +	int pos =3D pblk_ppa_to_pos(geo, ppa);
>>>=20
>>> 	rlun =3D &pblk->luns[pos];
>>> 	up(&rlun->wr_sem);
>>> diff --git a/drivers/lightnvm/pblk-map.c =
b/drivers/lightnvm/pblk-map.c
>>> index dc0efb852475..ff677ca6e4e1 100644
>>> --- a/drivers/lightnvm/pblk-map.c
>>> +++ b/drivers/lightnvm/pblk-map.c
>>> @@ -79,7 +79,7 @@ static int pblk_map_page_data(struct pblk *pblk, =
unsigned int sentry,
>>> 		}
>>> 	}
>>>=20
>>> -	pblk_down_rq(pblk, ppa_list, nr_secs, lun_bitmap);
>>> +	pblk_down_rq(pblk, ppa_list[0], lun_bitmap);
>>> 	return 0;
>>> }
>>>=20
>>> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
>>> index eea901d7cebc..df624d504d24 100644
>>> --- a/drivers/lightnvm/pblk-recovery.c
>>> +++ b/drivers/lightnvm/pblk-recovery.c
>>> @@ -227,7 +227,7 @@ static void pblk_end_io_recov(struct nvm_rq =
*rqd)
>>> 	struct pblk_pad_rq *pad_rq =3D rqd->private;
>>> 	struct pblk *pblk =3D pad_rq->pblk;
>>>=20
>>> -	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
>>> +	pblk_up_pu(pblk, ppa_list[0]);
>>>=20
>>> 	pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
>>>=20
>>> @@ -339,12 +339,12 @@ static int pblk_recov_pad_oob(struct pblk =
*pblk, struct pblk_line *line,
>>> 	}
>>>=20
>>> 	kref_get(&pad_rq->ref);
>>> -	pblk_down_page(pblk, rqd->ppa_list, rqd->nr_ppas);
>>> +	pblk_down_pu(pblk, rqd->ppa_list[0]);
>>>=20
>>> 	ret =3D pblk_submit_io(pblk, rqd);
>>> 	if (ret) {
>>> 		pblk_err(pblk, "I/O submission failed: %d\n", ret);
>>> -		pblk_up_page(pblk, rqd->ppa_list, rqd->nr_ppas);
>>> +		pblk_up_pu(pblk, rqd->ppa_list[0]);
>>> 		goto fail_free_bio;
>>> 	}
>>>=20
>>> diff --git a/drivers/lightnvm/pblk-write.c =
b/drivers/lightnvm/pblk-write.c
>>> index cd579b440b56..55d198edd70a 100644
>>> --- a/drivers/lightnvm/pblk-write.c
>>> +++ b/drivers/lightnvm/pblk-write.c
>>> @@ -270,7 +270,7 @@ static void pblk_end_io_write_meta(struct nvm_rq =
*rqd)
>>> 	struct ppa_addr *ppa_list =3D nvm_rq_to_ppa_list(rqd);
>>> 	int sync;
>>>=20
>>> -	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
>>> +	pblk_up_pu(pblk, ppa_list[0]);
>>>=20
>>> 	if (rqd->error) {
>>> 		pblk_log_write_err(pblk, rqd);
>>> @@ -420,7 +420,7 @@ int pblk_submit_meta_io(struct pblk *pblk, =
struct pblk_line *meta_line)
>>> 		list_del(&meta_line->list);
>>> 	spin_unlock(&l_mg->close_lock);
>>>=20
>>> -	pblk_down_page(pblk, ppa_list, rqd->nr_ppas);
>>> +	pblk_down_pu(pblk, ppa_list[0]);
>>>=20
>>> 	ret =3D pblk_submit_io(pblk, rqd);
>>> 	if (ret) {
>>> @@ -431,7 +431,7 @@ int pblk_submit_meta_io(struct pblk *pblk, =
struct pblk_line *meta_line)
>>> 	return NVM_IO_OK;
>>>=20
>>> fail_rollback:
>>> -	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
>>> +	pblk_up_pu(pblk, ppa_list[0]);
>>> 	spin_lock(&l_mg->close_lock);
>>> 	pblk_dealloc_page(pblk, meta_line, rq_ppas);
>>> 	list_add(&meta_line->list, &meta_line->list);
>>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>>> index 2f61f4428fcb..390855375b1e 100644
>>> --- a/drivers/lightnvm/pblk.h
>>> +++ b/drivers/lightnvm/pblk.h
>>> @@ -823,10 +823,10 @@ u64 pblk_alloc_page(struct pblk *pblk, struct =
pblk_line *line, int nr_secs);
>>> u64 __pblk_alloc_page(struct pblk *pblk, struct pblk_line *line, int =
nr_secs);
>>> int pblk_calc_secs(struct pblk *pblk, unsigned long secs_avail,
>>> 		   unsigned long secs_to_flush);
>>> -void pblk_up_page(struct pblk *pblk, struct ppa_addr *ppa_list, int =
nr_ppas);
>>> -void pblk_down_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int =
nr_ppas,
>>> +void pblk_up_pu(struct pblk *pblk, struct ppa_addr ppa);
>>> +void pblk_down_rq(struct pblk *pblk, struct ppa_addr ppa,
>>> 		  unsigned long *lun_bitmap);
>>> -void pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list, =
int nr_ppas);
>>> +void pblk_down_pu(struct pblk *pblk, struct ppa_addr ppa);
>>> void pblk_up_rq(struct pblk *pblk, unsigned long *lun_bitmap);
>>> int pblk_bio_add_pages(struct pblk *pblk, struct bio *bio, gfp_t =
flags,
>>> 		       int nr_pages);
>>> --
>>> 2.11.0
>> The patch looks good to me. The renaming to PU though is confusing. =
The
>> underlying reason to take the semaphore is to avoid write pointer
>> violations. At the moment, we only have an open line in pblk, which
>> makes that the semaphore effectively protects a PU, but when we have
>> several open lines this is no longer true.
>=20
> I don't understand this, how will it change when multiple lines are =
active?
>=20
> My guess is that one has to keep track of the number of outstanding
> I/Os for each PU.

The confusion comes from the current semaphore having 2 purposes: (i)
guaranteeing the write pointer at a chunk level, and (ii) being the
mechanism used by the scheduler to minimize internal write collisions.
When we have several open lines this semaphore will still be used for
(i), however, we will need a separate mechanism for (ii).

> Regarding naming, pblk_[down/up]_line doesn't quite cut it, and _page
> doesn't mean anything to me. Can we find a better name?

Give the above, what do you say pblk_[down/up]_chunk?

Javier


--Apple-Mail=_2A8167DA-39A9-403D-8AC3-AB44953D2B97
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluM+wwACgkQIX4xUKFR
nnTb7xAApQfZnUoRKCccbptqxfIcU04aXq4XPG4D/8nVuLBfhrsygngpoL+Ywb20
P5IqeIgLdBoj3tuWmCvAqZwCPM0oN5Eo1xsok0UHyDPVWdvegVMN3C/qSNE02Bud
2dFavgbQ+iP0XBl/Mo8ITAUaZYHSWWtGdqfBKH/NRmo/kyCIeIZjf3Yr2FeWQcAx
7K3W6qnzaymuE5pC14Kc9XqpWP8ING23w43nNFkGEJMZ8qUmjKOkZCVHqe/4mwU+
Nf5SYCu4jPDudVUwwcmx6+bJoXiVagWHGQzfkGv8i3goB3jxnlPDXl0c3wYaUvZH
vUaGofT9jiYLIpKqhqLn5yWMbK1zHbu7fP42Lu+IETKpcicdtA5ebwA6Ck7QEFFr
FYyhfsvQB5cXQfP/AdOWf+kLdUq/E+ZBHuMWWeb1llpvkJIsGtCMPBDNSMdkOsha
eqJDN66OwwAuMa5b4DbpDTZX6c8y/54T2Y4CyrOUVPqepbc1BxIm1QDP/vBU93G4
OfDhmG1batMe549CeNXdwg/OP2nTWf9dwsmcSqCTsjIVLOc5mBwm38bdmEPHUDQb
rDNM5XqGBFD/xr6J6/Wo59I003cYYobrPW3AmbqRI45MalbjkwAAMQgjWg054vP7
1D9lE35oSFlubM9iiF4uKw77j3678aLjV7qpU1HOhL0UHbcShk8=
=gWI5
-----END PGP SIGNATURE-----

--Apple-Mail=_2A8167DA-39A9-403D-8AC3-AB44953D2B97--
