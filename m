Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:20084 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbdDHU4P (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 8 Apr 2017 16:56:15 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <jg@lightnvm.io>,
        "mb@lightnvm.io" <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@cnexlabs.com>
Subject: Re: [PATCH v3] lightnvm: physical block device (pblk) target
Date: Sat, 8 Apr 2017 20:56:10 +0000
Message-ID: <CY1PR0401MB1536AD7F70C960D62DCA6983810F0@CY1PR0401MB1536.namprd04.prod.outlook.com>
References: <1491591015-7554-1-git-send-email-javier@cnexlabs.com>
 <1491591015-7554-2-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/07/17 11:50, Javier Gonz=E1lez wrote:=0A=
>  Documentation/lightnvm/pblk.txt  |   21 +=0A=
>  drivers/lightnvm/Kconfig         |   19 +=0A=
>  drivers/lightnvm/Makefile        |    5 +=0A=
>  drivers/lightnvm/pblk-cache.c    |  112 +++=0A=
>  drivers/lightnvm/pblk-core.c     | 1641 ++++++++++++++++++++++++++++++++=
++++++=0A=
>  drivers/lightnvm/pblk-gc.c       |  542 +++++++++++++=0A=
>  drivers/lightnvm/pblk-init.c     |  942 ++++++++++++++++++++++=0A=
>  drivers/lightnvm/pblk-map.c      |  135 ++++=0A=
>  drivers/lightnvm/pblk-rb.c       |  859 ++++++++++++++++++++=0A=
>  drivers/lightnvm/pblk-read.c     |  513 ++++++++++++=0A=
>  drivers/lightnvm/pblk-recovery.c | 1007 +++++++++++++++++++++++=0A=
>  drivers/lightnvm/pblk-rl.c       |  182 +++++=0A=
>  drivers/lightnvm/pblk-sysfs.c    |  500 ++++++++++++=0A=
>  drivers/lightnvm/pblk-write.c    |  408 ++++++++++=0A=
>  drivers/lightnvm/pblk.h          | 1127 ++++++++++++++++++++++++++=0A=
>  include/linux/lightnvm.h         |   57 +-=0A=
>  pblk-sysfs.c                     |  581 ++++++++++++++=0A=
=0A=
This patch introduces two slightly different versions of pblk-sysfs.c - =0A=
one at the top level and one in drivers/lightnvm. Please remove the file=0A=
at the top level.=0A=
=0A=
> +config NVM_PBLK_L2P_OPT=0A=
> +	bool "PBLK with optimized L2P table for devices up to 8TB"=0A=
> +	depends on NVM_PBLK=0A=
> +	---help---=0A=
> +	Physical device addresses are typical 64-bit integers. Since we store=
=0A=
> +	the logical to physical (L2P) table on the host, this takes 1/500 of=0A=
> +	host memory (e.g., 2GB per 1TB of storage media). On drives under 8TB,=
=0A=
> +	it is possible to reduce this to 1/1000 (e.g., 1GB per 1TB). This=0A=
> +	option allows to do this optimization on the host L2P table.=0A=
=0A=
Why is NVM_PBLK_L2P_OPT a compile-time option instead of a run-time =0A=
option? Since this define does not affect the definition of the ppa_addr =
=0A=
I don't see why this has to be a compile-time option. For e.g. Linux =0A=
distributors the only choice would be to disable NVM_PBLK_L2P_OPT. I =0A=
think it would be unfortunate if no Linux distribution ever would be =0A=
able to benefit from this optimization.=0A=
=0A=
> +#ifdef CONFIG_NVM_DEBUG=0A=
> +	atomic_add(nr_entries, &pblk->inflight_writes);=0A=
> +	atomic_add(nr_entries, &pblk->req_writes);=0A=
> +#endif=0A=
=0A=
Has it been considered to use the "static key" feature such that =0A=
consistency checks can be enabled at run-time instead of having to =0A=
rebuild the kernel to enable CONFIG_NVM_DEBUG?=0A=
=0A=
> +#ifdef CONFIG_NVM_DEBUG=0A=
> +	BUG_ON(nr_rec_entries !=3D valid_entries);=0A=
> +	atomic_add(valid_entries, &pblk->inflight_writes);=0A=
> +	atomic_add(valid_entries, &pblk->recov_gc_writes);=0A=
> +#endif=0A=
=0A=
Are you aware that Linus is strongly opposed against using BUG_ON()?=0A=
=0A=
> +#ifdef CONFIG_NVM_DEBUG=0A=
> +	lockdep_assert_held(&l_mg->free_lock);=0A=
> +#endif=0A=
=0A=
Why is lockdep_assert_held() surrounded with #ifdef CONFIG_NVM_DEBUG / =0A=
#endif? Are you aware that lockdep_assert_held() do not generate any =0A=
code with CONFIG_PROVE_LOCKING=3Dn?=0A=
=0A=
> +static const struct block_device_operations pblk_fops =3D {=0A=
> +	.owner		=3D THIS_MODULE,=0A=
> +};=0A=
=0A=
Is this data structure useful? If so, where is pblk_fops used?=0A=
=0A=
> +static void pblk_l2p_free(struct pblk *pblk)=0A=
> +{=0A=
> +	vfree(pblk->trans_map);=0A=
> +}=0A=
> +=0A=
> +static int pblk_l2p_init(struct pblk *pblk)=0A=
> +{=0A=
> +	sector_t i;=0A=
> +=0A=
> +	pblk->trans_map =3D vmalloc(sizeof(pblk_addr) * pblk->rl.nr_secs);=0A=
> +	if (!pblk->trans_map)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	for (i =3D 0; i < pblk->rl.nr_secs; i++)=0A=
> +		pblk_ppa_set_empty(&pblk->trans_map[i]);=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
=0A=
Has it been considered to add support for keeping a subset of the L2P =0A=
translation table in memory instead of keeping it in memory in its entirety=
?=0A=
=0A=
> +	sprintf(cache_name, "pblk_line_m_%s", pblk->disk->disk_name);=0A=
=0A=
Please use snprintf() or kasprintf() instead of printf(). That makes it =0A=
easier for humans to verify that no buffer overflow is triggered.=0A=
=0A=
> +/* physical block device target */=0A=
> +static struct nvm_tgt_type tt_pblk =3D {=0A=
> +	.name		=3D "pblk",=0A=
> +	.version	=3D {1, 0, 0},=0A=
=0A=
Are version numbers useful inside the kernel tree?=0A=
=0A=
> +void pblk_map_rq(struct pblk *pblk, struct nvm_rq *rqd, unsigned int sen=
try,=0A=
> +		 unsigned long *lun_bitmap, unsigned int valid_secs,=0A=
> +		 unsigned int off)=0A=
> +{=0A=
> +	struct pblk_sec_meta *meta_list =3D rqd->meta_list;=0A=
> +	unsigned int map_secs;=0A=
> +	int min =3D pblk->min_write_pgs;=0A=
> +	int i;=0A=
> +=0A=
> +	for (i =3D off; i < rqd->nr_ppas; i +=3D min) {=0A=
> +		map_secs =3D (i + min > valid_secs) ? (valid_secs % min) : min;=0A=
> +		pblk_map_page_data(pblk, sentry + i, &rqd->ppa_list[i],=0A=
> +					lun_bitmap, &meta_list[i], map_secs);=0A=
> +	}=0A=
> +}=0A=
=0A=
Has it been considered to implement the above code such that no modulo =0A=
(%) computation is needed, which is a relatively expensive operation? I =0A=
think for this loop that can be done easily.=0A=
=0A=
> +static DECLARE_RWSEM(pblk_rb_lock);=0A=
> +=0A=
> +void pblk_rb_data_free(struct pblk_rb *rb)=0A=
> +{=0A=
> +	struct pblk_rb_pages *p, *t;=0A=
> +=0A=
> +	down_write(&pblk_rb_lock);=0A=
> +	list_for_each_entry_safe(p, t, &rb->pages, list) {=0A=
> +		free_pages((unsigned long)page_address(p->pages), p->order);=0A=
> +		list_del(&p->list);=0A=
> +		kfree(p);=0A=
> +	}=0A=
> +	up_write(&pblk_rb_lock);=0A=
> +}=0A=
=0A=
Global locks like pblk_rb_lock are a performance bottleneck on =0A=
multi-socket systems. Why is that lock global?=0A=
=0A=
Bart.=0A=
