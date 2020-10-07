Return-Path: <SRS0=w7gf=DO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A52C41604
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 16:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 057C9215A4
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 16:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNPF/J0E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgJGQkX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Oct 2020 12:40:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33533 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726702AbgJGQkX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 7 Oct 2020 12:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602088821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=saelsKuZSmvrUQUxcs48BzcLX5DdEKkzBPmTO93LrRk=;
        b=DNPF/J0ETLykrK6chPkNLCGuIgIF5g+FfUldL894f8GNHccCC3L3M8ughM0rIxUFLP1iTL
        verYcEGMi2V3CIy7BVRrkTIF51HMHmS46FHRtK4SlxcCqsec3fY4psJXysLBz0GBUxEkDe
        H3pj3hkVHh3I0U7iHFcuoDfYK3a4tuI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-bGYmd3_CMwSHOSoUYJnQbw-1; Wed, 07 Oct 2020 12:40:17 -0400
X-MC-Unique: bGYmd3_CMwSHOSoUYJnQbw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07115101FFA5;
        Wed,  7 Oct 2020 16:40:16 +0000 (UTC)
Received: from gondolin (ovpn-112-246.ams2.redhat.com [10.36.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2FA3F76648;
        Wed,  7 Oct 2020 16:40:14 +0000 (UTC)
Date:   Wed, 7 Oct 2020 18:40:11 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Jan =?UTF-8?B?SMO2cHBuZXI=?= <hoeppner@linux.ibm.com>
Cc:     Stefan Haberland <sth@linux.ibm.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: Re: [PATCH 08/10] s390/dasd: Display FC Endpoint Security
 information via sysfs
Message-ID: <20201007184011.6dece07f.cohuck@redhat.com>
In-Reply-To: <243fe10e-ce80-57de-a92c-3a6457cde40a@linux.ibm.com>
References: <20201002193940.24012-1-sth@linux.ibm.com>
        <20201002193940.24012-9-sth@linux.ibm.com>
        <20201006122632.098149ba.cohuck@redhat.com>
        <d88b8230-993e-d63d-394a-efcaf60f813d@linux.ibm.com>
        <20201007114928.6a088a7d.cohuck@redhat.com>
        <243fe10e-ce80-57de-a92c-3a6457cde40a@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 7 Oct 2020 16:33:37 +0200
Jan H=C3=B6ppner <hoeppner@linux.ibm.com> wrote:

> >>>> +static inline void dasd_path_release(struct kobject *kobj)
> >>>> +{
> >>>> +/* Memory for the dasd_path kobject is freed when dasd_free_device(=
) is called */
> >>>> +}
> >>>> +   =20
> >>>
> >>> As already said, I don't think that's a correct way to implement this.
> >>>    =20
> >>
> >> As you correctly pointed out, our release function doesn't do anything.
> >> This is because our path data is a (static) part of our device.
> >> This data is critical to keep our devices operational.
> >> We can't simply rely on allocated memory if systems are under stress. =
 =20
> >=20
> > Yes, avoiding freeing and reallocating memory certainly makes sense.
> >  =20
> >>
> >> Having this data dynamically allocated involves a lot of rework of our
> >> path handling as well. There are a few things that are subject to impr=
ovement
> >> and evaluating whether our dasd_path structures can be dynamic is one =
of
> >> these things. However, even then, the above concern persists and I
> >> highly doubt that dynamic dasd_paths objects are doable for us at this
> >> moment.
> >>
> >> I do understand the concerns, however, we release the memory for dasd_=
path
> >> structures eventually when dasd_free_device() is called. Until that po=
int,
> >> the data has to be kept alive. The rest is taking care of by the kobje=
ct
> >> library. =20
> >=20
> > Yes, there doesn't seem to be any memory leakage.
> >  =20
> >> In our path handling we also make sure that we can always verify/valid=
ate
> >> paths information even if a system is under high memory pressure. Anot=
her
> >> reason why it would contradictory for dasd_path objects to be dynamic.
> >>
> >> I hope this explains the reasoning behind the release function. =20
> >=20
> > I understand where you're coming from.
> >=20
> > However, "static" kobjects (in the sense of "we may re-register the
> > same kobject") are still problematic. Is there any way to simply
> > "disappear" path objects that are not valid at the moment, or mark them
> > as not valid? =20
>=20
> You could use kobject_del(), but it is rather intended to be used for
> a two-stage removal of the kobject.
>=20
> >=20
> > Also, the simple act of registering/unregistering a kobject already
> > creates stress from its sysfs interactions... it seems you should try
> > to avoid that as well?
> >  =20
>=20
> We don't re-register kobjects over and over again. The kobjects are
> infact initialized and created only _once_. This is done either during
> device initialization (after dasd_eckd_read_conf() in
> dasd_eckd_check_characteristics()) or when a path is newly added
> (in the path event handler).
> The kobject will stay until the memory for the whole device is being
> freed. This is also the reason why the kobject can stay initialized and
> we track ourselves whether we did the initialization/creation already
> (which we check e.g. when a path is removed and added again).
> So, instead of the release function freeing the kobject data,
> it is done by our dasd_free_device() (same thing, different function IMHO=
).
>=20
> I think the concerns would be more worrisome if we'd remove/add
> the kobjects every time. And then I agree, we'd run into trouble.
>=20

The thing that tripped me is

+void dasd_path_remove_kobj(struct dasd_device *device, int chp)
+{
+	if (device->path[chp].in_sysfs) {
+		kobject_put(&device->path[chp].kobj);
+		device->path[chp].in_sysfs =3D false;
+	}
+}

As an exported function, it is not clear where this may be called from.
Given your explanation above (and some more code reading on my side),
the code looks ok in its current incarnation (but non-idiomatic).

Is there a way to check that indeed nobody re-adds a previously removed
path object due to a (future) programming error? And maybe add a
comment that you must never re-register a path? "The path is gone,
let's remove the object" looks quite tempting.

