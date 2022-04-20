Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C91AC433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 15:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380288AbiDTPXQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Apr 2022 11:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380206AbiDTPWv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Apr 2022 11:22:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6FD34552B
        for <linux-block@vger.kernel.org>; Wed, 20 Apr 2022 08:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650468004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vr65kK48b4IYGWq3LEsb2mA5/gjqSSqZxbsyzjsVrlA=;
        b=Oil/+wYNLovfRf4+MH7hHolVRf7NIJHGJK4XXJoC/qnJF8EuJ6dvC9JMd7ktmAKAsinFcu
        GqiWgBABoz80Ds5oyGpyrJmydQrl/huWBXmj4BxJ4p4SsHiyGkWiw0xWXKVCUtu9by4rhg
        bPc3jkx6WQVVdm7fhSCtuuR+46rIsRw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-JOxFjWwfNxejb_ux5u4Oxw-1; Wed, 20 Apr 2022 11:20:00 -0400
X-MC-Unique: JOxFjWwfNxejb_ux5u4Oxw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19E761C05142;
        Wed, 20 Apr 2022 15:20:00 +0000 (UTC)
Received: from localhost (unknown [10.39.194.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0ABEE2166B44;
        Wed, 20 Apr 2022 15:19:53 +0000 (UTC)
Date:   Wed, 20 Apr 2022 17:19:51 +0200
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Chaitanya Kulkarni <kch@nvidia.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 4/4] virtio-blk: remove deprecated ida_simple_XXX()
Message-ID: <YmAklxLSkwiijfxV@stefanha-x1.localdomain>
References: <20220420041053.7927-1-kch@nvidia.com>
 <20220420041053.7927-5-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n2ti8gPJk9PvKj1M"
Content-Disposition: inline
In-Reply-To: <20220420041053.7927-5-kch@nvidia.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--n2ti8gPJk9PvKj1M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 19, 2022 at 09:10:53PM -0700, Chaitanya Kulkarni wrote:
> Replace deprecated ida_simple_get() and ida_simple_remove() with
> ida_alloc_max() and ida_free().
>=20
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/block/virtio_blk.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--n2ti8gPJk9PvKj1M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmJgJJcACgkQnKSrs4Gr
c8giFQf/bIt70RKS9GLawcbAsbUw996Yx8V9PyZRRGJopQZ9K8AixFN7Vi0NJskQ
qYFvP0yIn8ZwXDbGoQmZ/iH+zDvTingGGhb1kB4hm5eZa3qMy8X84ZuvhmNNcpbO
jtJa3rl7kqL++9m54XnGelL9M/g4pYPiLKqalh6Ri+HZ2VyVtFhhbbMftcSjRj0h
PE5iN9neP545tsu2k+lm1IJaOd2vSC5dG7HrqnHPYsRbiGUx9wrzcSIXew6AZlJd
19Pp8ZGhK0JBhxoTW6OUU0xDAQnR4/yyBbKxwdBxn7W1hFbR5+UUM/yuGrppa4IG
PSJbUB49PVdLzKTxoIHiGsDUmujkcQ==
=WzxC
-----END PGP SIGNATURE-----

--n2ti8gPJk9PvKj1M--

