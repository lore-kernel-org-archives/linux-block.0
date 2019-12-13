Return-Path: <SRS0=J0ZO=2D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F1EC3B1BC
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4020B246B1
	for <linux-block@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ct2bk9J/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfLMLM5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Dec 2019 06:12:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26666 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726263AbfLMLM5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Dec 2019 06:12:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576235576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lxgYDeLn+qsD2/3M7+5DqmcLMAJ3gqSfcZrOd3a7MZc=;
        b=ct2bk9J/hseEWY30m/Jg4PK/beo4U2n9B1oabxDsYxVB8lcDb/n6FozD8QshMCCNoRIAxT
        F3xmsYZHHXMtYzjBMP2nHKKNXtDo/mj3WqHVSrS0ZuPu25f3EtPuFKuZxFBGSGcf3R7RCT
        NtQbb8FbtvF1bRlNKpuNSpUsD8cpFD0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-uPeUHrhDONiQNaDCyb1D_w-1; Fri, 13 Dec 2019 06:12:55 -0500
X-MC-Unique: uPeUHrhDONiQNaDCyb1D_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1D5CDB22;
        Fri, 13 Dec 2019 11:12:53 +0000 (UTC)
Received: from localhost (unknown [10.36.118.64])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FAA76013D;
        Fri, 13 Dec 2019 11:12:49 +0000 (UTC)
Date:   Fri, 13 Dec 2019 11:12:48 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com,
        pbonzini@redhat.com, linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] virtio-blk: remove VIRTIO_BLK_F_SCSI support
Message-ID: <20191213111248.GF1180977@stefanha-x1.localdomain>
References: <20191212163719.28432-1-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20191212163719.28432-1-hch@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="B0nZA57HJSoPbsHY"
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--B0nZA57HJSoPbsHY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2019 at 05:37:19PM +0100, Christoph Hellwig wrote:
> Since the need for a special flag to support SCSI passthrough on a
> block device was added in May 2017 the SCSI passthrough support in
> virtio-blk has been disabled.  It has always been a bad idea
> (just ask the original author..) and we have virtio-scsi for proper
> passthrough.  The feature also never made it into the virtio 1.0
> or later specifications.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/configs/guest.config |   1 -
>  drivers/block/Kconfig             |  10 ---
>  drivers/block/virtio_blk.c        | 115 +-----------------------------
>  3 files changed, 1 insertion(+), 125 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--B0nZA57HJSoPbsHY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3zcjAACgkQnKSrs4Gr
c8hUCwgAwoDSWLqUUFcE49cvm2R06U1mq/S+1RD+NEKHblyqWDsshV3UG8/It0EK
P0UJdPG99+Px7vbsh8WoZx0THO+YT3pBT0UzxY/KggDZYU2IAStfaSxBwDa0mULu
utlt/elBTbhtTd8dNIDz0w9qxyVHaa/8urGHtFe8mWw7xhOg5LHLqQESRV6V7y9v
f7+Za7/DFg1XeFxGDlZW3dWY22lPTe8gAGrOqQRnj69lrYZuezbCIDNf3Ab+PJQp
p2HoSZBNZTRrekMap2n3iEA63GNQAlXrDRfdWqRXkK3EXjHlVJcGe86ZZD8XqiCp
g/TdO1+w4c9ds5Oqo6dO/MWQKOVYGg==
=+gj9
-----END PGP SIGNATURE-----

--B0nZA57HJSoPbsHY--

