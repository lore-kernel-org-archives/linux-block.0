Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAEBC433FE
	for <linux-block@archiver.kernel.org>; Sun, 16 Oct 2022 22:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiJPWQz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Oct 2022 18:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiJPWQz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Oct 2022 18:16:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F29303DA
        for <linux-block@vger.kernel.org>; Sun, 16 Oct 2022 15:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665958612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7WGBKVGNgP55dO8rSbU6eAXVrWT8PmWide82sPU44mc=;
        b=eUt2jw13cGBsblvzuZHGWd4R9pAES9vGyyaYx2wvWsiwK47VtxVDSrrg1WeMpKnP/mdbdD
        mvlpQs57Par9GF7YsPzq2xm077wUat4KFhHtdEpXDpT5HhymieCSsWJmonA2W7TdDhZrTJ
        y6OylnlcNZMEN3fRklReAWT5xk7LCBY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-yZmsFPxpP_mHh-HZXzMjsA-1; Sun, 16 Oct 2022 18:16:46 -0400
X-MC-Unique: yZmsFPxpP_mHh-HZXzMjsA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23513101A54E;
        Sun, 16 Oct 2022 22:16:46 +0000 (UTC)
Received: from localhost (unknown [10.39.192.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D593C5661A;
        Sun, 16 Oct 2022 22:16:45 +0000 (UTC)
Date:   Sun, 16 Oct 2022 18:16:43 -0400
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Dmitry Fomichev <dmitry.fomichev@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>,
        virtio-dev@lists.oasis-open.org
Subject: Re: [virtio-dev] [PATCH v2 1/2] virtio-blk: use a helper to handle
 request queuing errors
Message-ID: <Y0yCy4fULmG8cwz9@fedora>
References: <20221016034127.330942-1-dmitry.fomichev@wdc.com>
 <20221016034127.330942-2-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WrxOcra4N/hDC62u"
Content-Disposition: inline
In-Reply-To: <20221016034127.330942-2-dmitry.fomichev@wdc.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--WrxOcra4N/hDC62u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 15, 2022 at 11:41:26PM -0400, Dmitry Fomichev wrote:
> Define a new helper function, virtblk_fail_to_queue(), to
> clean up the error handling code in virtio_queue_rq().
>=20
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  drivers/block/virtio_blk.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--WrxOcra4N/hDC62u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmNMgssACgkQnKSrs4Gr
c8j3Qgf/SjnLG+UDK6hdHghUkZpxR+GNWEQgjI4su181tWMDF1xvIHUsLvd0VkhB
RrRaOzGHjYtGToFjZ3bghA+YS9t5LjfltXEC52sBo2CckkWJjdVPXFrUlGVcVgnk
m/Hzq6ZNsI1/DDFw2Cl1LTeKWM6yRba91pbhPfSU6FB3qcuc7QUcY+oDP51nRKNB
0fzfyRlYk8XKSj5wb98CTL8lCTqEU5tUwrJuWeV7bax2weERBXZR4x6Sar3LxV5i
rKf7q9WjPASRUHXV+etaW4CPjp4qDlWWpbuVy161gLl0cm47CGcfXI0al4taj/ZR
UXSxjPeiyBuLIYVVkKLNA4Viip/LMg==
=73yJ
-----END PGP SIGNATURE-----

--WrxOcra4N/hDC62u--

