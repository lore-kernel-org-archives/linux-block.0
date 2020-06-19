Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838DDC433E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 12:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AA3B207E8
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 12:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPVgU561"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732526AbgFSMt7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 08:49:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44308 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732379AbgFSMtt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 08:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592570988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IGO+CJBEnWQc9Ot84SOMePVBK9U6K5jZVae2LE+FwxE=;
        b=HPVgU561i+TBXvW+b45txCrDKwkyiHBxlkZLl96BPqI5yoe4WaB628sKM9b0MtQ2AouWY/
        ImDW5BSay1SaGtj0U/s1TPPvGOAfba0sOPx/Uw6kto7QMjMhGiDKPTj7qvi9UBzk6TyTnR
        1YdFlxo8upDaddd/Xzl24BxGen+zcMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-qs7lwy3qMVevVZcbLW21uQ-1; Fri, 19 Jun 2020 08:49:44 -0400
X-MC-Unique: qs7lwy3qMVevVZcbLW21uQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 579BD801A03;
        Fri, 19 Jun 2020 12:49:43 +0000 (UTC)
Received: from localhost (ovpn-113-212.ams2.redhat.com [10.36.113.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93F345C1D0;
        Fri, 19 Jun 2020 12:49:39 +0000 (UTC)
Date:   Fri, 19 Jun 2020 13:49:38 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Wang Qing <wangqing@vivo.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers\block: Use kobj_to_dev() API
Message-ID: <20200619124938.GA2424182@stefanha-x1.localdomain>
References: <1591945856-14749-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
In-Reply-To: <1591945856-14749-1-git-send-email-wangqing@vivo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2020 at 03:10:56PM +0800, Wang Qing wrote:
> Use kobj_to_dev() API instead of container_of().
>=20
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  mode change 100644 =3D> 100755 drivers/block/virtio_blk.c

Please fix the '\' -> '/' in the commit message. Looks good otherwise:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7stGIACgkQnKSrs4Gr
c8iKlgf/f+yvjTB2iqqDHAxkMDvnIu83CmaNspZ6bGF/0hEaFtWKGCIiJ+uyD2ow
HeS/6wRfIYMFpEcrwpEPWssIh/+US/957FmjIVeUU8b7jIER7VHH1BcAZq8DDKe3
yIxlUtJPOFRUz8GyddfoWDycsSL5SCGjP8eRTJkIy93yBlw308K8h/Y0keIN3ToJ
QYnuq143Mm0XmVk7RgkIMIM6iiDgxrU+qU5wIRg4f5UVzGWFAHIugGHEN+BMEUfv
hXpS0Akw5CkVFSTkOewu15i52Hp4TDRyQn+A0DldsPdjnjebGaygbRH5In8NzqX/
AACpzHtUyBhoDiAf2Ml3OAh86QIIEA==
=eGvO
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--

