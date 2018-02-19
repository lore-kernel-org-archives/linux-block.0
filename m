Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33808 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752666AbeBSNkg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Feb 2018 08:40:36 -0500
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/8] lightnvm: show generic geometry in sysfs
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javigon.napster@gmail.com>
In-Reply-To: <dc558965-9c1f-26f1-9274-12a6f8057825@lightnvm.io>
Date: Mon, 19 Feb 2018 14:40:32 +0100
Cc: Javier Gonzalez <javier@cnexlabs.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Message-Id: <F72BAE57-88B8-447B-B0D2-7EB6AE8105A2@gmail.com>
References: <1518530768-20956-1-git-send-email-javier@cnexlabs.com> <1518530768-20956-3-git-send-email-javier@cnexlabs.com> <caa2634b-63bf-3a35-ed53-220aab2bd05a@lightnvm.io> <E53B65E9-3D1A-49BB-AA5D-F3D2C4032484@cnexlabs.com> <dc558965-9c1f-26f1-9274-12a6f8057825@lightnvm.io>
To: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


>>> This breaks user-space. The intention is for user-space to decide
>>> based on version id. Then it can either retrieve the 1.2 or 2.0
>>> attributes. The 2.0 attributes should not be available when a device
>>> is 1.2.
>>>=20
>> Why does it break it? I'm only adding new entries.
>> The objective is to expose the genneric geometry, since this is the
>> structure that is passed on to the targets. Since some of the values are
>> calculated, there is value on exposing this information, I believe.
>> Another way of doing it, is adding the generic geometry at the target
>> level, showing what base values it is getting, including the real number
>> of channels/groups and luns/pus.
>> Would this be better in your opinion?
>=20
> No. It should be one set of attributes for 1.2 (keep the way it is today),=
 and then separate 2.0 attributes. User-space should then identify either by=
 either 1 or 2 in the version attribute.
>=20
>>>> ...

>>> csecs and sos are derived from the the generic block device data structu=
res.
>> As mentioned above, it is to represent the generic geometry.
>=20
> They are not part of the 2.0 spec. The fields can be derived from elsewher=
e.
>>>=20

Ok. Thanks for looking into it.=20

Javier.=20=
