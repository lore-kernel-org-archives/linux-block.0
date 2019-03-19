Return-Path: <SRS0=YHP0=RW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0F1C43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 14:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724CC213F2
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 14:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="CBjlJa2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfCSOZ2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:25:28 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34579 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfCSOZ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Mar 2019 10:25:28 -0400
Received: by mail-ed1-f65.google.com with SMTP id a16so16778319edn.1
        for <linux-block@vger.kernel.org>; Tue, 19 Mar 2019 07:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=8TJFn66W0Eqg5Zq6m2bK77QV/dTJCQf/76jQ+dgT88o=;
        b=CBjlJa2skatYCXmy3/rLw3I0Ycg26BEb5kG7pM01/+WLd8yYdi7MBbv0WbudQL+69k
         aJJjy8AUHY70vkbvBNhJdX7tLhTnFGhO6/J1VakiT9zsONJ+2n7xhat+n5nXKXLHkPMQ
         4ZJGbIN/4fhs/kiPzRNgyJVRq5UakiXrpDwjakVhSt6eUzaPEJm1NTlA+BJQodnAimwh
         z1DP0lEXuPrcSVWG1mGAv/koIaZky5KwjOSnmIRw/2+4Xi7lmvN+IXQTOnptEGQtIZpf
         YUir+dyQ0mig+VD70Odc4LSEs+eS1pJI1ok3dT4zQzuHrQmlG37LVyXoCAHTJe/64YBA
         p8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=8TJFn66W0Eqg5Zq6m2bK77QV/dTJCQf/76jQ+dgT88o=;
        b=DC7uUciPGI8VXM4HvFUKagqHVgAv8xAXw1I5rC9hVSescRo3OAL1+xpbM7s4sur+xz
         +QMNG7g2L/ycLDkiHd/N2QhJRcyu/V53YfkZnQMMm/Aw6n7UHpj/cVRIf/WBPTfr4Cow
         Fs44yVDMzV6y2xjD0JUVF3TUCDm5cxXPT1QQiX/uTb6OWd3mCztt9nDfH2XkeMIZdgZh
         c15coVwBZmSirEwgb9mWUs2aBXYOyP9o+bscv1IKnLWXzVKmu0fl4kf3hey5o+azNLtg
         FgJGAOjXu2aw2Tza1YtFPla9bmtZ99j5gF3bPXGoO4MPeHvUgo3d7lACcDgvko+whzuc
         FtQQ==
X-Gm-Message-State: APjAAAUkfBUr9MPCwzJSkxfdj4UB/Kqtz8DJG18iyA7crLhJErpy+jsi
        ud2cXoCaKPNv/OEWOOxSgl/Qkg==
X-Google-Smtp-Source: APXvYqyISEEnA4YqMfJBro32SHcrTRnfbE38SEERUdzXh2EcEMtDk9ELvCPC4jQgma0yuzURbYloWA==
X-Received: by 2002:a17:906:1e51:: with SMTP id i17mr14519273ejj.195.1553005526184;
        Tue, 19 Mar 2019 07:25:26 -0700 (PDT)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id n7sm4282280edq.69.2019.03.19.07.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 07:25:25 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <FFDFC41B-DFBF-45AD-B88E-20E471B2992B@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_74CCBEF1-2064-434C-A46B-9C3AC42874D4";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] lightnvm: pblk: set write thread affinity to particular
 cpu
Date:   Tue, 19 Mar 2019 15:25:24 +0100
In-Reply-To: <8a5b2527-20b2-0e17-1546-64d0f3c81a5b@intel.com>
Cc:     Hans Holmberg <hans@owltronix.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        "Konopko, Igor J" <igor.j.konopko@intel.com>
To:     Marcin Dziegielewski <marcin.dziegielewski@intel.com>
References: <1552573079-12712-1-git-send-email-marcin.dziegielewski@intel.com>
 <874EAB88-573F-485A-A008-FE1CC803E8D3@javigon.com>
 <D45E9938-F025-446D-8E48-CAE954B791A6@javigon.com>
 <a63ef9e7-214a-a701-5c40-d1d1107de4a4@intel.com>
 <CANr-nt3B8UknSTdKOj2PbfDRTfPJZ+g1s83XY2egtBdZqsU6tQ@mail.gmail.com>
 <F0D71B2E-6AD6-413F-BE90-660361FFC232@javigon.com>
 <8a5b2527-20b2-0e17-1546-64d0f3c81a5b@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_74CCBEF1-2064-434C-A46B-9C3AC42874D4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 19 Mar 2019, at 14.33, Marcin Dziegielewski =
<marcin.dziegielewski@intel.com> wrote:
>=20
>=20
>=20
> On 3/18/19 7:22 PM, Javier Gonz=C3=A1lez wrote:
>>> On 18 Mar 2019, at 13.22, Hans Holmberg <hans@owltronix.com> wrote:
>>>=20
>>> On Mon, Mar 18, 2019 at 10:44 AM Marcin Dziegielewski
>>> <marcin.dziegielewski@intel.com> wrote:
>>>> On 3/14/19 3:22 PM, Javier Gonz=C3=A1lez wrote:
>>>>>> On 14 Mar 2019, at 07.22, Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
>>>>>>=20
>>>>>>> On 14 Mar 2019, at 07.17, Marcin Dziegielewski =
<marcin.dziegielewski@intel.com> wrote:
>>>>>>>=20
>>>>>>> In some cases write thread migration between cpus can cause
>>>>>>> sending writes in improper order and in consequence a lot of
>>>>>>> errors from device.
>>>>>>>=20
>>>>>>> Write thread affinity to particular cpu prevent before it.
>>>>>>>=20
>>>>>>> Signed-off-by: Marcin Dziegielewski =
<marcin.dziegielewski@intel.com>
>>>>>>> ---
>>>>>>> drivers/lightnvm/pblk-init.c | 30 +++++++++++++++++++++++++++++-
>>>>>>> drivers/lightnvm/pblk.h      |  1 +
>>>>>>> drivers/nvme/host/lightnvm.c |  1 +
>>>>>>> include/linux/lightnvm.h     |  2 ++
>>>>>>> 4 files changed, 33 insertions(+), 1 deletion(-)
>>>>>>>=20
>>>>>>> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
>>>>>>> index 81e8ed4..bd25004 100644
>>>>>>> --- a/drivers/lightnvm/pblk-init.c
>>>>>>> +++ b/drivers/lightnvm/pblk-init.c
>>>>>>> @@ -21,6 +21,8 @@
>>>>>>>=20
>>>>>>> #include "pblk.h"
>>>>>>> #include "pblk-trace.h"
>>>>>>> +#include <linux/cpumask.h>
>>>>>>> +#include <linux/numa.h>
>>>>>>>=20
>>>>>>> static unsigned int write_buffer_size;
>>>>>>>=20
>>>>>>> @@ -47,6 +49,8 @@ struct pblk_global_caches {
>>>>>>>=20
>>>>>>> struct bio_set pblk_bio_set;
>>>>>>>=20
>>>>>>> +cpumask_t free_cpumask;
>>>>>>> +
>>>>>>> static int pblk_rw_io(struct request_queue *q, struct pblk =
*pblk,
>>>>>>>                      struct bio *bio)
>>>>>>> {
>>>>>>> @@ -1098,6 +1102,9 @@ static int pblk_lines_init(struct pblk =
*pblk)
>>>>>>>=20
>>>>>>> static int pblk_writer_init(struct pblk *pblk)
>>>>>>> {
>>>>>>> +   cpumask_t tmp_cpumask, cpumask;
>>>>>>> +   int cpu;
>>>>>>> +
>>>>>>>    pblk->writer_ts =3D kthread_create(pblk_write_ts, pblk, =
"pblk-writer-t");
>>>>>>>    if (IS_ERR(pblk->writer_ts)) {
>>>>>>>            int err =3D PTR_ERR(pblk->writer_ts);
>>>>>>> @@ -1108,6 +1115,22 @@ static int pblk_writer_init(struct pblk =
*pblk)
>>>>>>>            return err;
>>>>>>>    }
>>>>>>>=20
>>>>>>> +   cpumask_and(&tmp_cpumask, =
cpumask_of_node(pblk->dev->parent->node),
>>>>>>> +                   cpu_online_mask);
>>>>>>> +   cpumask_and(&cpumask, &tmp_cpumask, &free_cpumask);
>>>>>>> +
>>>>>>> +   if (!cpumask_weight(&free_cpumask)) {
>>>>>>> +           free_cpumask =3D CPU_MASK_ALL;
>>>>>>> +           cpumask_and(&cpumask, &tmp_cpumask, &free_cpumask);
>>>>>>> +   }
>>>>>>> +
>>>>>>> +   cpu =3D cpumask_last(&cpumask);
>>>>>>> +
>>>>>>> +   kthread_bind(pblk->writer_ts, cpu);
>>>>>>> +
>>>>>>> +   cpumask_clear_cpu(cpu, &free_cpumask);
>>>>>>> +   pblk->writer_cpu =3D cpu;
>>>>>>> +
>>>>>>>    timer_setup(&pblk->wtimer, pblk_write_timer_fn, 0);
>>>>>>>    mod_timer(&pblk->wtimer, jiffies + msecs_to_jiffies(100));
>>>>>>>=20
>>>>>>> @@ -1126,8 +1149,11 @@ static void pblk_writer_stop(struct pblk =
*pblk)
>>>>>>>                    "Stopping not fully synced write buffer\n");
>>>>>>>=20
>>>>>>>    del_timer_sync(&pblk->wtimer);
>>>>>>> -   if (pblk->writer_ts)
>>>>>>> +   if (pblk->writer_ts) {
>>>>>>> +           set_cpus_allowed_ptr(pblk->writer_ts, =
cpu_online_mask);
>>>>>>>            kthread_stop(pblk->writer_ts);
>>>>>>> +           cpumask_set_cpu(pblk->writer_cpu, &free_cpumask);
>>>>>>> +   }
>>>>>>> }
>>>>>>>=20
>>>>>>> static void pblk_free(struct pblk *pblk)
>>>>>>> @@ -1328,6 +1354,8 @@ static int __init pblk_module_init(void)
>>>>>>> {
>>>>>>>    int ret;
>>>>>>>=20
>>>>>>> +   free_cpumask =3D CPU_MASK_ALL;
>>>>>>> +
>>>>>>>    ret =3D bioset_init(&pblk_bio_set, BIO_POOL_SIZE, 0, 0);
>>>>>>>    if (ret)
>>>>>>>            return ret;
>>>>>>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>>>>>>> index 381f074..650f983 100644
>>>>>>> --- a/drivers/lightnvm/pblk.h
>>>>>>> +++ b/drivers/lightnvm/pblk.h
>>>>>>> @@ -690,6 +690,7 @@ struct pblk {
>>>>>>>    atomic_t inflight_io;           /* General inflight I/O =
counter */
>>>>>>>=20
>>>>>>>    struct task_struct *writer_ts;
>>>>>>> +   int writer_cpu;
>>>>>>>=20
>>>>>>>    /* Simple translation map of logical addresses to physical =
addresses.
>>>>>>>     * The logical addresses is known by the host system, while =
the physical
>>>>>>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>>>>>>> index 949e29e..971a19f 100644
>>>>>>> --- a/drivers/nvme/host/lightnvm.c
>>>>>>> +++ b/drivers/nvme/host/lightnvm.c
>>>>>>> @@ -982,6 +982,7 @@ int nvme_nvm_register(struct nvme_ns *ns, =
char *disk_name, int node)
>>>>>>>    memcpy(dev->name, disk_name, DISK_NAME_LEN);
>>>>>>>    dev->ops =3D &nvme_nvm_dev_ops;
>>>>>>>    dev->private_data =3D ns;
>>>>>>> +   dev->node =3D node;
>>>>>>>    ns->ndev =3D dev;
>>>>>>>=20
>>>>>>>    return nvm_register(dev);
>>>>>>> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
>>>>>>> index 5d865a5..312029e 100644
>>>>>>> --- a/include/linux/lightnvm.h
>>>>>>> +++ b/include/linux/lightnvm.h
>>>>>>> @@ -427,6 +427,8 @@ struct nvm_dev {
>>>>>>>    char name[DISK_NAME_LEN];
>>>>>>>    void *private_data;
>>>>>>>=20
>>>>>>> +   int node;
>>>>>>> +
>>>>>>>    void *rmap;
>>>>>>>=20
>>>>>>>    struct mutex mlock;
>>>>>>> --
>>>>>>> 1.8.3.1
>>>>>>=20
>>>>>> We have a per-CPU semaphore that only allows to send a single I/O =
in
>>>>>> order to prevent write pointer violations. Are you seeing this =
error, or
>>>>>> is it theoretical?
>>>>>>=20
>>>>>> Javier
>>>>>=20
>>>>> I meant per PU (parallel unit)=E2=80=A6
>>>>=20
>>>> You are right, for current upstream implementation it's =
theoretical. I
>>>> saw it after some experimental changes in lightnvm layer.
>>>>=20
>>>> But I see one more potential benefit from this patch (correct me if =
I'm
>>>> wrong), after this patch we will be sure that write thread is =
working on
>>>> cpu from right numa node for device. Now I think, we can also take =
under
>>>> consideration binding to whole set of cpus from right numa node =
instead
>>>> of particular one.
>> I can see what you mean, but I think we are better relying on the
>> scheduler balancing the NUMA nodes rather than pinning the write =
thread
>> to specific CPUs. Are we doing something like this in the writeback
>> path?
> I have checked wrtieback path and I didn't find nothing similar, so =
please disregard this patch.
>=20
> Marcin
>=20

Don=E2=80=99t get me wrong. I think it is a good motivation, but maybe =
it should
be implemented at a different level.

Thanks,
Javier

--Apple-Mail=_74CCBEF1-2064-434C-A46B-9C3AC42874D4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyQ+9QACgkQPEYBfS0l
eOCwmxAA1wSea0auUaNa2rD+AQ4wYdRuRWBeJxqJyul/R5z8Dhfvf7K7kENrwuvF
s0T7d0DhWYfaPhdU/3sewwjuC/aNUOEbHMf2i0hE8D9d6VLY93zDw8fYL3xygwCB
dumRCaePNIoKhbxkV+OzxyI+ufJVA5qsbbp0RDnctWU6uwvSYMbJDw+yk+lRbaqU
OoTQn2nbX3DVxbSpLuIgnbXba1SM3hz0OBIxHRpDZS9P/psthhUiCnvo2jmmY1lJ
Ohn9S68gXlXrj+fQQNWBH3lox1depmAz+ynDETHoHMYoron89JkgLv71Eme/DFSi
Cz22FvkJXJkE9NTyGZuyI9R9EY9Izl+1PN0ttMMjoOKwvCwrwsmQNzXUrXiuZi4k
5QSNAcZA1wainl7nxpwY7UT7gns/yOzDbMiFRwrcSKnmnP74N4i3d5dVFUUlD0PK
G+JOwkoj3iDshfh/HRrMFo5rc+j4N+dFH+tk4sMVPnaibi9iYgYruYncpEMSNmcU
U5hZqvPRAu5GOx/z4Cj1owEQfvIbM575hyi/7mIshLSI/pTHD5Ws6PKr73GkaguB
bW0BrepuvSV/0aasp2OPq06wGpcfYZ6DaDm8Rbp3zk7TueM/iHnzu9dLmTgEGL0p
xK6mJAaIwAIAD4VP1dKiTpwp+TwR0qep53vKpaptSOpjxSsM5cQ=
=C4ej
-----END PGP SIGNATURE-----

--Apple-Mail=_74CCBEF1-2064-434C-A46B-9C3AC42874D4--
