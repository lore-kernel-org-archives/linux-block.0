Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE94DC43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 18:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD41E2133D
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 18:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="YlZku5a8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfCRSW0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:22:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43491 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfCRSWZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 14:22:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id m35so14371126ede.10
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2019 11:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=F5/4FdBQkQSjwK0DnnWzIp2usAqh3IW6z6t7Jl1fQ5o=;
        b=YlZku5a878ghBVl6AkZh9rfQraDBtMocKjW8UAWCErMcUh137wJGKLvJoEeRLhuqeW
         3tbTiavq/DI45/ekyEzORcvtrXuTfCvXbrdtXHiXyVXmnO+P7MK73Dx31vzFBtob0AQ4
         VH9q0ngzdh6+6YbwCcUoh9+MuS4a2W6/MdNzrsz4hnG53OEmv4VG491KZQO3+61kIJ4C
         H2VPr3r9vs3XZB2Go+cCqJumWG0/429CKc96tdQkGtrCIOEj66c4aXlZGn4rwRT/QoWo
         PkZlNAPpssNgVygN8iaK5wcJe1HxEu5MF5TCcjS4KEG01M9b4oIrCrOPGPqFA9Hh/WxC
         Wvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=F5/4FdBQkQSjwK0DnnWzIp2usAqh3IW6z6t7Jl1fQ5o=;
        b=o6pRIP4GDOcz1dpNMCNeuNJO65xxUMbJKZ7kR+WTndg2OSNfbrxvyP6hrnUTNplCDk
         a6zHhfSStV90O/5cJPAshO3v3U3C9mYjS1obEkywMlkcTm4/p7d4P+HoBeaWQJ3m5mX7
         4K6yExkux1227kxhF5QbtbcCTYos/MYMaQSJpbbXkYmlWFWy9y1Ktp88UP+oFtb4g7Dt
         IQP9KxUfa9bAfFhkMjvon6/uspanpv3C3SG3uCjvo34yMCq40ajtgfRp7gi/8oLWJIUT
         yWoNG/2JkfONc5o0gSp/wK7iCX9vJAVN+YO4APTHfGAudDyCJcSQ9mYlkxv7yGLb6NmG
         rsCw==
X-Gm-Message-State: APjAAAXHtCnb+NSJiezuFCl1h2hm/i9enh9ERzyivLQxZFehM8lZEjmU
        bQ0e8FybVnFRJRu7JGiUaHOmDQ==
X-Google-Smtp-Source: APXvYqxeGjaHPWiHceZmdCnVAMPnMemzenJeaHE35bniD4YzcvmODN7pZLcAGTYDt0KIaUq6HljczQ==
X-Received: by 2002:a17:906:5245:: with SMTP id y5mr11905094ejm.151.1552933343628;
        Mon, 18 Mar 2019 11:22:23 -0700 (PDT)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id p25sm2565638ejb.20.2019.03.18.11.22.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 11:22:22 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <F0D71B2E-6AD6-413F-BE90-660361FFC232@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_697463C2-C686-456C-BD9F-DE1C57BF808E";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] lightnvm: pblk: set write thread affinity to particular
 cpu
Date:   Mon, 18 Mar 2019 19:22:21 +0100
In-Reply-To: <CANr-nt3B8UknSTdKOj2PbfDRTfPJZ+g1s83XY2egtBdZqsU6tQ@mail.gmail.com>
Cc:     Marcin Dziegielewski <marcin.dziegielewski@intel.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        "Konopko, Igor J" <igor.j.konopko@intel.com>
To:     Hans Holmberg <hans@owltronix.com>
References: <1552573079-12712-1-git-send-email-marcin.dziegielewski@intel.com>
 <874EAB88-573F-485A-A008-FE1CC803E8D3@javigon.com>
 <D45E9938-F025-446D-8E48-CAE954B791A6@javigon.com>
 <a63ef9e7-214a-a701-5c40-d1d1107de4a4@intel.com>
 <CANr-nt3B8UknSTdKOj2PbfDRTfPJZ+g1s83XY2egtBdZqsU6tQ@mail.gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_697463C2-C686-456C-BD9F-DE1C57BF808E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 18 Mar 2019, at 13.22, Hans Holmberg <hans@owltronix.com> wrote:
>=20
> On Mon, Mar 18, 2019 at 10:44 AM Marcin Dziegielewski
> <marcin.dziegielewski@intel.com> wrote:
>> On 3/14/19 3:22 PM, Javier Gonz=C3=A1lez wrote:
>>>> On 14 Mar 2019, at 07.22, Javier Gonz=C3=A1lez <javier@javigon.com> =
wrote:
>>>>=20
>>>>> On 14 Mar 2019, at 07.17, Marcin Dziegielewski =
<marcin.dziegielewski@intel.com> wrote:
>>>>>=20
>>>>> In some cases write thread migration between cpus can cause
>>>>> sending writes in improper order and in consequence a lot of
>>>>> errors from device.
>>>>>=20
>>>>> Write thread affinity to particular cpu prevent before it.
>>>>>=20
>>>>> Signed-off-by: Marcin Dziegielewski =
<marcin.dziegielewski@intel.com>
>>>>> ---
>>>>> drivers/lightnvm/pblk-init.c | 30 +++++++++++++++++++++++++++++-
>>>>> drivers/lightnvm/pblk.h      |  1 +
>>>>> drivers/nvme/host/lightnvm.c |  1 +
>>>>> include/linux/lightnvm.h     |  2 ++
>>>>> 4 files changed, 33 insertions(+), 1 deletion(-)
>>>>>=20
>>>>> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
>>>>> index 81e8ed4..bd25004 100644
>>>>> --- a/drivers/lightnvm/pblk-init.c
>>>>> +++ b/drivers/lightnvm/pblk-init.c
>>>>> @@ -21,6 +21,8 @@
>>>>>=20
>>>>> #include "pblk.h"
>>>>> #include "pblk-trace.h"
>>>>> +#include <linux/cpumask.h>
>>>>> +#include <linux/numa.h>
>>>>>=20
>>>>> static unsigned int write_buffer_size;
>>>>>=20
>>>>> @@ -47,6 +49,8 @@ struct pblk_global_caches {
>>>>>=20
>>>>> struct bio_set pblk_bio_set;
>>>>>=20
>>>>> +cpumask_t free_cpumask;
>>>>> +
>>>>> static int pblk_rw_io(struct request_queue *q, struct pblk *pblk,
>>>>>                      struct bio *bio)
>>>>> {
>>>>> @@ -1098,6 +1102,9 @@ static int pblk_lines_init(struct pblk =
*pblk)
>>>>>=20
>>>>> static int pblk_writer_init(struct pblk *pblk)
>>>>> {
>>>>> +   cpumask_t tmp_cpumask, cpumask;
>>>>> +   int cpu;
>>>>> +
>>>>>    pblk->writer_ts =3D kthread_create(pblk_write_ts, pblk, =
"pblk-writer-t");
>>>>>    if (IS_ERR(pblk->writer_ts)) {
>>>>>            int err =3D PTR_ERR(pblk->writer_ts);
>>>>> @@ -1108,6 +1115,22 @@ static int pblk_writer_init(struct pblk =
*pblk)
>>>>>            return err;
>>>>>    }
>>>>>=20
>>>>> +   cpumask_and(&tmp_cpumask, =
cpumask_of_node(pblk->dev->parent->node),
>>>>> +                   cpu_online_mask);
>>>>> +   cpumask_and(&cpumask, &tmp_cpumask, &free_cpumask);
>>>>> +
>>>>> +   if (!cpumask_weight(&free_cpumask)) {
>>>>> +           free_cpumask =3D CPU_MASK_ALL;
>>>>> +           cpumask_and(&cpumask, &tmp_cpumask, &free_cpumask);
>>>>> +   }
>>>>> +
>>>>> +   cpu =3D cpumask_last(&cpumask);
>>>>> +
>>>>> +   kthread_bind(pblk->writer_ts, cpu);
>>>>> +
>>>>> +   cpumask_clear_cpu(cpu, &free_cpumask);
>>>>> +   pblk->writer_cpu =3D cpu;
>>>>> +
>>>>>    timer_setup(&pblk->wtimer, pblk_write_timer_fn, 0);
>>>>>    mod_timer(&pblk->wtimer, jiffies + msecs_to_jiffies(100));
>>>>>=20
>>>>> @@ -1126,8 +1149,11 @@ static void pblk_writer_stop(struct pblk =
*pblk)
>>>>>                    "Stopping not fully synced write buffer\n");
>>>>>=20
>>>>>    del_timer_sync(&pblk->wtimer);
>>>>> -   if (pblk->writer_ts)
>>>>> +   if (pblk->writer_ts) {
>>>>> +           set_cpus_allowed_ptr(pblk->writer_ts, =
cpu_online_mask);
>>>>>            kthread_stop(pblk->writer_ts);
>>>>> +           cpumask_set_cpu(pblk->writer_cpu, &free_cpumask);
>>>>> +   }
>>>>> }
>>>>>=20
>>>>> static void pblk_free(struct pblk *pblk)
>>>>> @@ -1328,6 +1354,8 @@ static int __init pblk_module_init(void)
>>>>> {
>>>>>    int ret;
>>>>>=20
>>>>> +   free_cpumask =3D CPU_MASK_ALL;
>>>>> +
>>>>>    ret =3D bioset_init(&pblk_bio_set, BIO_POOL_SIZE, 0, 0);
>>>>>    if (ret)
>>>>>            return ret;
>>>>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>>>>> index 381f074..650f983 100644
>>>>> --- a/drivers/lightnvm/pblk.h
>>>>> +++ b/drivers/lightnvm/pblk.h
>>>>> @@ -690,6 +690,7 @@ struct pblk {
>>>>>    atomic_t inflight_io;           /* General inflight I/O counter =
*/
>>>>>=20
>>>>>    struct task_struct *writer_ts;
>>>>> +   int writer_cpu;
>>>>>=20
>>>>>    /* Simple translation map of logical addresses to physical =
addresses.
>>>>>     * The logical addresses is known by the host system, while the =
physical
>>>>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>>>>> index 949e29e..971a19f 100644
>>>>> --- a/drivers/nvme/host/lightnvm.c
>>>>> +++ b/drivers/nvme/host/lightnvm.c
>>>>> @@ -982,6 +982,7 @@ int nvme_nvm_register(struct nvme_ns *ns, char =
*disk_name, int node)
>>>>>    memcpy(dev->name, disk_name, DISK_NAME_LEN);
>>>>>    dev->ops =3D &nvme_nvm_dev_ops;
>>>>>    dev->private_data =3D ns;
>>>>> +   dev->node =3D node;
>>>>>    ns->ndev =3D dev;
>>>>>=20
>>>>>    return nvm_register(dev);
>>>>> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
>>>>> index 5d865a5..312029e 100644
>>>>> --- a/include/linux/lightnvm.h
>>>>> +++ b/include/linux/lightnvm.h
>>>>> @@ -427,6 +427,8 @@ struct nvm_dev {
>>>>>    char name[DISK_NAME_LEN];
>>>>>    void *private_data;
>>>>>=20
>>>>> +   int node;
>>>>> +
>>>>>    void *rmap;
>>>>>=20
>>>>>    struct mutex mlock;
>>>>> --
>>>>> 1.8.3.1
>>>>=20
>>>> We have a per-CPU semaphore that only allows to send a single I/O =
in
>>>> order to prevent write pointer violations. Are you seeing this =
error, or
>>>> is it theoretical?
>>>>=20
>>>> Javier
>>>=20
>>> I meant per PU (parallel unit)=E2=80=A6
>>=20
>> You are right, for current upstream implementation it's theoretical. =
I
>> saw it after some experimental changes in lightnvm layer.
>>=20
>> But I see one more potential benefit from this patch (correct me if =
I'm
>> wrong), after this patch we will be sure that write thread is working =
on
>> cpu from right numa node for device. Now I think, we can also take =
under
>> consideration binding to whole set of cpus from right numa node =
instead
>> of particular one.

I can see what you mean, but I think we are better relying on the
scheduler balancing the NUMA nodes rather than pinning the write thread
to specific CPUs. Are we doing something like this in the writeback
path?

>=20
> If this is just a potential benefit, I'd rather not do this, at least
> not until we have numbers on any performance benefits and an analysis
> of any trade offs.
>=20
> Thanks,
> Hans
>> Marcin

--Apple-Mail=_697463C2-C686-456C-BD9F-DE1C57BF808E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyP4d4ACgkQPEYBfS0l
eOAoRRAAnmynEOtqcr8d9iMem6J9ZDYR3FyW/E1bPqfP8Qf+2XpNoHteJoT9kjv8
1yvIWI8S6H9kwMYk+qmWc4s9f0N5ak3xy/XWWYod6BALY9jKKK8sEFC9faOLxBUS
+6KrWAGQHQGC0lvGW5L5AsaP6sLMQFcw63SC2K2UOE0/ove3GGTEBmxqz8ZUY8X/
k87/ZMZQwZQrmdcNFQ/hw9dZl4Htm5yGcRSLXZ/PsQ6L+jCDeKpp6cRZDzRjyJh4
hhPCQNQHwP45uSL7XURYNJs6lsYp4Fe7f54cokmsyHIkUE2h4TLoxywTJWaF54zc
9EpyZ+cxIe2eSsN7L3VziysEIex7ioKnGxF8uqp9TmW/j/Ge9nTvag8yOxLIKo/l
/c/ftiRXIJvnmtZq3b6iqYSVCd0e18gkjrXfWAMoxO/ZzFV2phTEp3UjLuuYkDxD
MLKB4WJ9Gq6qsQiyG0kYuSDRcIcB2r6LmpGWdCCqhJ2zTR9Td2u1Bowd4d2/u4gU
87/OqecNf/xKW+vs8126xTOsLpENszjKjINgX4TWVvYbBnDPjL4zYQg6iVqtrwTP
+sTEWw925EQEvMAmj/Ns7WWMhkHXa07nRIxqrHFSnwFZnuRk4aSEcDE2nIJ73ZSV
fwqDPdNRlC0SnLdW7r0dvPrzp5mtOszMXBoCjciG0FG6k9umD5w=
=Hk5v
-----END PGP SIGNATURE-----

--Apple-Mail=_697463C2-C686-456C-BD9F-DE1C57BF808E--
