Return-Path: <SRS0=/MU2=DN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B294C41604
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 10:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04A66206D4
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 10:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MV71gqT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgJFK0o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Oct 2020 06:26:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60971 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725943AbgJFK0o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Oct 2020 06:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601980002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B+xpK39ipzEQZP2pUbR9zVuwbrzagaVE3kPCHYxBbPQ=;
        b=MV71gqT97PslyWSevjZQ4hcp2oilCEMiteWQGr/4141e8v+DHvWvoSAR0PkK2wjEZxX3CB
        q1wehVBePbNWikRJnt4SeAFv2h+PGYx373f5HWwHNWLpwMTA6iCM22lrFGDV5NrtyBYkKM
        X72CAB2Y5D6dcPx2rJCsk9OoCEurnjY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-4I0E1M8oOVG9ptvJv5UMzQ-1; Tue, 06 Oct 2020 06:26:38 -0400
X-MC-Unique: 4I0E1M8oOVG9ptvJv5UMzQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF8608D985B;
        Tue,  6 Oct 2020 10:26:36 +0000 (UTC)
Received: from gondolin (ovpn-112-156.ams2.redhat.com [10.36.112.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CC541A923;
        Tue,  6 Oct 2020 10:26:34 +0000 (UTC)
Date:   Tue, 6 Oct 2020 12:26:32 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        hoeppner@linux.ibm.com, linux-s390@vger.kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: Re: [PATCH 08/10] s390/dasd: Display FC Endpoint Security
 information via sysfs
Message-ID: <20201006122632.098149ba.cohuck@redhat.com>
In-Reply-To: <20201002193940.24012-9-sth@linux.ibm.com>
References: <20201002193940.24012-1-sth@linux.ibm.com>
        <20201002193940.24012-9-sth@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri,  2 Oct 2020 21:39:38 +0200
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
> Reference-ID: IO1812
> Signed-off-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> ---
>  drivers/s390/block/dasd_devmap.c | 105 +++++++++++++++++++++++++++++++
>  drivers/s390/block/dasd_eckd.c   |  30 +++++++++
>  drivers/s390/block/dasd_int.h    |  68 ++++++++++++++++++++
>  3 files changed, 203 insertions(+)
>=20

(...)

> +static struct kobj_type path_attr_type =3D {
> +	.release	=3D dasd_path_release,

This function does nothing; I think there's something wrong with your
kobject handling?

> +	.default_attrs	=3D paths_info_attrs,
> +	.sysfs_ops	=3D &kobj_sysfs_ops,
> +};
> +
> +static void dasd_path_init_kobj(struct dasd_device *device, int chp)
> +{
> +	device->path[chp].kobj.kset =3D device->paths_info;
> +	kobject_init(&device->path[chp].kobj, &path_attr_type);

This inits a static kobject; as you never free it, doesn't the code
moan about state_initialized if you try to do that a second time?

> +}
> +
> +void dasd_path_create_kobj(struct dasd_device *device, int chp)
> +{
> +	int rc;
> +
> +	if (test_bit(DASD_FLAG_OFFLINE, &device->flags))
> +		return;
> +	if (!device->paths_info) {
> +		dev_warn(&device->cdev->dev, "Unable to create paths objects\n");

I guess this warns every time you come along here, is warning more than
once useful?

> +		return;
> +	}
> +	if (device->path[chp].in_sysfs)
> +		return;
> +	if (!device->path[chp].conf_data)

Out of interest: Have you tried this with vfio-ccw under QEMU, where
some information is simply not available?

> +		return;
> +
> +	dasd_path_init_kobj(device, chp);
> +
> +	rc =3D kobject_add(&device->path[chp].kobj, NULL, "%x.%02x",
> +			 device->path[chp].cssid, device->path[chp].chpid);
> +	if (rc)
> +		kobject_put(&device->path[chp].kobj);

This will eventually lead to the nop release function, which doesn't
unset state_initialized (see above) -- but OTOH, it shouldn't muck
around with kobject internals anyway.

I think the kobjects really want to be dynamically allocated; instead
of going through a remove/add cycle, is there a way to make path
objects "invisible" instead? Or add an "available" attribute, and error
out reading any other attribute?

> +	device->path[chp].in_sysfs =3D true;
> +}
> +EXPORT_SYMBOL(dasd_path_create_kobj);
> +
> +void dasd_path_create_kobjects(struct dasd_device *device)
> +{
> +	u8 lpm, opm;
> +
> +	opm =3D dasd_path_get_opm(device);
> +	for (lpm =3D 0x80; lpm; lpm >>=3D 1) {
> +		if (!(lpm & opm))
> +			continue;

Any reason you do not simply create objects for _all_ paths, combined
with returning n/a or erroring out for paths where this does not apply?
(I might be missing something obvious.)

> +		dasd_path_create_kobj(device, pathmask_to_pos(lpm));
> +	}
> +}
> +EXPORT_SYMBOL(dasd_path_create_kobjects);
> +
> +void dasd_path_remove_kobj(struct dasd_device *device, int chp)
> +{
> +	if (device->path[chp].in_sysfs) {
> +		kobject_put(&device->path[chp].kobj);
> +		device->path[chp].in_sysfs =3D false;
> +	}
> +}
> +EXPORT_SYMBOL(dasd_path_remove_kobj);

Also, how is userspace supposed to deal with changes here? Should there
be a uevent on the parent device to notify about changes?

> =20
>  int dasd_add_sysfs_files(struct ccw_device *cdev)
>  {

(...)

> +static inline void dasd_path_release(struct kobject *kobj)
> +{
> +/* Memory for the dasd_path kobject is freed when dasd_free_device() is =
called */
> +}
> +

As already said, I don't think that's a correct way to implement this.

(...)

