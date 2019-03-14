Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8DBC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 14:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7AE32184E
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 14:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="sHSe5Lew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfCNOWM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:22:12 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43385 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbfCNOWM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 10:22:12 -0400
Received: by mail-qk1-f195.google.com with SMTP id s26so3400441qkm.10
        for <linux-block@vger.kernel.org>; Thu, 14 Mar 2019 07:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=pQyBEzCxidi7SUdmAFXz9TMI0PIwhRF6tmHuw023cmc=;
        b=sHSe5LewaB3MJiamfpV1h4QEE74FaHz+d65LmdzsL+CLxZHBoLr4/9J38Ls1K1tNSy
         myx1RTzZSRPbg16nSoK1K3lu9iMly+2A2XseHFnoCsaOFZfn8qqFMOWX+smIMhD3lmfl
         jH+Pov1E54Xra4s2BQv0jkjjEzjuw9CBG0AGrBcKg9Ktq4IXPE7jMIPmCqz5UMnivZfu
         jtpOYBbAmUdV3FQz23gOT8qQeCtGzXzbekRJzp9gyV2lDLUzlkZR88ACp19h+U74p31M
         K9JYxmWL9SCl6+vqdcW7C2hhhzWJGv2GkgUq7uPd59IFfpvF4oqYLsKz8u2k3LcYwwX2
         VWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=pQyBEzCxidi7SUdmAFXz9TMI0PIwhRF6tmHuw023cmc=;
        b=c/afA9sSq4nQ7ekvbRnot35u+GcoyfkyL06G0vOsl3TapcXsp4cSbCcz7PERAk+JZl
         dWnqHzKLVrDuT56mtRsbtRlhG/CAXlH1oVbLTcAxtZkXTSjZFkuVhPBdFnFWwc//TEbu
         G/OQlpFPDKBCF0roL2kzbJ0/sKwTbh5A/ChzAiSxiQmnEi+W83HQoPqtjr+a8JVS0qkT
         wEn9t6C9bkKjscBNHlX7l7ebdlUZtGOP9kn2Zo3mfuc4bfKNpvBMhjyZ623L2mrWbLYf
         m+/i8Vow7QWojWcD6JC9BwXQos9lNsJtxFgJtKfXUJFsfdwMfMLwjOptR2rjVjdUpv8F
         Voag==
X-Gm-Message-State: APjAAAUxyEcurK59uMwQAe/kp6Rf9Eqa+CSUUxFvlZJBZKt/J1+jGMOp
        PUwlApSyvWkThYd11ejqeixi1Q==
X-Google-Smtp-Source: APXvYqwwYe/fYQt+V3Qg2sNrSRFD/woDoOQNA/gY7ovhpk18antReb/qRSIUg9g10JFe4AJSBfJSWA==
X-Received: by 2002:a37:330c:: with SMTP id z12mr38174375qkz.136.1552573330484;
        Thu, 14 Mar 2019 07:22:10 -0700 (PDT)
Received: from [172.16.152.72] ([50.238.205.70])
        by smtp.gmail.com with ESMTPSA id y17sm364253qtf.72.2019.03.14.07.22.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 07:22:09 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <874EAB88-573F-485A-A008-FE1CC803E8D3@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_78322757-970F-4EF4-A774-5DE0ACE744E4";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] lightnvm: pblk: set write thread affinity to particular
 cpu
Date:   Thu, 14 Mar 2019 07:22:08 -0700
In-Reply-To: <1552573079-12712-1-git-send-email-marcin.dziegielewski@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        "Konopko, Igor J" <igor.j.konopko@intel.com>
To:     Marcin Dziegielewski <marcin.dziegielewski@intel.com>
References: <1552573079-12712-1-git-send-email-marcin.dziegielewski@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_78322757-970F-4EF4-A774-5DE0ACE744E4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 14 Mar 2019, at 07.17, Marcin Dziegielewski =
<marcin.dziegielewski@intel.com> wrote:
>=20
> In some cases write thread migration between cpus can cause
> sending writes in improper order and in consequence a lot of
> errors from device.
>=20
> Write thread affinity to particular cpu prevent before it.
>=20
> Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
> ---
> drivers/lightnvm/pblk-init.c | 30 +++++++++++++++++++++++++++++-
> drivers/lightnvm/pblk.h      |  1 +
> drivers/nvme/host/lightnvm.c |  1 +
> include/linux/lightnvm.h     |  2 ++
> 4 files changed, 33 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index 81e8ed4..bd25004 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -21,6 +21,8 @@
>=20
> #include "pblk.h"
> #include "pblk-trace.h"
> +#include <linux/cpumask.h>
> +#include <linux/numa.h>
>=20
> static unsigned int write_buffer_size;
>=20
> @@ -47,6 +49,8 @@ struct pblk_global_caches {
>=20
> struct bio_set pblk_bio_set;
>=20
> +cpumask_t free_cpumask;
> +
> static int pblk_rw_io(struct request_queue *q, struct pblk *pblk,
> 			  struct bio *bio)
> {
> @@ -1098,6 +1102,9 @@ static int pblk_lines_init(struct pblk *pblk)
>=20
> static int pblk_writer_init(struct pblk *pblk)
> {
> +	cpumask_t tmp_cpumask, cpumask;
> +	int cpu;
> +
> 	pblk->writer_ts =3D kthread_create(pblk_write_ts, pblk, =
"pblk-writer-t");
> 	if (IS_ERR(pblk->writer_ts)) {
> 		int err =3D PTR_ERR(pblk->writer_ts);
> @@ -1108,6 +1115,22 @@ static int pblk_writer_init(struct pblk *pblk)
> 		return err;
> 	}
>=20
> +	cpumask_and(&tmp_cpumask, =
cpumask_of_node(pblk->dev->parent->node),
> +			cpu_online_mask);
> +	cpumask_and(&cpumask, &tmp_cpumask, &free_cpumask);
> +
> +	if (!cpumask_weight(&free_cpumask)) {
> +		free_cpumask =3D CPU_MASK_ALL;
> +		cpumask_and(&cpumask, &tmp_cpumask, &free_cpumask);
> +	}
> +
> +	cpu =3D cpumask_last(&cpumask);
> +
> +	kthread_bind(pblk->writer_ts, cpu);
> +
> +	cpumask_clear_cpu(cpu, &free_cpumask);
> +	pblk->writer_cpu =3D cpu;
> +
> 	timer_setup(&pblk->wtimer, pblk_write_timer_fn, 0);
> 	mod_timer(&pblk->wtimer, jiffies + msecs_to_jiffies(100));
>=20
> @@ -1126,8 +1149,11 @@ static void pblk_writer_stop(struct pblk *pblk)
> 			"Stopping not fully synced write buffer\n");
>=20
> 	del_timer_sync(&pblk->wtimer);
> -	if (pblk->writer_ts)
> +	if (pblk->writer_ts) {
> +		set_cpus_allowed_ptr(pblk->writer_ts, cpu_online_mask);
> 		kthread_stop(pblk->writer_ts);
> +		cpumask_set_cpu(pblk->writer_cpu, &free_cpumask);
> +	}
> }
>=20
> static void pblk_free(struct pblk *pblk)
> @@ -1328,6 +1354,8 @@ static int __init pblk_module_init(void)
> {
> 	int ret;
>=20
> +	free_cpumask =3D CPU_MASK_ALL;
> +
> 	ret =3D bioset_init(&pblk_bio_set, BIO_POOL_SIZE, 0, 0);
> 	if (ret)
> 		return ret;
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 381f074..650f983 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -690,6 +690,7 @@ struct pblk {
> 	atomic_t inflight_io;		/* General inflight I/O counter =
*/
>=20
> 	struct task_struct *writer_ts;
> +	int writer_cpu;
>=20
> 	/* Simple translation map of logical addresses to physical =
addresses.
> 	 * The logical addresses is known by the host system, while the =
physical
> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
> index 949e29e..971a19f 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -982,6 +982,7 @@ int nvme_nvm_register(struct nvme_ns *ns, char =
*disk_name, int node)
> 	memcpy(dev->name, disk_name, DISK_NAME_LEN);
> 	dev->ops =3D &nvme_nvm_dev_ops;
> 	dev->private_data =3D ns;
> +	dev->node =3D node;
> 	ns->ndev =3D dev;
>=20
> 	return nvm_register(dev);
> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
> index 5d865a5..312029e 100644
> --- a/include/linux/lightnvm.h
> +++ b/include/linux/lightnvm.h
> @@ -427,6 +427,8 @@ struct nvm_dev {
> 	char name[DISK_NAME_LEN];
> 	void *private_data;
>=20
> +	int node;
> +
> 	void *rmap;
>=20
> 	struct mutex mlock;
> --
> 1.8.3.1

We have a per-CPU semaphore that only allows to send a single I/O in
order to prevent write pointer violations. Are you seeing this error, or
is it theoretical?

Javier

--Apple-Mail=_78322757-970F-4EF4-A774-5DE0ACE744E4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyKY5AACgkQPEYBfS0l
eODO9Q//aD+dOvnPDtriUxsmTIesK+H4AOFB0eEluvEhR2VypSpqX0tORzAE9Elu
oAkljF4PNVuXIEi1zNxLcisSXMPSrgN1J2Re7rNJQfOul9/1geZTtwshpjzBFVXy
qqQKxtWOqUDuCD1RHx+hOHIiDIs19bAhwp2iw4kX4icYaJMU/2ZvaVLcULOLbXra
fqk9qLRpLHGfFwXOHtEagwZb7CO7xIHF3FN+bK3bmXyhK2Y8uWoGETPL7XgaXNi4
OPP8JrcCul6Qdl5LRknYEp0Hml5h0jp51BzCud0Se1pvrUExqsk0o2YNM4NBqA64
/8uHHv43wmFcb3i7RCdvchhEajUMLvFP3xHCg0cSGNfIyUs2ork3HDmMvqeeuqV0
BslePIeL6t7WNlYrPmxfzhznBIZGMk/YorTxFE42UhXxU/ZoKdyhWHPgiNggpIbC
5MIf1pUCU3OsMda+JBQbx2JnIwpEGyYnslVTkSiT0jnzfWuP1yzE9ZZTGt6/SUfj
BbE2SzAw33I5tiyvJbLATJdH0dVdAANiYWhxu0pqrHKE1Pz7OYKia9tD9txPAaPy
ISP+IIkzw1G3DllhgOEAvWOS6QysBgiuARH8WzD9UdJ8mo7uwlLJVvHYKVEsv6y8
9T4FYKqgh6amL05/jKDzq6R/UJ0MxSZbD/l/wJ1KLDwpTVF4nG4=
=9ukH
-----END PGP SIGNATURE-----

--Apple-Mail=_78322757-970F-4EF4-A774-5DE0ACE744E4--
