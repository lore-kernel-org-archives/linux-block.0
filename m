Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275AAC10F06
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 14:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E184A20657
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 14:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="JWXNsx0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfCNOWs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:22:48 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43131 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfCNOWs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 10:22:48 -0400
Received: by mail-qt1-f194.google.com with SMTP id v32so6193283qtc.10
        for <linux-block@vger.kernel.org>; Thu, 14 Mar 2019 07:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=ovS92Eees2dPclNlo12Hf0pXlZKEdRBGoxtkp/LZrUQ=;
        b=JWXNsx0gHUitQbrOmdEltLjRPuEFsExi+XyruJJK2ELo51M66QiDta+4FtbbAv2MDN
         cMeY1erwUPOyTygSvwlwR7p/UI+e89RCrEIOv5chWFq8pGxBki7biAD+1vDrYC4zlMH6
         NLuAhXBJE9uW9a1aXtR0KNOtxjmmZaQc4FpzviHaZ9i6F9EnVp6mS1mQj3nHLKk1iN55
         e5C2BX8Fxcp+zuHm61HBpmDRZTpWK59KmzKr7tYdpGFdgl+9odb65a5zLJJB2F3p7Wp3
         Z2Sb2v0JCHuW4AbWawnEQVh2S8FYWWmlnepiZSpLT8jqdmPlnJdAOIF7GuRASkFBaavS
         GelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=ovS92Eees2dPclNlo12Hf0pXlZKEdRBGoxtkp/LZrUQ=;
        b=cJ9jIY6ca/Bwm4/1dBLuF31cJPI/kxLR4HHsZ5NmMYciJ3agfrs4+OuxY2AegxC+9y
         UUV31ss+f8zhG3i4E/BEj3AK4GTzdEuXVwBm+7Evdkmf8xFJvnT8gVoNtKKx9srgnMcN
         +ZjbsfGrqpiKlr/GqVnRgMRdMl9rzGOP6cRjiUY//HazoYWODYrhdBzU/3SyxJ+7Z++b
         uKwzo6pRvH/RCDhndRc6C8NhuYXduAgcGp/ccmA58JPf9xbD2di4v/d4Krj5tA+J4WYq
         5wjYoonM+SXegjPxAdSZpuj60yXwFunYclokYcqDhxmeXAw4ya8/YxFm7/m2jF5Sucor
         umIg==
X-Gm-Message-State: APjAAAVmXYJfSn/OmQiIKyLfPIOXBgmZQWIA+FtEviZsDnrhxdR4AYaZ
        vgtUxOwHppuWPCOkvrtT7oFnoQ==
X-Google-Smtp-Source: APXvYqyNWqiopFQilQVFzZShG67+ldxKHPyBN8j6qzPsUjJU28fC1/25LxkTQU5vxMMg2ngSDhSIZw==
X-Received: by 2002:a0c:d121:: with SMTP id a30mr40309575qvh.0.1552573366918;
        Thu, 14 Mar 2019 07:22:46 -0700 (PDT)
Received: from [172.16.152.72] ([50.238.205.70])
        by smtp.gmail.com with ESMTPSA id y17sm364253qtf.72.2019.03.14.07.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 07:22:46 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <D45E9938-F025-446D-8E48-CAE954B791A6@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_A1587A5E-FB09-4DA8-ADB2-E996D63A36C3";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] lightnvm: pblk: set write thread affinity to particular
 cpu
Date:   Thu, 14 Mar 2019 07:22:45 -0700
In-Reply-To: <874EAB88-573F-485A-A008-FE1CC803E8D3@javigon.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        "Konopko, Igor J" <igor.j.konopko@intel.com>
To:     Marcin Dziegielewski <marcin.dziegielewski@intel.com>
References: <1552573079-12712-1-git-send-email-marcin.dziegielewski@intel.com>
 <874EAB88-573F-485A-A008-FE1CC803E8D3@javigon.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_A1587A5E-FB09-4DA8-ADB2-E996D63A36C3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 14 Mar 2019, at 07.22, Javier Gonz=C3=A1lez <javier@javigon.com> =
wrote:
>=20
>> On 14 Mar 2019, at 07.17, Marcin Dziegielewski =
<marcin.dziegielewski@intel.com> wrote:
>>=20
>> In some cases write thread migration between cpus can cause
>> sending writes in improper order and in consequence a lot of
>> errors from device.
>>=20
>> Write thread affinity to particular cpu prevent before it.
>>=20
>> Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
>> ---
>> drivers/lightnvm/pblk-init.c | 30 +++++++++++++++++++++++++++++-
>> drivers/lightnvm/pblk.h      |  1 +
>> drivers/nvme/host/lightnvm.c |  1 +
>> include/linux/lightnvm.h     |  2 ++
>> 4 files changed, 33 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
>> index 81e8ed4..bd25004 100644
>> --- a/drivers/lightnvm/pblk-init.c
>> +++ b/drivers/lightnvm/pblk-init.c
>> @@ -21,6 +21,8 @@
>>=20
>> #include "pblk.h"
>> #include "pblk-trace.h"
>> +#include <linux/cpumask.h>
>> +#include <linux/numa.h>
>>=20
>> static unsigned int write_buffer_size;
>>=20
>> @@ -47,6 +49,8 @@ struct pblk_global_caches {
>>=20
>> struct bio_set pblk_bio_set;
>>=20
>> +cpumask_t free_cpumask;
>> +
>> static int pblk_rw_io(struct request_queue *q, struct pblk *pblk,
>> 			  struct bio *bio)
>> {
>> @@ -1098,6 +1102,9 @@ static int pblk_lines_init(struct pblk *pblk)
>>=20
>> static int pblk_writer_init(struct pblk *pblk)
>> {
>> +	cpumask_t tmp_cpumask, cpumask;
>> +	int cpu;
>> +
>> 	pblk->writer_ts =3D kthread_create(pblk_write_ts, pblk, =
"pblk-writer-t");
>> 	if (IS_ERR(pblk->writer_ts)) {
>> 		int err =3D PTR_ERR(pblk->writer_ts);
>> @@ -1108,6 +1115,22 @@ static int pblk_writer_init(struct pblk *pblk)
>> 		return err;
>> 	}
>>=20
>> +	cpumask_and(&tmp_cpumask, =
cpumask_of_node(pblk->dev->parent->node),
>> +			cpu_online_mask);
>> +	cpumask_and(&cpumask, &tmp_cpumask, &free_cpumask);
>> +
>> +	if (!cpumask_weight(&free_cpumask)) {
>> +		free_cpumask =3D CPU_MASK_ALL;
>> +		cpumask_and(&cpumask, &tmp_cpumask, &free_cpumask);
>> +	}
>> +
>> +	cpu =3D cpumask_last(&cpumask);
>> +
>> +	kthread_bind(pblk->writer_ts, cpu);
>> +
>> +	cpumask_clear_cpu(cpu, &free_cpumask);
>> +	pblk->writer_cpu =3D cpu;
>> +
>> 	timer_setup(&pblk->wtimer, pblk_write_timer_fn, 0);
>> 	mod_timer(&pblk->wtimer, jiffies + msecs_to_jiffies(100));
>>=20
>> @@ -1126,8 +1149,11 @@ static void pblk_writer_stop(struct pblk =
*pblk)
>> 			"Stopping not fully synced write buffer\n");
>>=20
>> 	del_timer_sync(&pblk->wtimer);
>> -	if (pblk->writer_ts)
>> +	if (pblk->writer_ts) {
>> +		set_cpus_allowed_ptr(pblk->writer_ts, cpu_online_mask);
>> 		kthread_stop(pblk->writer_ts);
>> +		cpumask_set_cpu(pblk->writer_cpu, &free_cpumask);
>> +	}
>> }
>>=20
>> static void pblk_free(struct pblk *pblk)
>> @@ -1328,6 +1354,8 @@ static int __init pblk_module_init(void)
>> {
>> 	int ret;
>>=20
>> +	free_cpumask =3D CPU_MASK_ALL;
>> +
>> 	ret =3D bioset_init(&pblk_bio_set, BIO_POOL_SIZE, 0, 0);
>> 	if (ret)
>> 		return ret;
>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>> index 381f074..650f983 100644
>> --- a/drivers/lightnvm/pblk.h
>> +++ b/drivers/lightnvm/pblk.h
>> @@ -690,6 +690,7 @@ struct pblk {
>> 	atomic_t inflight_io;		/* General inflight I/O counter =
*/
>>=20
>> 	struct task_struct *writer_ts;
>> +	int writer_cpu;
>>=20
>> 	/* Simple translation map of logical addresses to physical =
addresses.
>> 	 * The logical addresses is known by the host system, while the =
physical
>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>> index 949e29e..971a19f 100644
>> --- a/drivers/nvme/host/lightnvm.c
>> +++ b/drivers/nvme/host/lightnvm.c
>> @@ -982,6 +982,7 @@ int nvme_nvm_register(struct nvme_ns *ns, char =
*disk_name, int node)
>> 	memcpy(dev->name, disk_name, DISK_NAME_LEN);
>> 	dev->ops =3D &nvme_nvm_dev_ops;
>> 	dev->private_data =3D ns;
>> +	dev->node =3D node;
>> 	ns->ndev =3D dev;
>>=20
>> 	return nvm_register(dev);
>> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
>> index 5d865a5..312029e 100644
>> --- a/include/linux/lightnvm.h
>> +++ b/include/linux/lightnvm.h
>> @@ -427,6 +427,8 @@ struct nvm_dev {
>> 	char name[DISK_NAME_LEN];
>> 	void *private_data;
>>=20
>> +	int node;
>> +
>> 	void *rmap;
>>=20
>> 	struct mutex mlock;
>> --
>> 1.8.3.1
>=20
> We have a per-CPU semaphore that only allows to send a single I/O in
> order to prevent write pointer violations. Are you seeing this error, =
or
> is it theoretical?
>=20
> Javier

I meant per PU (parallel unit)=E2=80=A6


--Apple-Mail=_A1587A5E-FB09-4DA8-ADB2-E996D63A36C3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyKY7UACgkQPEYBfS0l
eOBb7A//bzeaKITAhIIbERHqGaDXgKNRkJsBK8BRETZDr+zx6uqBEA33Nu7e4pZL
V9F+ji5yyShQqcpcVB/gP6VZ3HY6q1IAjneMQNnxPBGtotzePXNhFtPo0iT12+Xf
dj7XyCyPezz6aJZT5iYplyArnBMaXwy3u+rfyVNqcEs1yuSxQoJkFT04kVXtfFLM
zirZheeBpmcAif8utgUon8dvBSTj/+NqrZm6VlUpD95bba7TM9XjGSiFMYS7i3gh
mUrv1d7o5nuAaHRcCXYa50OUpXTSTtThzxUyiCUL37vOOWU5E4pfu2b4DV8tQr7/
gVhN4pazZtMO8cy0aYE0+SNVjEwzknYbX45oIkwpMsNbiq727zuiW1ZDg4t7RBOl
LqJx9svJLsmV1Gvt3wYI8UPTfWJGe9hebJRBRLeO1mXsKsj+rhM/uvAex3+LO/Pe
hbaY8QU+BjgVRlkBoww2g8ta3UJxKqKEW2oU5+OKifYXzb3aHQvgmcoIWTwPx2XH
tJw+wQtJECGkBT/cfsPyw6w51vS8Bt7UTVuQlVq9EvlTbVBtu3SOOSNDx6Xg+pUY
iufG7Si1MIiqLQd/YPqT7u0KQIj28lbbfJ4Ge+ziJEeVgCSc7a3ccayaQmEKRNhW
x/4clKlv2lmM3choRD9vweKDBpQw3QSeYiBepY8sVY1g6Ji9eJI=
=X4Pb
-----END PGP SIGNATURE-----

--Apple-Mail=_A1587A5E-FB09-4DA8-ADB2-E996D63A36C3--
