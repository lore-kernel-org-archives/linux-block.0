Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1687C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 12:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CBD218A1
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 12:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="tGol1RNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388564AbfCVMfn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:35:43 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33476 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390003AbfCVMeq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 08:34:46 -0400
Received: by mail-ed1-f68.google.com with SMTP id q3so1561851edg.0
        for <linux-block@vger.kernel.org>; Fri, 22 Mar 2019 05:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=V53kJ96aKw32vrLZTIDJkSvYG2OnDUTGNsJdZYXUxxc=;
        b=tGol1RNi/InzwcGPdhmY2nITX7SUpE/OEHoHAcjhfBQZiIKm9DobgpDULofXNgoW3t
         dATX2JxWdOJFZVm61/2sgjwqPqO7JxlHF/1WlFD2xRP021Yw7aCqc2jhjcf5S88NQesb
         cpLwtwxRZxej8XG7F+CXj6gUVFxCSEhe962w3d7PgJNHr436Dvy4BMZ+QgjN+tccc42v
         EXMdEcJZx3di9RfKZPgrO0ATWIZLrqsuhqct/ULJFPxGAdVsMX3L9Ausw8P1d4ksVAkO
         zpVb9yk8u/QJodKmtIadgK/Dbo2vcHtAjrcYWXCPcr+lQXJPyFo7AD/aAoY2hCxotkEi
         yawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=V53kJ96aKw32vrLZTIDJkSvYG2OnDUTGNsJdZYXUxxc=;
        b=DmwuNT82G2dhcyws6t0Mh0ciduXshTEWe7eVOnq7SU3qEeeMWl3bN8ex6TZ0dr0zmy
         bcDCJHCtYcPnY4whm8orjHm29ukciF1/g+rCRHcWnHmisDS/Hje7UC34m5HX4v9dRa8d
         PP9fKcDABn+S1C0PsVd+lP4vjn45pSqf9VdPQECJtSNK8t98KT+1UQsQTBgIft7spKm6
         zSSDt14FkIp8KDXjcOgmrifQ3rqKzY0GNKIry9Cw9E5Ib0Kvm5Nu39MeUal4QZJqgIU8
         Myy+za3wHV0SCjetfIKIR1Xtwx69y8iyrAuucU52YCGoII07unJ971GIgFYFlkZnBPzX
         XQ8Q==
X-Gm-Message-State: APjAAAWnq9zdUsDexeWsdTMWJZBeN6fEv2pJLI/EXVCrLWgjtszKWNLs
        2ojAuv4fGoM7LnARuwSl0hascA==
X-Google-Smtp-Source: APXvYqyw408KSf+qmdWFIUL7ZJcGpo079++xIys+8Q0BqrsEyyocsAsW/WBUT9GIGoV0hyV88iZEhA==
X-Received: by 2002:a50:ca41:: with SMTP id e1mr6302066edi.73.1553258083926;
        Fri, 22 Mar 2019 05:34:43 -0700 (PDT)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id h34sm2633071edb.13.2019.03.22.05.34.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 05:34:43 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <B62BC149-32E4-4033-81BD-8AC1F2B5E5EE@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_35FD5C8D-D2E2-4C9D-BAE4-23493D047A3F";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [RFC PATCH] lightnvm: add mechanism to trigger pblk close on
 reboot
Date:   Fri, 22 Mar 2019 13:34:42 +0100
In-Reply-To: <45ed5eee-ec10-5fa3-fda2-33f413d68ced@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        "Konopko, Igor J" <igor.j.konopko@intel.com>
To:     Marcin Dziegielewski <marcin.dziegielewski@intel.com>
References: <1553096315-11128-1-git-send-email-marcin.dziegielewski@intel.com>
 <3925EE02-8AE8-4F99-BF85-A73B195C601C@javigon.com>
 <45ed5eee-ec10-5fa3-fda2-33f413d68ced@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_35FD5C8D-D2E2-4C9D-BAE4-23493D047A3F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 22 Mar 2019, at 13.01, Marcin Dziegielewski =
<marcin.dziegielewski@intel.com> wrote:
>=20
>=20
>=20
> On 3/21/19 10:32 AM, Javier Gonz=C3=A1lez wrote:
>>> On 20 Mar 2019, at 16.38, Marcin Dziegielewski =
<marcin.dziegielewski@intel.com> wrote:
>>>=20
>>> Currently if we issue reboot to the system pblk will close
>>> ungracefully and in consequence it will need recovery on load.
>>>=20
>>> This patch propose utilize of reboot notifier feature to trigger
>>> gracefull pblk shutdown on reboot.
>>>=20
>>> Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
>>> ---
>>> drivers/lightnvm/core.c | 64 =
+++++++++++++++++++++++++++++++++++++++----------
>>> 1 file changed, 51 insertions(+), 13 deletions(-)
>>>=20
>>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>>> index 5f82036..5488051 100644
>>> --- a/drivers/lightnvm/core.c
>>> +++ b/drivers/lightnvm/core.c
>>> @@ -27,6 +27,7 @@
>>> #include <linux/miscdevice.h>
>>> #include <linux/lightnvm.h>
>>> #include <linux/sched/sysctl.h>
>>> +#include <linux/reboot.h>
>>>=20
>>> static LIST_HEAD(nvm_tgt_types);
>>> static DECLARE_RWSEM(nvm_tgtt_lock);
>>> @@ -1138,6 +1139,48 @@ struct nvm_dev *nvm_alloc_dev(int node)
>>> }
>>> EXPORT_SYMBOL(nvm_alloc_dev);
>>>=20
>>> +static void _nvm_unregister(struct nvm_dev *dev, bool graceful)
>>> +{
>>> +	struct nvm_target *t, *tmp;
>>> +
>>> +	mutex_lock(&dev->mlock);
>>> +	list_for_each_entry_safe(t, tmp, &dev->targets, list) {
>>> +		if (t->dev->parent !=3D dev)
>>> +			continue;
>>> +		__nvm_remove_target(t, graceful);
>>> +	}
>>> +	mutex_unlock(&dev->mlock);
>>> +
>>> +	list_del(&dev->devices);
>>> +
>>> +	nvm_free(dev);
>>> +}
>>> +
>>> +static int nvm_notify_reboot(struct notifier_block *this,
>>> +			    unsigned long code, void *x)
>>> +{
>>> +	struct nvm_dev *dev, *t;
>>> +
>>> +	down_write(&nvm_lock);
>>> +	if (list_empty(&nvm_devices)) {
>>> +		up_write(&nvm_lock);
>>> +		return NOTIFY_DONE;
>>> +	}
>>> +
>>> +	list_for_each_entry_safe(dev, t, &nvm_devices, devices)
>>> +		_nvm_unregister(dev, true);
>>> +
>>> +	up_write(&nvm_lock);
>>> +
>>> +	return NOTIFY_DONE;
>>> +}
>>> +
>>> +static struct notifier_block nvm_notifier =3D {
>>> +	.notifier_call	=3D nvm_notify_reboot,
>>> +	.next		=3D NULL,
>>> +	.priority	=3D INT_MAX, /* before any real devices */
>> Why this priority?
>=20
> I believe that is the safest priority for our case, I based on bcache
> approach. Should I use other priority?
>=20

I=E2=80=99m not very familiar with the notifier_block. I quick look =
showed that
most modules do not use it, that=E2=80=99s what I asked. Not real =
feedback here.

>>> +};
>>> +
>>> int nvm_register(struct nvm_dev *dev)
>>> {
>>> 	int ret, exp_pool_size;
>>> @@ -1161,8 +1204,11 @@ int nvm_register(struct nvm_dev *dev)
>>> 		return -ENOMEM;
>>> 	}
>>>=20
>>> -	/* register device with a supported media manager */
>>> 	down_write(&nvm_lock);
>>> +	if (list_empty(&nvm_devices))
>>> +		register_reboot_notifier(&nvm_notifier);
>>> +
>>> +	/* register device with a supported media manager */
>>> 	list_add(&dev->devices, &nvm_devices);
>>> 	up_write(&nvm_lock);
>>>=20
>>> @@ -1172,21 +1218,13 @@ int nvm_register(struct nvm_dev *dev)
>>>=20
>>> void nvm_unregister(struct nvm_dev *dev)
>>> {
>>> -	struct nvm_target *t, *tmp;
>>> +	down_write(&nvm_lock);
>>>=20
>>> -	mutex_lock(&dev->mlock);
>>> -	list_for_each_entry_safe(t, tmp, &dev->targets, list) {
>>> -		if (t->dev->parent !=3D dev)
>>> -			continue;
>>> -		__nvm_remove_target(t, false);
>>> -	}
>>> -	mutex_unlock(&dev->mlock);
>>> +	_nvm_unregister(dev, false);
>> You are adding an extra lock dependency here. I cannot see any =
obvious
>> problem with it, but you probably want to test this with lock =
debugging
>> enabled.
>=20
> It was good suggestion, thanks. With enabled lock debugging I have =
found
> one potential deadlock, I will send second version of this patch.
>=20

Cool.


>>> -	down_write(&nvm_lock);
>>> -	list_del(&dev->devices);
>>> +	if (list_empty(&nvm_devices))
>>> +		unregister_reboot_notifier(&nvm_notifier);
>>> 	up_write(&nvm_lock);
>>> -
>>> -	nvm_free(dev);
>>> }
>>> EXPORT_SYMBOL(nvm_unregister);
>>>=20
>>> --
>>> 1.8.3.1
>> Otherwise, I think adding this functionality is beneficial.

--Apple-Mail=_35FD5C8D-D2E2-4C9D-BAE4-23493D047A3F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyU1mIACgkQPEYBfS0l
eOB/ghAAgtxh4hI8PjMp8vbS8Es7U2njZINlPnW+m9afZZQUM8zPmYJ30L3kaY46
XlTiRnZdyHKW6S02idZ9ks9Cfv6+mHX1lCEzigMNWiJir7nBhIolDsNuVTFQm1ZQ
dDN0PRlW4v3zTw4Mg+DvTGyhj49GCAegXGc81Dj8TVbdfScKERVlKlefWRCTEgBN
/ujMObV6Nt6ScnhzLw2KoJUJDj01EXHKmikQdLLGdPKYzIPctWGaEkUnnHpkzwdp
usK1s4JG6fKHdYDO/GhY/+hbOzpM3jarqY+ou2ObSSxVlD1tE/ILeaXUyyIRaOr6
XnHdEojL2YGjxsWpDcr4AMp1U0zI660GOmksv+zbjjjdF+953V+GN/IYRsQ0T5a2
rh/IWkJIRAmKc7Q0XcOp/83625t4OYaREoGcc5lHXcgSiQbZJBIui3V5CWqteVVX
X3fXhxmccMMNW3mOJBH5yX1p/bx4lY51fc0Z1Mv63KsUJuZTURrmA+pzTwV1ueI5
5NBAWdAT6yeJey79g8m2aXR67bgXyXK4jvni9ddRd/Zv7i7rQqH+wWmy+dBYv/DZ
M8OSdEc24egGwUV1PltJRSfddpuWc/8vZOmRrcdy7KMOjHxuE5rs1nUmBVoRPba2
vyoUIrNnyFsdgemzPKdNRcBefAGM5LKrJg82CvUj0l0B4cdTTKU=
=phPu
-----END PGP SIGNATURE-----

--Apple-Mail=_35FD5C8D-D2E2-4C9D-BAE4-23493D047A3F--
