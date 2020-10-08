Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01244C4363C
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 14:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B981A21924
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 14:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LGAQaCWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbgJHOiI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 10:38:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35196 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730496AbgJHOiI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Oct 2020 10:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602167886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KKWMmiZMyq61zFpIIsVaDRYrVy5ZZLo1g3IsVWjOJcM=;
        b=LGAQaCWB49NaTO8Sikhd0ZZpvqscBYSNOLDSdW1xwqMY3QdaeZRHGwmEmXxarotAjzHW7t
        +SS+PcY3BkAnPxoU7ATYzqf0LoL8szU+JqTFwKWkqElcUO5v1gZWgiOAxEYQpbELsKQL7k
        OJV+KQVMz27517Ed9ffJYBUlXMEnl9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-qxheqSOQPz2fnjE6FtNA0A-1; Thu, 08 Oct 2020 10:38:02 -0400
X-MC-Unique: qxheqSOQPz2fnjE6FtNA0A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B87AA1868430;
        Thu,  8 Oct 2020 14:38:00 +0000 (UTC)
Received: from gondolin (ovpn-113-82.ams2.redhat.com [10.36.113.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC6265C1BD;
        Thu,  8 Oct 2020 14:37:58 +0000 (UTC)
Date:   Thu, 8 Oct 2020 16:37:56 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 07/10] s390/dasd: Fix operational path inconsistency
Message-ID: <20201008163756.3d1443b9.cohuck@redhat.com>
In-Reply-To: <20201008131336.61100-8-sth@linux.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
        <20201008131336.61100-8-sth@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu,  8 Oct 2020 15:13:33 +0200
Stefan Haberland <sth@linux.ibm.com> wrote:

> From: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
>=20
> During online processing and setting up a DASD device, the configuration
> data for operational paths is read and validated two times
> (dasd_eckd_read_conf()). The first time to provide information that are
> necessary for the LCU setup. A second time after the LCU setup as a
> device might report different configuration data then.
>=20
> When the configuration setup for each operational path is being
> validated, an initial call to dasd_eckd_clear_conf_data() is issued.
> This call wipes all previously available configuration data and path
> information for each path.
> However, the operational path mask is not updated during this process.
>=20
> As a result, the stored operational path mask might no longer correspond
> to the operational paths mask reported by the CIO layer, as several
> paths might be gone between the two dasd_eckd_read_conf() calls.
>=20
> This inconsistency leads to more severe issues in later path handling
> changes. Fix this by removing the channel paths from the operational
> path mask during the dasd_eckd_clear_conf_data() call.
>=20
> Signed-off-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> ---
>  drivers/s390/block/dasd_eckd.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 3ff7b532a5bf..3273b26b25b0 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -1034,6 +1034,7 @@ static void dasd_eckd_clear_conf_data(struct dasd_d=
evice *device)
>  		device->path[i].cssid =3D 0;
>  		device->path[i].ssid =3D 0;
>  		device->path[i].chpid =3D 0;
> +		dasd_path_notoper(device, i);
>  	}
>  }
> =20

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

