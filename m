Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09322C4363A
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 14:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96FDB21941
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 14:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ay5mEoM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbgJHOn5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 10:43:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20285 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729830AbgJHOn5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Oct 2020 10:43:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602168236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZXuOxluFt5O3b6TBIo+f4RqKR9Ax41B84tpljuhMJpI=;
        b=ay5mEoM1pry8BLSrQ28khl8T1q5Z5SMJkMvZDrvYsMvwUSixiZYCiraksPru8pCUFzq34y
        JNzwio7Zo4CCDF5IeDrNj7icFxhkJpELFCyCtdQ8k1m0WTs8b4XOTVEEAZmdRhXqInY2Q6
        WsZ0OnSKG0sbFWn7A5MfiiQbrDsbj7Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-GyoMgeN4MrqXPHXIm4tq9Q-1; Thu, 08 Oct 2020 10:43:54 -0400
X-MC-Unique: GyoMgeN4MrqXPHXIm4tq9Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6AC6107AD64;
        Thu,  8 Oct 2020 14:43:52 +0000 (UTC)
Received: from gondolin (ovpn-113-82.ams2.redhat.com [10.36.113.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E60DD61176;
        Thu,  8 Oct 2020 14:43:50 +0000 (UTC)
Date:   Thu, 8 Oct 2020 16:43:48 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 08/10] s390/dasd: Display FC Endpoint Security
 information via sysfs
Message-ID: <20201008164348.0e640045.cohuck@redhat.com>
In-Reply-To: <20201008131336.61100-9-sth@linux.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
        <20201008131336.61100-9-sth@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu,  8 Oct 2020 15:13:34 +0200
Stefan Haberland <sth@linux.ibm.com> wrote:

> From: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
>=20
> Add a new sysfs attribute (fc_security) per device and per operational
> channel path. The information of the current FC Endpoint Security state
> is received through the CIO layer.
>=20
> The state of the FC Endpoint Security can be either "Unsupported",
> "Authentication", or "Encryption".
>=20
> For example:
> $ cat /sys/bus/ccw/devices/0.0.c600/fc_security
> Encryption
>=20
> If any of the operational paths is in a state different from all
> others, the device sysfs attribute will display the additional state
> "Inconsistent".
>=20
> The sysfs attributes per paths are organised in a new directory called
> "paths_info" with subdirectories for each path.
>=20
> /sys/bus/ccw/devices/0.0.c600/paths_info/
> =E2=94=9C=E2=94=80=E2=94=80 0.38
> =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 fc_security
> =E2=94=9C=E2=94=80=E2=94=80 0.39
> =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 fc_security
> =E2=94=9C=E2=94=80=E2=94=80 0.3a
> =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 fc_security
> =E2=94=94=E2=94=80=E2=94=80 0.3b
>     =E2=94=94=E2=94=80=E2=94=80 fc_security
>=20
> Signed-off-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> ---
>  drivers/s390/block/dasd_devmap.c | 109 +++++++++++++++++++++++++++++++
>  drivers/s390/block/dasd_eckd.c   |  30 +++++++++
>  drivers/s390/block/dasd_int.h    |  68 +++++++++++++++++++
>  3 files changed, 207 insertions(+)

(...)

> +/*
> + * As we keep kobjects for the lifetime of a device, this function must =
not be
> + * called anywhere but in the context of offlining a device.
> + */

Works for me :)

> +void dasd_path_remove_kobj(struct dasd_device *device, int chp)
> +{
> +	if (device->path[chp].in_sysfs) {
> +		kobject_put(&device->path[chp].kobj);
> +		device->path[chp].in_sysfs =3D false;
> +	}
> +}
> +EXPORT_SYMBOL(dasd_path_remove_kobj);

(...)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

