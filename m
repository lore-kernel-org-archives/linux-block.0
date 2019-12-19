Return-Path: <SRS0=q1Dd=2J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FEAC43603
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 09:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441542467B
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 09:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ghkk5d20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfLSJZK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Dec 2019 04:25:10 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28299 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726599AbfLSJZJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Dec 2019 04:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576747508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PS1Ppzg7zZwCn5KsW+P0K8cXdORYyX0ludGbM5VdEfI=;
        b=ghkk5d20KlttUPfYgiZGc5NoQKuajjJ2MiUDjOfrySSzSWZe9FNnnmbMX6BRaMZEh8QVZX
        grjoAq1ruD4npmaHH6qTnuXjtnm6G0IkMq8TqQQAww+pIR/r8DaB0gRcYMKzASxrUsdHvA
        juXVF/LtRfmV17cnlf0lnUu0k0Jak8o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-ZSVtTFEjM6mprY6qR0H_mg-1; Thu, 19 Dec 2019 04:25:05 -0500
X-MC-Unique: ZSVtTFEjM6mprY6qR0H_mg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74EBF801E78;
        Thu, 19 Dec 2019 09:25:03 +0000 (UTC)
Received: from gondolin (ovpn-117-134.ams2.redhat.com [10.36.117.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9B8B7D97D;
        Thu, 19 Dec 2019 09:25:01 +0000 (UTC)
Date:   Thu, 19 Dec 2019 10:24:59 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        hoeppner@linux.ibm.com, linux-s390@vger.kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: Re: [PATCH 1/3] s390/dasd/cio: Interpret ccw_device_get_mdc return
 value correctly
Message-ID: <20191219102459.053999a2.cohuck@redhat.com>
In-Reply-To: <20191219084352.75114-2-sth@linux.ibm.com>
References: <20191219084352.75114-1-sth@linux.ibm.com>
        <20191219084352.75114-2-sth@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 19 Dec 2019 09:43:50 +0100
Stefan Haberland <sth@linux.ibm.com> wrote:

> From: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
>=20
> The max data count (mdc) is an unsigned 16-bit integer value as per AR
> documentation and is received via ccw_device_get_mdc() for a specific
> path mask from the CIO layer. The function itself also always returns a
> positive mdc value or 0 in case mdc isn't supported or couldn't be
> determined.
>=20
> Though, the comment for this function describes a negative return value
> to indicate failures.

Note that this used to be true before 040495d110ba ("s390/cio: make use
of newly added format 1 channel-path data").

>=20
> As a result, the DASD device driver interprets the return value of
> ccw_device_get_mdc() incorrectly. The error case is essentially a dead
> code path.

To be pedantic: It did not check for <=3D 0 (as documented) either :)

>=20
> To fix this behaviour, check explicitly for a return value of 0 and
> change the comment for ccw_device_get_mdc() accordingly.
>=20
> This fix merely enables the error code path in the DASD functions
> get_fcx_max_data() and verify_fcx_max_data(). The actual functionality
> stays the same and is still correct.
>=20
> Signed-off-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Acked-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> ---
>  drivers/s390/block/dasd_eckd.c | 9 +++++----
>  drivers/s390/cio/device_ops.c  | 2 +-
>  2 files changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index c94184d080f8..f5622f4a2ecf 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -1128,7 +1128,8 @@ static u32 get_fcx_max_data(struct dasd_device *dev=
ice)
>  {
>  	struct dasd_eckd_private *private =3D device->private;
>  	int fcx_in_css, fcx_in_gneq, fcx_in_features;
> -	int tpm, mdc;
> +	unsigned int mdc;
> +	int tpm;
> =20
>  	if (dasd_nofcx)
>  		return 0;
> @@ -1142,7 +1143,7 @@ static u32 get_fcx_max_data(struct dasd_device *dev=
ice)
>  		return 0;
> =20
>  	mdc =3D ccw_device_get_mdc(device->cdev, 0);
> -	if (mdc < 0) {
> +	if (mdc =3D=3D 0) {
>  		dev_warn(&device->cdev->dev, "Detecting the maximum supported data siz=
e for zHPF requests failed\n");
>  		return 0;
>  	} else {
> @@ -1153,12 +1154,12 @@ static u32 get_fcx_max_data(struct dasd_device *d=
evice)
>  static int verify_fcx_max_data(struct dasd_device *device, __u8 lpm)
>  {
>  	struct dasd_eckd_private *private =3D device->private;
> -	int mdc;
> +	unsigned int mdc;
>  	u32 fcx_max_data;
> =20
>  	if (private->fcx_max_data) {
>  		mdc =3D ccw_device_get_mdc(device->cdev, lpm);
> -		if ((mdc < 0)) {
> +		if (mdc =3D=3D 0) {
>  			dev_warn(&device->cdev->dev,
>  				 "Detecting the maximum data size for zHPF "
>  				 "requests failed (rc=3D%d) for a new path %x\n",
> diff --git a/drivers/s390/cio/device_ops.c b/drivers/s390/cio/device_ops.c
> index 65841af15748..ccecf6b9504e 100644
> --- a/drivers/s390/cio/device_ops.c
> +++ b/drivers/s390/cio/device_ops.c
> @@ -635,7 +635,7 @@ EXPORT_SYMBOL(ccw_device_tm_start_timeout);
>   * @mask: mask of paths to use
>   *
>   * Return the number of 64K-bytes blocks all paths at least support
> - * for a transport command. Return values <=3D 0 indicate failures.
> + * for a transport command. Return value 0 indicates failure.

s/Return value/The return value/ ?

>   */
>  int ccw_device_get_mdc(struct ccw_device *cdev, u8 mask)
>  {

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

