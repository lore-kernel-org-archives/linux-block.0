Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37117 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751825AbdDIJPF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Apr 2017 05:15:05 -0400
Received: by mail-wm0-f52.google.com with SMTP id u2so17986945wmu.0
        for <linux-block@vger.kernel.org>; Sun, 09 Apr 2017 02:15:04 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <E42A544D-D09C-4DDB-800A-9FCED4CBBD28@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_9DFA9224-AA4E-4DCC-96F5-36DE58ACDCDE";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3] lightnvm: physical block device (pblk) target
Date: Sun, 9 Apr 2017 11:15:00 +0200
In-Reply-To: <CY1PR0401MB1536AD7F70C960D62DCA6983810F0@CY1PR0401MB1536.namprd04.prod.outlook.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Bart Van Assche <bart.vanassche@sandisk.com>
References: <1491591015-7554-1-git-send-email-javier@cnexlabs.com>
 <1491591015-7554-2-git-send-email-javier@cnexlabs.com>
 <CY1PR0401MB1536AD7F70C960D62DCA6983810F0@CY1PR0401MB1536.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_9DFA9224-AA4E-4DCC-96F5-36DE58ACDCDE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Bart,

Thanks for reviewing the code.

> On 8 Apr 2017, at 22.56, Bart Van Assche <bart.vanassche@sandisk.com> =
wrote:
>=20
> On 04/07/17 11:50, Javier Gonz=C3=A1lez wrote:
>> Documentation/lightnvm/pblk.txt  |   21 +
>> drivers/lightnvm/Kconfig         |   19 +
>> drivers/lightnvm/Makefile        |    5 +
>> drivers/lightnvm/pblk-cache.c    |  112 +++
>> drivers/lightnvm/pblk-core.c     | 1641 =
++++++++++++++++++++++++++++++++++++++
>> drivers/lightnvm/pblk-gc.c       |  542 +++++++++++++
>> drivers/lightnvm/pblk-init.c     |  942 ++++++++++++++++++++++
>> drivers/lightnvm/pblk-map.c      |  135 ++++
>> drivers/lightnvm/pblk-rb.c       |  859 ++++++++++++++++++++
>> drivers/lightnvm/pblk-read.c     |  513 ++++++++++++
>> drivers/lightnvm/pblk-recovery.c | 1007 +++++++++++++++++++++++
>> drivers/lightnvm/pblk-rl.c       |  182 +++++
>> drivers/lightnvm/pblk-sysfs.c    |  500 ++++++++++++
>> drivers/lightnvm/pblk-write.c    |  408 ++++++++++
>> drivers/lightnvm/pblk.h          | 1127 ++++++++++++++++++++++++++
>> include/linux/lightnvm.h         |   57 +-
>> pblk-sysfs.c                     |  581 ++++++++++++++
>=20
> This patch introduces two slightly different versions of pblk-sysfs.c =
-
> one at the top level and one in drivers/lightnvm. Please remove the =
file
> at the top level.

The top level file is a mistake; I'll remove it.

>=20
>> +config NVM_PBLK_L2P_OPT
>> +	bool "PBLK with optimized L2P table for devices up to 8TB"
>> +	depends on NVM_PBLK
>> +	---help---
>> +	Physical device addresses are typical 64-bit integers. Since we =
store
>> +	the logical to physical (L2P) table on the host, this takes =
1/500 of
>> +	host memory (e.g., 2GB per 1TB of storage media). On drives =
under 8TB,
>> +	it is possible to reduce this to 1/1000 (e.g., 1GB per 1TB). =
This
>> +	option allows to do this optimization on the host L2P table.
>=20
> Why is NVM_PBLK_L2P_OPT a compile-time option instead of a run-time
> option? Since this define does not affect the definition of the =
ppa_addr
> I don't see why this has to be a compile-time option. For e.g. Linux
> distributors the only choice would be to disable NVM_PBLK_L2P_OPT. I
> think it would be unfortunate if no Linux distribution ever would be
> able to benefit from this optimization.

struct ppa_addr, which is the physical address format is not affected,
but pblk's internal L2P address representation (pblk_addr) is. You can
see that the type either represents struct ppa_addr or ppa_addr_32. How
would you define a type that can either be u64 or u32 with different bit
offsets at run-time? Note that address conversions to this type is in
the fast path and this format allows us to only use bit shifts.

>=20
>> +#ifdef CONFIG_NVM_DEBUG
>> +	atomic_add(nr_entries, &pblk->inflight_writes);
>> +	atomic_add(nr_entries, &pblk->req_writes);
>> +#endif
>=20
> Has it been considered to use the "static key" feature such that
> consistency checks can be enabled at run-time instead of having to
> rebuild the kernel to enable CONFIG_NVM_DEBUG?

I haven't considered it. I'll look into it. I would like to have this
counters and the corresponding sysfs entry only available on debug mode
since it allows us to have a good picture of the FTL state.

>=20
>> +#ifdef CONFIG_NVM_DEBUG
>> +	BUG_ON(nr_rec_entries !=3D valid_entries);
>> +	atomic_add(valid_entries, &pblk->inflight_writes);
>> +	atomic_add(valid_entries, &pblk->recov_gc_writes);
>> +#endif
>=20
> Are you aware that Linus is strongly opposed against using BUG_ON()?
>=20

Yes, I am aware of the discussions around BUG_ON. The rationale on the
cases we have it is that they represent a pblk internal state error.
This will most probably result on a wild memory access or an
out-of-bound, which will eventually cause the kernel to crash either
way. You can see that most of them are under CONFIG_NVM_DEBUG. Would it
make sense to maintain CONFIG_NVM_DEBUG so that all BUG_ON checks are
contained within them? As far as I can read, this is not possible with
"static key"

>> +#ifdef CONFIG_NVM_DEBUG
>> +	lockdep_assert_held(&l_mg->free_lock);
>> +#endif
>=20
> Why is lockdep_assert_held() surrounded with #ifdef CONFIG_NVM_DEBUG /
> #endif? Are you aware that lockdep_assert_held() do not generate any
> code with CONFIG_PROVE_LOCKING=3Dn?

I did not know about CONFIG_PROVE_LOCKING, thanks for pointing it out.

>=20
>> +static const struct block_device_operations pblk_fops =3D {
>> +	.owner		=3D THIS_MODULE,
>> +};
>=20
> Is this data structure useful? If so, where is pblk_fops used?

It is not useful anymore. I'll remove it.

>=20
>> +static void pblk_l2p_free(struct pblk *pblk)
>> +{
>> +	vfree(pblk->trans_map);
>> +}
>> +
>> +static int pblk_l2p_init(struct pblk *pblk)
>> +{
>> +	sector_t i;
>> +
>> +	pblk->trans_map =3D vmalloc(sizeof(pblk_addr) * =
pblk->rl.nr_secs);
>> +	if (!pblk->trans_map)
>> +		return -ENOMEM;
>> +
>> +	for (i =3D 0; i < pblk->rl.nr_secs; i++)
>> +		pblk_ppa_set_empty(&pblk->trans_map[i]);
>> +
>> +	return 0;
>> +}
>=20
> Has it been considered to add support for keeping a subset of the L2P
> translation table in memory instead of keeping it in memory in its =
entirety?

Yes. L2P caching is on our roadmap and will be included in the future.

>=20
>> +	sprintf(cache_name, "pblk_line_m_%s", pblk->disk->disk_name);
>=20
> Please use snprintf() or kasprintf() instead of printf(). That makes =
it
> easier for humans to verify that no buffer overflow is triggered.
>=20

Ok.

>> +/* physical block device target */
>> +static struct nvm_tgt_type tt_pblk =3D {
>> +	.name		=3D "pblk",
>> +	.version	=3D {1, 0, 0},
>=20
> Are version numbers useful inside the kernel tree?

It allows us to relate in to the disk format version, but most probably
the version on the actual disk format structures is enough.

>=20
>> +void pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int =
sentry,
>> +		 unsigned long *lun_bitmap, unsigned int valid_secs,
>> +		 unsigned int off)
>> +{
>> +	struct pblk_sec_meta *meta_list =3D rqd->meta_list;
>> +	unsigned int map_secs;
>> +	int min =3D pblk->min_write_pgs;
>> +	int i;
>> +
>> +	for (i =3D off; i < rqd->nr_ppas; i +=3D min) {
>> +		map_secs =3D (i + min > valid_secs) ? (valid_secs % min) =
: min;
>> +		pblk_map_page_data(pblk, sentry + i, &rqd->ppa_list[i],
>> +					lun_bitmap, &meta_list[i], =
map_secs);
>> +	}
>> +}
>=20
> Has it been considered to implement the above code such that no modulo
> (%) computation is needed, which is a relatively expensive operation? =
I
> think for this loop that can be done easily.

I'll look into it.

>=20
>> +static DECLARE_RWSEM(pblk_rb_lock);
>> +
>> +void pblk_rb_data_free(struct pblk_rb *rb)
>> +{
>> +	struct pblk_rb_pages *p, *t;
>> +
>> +	down_write(&pblk_rb_lock);
>> +	list_for_each_entry_safe(p, t, &rb->pages, list) {
>> +		free_pages((unsigned long)page_address(p->pages), =
p->order);
>> +		list_del(&p->list);
>> +		kfree(p);
>> +	}
>> +	up_write(&pblk_rb_lock);
>> +}
>=20
> Global locks like pblk_rb_lock are a performance bottleneck on
> multi-socket systems. Why is that lock global?

This global lock is only used for the write buffer init and exit; it
does not touch the fast path. On tear down it guarantees that we flush
all the data present on the buffer before freeing the buffer itself.

>=20
> Bart.

Javier

--Apple-Mail=_9DFA9224-AA4E-4DCC-96F5-36DE58ACDCDE
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJY6fuUAAoJEGMfBTt1mRjKOxsQAJ2qFRBVfVynY/35NTpDZM9g
COPjUy+Dy4zoVv3ZqS6eZW4z7dH3REVwv23muh+cnwnUvf4lw315nYdYbpBEa3l0
e6P3j0QOR+nLTv2GyAruO78FXTcqb/fHMuXwblyOLhs8/BEp7lubA95A1usQwbpH
PTK7n6whxNzUTOQqeoS5GVvYFDWBKtvWN/rA0TEp2lOEYfY9mfmtPcUuK4LCvTTu
2WiBQIEciMe/N5xVW/FXWXPe3KFzUNuywfY8dD4B0OBXwZi748TKkmi6h5hr7koI
6pzof66eurZwpZUAJ8txzJwvmMJ1TwnDu6DGwnhsUlksNjLyUvlyJqvt5u7Rjv0S
fjlYMRdnirXIXyuuYSLyZWNsp4PoZmYH79mD+l4jokeSzeVJ9wsI4H75Jvge0+wq
9qc4rTqSCudp5YTQBZNhMcNqIC7nT72M2ZVHbs87Ty4aX1AtF2xb/WvLbYHKLU/3
GoNf3nff4XBCr3ocX2GqWzlvb+QL/M7u9deigOy6eFEKdQDcXTBf6den9N+1pcvg
rPOojJTQ0hFJj0atKAY4yXKMamHMa8TkIhAdfdyk4mOeCgRIaDChqy3mlFELxD8C
Zg2mZRxUWZ/QnrF3LhV+dvUULIeaOT40U0CDUIzkBM4X3DYiZqwcXzasG0AmOEgu
tDEnmGFAoFcstKibkwFS
=Cfl1
-----END PGP SIGNATURE-----

--Apple-Mail=_9DFA9224-AA4E-4DCC-96F5-36DE58ACDCDE--
