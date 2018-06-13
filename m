Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr730076.outbound.protection.outlook.com ([40.107.73.76]:48440
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934895AbeFMQ4n (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jun 2018 12:56:43 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        "Hans Holmberg" <hans.holmberg@cnexlabs.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] lightnvm: move NVM_DEBUG to pblk
Date: Wed, 13 Jun 2018 16:56:35 +0000
Message-ID: <52B9211F-0293-4ED9-AC03-C46A1DC87589@cnexlabs.com>
References: <20180612112918.25795-1-mb@lightnvm.io>
 <871AB6B2-E790-48A0-A081-6C68EAF9D171@cnexlabs.com>
 <5951e248-6699-912e-1027-36890d3c5367@lightnvm.io>
In-Reply-To: <5951e248-6699-912e-1027-36890d3c5367@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_ED9F9247-9D12-4D7F-BDFE-A97C5427845C";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_ED9F9247-9D12-4D7F-BDFE-A97C5427845C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 12 Jun 2018, at 10.11, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 06/12/2018 04:44 PM, Javier Gonzalez wrote:
>>> On 12 Jun 2018, at 04.29, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> There is no users of CONFIG_NVM_DEBUG in the LightNVM subsystem. All
>>> users are in pblk. Rename NVM_DEBUG to NVM_PBLK_DEBUG and enable
>>> only for pblk.
>>>=20
>>> Also fix up the CONFIG_NVM_PBLK entry to follow the code style for
>>> Kconfig files.
>>>=20
>>> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
>>> ---
>>> drivers/lightnvm/Kconfig      | 32 +++++++++++++++++---------------
>>> drivers/lightnvm/pblk-cache.c |  4 ++--
>>> drivers/lightnvm/pblk-core.c  | 26 +++++++++++++-------------
>>> drivers/lightnvm/pblk-gc.c    |  2 +-
>>> drivers/lightnvm/pblk-init.c  |  8 ++++----
>>> drivers/lightnvm/pblk-rb.c    | 16 ++++++++--------
>>> drivers/lightnvm/pblk-read.c  | 28 ++++++++++++++--------------
>>> drivers/lightnvm/pblk-sysfs.c |  8 ++++----
>>> drivers/lightnvm/pblk-write.c | 14 +++++++-------
>>> drivers/lightnvm/pblk.h       |  6 +++---
>>> 10 files changed, 73 insertions(+), 71 deletions(-)
>>>=20
>>> diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
>>> index 10c08982185a..7a281a91f1c1 100644
>>> --- a/drivers/lightnvm/Kconfig
>>> +++ b/drivers/lightnvm/Kconfig
>>> @@ -17,23 +17,25 @@ menuconfig NVM
>>>=20
>>> if NVM
>>>=20
>>> -config NVM_DEBUG
>>> -	bool "Open-Channel SSD debugging support"
>>> -	default n
>>> -	---help---
>>> -	Exposes a debug management interface to create/remove targets =
at:
>>> -
>>> -	  /sys/module/lnvm/parameters/configure_debug
>>> -
>>> -	It is required to create/remove targets without IOCTLs.
>>> -
>>> config NVM_PBLK
>>> 	tristate "Physical Block Device Open-Channel SSD target"
>>> -	---help---
>>> -	Allows an open-channel SSD to be exposed as a block device to =
the
>>> -	host. The target assumes the device exposes raw flash and must =
be
>>> -	explicitly managed by the host.
>>> +	help
>>> +	  Allows an open-channel SSD to be exposed as a block device to =
the
>>> +	  host. The target assumes the device exposes raw flash and must =
be
>>> +	  explicitly managed by the host.
>>>=20
>>> -	Please note the disk format is considered EXPERIMENTAL for now.
>>> +	  Please note the disk format is considered EXPERIMENTAL for =
now.
>>> +
>>> +if NVM_PBLK
>>> +
>>> +config NVM_PBLK_DEBUG
>>> +	bool "PBlk Debug Support"
>>> +	default n
>>> +	help
>>> +	  Enables debug support for pblk. This includes extra checks, =
more
>>> +	  vocal error messages, and extra tracking fields in the pblk =
sysfs
>>> +	  entries.
>>> +
>>> +endif # NVM_PBLK_DEBUG
>>>=20
>>> endif # NVM
>>> diff --git a/drivers/lightnvm/pblk-cache.c =
b/drivers/lightnvm/pblk-cache.c
>>> index b1c6d7eb6115..77d811962818 100644
>>> --- a/drivers/lightnvm/pblk-cache.c
>>> +++ b/drivers/lightnvm/pblk-cache.c
>>> @@ -67,7 +67,7 @@ int pblk_write_to_cache(struct pblk *pblk, struct =
bio *bio, unsigned long flags)
>>>=20
>>> 	atomic64_add(nr_entries, &pblk->user_wa);
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	atomic_long_add(nr_entries, &pblk->inflight_writes);
>>> 	atomic_long_add(nr_entries, &pblk->req_writes);
>>> #endif
>>> @@ -123,7 +123,7 @@ int pblk_write_gc_to_cache(struct pblk *pblk, =
struct pblk_gc_rq *gc_rq)
>>>=20
>>> 	atomic64_add(valid_entries, &pblk->gc_wa);
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	atomic_long_add(valid_entries, &pblk->inflight_writes);
>>> 	atomic_long_add(valid_entries, &pblk->recov_gc_writes);
>>> #endif
>>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>>> index ed9cc977c8b3..66ab1036f2fb 100644
>>> --- a/drivers/lightnvm/pblk-core.c
>>> +++ b/drivers/lightnvm/pblk-core.c
>>> @@ -194,7 +194,7 @@ void pblk_map_invalidate(struct pblk *pblk, =
struct ppa_addr ppa)
>>> 	u64 paddr;
>>> 	int line_id;
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	/* Callers must ensure that the ppa points to a device address =
*/
>>> 	BUG_ON(pblk_addr_in_cache(ppa));
>>> 	BUG_ON(pblk_ppa_empty(ppa));
>>> @@ -430,7 +430,7 @@ void pblk_discard(struct pblk *pblk, struct bio =
*bio)
>>> void pblk_log_write_err(struct pblk *pblk, struct nvm_rq *rqd)
>>> {
>>> 	atomic_long_inc(&pblk->write_failed);
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	pblk_print_failed_rqd(pblk, rqd, rqd->error);
>>> #endif
>>> }
>>> @@ -454,7 +454,7 @@ void pblk_log_read_err(struct pblk *pblk, struct =
nvm_rq *rqd)
>>> 	default:
>>> 		pr_err("pblk: unknown read error:%d\n", rqd->error);
>>> 	}
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	pblk_print_failed_rqd(pblk, rqd, rqd->error);
>>> #endif
>>> }
>>> @@ -470,7 +470,7 @@ int pblk_submit_io(struct pblk *pblk, struct =
nvm_rq *rqd)
>>>=20
>>> 	atomic_inc(&pblk->inflight_io);
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	if (pblk_check_io(pblk, rqd))
>>> 		return NVM_IO_ERR;
>>> #endif
>>> @@ -484,7 +484,7 @@ int pblk_submit_io_sync(struct pblk *pblk, =
struct nvm_rq *rqd)
>>>=20
>>> 	atomic_inc(&pblk->inflight_io);
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	if (pblk_check_io(pblk, rqd))
>>> 		return NVM_IO_ERR;
>>> #endif
>>> @@ -1726,7 +1726,7 @@ void pblk_line_close(struct pblk *pblk, struct =
pblk_line *line)
>>> 	struct list_head *move_list;
>>> 	int i;
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	WARN(!bitmap_full(line->map_bitmap, lm->sec_per_line),
>>> 				"pblk: corrupt closed line %d\n", =
line->id);
>>> #endif
>>> @@ -1856,7 +1856,7 @@ static void __pblk_down_page(struct pblk =
*pblk, struct ppa_addr *ppa_list,
>>> 	 * Only send one inflight I/O per LUN. Since we map at a page
>>> 	 * granurality, all ppas in the I/O will map to the same LUN
>>> 	 */
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	int i;
>>>=20
>>> 	for (i =3D 1; i < nr_ppas; i++)
>>> @@ -1901,7 +1901,7 @@ void pblk_up_page(struct pblk *pblk, struct =
ppa_addr *ppa_list, int nr_ppas)
>>> 	struct pblk_lun *rlun;
>>> 	int pos =3D pblk_ppa_to_pos(geo, ppa_list[0]);
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	int i;
>>>=20
>>> 	for (i =3D 1; i < nr_ppas; i++)
>>> @@ -1951,7 +1951,7 @@ void pblk_update_map(struct pblk *pblk, =
sector_t lba, struct ppa_addr ppa)
>>> void pblk_update_map_cache(struct pblk *pblk, sector_t lba, struct =
ppa_addr ppa)
>>> {
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	/* Callers must ensure that the ppa points to a cache address */
>>> 	BUG_ON(!pblk_addr_in_cache(ppa));
>>> 	BUG_ON(pblk_rb_pos_oob(&pblk->rwb, =
pblk_addr_to_cacheline(ppa)));
>>> @@ -1966,7 +1966,7 @@ int pblk_update_map_gc(struct pblk *pblk, =
sector_t lba, struct ppa_addr ppa_new,
>>> 	struct ppa_addr ppa_l2p, ppa_gc;
>>> 	int ret =3D 1;
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	/* Callers must ensure that the ppa points to a cache address */
>>> 	BUG_ON(!pblk_addr_in_cache(ppa_new));
>>> 	BUG_ON(pblk_rb_pos_oob(&pblk->rwb, =
pblk_addr_to_cacheline(ppa_new)));
>>> @@ -2003,14 +2003,14 @@ void pblk_update_map_dev(struct pblk *pblk, =
sector_t lba,
>>> {
>>> 	struct ppa_addr ppa_l2p;
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	/* Callers must ensure that the ppa points to a device address =
*/
>>> 	BUG_ON(pblk_addr_in_cache(ppa_mapped));
>>> #endif
>>> 	/* Invalidate and discard padded entries */
>>> 	if (lba =3D=3D ADDR_EMPTY) {
>>> 		atomic64_inc(&pblk->pad_wa);
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 		atomic_long_inc(&pblk->padded_wb);
>>> #endif
>>> 		if (!pblk_ppa_empty(ppa_mapped))
>>> @@ -2036,7 +2036,7 @@ void pblk_update_map_dev(struct pblk *pblk, =
sector_t lba,
>>> 		goto out;
>>> 	}
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	WARN_ON(!pblk_addr_in_cache(ppa_l2p) && =
!pblk_ppa_empty(ppa_l2p));
>>> #endif
>>>=20
>>> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
>>> index df88f1bdd921..1a4186ddca4b 100644
>>> --- a/drivers/lightnvm/pblk-gc.c
>>> +++ b/drivers/lightnvm/pblk-gc.c
>>> @@ -521,7 +521,7 @@ static int pblk_gc_reader_ts(void *data)
>>> 		io_schedule();
>>> 	}
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	pr_info("pblk: flushing gc pipeline, %d lines left\n",
>>> 		atomic_read(&gc->pipeline_gc));
>>> #endif
>>> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
>>> index ce561f5d48ce..5957744c3aab 100644
>>> --- a/drivers/lightnvm/pblk-init.c
>>> +++ b/drivers/lightnvm/pblk-init.c
>>> @@ -91,7 +91,7 @@ static size_t pblk_trans_map_size(struct pblk =
*pblk)
>>> 	return entry_size * pblk->rl.nr_secs;
>>> }
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> static u32 pblk_l2p_crc(struct pblk *pblk)
>>> {
>>> 	size_t map_size;
>>> @@ -122,7 +122,7 @@ static int pblk_l2p_recover(struct pblk *pblk, =
bool factory_init)
>>> 		}
>>> 	}
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	pr_info("pblk init: L2P CRC: %x\n", pblk_l2p_crc(pblk));
>>> #endif
>>>=20
>>> @@ -1165,7 +1165,7 @@ static void pblk_exit(void *private, bool =
graceful)
>>> 	pblk_gc_exit(pblk, graceful);
>>> 	pblk_tear_down(pblk, graceful);
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	pr_info("pblk exit: L2P CRC: %x\n", pblk_l2p_crc(pblk));
>>> #endif
>>>=20
>>> @@ -1216,7 +1216,7 @@ static void *pblk_init(struct nvm_tgt_dev =
*dev, struct gendisk *tdisk,
>>> 	spin_lock_init(&pblk->trans_lock);
>>> 	spin_lock_init(&pblk->lock);
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	atomic_long_set(&pblk->inflight_writes, 0);
>>> 	atomic_long_set(&pblk->padded_writes, 0);
>>> 	atomic_long_set(&pblk->padded_wb, 0);
>>> diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
>>> index 00cd1f20a196..a81a97e8ea6d 100644
>>> --- a/drivers/lightnvm/pblk-rb.c
>>> +++ b/drivers/lightnvm/pblk-rb.c
>>> @@ -111,7 +111,7 @@ int pblk_rb_init(struct pblk_rb *rb, struct =
pblk_rb_entry *rb_entry_base,
>>> 	} while (iter > 0);
>>> 	up_write(&pblk_rb_lock);
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	atomic_set(&rb->inflight_flush_point, 0);
>>> #endif
>>>=20
>>> @@ -308,7 +308,7 @@ void pblk_rb_write_entry_user(struct pblk_rb =
*rb, void *data,
>>>=20
>>> 	entry =3D &rb->entries[ring_pos];
>>> 	flags =3D READ_ONCE(entry->w_ctx.flags);
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	/* Caller must guarantee that the entry is free */
>>> 	BUG_ON(!(flags & PBLK_WRITABLE_ENTRY));
>>> #endif
>>> @@ -332,7 +332,7 @@ void pblk_rb_write_entry_gc(struct pblk_rb *rb, =
void *data,
>>>=20
>>> 	entry =3D &rb->entries[ring_pos];
>>> 	flags =3D READ_ONCE(entry->w_ctx.flags);
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	/* Caller must guarantee that the entry is free */
>>> 	BUG_ON(!(flags & PBLK_WRITABLE_ENTRY));
>>> #endif
>>> @@ -362,7 +362,7 @@ static int pblk_rb_flush_point_set(struct =
pblk_rb *rb, struct bio *bio,
>>> 		return 0;
>>> 	}
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	atomic_inc(&rb->inflight_flush_point);
>>> #endif
>>>=20
>>> @@ -588,7 +588,7 @@ unsigned int pblk_rb_read_to_bio(struct pblk_rb =
*rb, struct nvm_rq *rqd,
>>> 		atomic64_add(pad, &pblk->pad_wa);
>>> 	}
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	atomic_long_add(pad, &pblk->padded_writes);
>>> #endif
>>>=20
>>> @@ -613,7 +613,7 @@ int pblk_rb_copy_to_bio(struct pblk_rb *rb, =
struct bio *bio, sector_t lba,
>>> 	int ret =3D 1;
>>>=20
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	/* Caller must ensure that the access will not cause an overflow =
*/
>>> 	BUG_ON(pos >=3D rb->nr_entries);
>>> #endif
>>> @@ -820,7 +820,7 @@ ssize_t pblk_rb_sysfs(struct pblk_rb *rb, char =
*buf)
>>> 			rb->subm,
>>> 			rb->sync,
>>> 			rb->l2p_update,
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 			atomic_read(&rb->inflight_flush_point),
>>> #else
>>> 			0,
>>> @@ -838,7 +838,7 @@ ssize_t pblk_rb_sysfs(struct pblk_rb *rb, char =
*buf)
>>> 			rb->subm,
>>> 			rb->sync,
>>> 			rb->l2p_update,
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 			atomic_read(&rb->inflight_flush_point),
>>> #else
>>> 			0,
>>> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
>>> index 18694694e5f0..6e93c489ce57 100644
>>> --- a/drivers/lightnvm/pblk-read.c
>>> +++ b/drivers/lightnvm/pblk-read.c
>>> @@ -28,7 +28,7 @@ static int pblk_read_from_cache(struct pblk *pblk, =
struct bio *bio,
>>> 				sector_t lba, struct ppa_addr ppa,
>>> 				int bio_iter, bool advanced_bio)
>>> {
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	/* Callers must ensure that the ppa points to a cache address */
>>> 	BUG_ON(pblk_ppa_empty(ppa));
>>> 	BUG_ON(!pblk_addr_in_cache(ppa));
>>> @@ -79,7 +79,7 @@ static void pblk_read_ppalist_rq(struct pblk =
*pblk, struct nvm_rq *rqd,
>>> 			WARN_ON(test_and_set_bit(i, read_bitmap));
>>> 			meta_list[i].lba =3D cpu_to_le64(lba);
>>> 			advanced_bio =3D true;
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 			atomic_long_inc(&pblk->cache_reads);
>>> #endif
>>> 		} else {
>>> @@ -97,7 +97,7 @@ static void pblk_read_ppalist_rq(struct pblk =
*pblk, struct nvm_rq *rqd,
>>> 	else
>>> 		rqd->flags =3D pblk_set_read_mode(pblk, =
PBLK_READ_RANDOM);
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	atomic_long_add(nr_secs, &pblk->inflight_reads);
>>> #endif
>>> }
>>> @@ -117,7 +117,7 @@ static void pblk_read_check_seq(struct pblk =
*pblk, struct nvm_rq *rqd,
>>> 			continue;
>>>=20
>>> 		if (lba !=3D blba + i) {
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 			struct ppa_addr *p;
>>>=20
>>> 			p =3D (nr_lbas =3D=3D 1) ? &rqd->ppa_list[i] : =
&rqd->ppa_addr;
>>> @@ -149,7 +149,7 @@ static void pblk_read_check_rand(struct pblk =
*pblk, struct nvm_rq *rqd,
>>> 		meta_lba =3D le64_to_cpu(meta_lba_list[j].lba);
>>>=20
>>> 		if (lba !=3D meta_lba) {
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 			struct ppa_addr *p;
>>> 			int nr_ppas =3D rqd->nr_ppas;
>>>=20
>>> @@ -185,7 +185,7 @@ static void pblk_read_put_rqd_kref(struct pblk =
*pblk, struct nvm_rq *rqd)
>>>=20
>>> static void pblk_end_user_read(struct bio *bio)
>>> {
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	WARN_ONCE(bio->bi_status, "pblk: corrupted read bio\n");
>>> #endif
>>> 	bio_endio(bio);
>>> @@ -212,7 +212,7 @@ static void __pblk_end_io_read(struct pblk =
*pblk, struct nvm_rq *rqd,
>>> 	if (put_line)
>>> 		pblk_read_put_rqd_kref(pblk, rqd);
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	atomic_long_add(rqd->nr_ppas, &pblk->sync_reads);
>>> 	atomic_long_sub(rqd->nr_ppas, &pblk->inflight_reads);
>>> #endif
>>> @@ -285,7 +285,7 @@ static int pblk_partial_read(struct pblk *pblk, =
struct nvm_rq *rqd,
>>>=20
>>> 	if (rqd->error) {
>>> 		atomic_long_inc(&pblk->read_failed);
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 		pblk_print_failed_rqd(pblk, rqd, rqd->error);
>>> #endif
>>> 	}
>>> @@ -359,7 +359,7 @@ static void pblk_read_rq(struct pblk *pblk, =
struct nvm_rq *rqd, struct bio *bio,
>>>=20
>>> 	pblk_lookup_l2p_seq(pblk, &ppa, lba, 1);
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	atomic_long_inc(&pblk->inflight_reads);
>>> #endif
>>>=20
>>> @@ -382,7 +382,7 @@ static void pblk_read_rq(struct pblk *pblk, =
struct nvm_rq *rqd, struct bio *bio,
>>> 		WARN_ON(test_and_set_bit(0, read_bitmap));
>>> 		meta_list[0].lba =3D cpu_to_le64(lba);
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 		atomic_long_inc(&pblk->cache_reads);
>>> #endif
>>> 	} else {
>>> @@ -514,7 +514,7 @@ static int read_ppalist_rq_gc(struct pblk *pblk, =
struct nvm_rq *rqd,
>>> 		rqd->ppa_list[valid_secs++] =3D ppa_list_l2p[i];
>>> 	}
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	atomic_long_add(valid_secs, &pblk->inflight_reads);
>>> #endif
>>>=20
>>> @@ -548,7 +548,7 @@ static int read_rq_gc(struct pblk *pblk, struct =
nvm_rq *rqd,
>>> 	rqd->ppa_addr =3D ppa_l2p;
>>> 	valid_secs =3D 1;
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	atomic_long_inc(&pblk->inflight_reads);
>>> #endif
>>>=20
>>> @@ -619,12 +619,12 @@ int pblk_submit_read_gc(struct pblk *pblk, =
struct pblk_gc_rq *gc_rq)
>>>=20
>>> 	if (rqd.error) {
>>> 		atomic_long_inc(&pblk->read_failed_gc);
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 		pblk_print_failed_rqd(pblk, &rqd, rqd.error);
>>> #endif
>>> 	}
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	atomic_long_add(gc_rq->secs_to_gc, &pblk->sync_reads);
>>> 	atomic_long_add(gc_rq->secs_to_gc, &pblk->recov_gc_reads);
>>> 	atomic_long_sub(gc_rq->secs_to_gc, &pblk->inflight_reads);
>>> diff --git a/drivers/lightnvm/pblk-sysfs.c =
b/drivers/lightnvm/pblk-sysfs.c
>>> index 88a0a7c407aa..b0e5e93a9d5f 100644
>>> --- a/drivers/lightnvm/pblk-sysfs.c
>>> +++ b/drivers/lightnvm/pblk-sysfs.c
>>> @@ -421,7 +421,7 @@ static ssize_t =
pblk_sysfs_get_padding_dist(struct pblk *pblk, char *page)
>>> 	return sz;
>>> }
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> static ssize_t pblk_sysfs_stats_debug(struct pblk *pblk, char *page)
>>> {
>>> 	return snprintf(page, PAGE_SIZE,
>>> @@ -598,7 +598,7 @@ static struct attribute sys_padding_dist =3D {
>>> 	.mode =3D 0644,
>>> };
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> static struct attribute sys_stats_debug_attr =3D {
>>> 	.name =3D "stats",
>>> 	.mode =3D 0444,
>>> @@ -619,7 +619,7 @@ static struct attribute *pblk_attrs[] =3D {
>>> 	&sys_write_amp_mileage,
>>> 	&sys_write_amp_trip,
>>> 	&sys_padding_dist,
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	&sys_stats_debug_attr,
>>> #endif
>>> 	NULL,
>>> @@ -654,7 +654,7 @@ static ssize_t pblk_sysfs_show(struct kobject =
*kobj, struct attribute *attr,
>>> 		return pblk_sysfs_get_write_amp_trip(pblk, buf);
>>> 	else if (strcmp(attr->name, "padding_dist") =3D=3D 0)
>>> 		return pblk_sysfs_get_padding_dist(pblk, buf);
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	else if (strcmp(attr->name, "stats") =3D=3D 0)
>>> 		return pblk_sysfs_stats_debug(pblk, buf);
>>> #endif
>>> diff --git a/drivers/lightnvm/pblk-write.c =
b/drivers/lightnvm/pblk-write.c
>>> index f353e52941f5..5f44df999aed 100644
>>> --- a/drivers/lightnvm/pblk-write.c
>>> +++ b/drivers/lightnvm/pblk-write.c
>>> @@ -38,7 +38,7 @@ static unsigned long pblk_end_w_bio(struct pblk =
*pblk, struct nvm_rq *rqd,
>>> 			/* Release flags on context. Protect from writes =
*/
>>> 			smp_store_release(&w_ctx->flags, flags);
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 			atomic_dec(&rwb->inflight_flush_point);
>>> #endif
>>> 		}
>>> @@ -51,7 +51,7 @@ static unsigned long pblk_end_w_bio(struct pblk =
*pblk, struct nvm_rq *rqd,
>>> 		pblk_bio_free_pages(pblk, rqd->bio, c_ctx->nr_valid,
>>> 							=
c_ctx->nr_padded);
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	atomic_long_add(rqd->nr_ppas, &pblk->sync_writes);
>>> #endif
>>>=20
>>> @@ -78,7 +78,7 @@ static void pblk_complete_write(struct pblk *pblk, =
struct nvm_rq *rqd,
>>> 	unsigned long flags;
>>> 	unsigned long pos;
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	atomic_long_sub(c_ctx->nr_valid, &pblk->inflight_writes);
>>> #endif
>>>=20
>>> @@ -196,7 +196,7 @@ static void pblk_queue_resubmit(struct pblk =
*pblk, struct pblk_c_ctx *c_ctx)
>>> 	list_add_tail(&r_ctx->list, &pblk->resubmit_list);
>>> 	spin_unlock(&pblk->resubmit_lock);
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	atomic_long_add(c_ctx->nr_valid, &pblk->recov_writes);
>>> #endif
>>> }
>>> @@ -258,7 +258,7 @@ static void pblk_end_io_write(struct nvm_rq =
*rqd)
>>> 		pblk_end_w_fail(pblk, rqd);
>>> 		return;
>>> 	}
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	else
>>> 		WARN_ONCE(rqd->bio->bi_status, "pblk: corrupted write =
error\n");
>>> #endif
>>> @@ -356,7 +356,7 @@ static int pblk_calc_secs_to_sync(struct pblk =
*pblk, unsigned int secs_avail,
>>>=20
>>> 	secs_to_sync =3D pblk_calc_secs(pblk, secs_avail, =
secs_to_flush);
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	if ((!secs_to_sync && secs_to_flush)
>>> 			|| (secs_to_sync < 0)
>>> 			|| (secs_to_sync > secs_avail && =
!secs_to_flush)) {
>>> @@ -640,7 +640,7 @@ static int pblk_submit_write(struct pblk *pblk)
>>> 	if (pblk_submit_io_set(pblk, rqd))
>>> 		goto fail_free_bio;
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	atomic_long_add(secs_to_sync, &pblk->sub_writes);
>>> #endif
>>>=20
>>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>>> index 34cc1d64a9d4..6d25c940f6ba 100644
>>> --- a/drivers/lightnvm/pblk.h
>>> +++ b/drivers/lightnvm/pblk.h
>>> @@ -193,7 +193,7 @@ struct pblk_rb {
>>> 	spinlock_t w_lock;		/* Write lock */
>>> 	spinlock_t s_lock;		/* Sync lock */
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	atomic_t inflight_flush_point;	/* Not served REQ_FLUSH | =
REQ_FUA */
>>> #endif
>>> };
>>> @@ -639,7 +639,7 @@ struct pblk {
>>> 	u64 nr_flush_rst;		/* Flushes reset value for pad =
dist.*/
>>> 	atomic64_t nr_flush;		/* Number of flush/fua I/O */
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> 	/* Non-persistent debug counters, 4kb sector I/Os */
>>> 	atomic_long_t inflight_writes;	/* Inflight writes (user and gc) =
*/
>>> 	atomic_long_t padded_writes;	/* Sectors padded due to =
flush/fua */
>>> @@ -1282,7 +1282,7 @@ static inline int pblk_io_aligned(struct pblk =
*pblk, int nr_secs)
>>> 	return !(nr_secs % pblk->min_write_pgs);
>>> }
>>>=20
>>> -#ifdef CONFIG_NVM_DEBUG
>>> +#ifdef CONFIG_NVM_PBLK_DEBUG
>>> static inline void print_ppa(struct nvm_geo *geo, struct ppa_addr =
*p,
>>> 			     char *msg, int error)
>>> {
>>> --
>>> 2.11.0
>> Are you sure you do not want any form of extra debug when you go =
around
>> pblk and use the BLK_DEV_ZONED path?
>=20
> I'm not sure what you mean. When exposing the drive as a zoned block =
device, an I/O would not go through the lightnvm subsystem. If =
debugging, we would use what the block layer provides.
>=20

I was thinking on both the identification part (e.g., report_zone) and
on the I/O path - here I assume that you needed to do at least an
address transformation on lightnvm subsystem.

Javier

--Apple-Mail=_ED9F9247-9D12-4D7F-BDFE-A97C5427845C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlshTMAACgkQIX4xUKFR
nnQQoxAAjjLpb8KPfWq7I22FSMcBE4Gei6U3TXev131lXvwyvlrEOroBbLSWSL/R
82qULeVgYf+UgWYs4aSdKqU6o9yd6f465FX4Mf2QQnqope0DffZd0JafZsuDY/5G
FjG2W3NGdR4N0AZgFsyAIzMcKZ3aLKmKlQWSb4W/Rj+RS6GkOXAgW1xgVKY4PV/a
sLef+CaSYaCSASz2nWYwmCNnsvnywEut+iNkfGXqoSnokD+NFrVcyk/1XqREMI0z
wHW8tFZCloFrf8ECkX0fQT+SYDLkzw6ugOyfogahej2NwsapWE2Has1MeF6qPJ+i
IG97P9uLZZQe74CnDtAxGnHjypdhQBeHxUxPOg6lcaaFpNRBzXtNc3p8nZVjQbtx
Ti9ejmLLKbH5H8i1Ea2jaFaSRTH8AFCbaNlwKJD/Bx2h9PswSTiF9vXNA9IoW4r9
14s2qb2ZZzRe8+I1F6ppy/7S9K+4aJBri1W7coI+IhHK7UKCati/ipuaJC7NDpZ7
q2ZMwkImE1i8s5JddE/CpxLHmjEzsFjWypNYhntElRsEw0rO0NaeypY4wOuzdZhu
hGBwWcPr9LhMXg7xj9KDMcLidLx2FuRld9wkqLLSLzl2Lk2S+vcGmPyaAzFOYNX4
WGwY6F7NMqNs8/Vt0IlaCpPghWl7g77OaCVMcJ1TOhkM2iJVQRI=
=Gua6
-----END PGP SIGNATURE-----

--Apple-Mail=_ED9F9247-9D12-4D7F-BDFE-A97C5427845C--
